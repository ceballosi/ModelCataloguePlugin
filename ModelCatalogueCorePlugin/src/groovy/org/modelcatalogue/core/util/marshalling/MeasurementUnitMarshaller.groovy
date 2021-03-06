package org.modelcatalogue.core.util.marshalling

import grails.util.GrailsNameUtils
import org.modelcatalogue.core.MeasurementUnit
import org.modelcatalogue.core.PrimitiveType

/**
 * Marshallers for MeasurementUnit.
 */
class MeasurementUnitMarshaller extends CatalogueElementMarshaller {

    MeasurementUnitMarshaller() {
        super(MeasurementUnit)
    }

    protected Map<String, Object> prepareJsonMap(unit) {
        if (!unit) return [:]
        def ret = super.prepareJsonMap(unit)
        ret.putAll(symbol: unit.symbol)
        ret.primitiveTypes = [count: unit.countPrimitiveTypes(), itemType: PrimitiveType.name, link: "/${GrailsNameUtils.getPropertyName(unit.getClass())}/$unit.id/primitiveType"]
        return ret
    }
}
