table 90000 "Table Import"
{
    DataCaptionFields = "Code", Description;
    DataPerCompany = false;
    //TODO
    // DrillDownPageID = 90004;
    // LookupPageID = 90004;
    fields
    {
        field(1; "Code"; Code[10])
        {
            // cleaned
        }
        field(2; "Table"; Option)
        {
            OptionMembers = Customer,Vendor,Item,"Gen. Journal","Item Journal","Sales Header","Sales Line","Purchase Header","Purchase Line","Sales Shipment Header","Sales Shipment Line","Sales Invoice Header","Sales Invoice Line","Sales Cr.Memo Header","Sales Cr.Memo Line","Purchase Rcpt. Header","Purchase Rcpt. Line","Purchase Invoice Header","Purchase Invoice Line","Purchase Cr. Memo Header","Purchase Cr. Memo Line";
            trigger OnValidate()
            begin
                IF (Table IN [Table::"Gen. Journal", Table::"Item Journal", Table::"Sales Header", Table::"Sales Line",
                   Table::"Purchase Header", Table::"Purchase Line"])
                THEN
                    "Delete Table Before Import" := FALSE;
                IF NOT (Table IN [Table::Customer, Table::Vendor, Table::Item]) THEN
                    "Update existing records" := FALSE;
            end;
        }
        field(3; Filetype; Option)
        {
            OptionMembers = Variable,"Fixed";
        }
        field(4; "Field start dilimiter"; Text[1])
        {
            InitValue = '"';
        }
        field(5; "Field end dilimiter"; Text[1])
        {
            InitValue = '"';
        }
        field(6; "Field seperator"; Text[1])
        {
            InitValue = ',';
        }
        field(7; "Start Lineno."; Integer)
        {
            // cleaned
        }
        field(8; "Char Table"; Option)
        {
            OptionMembers = OEM,Ansi;
        }
        field(9; "Allow Duplicates"; Boolean)
        {
            // cleaned
        }
        field(10; "Update existing records"; Boolean)
        {
            trigger OnValidate()
            begin
                IF "Update existing records" AND NOT (Table IN [Table::Customer, Table::Vendor, Table::Item]) THEN
                    FIELDERROR("Update existing records", 'can only be used on Customer, Vendor and Item.');
            end;
        }
        field(20; "Default filename"; Text[250])
        {
            // cleaned
        }
        field(21; "Delete Table Before Import"; Boolean)
        {
            trigger OnValidate()
            begin
                IF "Delete Table Before Import" AND
                   (Table IN [Table::"Gen. Journal", Table::"Item Journal", Table::"Sales Header", Table::"Sales Line",
                   Table::"Purchase Header", Table::"Purchase Line"])
                THEN
                    FIELDERROR("Delete Table Before Import", 'can not be used on Journals.');
            end;
        }
        field(22; Description; Text[80])
        {
            // cleaned
        }
        field(50; "Last import"; Date)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TableImportDef.SETRANGE("Table Import Code", Code);
        TableImportDef.DELETEALL();
        TableImportInitValue.SETRANGE("Table Import Code", Code);
        TableImportInitValue.DELETEALL();
        TableImportFieldValue.SETRANGE("Table Import Code", Code);
        TableImportFieldValue.DELETEALL();
    end;

    var
        TableImportDef: Record 90001;
        TableImportInitValue: Record 90003;
        TableImportFieldValue: Record 90006;

    procedure TableNo(): Integer
    begin
        CASE Table OF
            Table::Customer:
                EXIT(DATABASE::Customer);
            Table::Vendor:
                EXIT(DATABASE::Vendor);
            Table::Item:
                EXIT(DATABASE::Item);
            Table::"Gen. Journal":
                EXIT(DATABASE::"Gen. Journal Line");
            Table::"Item Journal":
                EXIT(DATABASE::"Item Journal Line");
            Table::"Sales Header":
                EXIT(DATABASE::"Sales Header");
            Table::"Sales Line":
                EXIT(DATABASE::"Sales Line");
            Table::"Purchase Header":
                EXIT(DATABASE::"Purchase Header");
            Table::"Purchase Line":
                EXIT(DATABASE::"Purchase Line");
            Table::"Sales Shipment Header":
                EXIT(DATABASE::"Sales Shipment Header");
            Table::"Sales Shipment Line":
                EXIT(DATABASE::"Sales Shipment Line");
            Table::"Sales Invoice Header":
                EXIT(DATABASE::"Sales Invoice Header");
            Table::"Sales Invoice Line":
                EXIT(DATABASE::"Sales Invoice Line");
            Table::"Sales Cr.Memo Header":
                EXIT(DATABASE::"Sales Cr.Memo Header");
            Table::"Sales Cr.Memo Line":
                EXIT(DATABASE::"Sales Cr.Memo Line");
            Table::"Purchase Rcpt. Header":
                EXIT(DATABASE::"Purch. Rcpt. Header");
            Table::"Purchase Rcpt. Line":
                EXIT(DATABASE::"Purch. Rcpt. Line");
            Table::"Purchase Invoice Header":
                EXIT(DATABASE::"Purch. Inv. Header");
            Table::"Purchase Invoice Line":
                EXIT(DATABASE::"Purch. Inv. Line");
            Table::"Purchase Cr. Memo Header":
                EXIT(DATABASE::"Purch. Cr. Memo Hdr.");
            Table::"Purchase Cr. Memo Line":
                EXIT(DATABASE::"Purch. Cr. Memo Line");
        END;
    end;
}
