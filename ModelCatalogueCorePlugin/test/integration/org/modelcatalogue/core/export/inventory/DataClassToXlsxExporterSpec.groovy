package org.modelcatalogue.core.export.inventory

import grails.test.spock.IntegrationSpec
import org.junit.Rule
import org.junit.rules.TemporaryFolder
import org.modelcatalogue.core.*
import org.modelcatalogue.core.api.ElementStatus
import org.modelcatalogue.core.util.builder.DefaultCatalogueBuilder

import static org.modelcatalogue.core.util.test.FileOpener.open

class DataClassToXlsxExporterSpec extends AbstractIntegrationSpec {

    ElementService elementService
    DataModelService dataModelService
    DataClassService dataClassService

    @Rule
    TemporaryFolder temporaryFolder = new TemporaryFolder()

    def setup() {
        buildComplexModel(dataModelService, elementService)
    }

    def "export model to excel"() {
        when:
        File file = temporaryFolder.newFile("${System.currentTimeMillis()}.xlsx")
        DataClass model = DataClass.findByName(COMPLEX_MODEL_ROOT_DATA_CLASS_NAME)

        new DataClassToXlsxExporter(model, dataClassService).export(file.newOutputStream())

        open file

        then:
        noExceptionThrown()

    }

}
