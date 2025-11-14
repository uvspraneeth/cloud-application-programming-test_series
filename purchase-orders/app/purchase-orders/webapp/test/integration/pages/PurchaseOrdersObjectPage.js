sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.uvs.praneeth.purchaseorders',
            componentId: 'PurchaseOrdersObjectPage',
            contextPath: '/PurchaseOrders'
        },
        CustomPageDefinitions
    );
});