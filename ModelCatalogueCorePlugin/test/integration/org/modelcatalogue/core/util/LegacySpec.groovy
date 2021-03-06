package org.modelcatalogue.core.util

import grails.test.spock.IntegrationSpec
import grails.util.Holders
import spock.lang.Unroll

class LegacySpec extends IntegrationSpec {

    @Unroll
    def "fixes model catalogue id #original to #fixed"() {
        Object old = Holders.grailsApplication.config.grails.serverURL
        Holders.grailsApplication.config.grails.serverURL = "http://localhost:8080/ModelCatalogueCorePluginTestApp"
        expect:
        Legacy.fixModelCatalogueId(original) == fixed


        cleanup:
        Holders.grailsApplication.config.grails.serverURL = old

        where:
        original                                                                                | fixed
        null                                                                                    | null
        'http://localhost:8080/ModelCatalogueCorePluginTestApp/catalogue/classification/24.1'   | 'http://localhost:8080/ModelCatalogueCorePluginTestApp/catalogue/dataModel/24.1'
        'http://localhost:8080/ModelCatalogueCorePluginTestApp/catalogue/model/22.1'            | 'http://localhost:8080/ModelCatalogueCorePluginTestApp/catalogue/dataClass/22.1'
        'http://www.example/model/ka'                                                           | 'http://www.example/model/ka'
        'http://localhost:8080/ModelCatalogueCorePluginTestApp/catalogue/dataElement/22.1'      | 'http://localhost:8080/ModelCatalogueCorePluginTestApp/catalogue/dataElement/22.1'

    }

}
