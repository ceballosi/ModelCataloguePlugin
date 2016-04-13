package org.modelcatalogue.core

import grails.test.spock.IntegrationSpec
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.modelcatalogue.core.util.Metadata
import org.modelcatalogue.core.util.builder.DefaultCatalogueBuilder
import org.modelcatalogue.core.util.test.TestDataHelper
import org.springframework.web.context.support.WebApplicationContextUtils

abstract class AbstractIntegrationSpec extends IntegrationSpec {

    protected static final String COMPLEX_MODEL_ROOT_DATA_CLASS_NAME = 'C4CTDE Root'
    protected static final String COMPLEX_MODEL_NAME = 'C4CTDE'

    def fixtureLoader
    def fixtures
    def initCatalogueService
    def sessionFactory
    def relationshipTypeService

    void loadMarshallers() {
        def springContext = WebApplicationContextUtils.getWebApplicationContext( ServletContextHolder.servletContext )
        springContext.getBean('modelCatalogueCorePluginCustomObjectMarshallers').register()
    }


    void initRelationshipTypes(){
        TestDataHelper.initFreshDb(sessionFactory, 'reltypes.sql') {
            initCatalogueService.initDefaultRelationshipTypes()
        }
        relationshipTypeService.clearCache()
        RelationshipType.clearCache()
    }

    void initCatalogue(){
        initCatalogueService.initCatalogue(true)
        relationshipTypeService.clearCache()
        RelationshipType.clearCache()
    }

    void loadFixtures(){
        TestDataHelper.initFreshDb(sessionFactory, 'testdata.sql') {
            initCatalogueService.initDefaultRelationshipTypes()
            fixtures = fixtureLoader.load("assets/*", "batches/*", "dataTypes/*", "enumeratedTypes/*", "measurementUnits/*", "models/*", "relationshipTypes/*", "classifications/*").load("actions/*", "users/*", "referenceTypes/*", "primitiveTypes/*").load("dataElements/*").load("extensions/*", "mappings/*").load("csvTransformations/*")
        }
        relationshipTypeService.clearCache()
        RelationshipType.clearCache()
    }

    /**
     * Builds a complex data model and stashes it in SQL for later calls.
     *
     * You have to call `./catalogue clean` script to clean the cached database script if you make any change.
     *
     * @param dataModelService
     * @param elementService
     * @return
     */
    DataModel buildComplexModel(DataModelService dataModelService, ElementService elementService) {
        TestDataHelper.initFreshDb(sessionFactory, 'complexModel.sql') {
            initRelationshipTypes()

            DefaultCatalogueBuilder builder = new DefaultCatalogueBuilder(dataModelService, elementService)

            Random random = new Random()
            List<DataType> domains = DataType.list()

            if (!domains) {
                for (int i in 1..10) {
                    DataModel classification = new DataModel(name: "C4CTDE Classification ${System.currentTimeMillis()}").save(failOnError: true)
                    new DataType(name: "C4CTDE Test Value Domain #${i}", dataModel: classification).save(failOnError: true)
                }
                domains = DataType.list()
            }

            builder.build {
                dataModel(name: COMPLEX_MODEL_NAME) {
                    description "This is a data model for testing DataModelToDocxExporter"

                    dataClass (name: COMPLEX_MODEL_ROOT_DATA_CLASS_NAME) {
                        for (int i in 1..10) {
                            dataClass name: "C4CTDE Model $i",  {
                                description "This is a description for Model $i"

                                for (int j in 1..10) {
                                    dataElement name: "C4CTDE Model $i Data Element $j", {
                                        description "This is a description for Model $i Data Element $j"
                                        DataType theType = domains[random.nextInt(domains.size())]
                                        dataType name: theType.name, dataModel: theType.dataModel ? theType.dataModel.name : null
                                    }
                                }
                                for (int j in 1..3) {
                                    dataClass name: "C4CTDE Model $i Child Model $j", {
                                        description "This is a description for Model $i Child Model $j"

                                        for (int k in 1..3) {
                                            dataElement name: "C4CTDE Model $i Child Model $j Data Element $k", {
                                                description "This is a description for Model $i Child Model $j Data Element $k"
                                                DataType domain = domains[random.nextInt(domains.size())]
                                                dataType name: domain.name, dataModel: domain.dataModel ? domain.dataModel.name : null
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ext Metadata.OWNER, 'The Owner'
                    ext Metadata.ORGANISATION, 'The Organisation'
                    ext Metadata.AUTHORS, 'Author One, Author Two, Author Three'
                    ext Metadata.REVIEWERS, 'Reviewer One, Reviewer Two, Reviewer Three'

                }
            }

        }
        return notNull(DataModel.findByName(COMPLEX_MODEL_NAME))
    }

    public <T> T notNull(T item) {
        assert item
        item
    }

}
