using { ust.uvs.praneeth.db as db } from '../db/datamodel';

service MyService {

    entity Address as projection on db.master.address;
    entity Businesspartners as projection on db.master.businesspartner;
    entity Products as projection on db.master.product;

    entity PurchaseOrdersItems as projection on db.transaction.poitems;
    entity PurchaseOrders as projection on db.transaction.purchaseorder;


}