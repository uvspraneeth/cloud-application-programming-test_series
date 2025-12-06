using {
    cuid,
    Country,
    Currency
} from '@sap/cds/common';
using {
    uvs.po.common.UoM,
    uvs.po.common.Managed
} from '../po_common/common';

namespace uvs.po.db;

// Master Data Schema.
context MasterData {
    // Types
    type MaterialTypes  : String enum {
        RawMaterials = 'Raw Material';
        Service;
        Others;
    }

    type GST            : String @assert.format: '\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}';

    type IsActive       : String enum {
        Active;
        InActive
    }

    type PaymentTerms   : String(10) enum {
        days30 = '30 days';
        days40 = '40 days'
    }

    // Aspects
    aspect ContactInfo {
        phone        : String @assert.format: '^\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$';
        emailAddress : String @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    }

    aspect Address : ContactInfo {
        country : Country default 'IN';
        state   : String;
        city    : String;
        pincode : Integer;
    }

    /**
     * Materials represent the Materials information in Procurement Life cycle,
     */
    entity Materials : cuid, UoM {
        /**
         * Material code prefixed with "M",
         * Unique Code for Material Identification.
         */
        @assert.unique
        @sql.unique
        code          : String(10) @mandatory;
        description   : String;

        @assert.enum
        materialType  : MaterialTypes;
        standardPrice : Decimal(15, 2);
        gstPercentage : Decimal(15, 2);

        @assert.enum
        isActive      : IsActive default #Active
    }

    /**
     * Vendors represents the Vendors information in Procurement life cycle,
     */
    entity Vendors : cuid, Address {
        @assert.unique
        @sql.unique
        code         : String(10) @mandatory;
        firstName    : String(30);
        lastName     : String(10);
        /**
        * Concatenated display name for Vendor records and reports.
        * Auto-computed from firstName + lastName on write; stored for query performance.
        */
        fullName     : String = firstName || ' ' || lastName stored;

        @assert.unique
        GSTIN        : GST        @title: 'GST IN';

        @assert.enum
        paymentTerms : PaymentTerms;

        @assert.enum
        isActive     : IsActive default #Active;
    }
}

// Purchase Order Management Schema.
context PurchaseOrderManagement {

    // Types
    type OrderStatus    : String enum {
        Draft;
        Submitted;
        Approved;
        Rejected;
        Closed;
        Cancelled
    }

    type ItemStatus     : String enum {
        Open;
        Partially;
        Received;
        FullyRecevied = 'Fully Received';
        Cancelled
    }

    // Aspects
    /** Aspect OrdersManaged for User who & when created this Order record.
         * User who & when Approved this Order record.
         * Auto-populated on insert from current session user.
         */
    aspect OrdersManaged : Managed {
        ApprovedBy : String    @cds.on.insert: $user;
        ApprovedAt : Timestamp @cds.on.insert: $now;

    }

    /**
     * Orders represents the Purchase Orders made by the users
     * Tracks the Orders Total Net Price, Status in the Procurement life cycle
     */
    entity Orders : cuid, OrdersManaged {
        @assert.unique
        @sql.unique
        orderNumber   : String(10);
        /**
         * Links Vendors, used for allocation of Payment Terms.
         */
        vendor        : Association to MasterData.Vendors not null;
        purchasingOrg : String(20);
        currency      : Currency;
        documentDate  : Timestamp;
        deliveryDate  : Timestamp;
        totalNetPrice : Decimal(15, 2);

        @assert.enum
        status        : OrderStatus;
        remarks       : String;
        orderItems    : Composition of many Items
                            on orderItems.order = $self
    }

    entity Items : UoM {
        key ID            : String(10);
            order         : Association to Orders;
            lineItemNo    : Integer;
            material      : Association to MasterData.Materials not null;
            description   : String;
            quantity      : Integer;
            netPrice      : Decimal(15, 2) @title: 'Net Price/unit';
            discount      : Decimal(15, 2);
            gstPercentage : Decimal(15, 2);

            @assert.enum
            status        : ItemStatus default #Open
    }
}

context Goods {

    // Types
    type ReceiptStatus  : String enum {
        Draft;
        Posted;
    }


    entity Receipt : cuid, Managed {
        @assert.unique
        @sql.unique
        receiptNo    : Integer;
        order        : Association to PurchaseOrderManagement.Orders;
        date         : Date;
        wareHouseLoc : String @title: 'WareHouse Location';

        @assert.enum
        status       : ReceiptStatus;
        goodsItems   : Composition of many Items
                           on goodsItems.receipt = $self
    }

    entity Items {
        key ID        : String(10);
            receipt   : Association to Receipt;
            orderItem : Association to PurchaseOrderManagement.Items not null;
            batch     : Integer;
            remarks   : String;
    }
}


context VendorInvoiceManagement {

    type InvoiceStatus  : String enum {
        Draft;
        Verified;
        Posted;
        Rejected;
        Cancelled
    }

    type InvoiceManaged : Managed {
        VerifiedBy : String;
        VerifiedAt : Timestamp @cds.on.insert: $now;
        PostedBy   : String;
        PostedAt   : Timestamp @cds.on.insert: $now
    }

    entity Invoice : cuid, InvoiceManaged {
        @assert.unique
        @sql.unique
        invoiceNo         : Integer;
        order             : Association to PurchaseOrderManagement.Orders not null;
        goodsReceipt      : Association to Goods.Receipt not null;
        generatedOn       : DateTime;
        postingOn         : DateTime;
        currency          : Currency;
        preTaxAmount      : Decimal(15, 2) @title: 'Total Amount Before Tax';
        taxAmount         : Decimal(15, 2);
        status            : InvoiceStatus;
        reasonOfRejection : String;
        invoiceItems      : Composition of many Items
                                on invoiceItems.invoice = $self
    }

    entity Items : UoM {
        key ID              : String(10);
            invoice         : Association to Invoice;
            orderItem       : Association to PurchaseOrderManagement.Items not null;
            goodsItem       : Association to Goods.Items not null;
            quantity        : Integer;
            discount        : Decimal(15, 2);
            gstPercentage   : Decimal(15, 2);
            lineNetAmount   : Decimal(15, 2);
            lineTotalAmount : Decimal(15, 2)
    }
}
