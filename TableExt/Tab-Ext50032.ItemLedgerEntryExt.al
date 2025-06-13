tableextension 50032 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50000;"Inspected Parts";Boolean)
        {
            Description = 'NIF';
            Editable = false;
        }
        field(50001;"Forecast on/off";Boolean)
        {
            Description = 'NIF';
            Editable = false;
        }
        field(50002;"Kitting Final Product";Code[20])
        {
            Description = 'NIF';
        }
        field(50005;"Mfg. Lot No.";Text[30])
        {
            Description = 'NIF';
            Editable = false;
        }
        field(50007;"Revision No.";Code[20])
        {
            Description = 'NIF';
            Editable = false;
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
        field(60000;"Patente Original";Code[10])
        {
            Description = 'NIF-Custom Agent License No.';
            Editable = false;
        }
        field(60002;"Aduana E/S";Code[10])
        {
            Description = 'NIF-Customer Agent E/S';
            Editable = false;
        }
        field(60010;"Pediment No.";Code[10])
        {
            Description = 'NIF-Summary Entry No.';
            Editable = false;
        }
        field(60012;"CVE Pedimento";Code[10])
        {
            Description = 'NIF-Summary Entry Code';
            Editable = false;
        }
        field(60015;"Fecha de entrada";Date)
        {
            Description = 'NIF-Date of Entry';
            Editable = false;
        }
    }
}
