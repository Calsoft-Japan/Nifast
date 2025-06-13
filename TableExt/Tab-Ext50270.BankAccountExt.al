tableextension 50270 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(50000;"Bank Code SAT";Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Numeric = true;
        }
        field(50001;"Client Number Payee Match";Code[9])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50002;"Transit/Branch Number";Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50003;"SRF Number";Code[9])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50005;"File Number Payee Match";Code[4])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
            
        }
    }
}
