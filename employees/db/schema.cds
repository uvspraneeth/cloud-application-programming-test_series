namespace ust.uvspraneeth.db;
using { Currency , cuid } from '@sap/cds/common';
using { ust.uvspraneeth.resue.EmailAddress as EmailAddress,
        ust.uvspraneeth.resue.Gender as Gender,
        ust.uvspraneeth.resue.PhoneNumber as PhoneNumber 
      } from './common';

entity Employees : cuid {
    nameFirst     : String(49);
    nameMiddle    : String(40);
    nameLast      : String(40);
    nameInitials  : String(40);
    gender        : Gender;
    language      : String(1);
    phoneNumber   : PhoneNumber;
    email         : EmailAddress;
    loginName     : String(12);
    currency      : Currency;
    salaryAmount  : Decimal(10, 2);
    accountNumber : String(16);
    bankID        : String(8);
    bankName      : String(64)

}

    
