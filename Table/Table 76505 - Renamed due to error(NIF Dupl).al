table 76505 "Renamed due to error(NIF Dupl)"
{
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
        }
        field(2; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(3; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            NotBlank = true;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Test Quality"; Option)
        {
            Caption = 'Test Quality';
            OptionCaption = ' ,Good,Average,Bad';
            OptionMembers = " ",Good,"Average",Bad;
        }
        field(12; "Certificate Number"; Code[20])
        {
            Caption = 'Certificate Number';
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(14; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(20; Inventory; Decimal)
        {
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(21; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
        }
        field(22; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
        }
        field(23; "Bin Filter"; Code[20])
        {
            Caption = 'Bin Filter';
        }
        field(24; "Expired Inventory"; Decimal)
        {
            Caption = 'Expired Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50010; "Mfg. Lot No."; Text[30])
        {
            // cleaned
        }
        field(50050; "Mfg. Date"; Date)
        {
            // cleaned
        }
        field(50055; "Mfg. Name"; Text[50])
        {
            // cleaned
        }
        field(50060; "Vendor No."; Code[20])
        {
            // cleaned
        }
        field(50070; "Vendor Name"; Text[50])
        {
            // cleaned
        }
        field(50075; "Date Received"; Date)
        {
            // cleaned
        }
        field(50080; "Country of Origin"; Code[10])
        {
            // cleaned
        }
        field(50090; "Source Location"; Code[10])
        {
            // cleaned
        }
        field(50100; "Multiple Certifications"; Integer)
        {
            Editable = false;
        }
        field(50105; "Certification Number"; Code[20])
        {
            // cleaned
        }
        field(50110; "Certification Type"; Option)
        {
            OptionMembers = " ",Internal,Vendor,Manufacturer;
        }
        field(50115; "Certification Scope"; Option)
        {
            OptionMembers = " ","Visual Only",Sample,Full;
        }
        field(50120; "Passed Inspection"; Boolean)
        {

        }
        field(50125; "Inspection Comments"; Text[100])
        {
            // cleaned
        }
        field(50130; "Quantity Tested"; Decimal)
        {
            // cleaned
        }
        field(50135; "Tested By"; Code[10])
        {
            // cleaned
        }
        field(50140; "Tested Date"; Date)
        {
            // cleaned
        }
        field(50150; "Tested Time"; Time)
        {
            // cleaned
        }
        field(50155; "QC Order Lines"; Integer)
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
            Enabled = false;
        }
        field(50160; "PO Number"; Code[20])
        {
            // cleaned
        }
        field(50170; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50171; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50172; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50500; "Open Whse. Entries Exist"; Boolean)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Item No.", "Variant Code", "Lot No.")
        {
        }
        key(Key2; "Item No.", "Mfg. Lot No.")
        {
        }
    }
}
