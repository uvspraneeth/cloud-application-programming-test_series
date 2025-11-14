using MyService as service from '../../srv/service';
annotate service.PurchaseOrders with @(
    UI.HeaderInfo: {
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title:    { Value: PO_ID },
        Description: { Value: LIFECYCLE_STATUS }
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Currency',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Gross Amount',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Net Amount',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Tax Amount',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Purchase Order ID',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Life Cycle Status',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Over Status',
                Value : OVERALL_STATUS,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Currency Code',
            Value : CURRENCY_code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Gross Amount',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Net Amount',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Tax Amount',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Purchase Order ID',
            Value : PO_ID,
        },
    ],
);

annotate service.PurchaseOrders with {
    PARTNER_GUID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Businesspartners',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : PARTNER_GUID_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'BP_ROLE',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'EMAIL_ADDRESS',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'PHONE_NUMBER',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'FAX_NUMBER',
            },
        ],
    }
};

