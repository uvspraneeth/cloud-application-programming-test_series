using { ust.uvs.praneeth.db as db } from '../db/datamodel';

service MyService @odata.draft.enabled {

    entity Address as projection on db.master.address;
    entity Businesspartners as projection on db.master.businesspartner;
    @Capabilities.InsertRestrictions.Insertable : true
    @Capabilities.UpdateRestrictions.Updatable  : true
    @Capabilities.DeleteRestrictions.Deletable  : true
    entity Products as projection on db.master.product;
    @Capabilities.InsertRestrictions.Insertable : true
    @Capabilities.UpdateRestrictions.Updatable  : true
    @Capabilities.DeleteRestrictions.Deletable  : true
    entity PurchaseOrdersItems as projection on db.transaction.poitems;
    entity PurchaseOrders as projection on db.transaction.purchaseorder;
    annotate PurchaseOrders with {
    PO_ID            @Common.Label : 'Purchase Order ID';
    PARTNER_GUID     @Common.Label : 'Vendor';
    LIFECYCLE_STATUS @Common.Label : 'Lifecycle Status';
    OVERALL_STATUS   @Common.Label : 'Overall Status';
};

}