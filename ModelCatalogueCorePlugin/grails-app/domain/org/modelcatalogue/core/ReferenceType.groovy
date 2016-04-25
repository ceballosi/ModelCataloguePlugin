package org.modelcatalogue.core

import org.modelcatalogue.core.publishing.Publisher
import org.modelcatalogue.core.publishing.PublishingChain

class ReferenceType extends DataType {

    DataClass dataClass

    static constraints = {
        dataClass nullable: true, fetch: 'join'
    }

    static mapping = {
        dataClass lazy: false
    }

    static fetchMode = [dataClass: 'eager']


    @Override
    protected PublishingChain preparePublishChain(PublishingChain chain) {
        super.preparePublishChain(chain).add(this.dataClass)
    }

    List<String> getInheritedAssociationsNames() { ['dataClass'] }

}
