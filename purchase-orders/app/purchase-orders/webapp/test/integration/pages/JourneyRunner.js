sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/uvs/praneeth/purchaseorders/test/integration/pages/PurchaseOrdersList",
	"com/uvs/praneeth/purchaseorders/test/integration/pages/PurchaseOrdersObjectPage",
	"com/uvs/praneeth/purchaseorders/test/integration/pages/PurchaseOrdersItemsObjectPage"
], function (JourneyRunner, PurchaseOrdersList, PurchaseOrdersObjectPage, PurchaseOrdersItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/uvs/praneeth/purchaseorders') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrdersList: PurchaseOrdersList,
			onThePurchaseOrdersObjectPage: PurchaseOrdersObjectPage,
			onThePurchaseOrdersItemsObjectPage: PurchaseOrdersItemsObjectPage
        },
        async: true
    });

    return runner;
});

