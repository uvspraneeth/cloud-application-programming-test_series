namespace uvs.po.common;

type UnitOfMeasure : String enum {};

aspect UoM {
    UnitOfMeasure : UnitOfMeasure
}

aspect Managed {
    createdBy  : String    @cds.on.insert: $user;
    createdAt  : Timestamp @cds.on.insert: $now;
}