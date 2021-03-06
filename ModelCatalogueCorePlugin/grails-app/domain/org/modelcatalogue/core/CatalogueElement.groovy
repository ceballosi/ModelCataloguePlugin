package org.modelcatalogue.core

import com.google.common.base.Function
import com.google.common.collect.ImmutableSet
import com.google.common.collect.Lists
import grails.util.GrailsNameUtils
import org.hibernate.proxy.HibernateProxyHelper
import org.modelcatalogue.core.api.ElementStatus
import org.modelcatalogue.core.publishing.CloningContext
import org.modelcatalogue.core.publishing.Published
import org.modelcatalogue.core.publishing.Publisher
import org.modelcatalogue.core.publishing.PublishingChain
import org.modelcatalogue.core.publishing.PublishingContext
import org.modelcatalogue.core.security.User
import org.modelcatalogue.core.util.DataModelAware
import org.modelcatalogue.core.util.ExtensionsWrapper
import org.modelcatalogue.core.util.FriendlyErrors
import org.modelcatalogue.core.util.HibernateHelper
import org.modelcatalogue.core.util.Inheritance
import org.modelcatalogue.core.util.OrderedMap
import org.modelcatalogue.core.util.RelationshipDirection

import org.modelcatalogue.core.api.CatalogueElement as ApiCatalogueElement
import rx.Observer

import static org.modelcatalogue.core.util.HibernateHelper.getEntityClass

/**
* Catalogue Element - there are a number of catalogue elements that make up the model
 * catalogue (please see DataType, MeasurementUnit, Model,
* DataElement) they extend catalogue element which allows creation of incoming and outgoing
* relationships between them. They also  share a number of characteristics.
* */
abstract class  CatalogueElement implements Extendible<ExtensionValue>, Published<CatalogueElement>, ApiCatalogueElement, DataModelAware {

    def grailsLinkGenerator
    def relationshipService
    def auditService
    def mappingService
    def elementService

    DataModel dataModel

    String name
    String description
	String modelCatalogueId

    //version number - this gets iterated every time a new version is created from a finalized version
    Integer versionNumber = 1

    //status: once an object is finalized it cannot be changed
    //it's version number is updated and any subsequent update will
    //be mean that the element is superseded. We will provide a supersede function
    //to do this
    ElementStatus status = ElementStatus.DRAFT

    Date versionCreated = new Date()

    // id of the latest version
    Long latestVersionId

    // time stamping
    Date dateCreated
    Date lastUpdated

    //stop null pointers (especially deleting new items)
    Set<Relationship> incomingRelationships = []
    Set<Relationship> outgoingRelationships = []
    Set<Mapping> outgoingMappings = []
    Set<Mapping> incomingMappings = []

    static transients = ['relations', 'info', 'archived', 'relations', 'incomingRelations', 'outgoingRelations', 'defaultModelCatalogueId', 'ext', 'combinedVersion', 'inheritedAssociationsNames', 'modelCatalogueResourceName', 'dataModelSemanticVersion', 'legacyModelCatalogueId', 'link']

    static hasMany = [incomingRelationships: Relationship, outgoingRelationships: Relationship, outgoingMappings: Mapping,  incomingMappings: Mapping, extensions: ExtensionValue]

    static relationships = [
            incoming: [base: 'isBasedOn', supersession: 'supersedes', favourite: 'isFavouriteOf', origin: 'isClonedFrom'],
            outgoing: [base: 'isBaseFor', attachment: 'hasAttachmentOf', supersession: 'supersededBy', origin: 'isOriginFor'],
            bidirectional: [relatedTo: 'relatedTo', synonym: 'isSynonymFor']
    ]

    static constraints = {
        name size: 1..255
        description nullable: true, maxSize: 20000
		modelCatalogueId nullable: true, /* unique: 'versionNumber', */ size: 1..255, url: true
        dateCreated bindable: false
        lastUpdated bindable: false
        archived bindable: false
        versionNumber bindable: false
        latestVersionId bindable: false, nullable: true
        dataModel nullable: true
    }

    static mapping = {
        tablePerHierarchy false
        sort "name"
		name index :'CtlgElement_name_idx'
		latestVersionId index :'CtlgElement_latestVersionId_idx'
        modelCatalogueId index :'CtlgElement_modelCatalogueId_idx'
        description type: "text"
        extensions lazy: false, sort: 'orderIndex'
        dataModel lazy: false
    }

    static mappedBy = [outgoingRelationships: 'source', incomingRelationships: 'destination', outgoingMappings: 'source', incomingMappings: 'destination']

    static fetchMode = [dataModel: 'eager']

    /**
     * Functions for specifying relationships between catalogue elements using the
     * org.modelcatalogue.core.Relationship class
     * @return list of items which contains incoming and outgoing relations
     *
     * @deprecated use #getOutgoingRelations() instead
     */

    @Deprecated
    List getRelations() {
        getOutgoingRelations() + getIncomingRelations()
    }

    List getIncomingRelations() {
        Lists.transform(relationshipService.getRelationships([:], RelationshipDirection.INCOMING, this).items, {
            it.source
        } as Function<Relationship, CatalogueElement>)
    }

    List getOutgoingRelations() {
        Lists.transform(relationshipService.getRelationships([:], RelationshipDirection.OUTGOING, this).items, {
            it.destination
        } as Function<Relationship, CatalogueElement>)
    }


    List getIncomingRelationsByType(RelationshipType type) {
        getIncomingRelationshipsByType(type).collect {
            it.source
        }
    }

    List getOutgoingRelationsByType(RelationshipType type) {
        getOutgoingRelationshipsByType(type).collect {
            it.destination
        }
    }

    @Deprecated
    List getRelationsByType(RelationshipType type) {
        [getOutgoingRelationsByType(type), getIncomingRelationsByType(type)].flatten()
    }

    List<Relationship> getIncomingRelationshipsByType(RelationshipType type) {
        relationshipService.getRelationships([:], RelationshipDirection.INCOMING, this, type).items
    }

    List<Relationship> getOutgoingRelationshipsByType(RelationshipType type) {
        relationshipService.getRelationships([:], RelationshipDirection.OUTGOING, this, type).items
    }

    @Deprecated
    List<Relationship> getRelationshipsByType(RelationshipType type) {
        [getOutgoingRelationshipsByType(type), getIncomingRelationshipsByType(type)].flatten()
    }

    int countIncomingRelationshipsByType(RelationshipType type) {
        relationshipService.countIncomingRelationshipsByType(this, type)
    }

    int countOutgoingRelationshipsByType(RelationshipType type) {
        relationshipService.countOutgoingRelationshipsByType(this, type)
    }


    int countRelationshipsByDirectionAndType(RelationshipDirection direction, RelationshipType type) {
        relationshipService.countRelationshipsByDirectionAndType(this, direction, type)
    }

    Relationship createLinkTo(Map<String, Object> params, CatalogueElement destination, RelationshipType type) {
        relationshipService.link RelationshipDefinition.create(this, destination, type).withParams(params).definition
    }

    Relationship createLinkTo(CatalogueElement destination, RelationshipType type) {
        createLinkTo([:], destination, type)
    }

    Relationship createLinkFrom(Map<String, Object> params, CatalogueElement source, RelationshipType type) {
        relationshipService.link RelationshipDefinition.create(source, this, type).withParams(params).definition
    }

    Relationship createLinkFrom(CatalogueElement source, RelationshipType type) {
        createLinkFrom([:], source, type)
    }

    Relationship removeLinkTo(CatalogueElement destination, RelationshipType type) {
        relationshipService.unlink(this, destination, type)
    }

    Relationship removeLinkFrom(CatalogueElement source, RelationshipType type) {
        relationshipService.unlink(source, this, type)
    }

    Map<String, Object> getInfo() {
        [
                id: getId(),
                name: name,
                link: "/${GrailsNameUtils.getPropertyName(getClass())}/${getId()}"
        ]
    }

    boolean isArchived() {
        if (!status) return false
        !status.modificable
    }

    def beforeValidate() {
        removeModelCatalogueIdIfDefault()
    }

    private void removeModelCatalogueIdIfDefault() {
        if (modelCatalogueId) {
            String defaultId = getDefaultModelCatalogueId(true)
            if (defaultId && (modelCatalogueId.startsWith(defaultId) || modelCatalogueId.contains('//localhost'))) {
                modelCatalogueId = null
            }
        }
    }

    def beforeDelete(){
        new HashSet(outgoingRelationships).each{ Relationship relationship->
            relationship.beforeDelete()
            relationship.delete(flush:true)
        }
        new HashSet(incomingRelationships).each{ Relationship relationship ->
            relationship.beforeDelete()
            relationship.delete(flush:true)
        }
        new HashSet(outgoingMappings).each{ Mapping mapping ->
            mapping.beforeDelete()
            mapping.delete(flush:true)
        }
        new HashSet(incomingMappings).each{ Mapping mapping ->
            mapping.beforeDelete()
            mapping.delete(flush:true)
        }
        auditService.logElementDeleted(this)
    }

    boolean hasModelCatalogueId() {
        this.@modelCatalogueId != null
    }

    final Integer countVersions() {
        elementService.countVersions(this)
    }


    protected String getModelCatalogueResourceName() {
        fixResourceName GrailsNameUtils.getPropertyName(getEntityClass(this))
    }

    @Deprecated
    String getLegacyModelCatalogueId(boolean withoutVersion = false) {
        if (!grailsLinkGenerator) {
            return null
        }
        String resourceName = getModelCatalogueResourceName()
        if (withoutVersion) {
            return grailsLinkGenerator.link(absolute: true, uri: "/catalogue/${resourceName}/${getLatestVersionId() ?: getId()}")
        }
        return grailsLinkGenerator.link(absolute: true, uri: "/catalogue/${resourceName}/${getLatestVersionId() ?: getId()}.${getVersionNumber()}")
    }

    String getDefaultModelCatalogueId(boolean withoutVersion = false) {
        if (!grailsLinkGenerator) {
            return null
        }
        String resourceName = getModelCatalogueResourceName()
        if (withoutVersion) {
            return grailsLinkGenerator.link(absolute: true, uri: "/catalogue/${resourceName}/${getLatestVersionId() ?: getId()}")
        }
        return grailsLinkGenerator.link(absolute: true, uri: "/catalogue/${resourceName}/${getCombinedVersion()}")
    }

    /**
     * Called before the archived element is persisted to the data store.
     */
    void beforeDraftPersisted(PublishingContext context) {}

    void afterDraftPersisted(CatalogueElement draft, PublishingContext context) {
        draft.ext.putAll this.ext
        for(Mapping mapping in outgoingMappings) {
            mappingService.map(draft, context.resolve(mapping.destination), mapping.mapping)
        }
        for (Mapping mapping in incomingMappings) {
            mappingService.map(context.resolve(mapping.source), draft, mapping.mapping)
        }
    }

    static String fixResourceName(String resourceName) {
        if (resourceName.contains('_')) {
            resourceName = resourceName.substring(0, resourceName.indexOf('_'))
        }
        if (resourceName == 'org.modelcatalogue.core.ValueDomain') {
            resourceName = 'org.modelcatalogue.core.DataType'
        } else if (resourceName == 'org.modelcatalogue.core.Classification') {
            resourceName = 'org.modelcatalogue.core.DataModel'
        }
        resourceName
    }

    final Map<String, String> ext = new ExtensionsWrapper(this)

    void setExt(Map<String, String> ext) {
        ext = OrderedMap.fromJsonMap(ext)
        for (String key in this.ext.keySet() - ext.keySet()) {

            this.ext.remove key
        }
        this.ext.putAll(ext)
    }

    final String toString() {
        DataModel dataModel = getDataModelId() ? DataModel.get(getDataModelId()) : null

        StringBuilder builder = new StringBuilder()

        builder << name << " ["

        if (getLatestVersionId()) {
            builder << getLatestVersionId()
        } else {
            builder << getId()
        }

        builder << '@'

        if (dataModel) {
            builder << dataModel.getSemanticVersion()
        } else if (HibernateProxyHelper.getClassWithoutInitializingProxy(this) == DataModel) {
            builder << getProperty('semanticVersion')
        } else {
            builder << "0.0.${getVersionNumber()}"
        }

        builder << "] (" << getStatus() << ":" << getClass().getSimpleName() << ":" << getId() << ')'

        if (dataModel) {
            builder << ' in ' << dataModel.getName() << '@' <<  dataModel.getSemanticVersion()
        }

        builder.toString()
    }

    @Override
    Set<ExtensionValue> listExtensions() {
        extensions
    }

    @Override
    ExtensionValue addExtension(String name, String value) {
        if (getId() && isAttached()) {
            ExtensionValue newOne = new ExtensionValue(name: name, extensionValue: value, element: this)
            FriendlyErrors.failFriendlySaveWithoutFlush(newOne)
            addToExtensions(newOne).save(validate: false)
            auditService.logNewMetadata(newOne)
            Inheritance.withChildren(this) {
                if (!it.ext.containsKey(name)) {
                    it.addExtension(name, value)
                }
            }
            return newOne
        }

        throw new IllegalStateException("Cannot add extension before saving the element (id: ${getId()}, attached: ${isAttached()})")
    }

    @Override
    void removeExtension(ExtensionValue extension) {
        Inheritance.withChildren(this) {
            ExtensionValue oldExt = it.findExtensionByName(extension.name)
            if (oldExt && oldExt.extensionValue == extension.extensionValue) {
                it.removeExtension(oldExt)
            }
        }
        auditService.logMetadataDeleted(extension)
        removeFromExtensions(extension).save(validate: false)
        extension.delete(flush: true)
    }

    @Override
    ExtensionValue findExtensionByName(String name) {
        listExtensions()?.find { it.name == name }
    }

    boolean isReadyForQueries() {
        isAttached() && !hasErrors()
    }

    @Override
    final CatalogueElement publish(Publisher<CatalogueElement> publisher, Observer<String> monitor) {
        preparePublishChain(PublishingChain.finalize(this)).run(publisher, monitor)
    }

    protected PublishingChain preparePublishChain(PublishingChain chain) { chain }

    List<CatalogueElement> collectExternalDependencies() { Collections.emptyList() }

    final CatalogueElement cloneElement(Publisher<CatalogueElement> publisher, CloningContext strategy) {
        preparePublishChain(PublishingChain.clone(this, strategy)).run(publisher, strategy.monitor)
    }

    @Override
    boolean isPublished() {
        return status in [ElementStatus.FINALIZED, ElementStatus.DEPRECATED]
    }

    /**
     * Method called after successfully finishing the generic merge
     * to finish domain class specific action such as changing the value domain of data elements.
     *
     * @param destination element in which this element was successfully merged
     */
    void afterMerge(CatalogueElement destination) {}

    void afterInsert() {
        auditService.logElementCreated(this)
    }

    void beforeInsert() {
        removeModelCatalogueIdIfDefault()
    }

    void beforeUpdate() {
        removeModelCatalogueIdIfDefault()
        auditService.logElementUpdated(this)

        CatalogueElement self = this


        if (inheritedAssociationsNames.any { self.isDirty(it) }) {
            Inheritance.withChildren(this) { CatalogueElement it, Relationship rel ->
                boolean changed = false

                for (String propertyName in inheritedAssociationsNames) {
                    if (self.isDirty(propertyName) && HibernateHelper.ensureNoProxy(it.getProperty(propertyName)) == HibernateHelper.ensureNoProxy(self.getValueToBeInherited(it, propertyName, rel.ext, true))) {
                        it.setProperty(propertyName, self.getValueToBeInherited(it, propertyName, rel.ext, false))
                        changed = true
                    }
                }

                if (changed) {
                    FriendlyErrors.failFriendlySaveWithoutFlush(it)
                }
            }

            for (String propertyName in inheritedAssociationsNames) {
                if (self.isDirty(propertyName) && self.getProperty(propertyName) == null){
                    Inheritance.withParents(this) {
                        if (it.getProperty(propertyName) != null) {
                            self.setProperty(propertyName, it.getProperty(propertyName))
                        }
                    }
                }
            }
        }
    }

    void clearAssociationsBeforeDelete() {
        // it is safe to remove all versioning informations
        for (CatalogueElement e in this.supersededBy) {
            this.removeFromSupersededBy(e)
        }
        for (CatalogueElement e in this.supersedes) {
            this.removeFromSupersedes(e)
        }
        for (User u in this.isFavouriteOf) {
            this.removeFromIsFavouriteOf(u)
        }
    }

    @Override
    int countExtensions() {
        listExtensions()?.size() ?: 0
    }

    ExtensionValue updateExtension(ExtensionValue old, String value) {
        Inheritance.withChildren(this) {
            ExtensionValue oldExt = it.findExtensionByName(old.name)
            if (oldExt && oldExt.extensionValue == old.extensionValue) {
                it.updateExtension(oldExt, value)
            }
        }
        old.orderIndex = System.currentTimeMillis()
        if (old.extensionValue == value) {
            FriendlyErrors.failFriendlySaveWithoutFlush(old)
            return old
        }
        old.extensionValue = value
        if (old.validate()) {
            auditService.logMetadataUpdated(old)
        }
        FriendlyErrors.failFriendlySaveWithoutFlush(old)
    }

    /**
     * Checks whether a certain extension presents in this catalogue element.
     * @param shortName Short name of the extension. It is prefixed with <i>http://www.modelcatalogue.org/metadata/#</i>.
     */
    void checkExtensionPresence(String shortName) {
        if (!ext.get("http://www.modelcatalogue.org/metadata/#$shortName"))
            errors.rejectValue("ext", "catalogElement.ext.$shortName", "${shortName.capitalize()} must be specified!")
    }

    // -- API

    @Override
    List<org.modelcatalogue.core.api.Relationship> getIncomingRelationshipsByType(org.modelcatalogue.core.api.RelationshipType type) {
        getIncomingRelationshipsByType(type as RelationshipType)
    }

    @Override
    List<org.modelcatalogue.core.api.Relationship> getOutgoingRelationshipsByType(org.modelcatalogue.core.api.RelationshipType type) {
        getOutgoingRelationshipsByType(type as RelationshipType)
    }

    @Override @Deprecated
    List<org.modelcatalogue.core.api.Relationship> getRelationshipsByType(org.modelcatalogue.core.api.RelationshipType type) {
        getRelationshipsByType(type as RelationshipType)
    }

    @Override
    int countIncomingRelationshipsByType(org.modelcatalogue.core.api.RelationshipType type) {
        countIncomingRelationshipsByType(type as RelationshipType)
    }

    @Override
    int countOutgoingRelationshipsByType(org.modelcatalogue.core.api.RelationshipType type) {
        countOutgoingRelationshipsByType(type as RelationshipType)
    }

    @Override @Deprecated
    int countRelationshipsByType(org.modelcatalogue.core.api.RelationshipType type) {
        countOutgoingRelationshipsByType(type as RelationshipType)
    }

    @Override
    org.modelcatalogue.core.api.Relationship createLinkTo(Map<String, Object> parameters, org.modelcatalogue.core.api.CatalogueElement destination, org.modelcatalogue.core.api.RelationshipType type) {
        createLinkTo(parameters, destination as CatalogueElement, type as RelationshipType)
    }

    @Override
    org.modelcatalogue.core.api.Relationship createLinkFrom(Map<String, Object> parameters, org.modelcatalogue.core.api.CatalogueElement source, org.modelcatalogue.core.api.RelationshipType type) {
        createLinkFrom(parameters, source as CatalogueElement, type as RelationshipType)
    }

    @Override
    org.modelcatalogue.core.api.Relationship removeLinkTo(org.modelcatalogue.core.api.CatalogueElement destination, org.modelcatalogue.core.api.RelationshipType type) {
        removeLinkTo(destination as CatalogueElement, type as RelationshipType)
    }

    @Override
    org.modelcatalogue.core.api.Relationship removeLinkFrom(org.modelcatalogue.core.api.CatalogueElement source, org.modelcatalogue.core.api.RelationshipType type) {
        removeLinkFrom(source as CatalogueElement, type as RelationshipType)
    }

    String getCombinedVersion() {
        "${getLatestVersionId() ?: getId() ?: '<id not assigned yet>'}@${getDataModelSemanticVersion() ?: "0.0.${getVersionNumber()}"}"
    }

    final void addInheritedAssociations(CatalogueElement child, Map<String, String> metadata) {
        for (String propertyName in inheritedAssociationsNames) {
            if (canInherit(child, propertyName, metadata)) {
                child.setProperty(propertyName, getValueToBeInherited(child, propertyName, metadata, false))
                child.afterPropertyInherited(propertyName, metadata)
            }
        }
        FriendlyErrors.failFriendlySave(child)
    }

    protected void afterPropertyInherited(String s, Map<String, String> metadata) {}

    protected boolean canInherit(CatalogueElement child, String propertyName, Map<String, String> metadata) {
        return child.getProperty(propertyName) == null
    }

    final void removeInheritedAssociations(CatalogueElement child, Map<String, String> metadata) {
        for (String propertyName in inheritedAssociationsNames) {
            if (isInherited(child, propertyName, metadata, false)) {
                child.setProperty(propertyName, null)
                child.afterInheritedPropertyRemoved(propertyName, metadata)
            }
        }
        FriendlyErrors.failFriendlySave(child)
    }

    protected void afterInheritedPropertyRemoved(String s, Map<String, String> metadata) {}

    protected boolean isInherited(CatalogueElement child, String propertyName, Map<String, String> metadata, boolean persistent) {
        return child.getProperty(propertyName) == getValueToBeInherited(child, propertyName, metadata, persistent)
    }


    protected Object getValueToBeInherited(CatalogueElement child, String propertyName, Map<String, String> metadata, boolean persistent) {
        return persistent ? getPersistentValue(propertyName) : getProperty(propertyName)
    }

    Iterable<String> getInheritedAssociationsNames() { ImmutableSet.of('description') }

    String getDataModelSemanticVersion() {
        if (HibernateProxyHelper.getClassWithoutInitializingProxy(this) == DataModel) {
            return getProperty('semanticVersion')
        }
        return getDataModel()?.semanticVersion
    }

    String getLink() {
        "/${GrailsNameUtils.getPropertyName(getClass())}/${getId()}".toString()
    }

    Long getFirstParentId() {
        if (getDataModel()) {
            return getDataModel().getId()
        }
        return null
    }
}
