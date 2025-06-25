tableextension 50039 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "USD Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Forex';
            Editable = false;
        }
        field(50005; "Sail-on Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50007; "Vessel Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50010; "Drawing No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Revision No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Revision Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50803; "Is retention Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
        }
        field(50804; "Is Withholding Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(52010; Manufacturer; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Alt. Price"; Decimal)//14017672->50003 BC Upgrade 
        { }
        field(50004; "Alt. Price UOM"; Decimal)//14017673->50004 BC Upgrade 
        { }
    }
}
