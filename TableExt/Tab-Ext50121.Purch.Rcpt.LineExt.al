tableextension 50121 "Purch. Rcpt. Line Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            // cleaned
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            // cleaned
        }
        field(50005; "Sail-on Date"; Date)
        {
            Description = '#10044';
        }
        field(50007; "Vessel Name"; Code[50])
        {
            Description = '#10044';
        }
        field(50010; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50011; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50012; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(51000; Select; Boolean)
        {
            // cleaned
        }
        field(51010; "Transfer Order Created"; Boolean)
        {
            // cleaned
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            // cleaned
        }
        field(52010; Manufacturer; Code[50])
        {
            // cleaned
        }
        field(60000; "HS Tariff Code"; Code[10])
        {
            Editable = false;
        }
    }

    keys
    {
        key(RPTSort; Type, "No.") { }
    }
}
