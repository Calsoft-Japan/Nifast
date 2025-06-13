tableextension 50037 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50000;"EDI Line No.";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005;"Certificate No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"Drawing No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50020;"Revision No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025;"Revision Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50027;"Revision No. (Label Only)";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50030;"Total Parcels";Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
            Description = '#10069';
        }
        field(50100;"Storage Location";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50105;"Line Supply Location";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50110;"Deliver To";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50115;"Receiving Area";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50120;"Ran No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50125;"Container No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50130;"Kanban No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50135;"Res. Mfg.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50140;"Release No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50145;"Mfg. Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50150;"Man No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50155;"Delivery Order No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50157;"Plant Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50160;"Dock Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50165;"Box Weight";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50170;"Store Address";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50175;"FRS No.";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50180;"Main Route";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50185;"Line Side Address";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50190;"Sub Route Number";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50195;"Special Markings";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50200;"Eng. Change No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50205;"Group Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50500;"Model Year";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50800;"Entry/Exit Date";Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801;"Entry/Exit No.";Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50802;National;Boolean)
        {
            Caption = 'National';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50803;"IoT Lot No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CIS.Ram IoT';
        }
    }
}
