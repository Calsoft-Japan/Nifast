tableextension 50003 "Payment Terms Ext" extends "Payment Terms"
{
    // version NAVW13.10,NV4.29,N,SE0.50.32FDC,NIF0.000
    fields
    {
        field(60000; "COL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "MPD Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "LEN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "SAL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60020; "TN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60025; "MICH Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60030; "IBN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //TODO
        /*  field(14000701; "COD Payment"; Boolean)
         {
             BlankZero = true;
             Caption = 'COD Payment';
             Description = 'NV';
         }
         field(14000702; "COD Cashiers Check"; Boolean)
         {
             Caption = 'COD Cashiers Check';
             Description = 'NV';
         } */
        //TODO
        field(14017610; Deferred; Boolean)
        {
            Description = 'NV';

            trigger OnValidate();
            begin
                TESTFIELD("Discount %", 0);
            end;
        }
        field(14017611; "No. of Payments"; Integer)
        {
            Description = 'NV';
            MaxValue = 12;
            MinValue = 0;
        }
        field(14017612; "Deferred Delay Date Calc."; DateFormula)
        {
            Description = 'NV';
        }
    }
}
