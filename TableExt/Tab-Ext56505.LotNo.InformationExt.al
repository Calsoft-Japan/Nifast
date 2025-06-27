tableextension 56505 "Lot No. Information Ext" extends "Lot No. Information"
{
    fields
    {
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
            // cleaned
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
        field(60000; "Patente Original"; Code[10])
        {
            Description = 'Custom Agent License No.';
        }
        field(60002; "Aduana E/S"; Code[10])
        {
            Description = 'Customer Agent E/S';
        }
        field(60010; "Pediment No."; Code[10])
        {
            Description = 'Summary Entry No.';
        }
        field(60012; "CVE Pedimento"; Code[10])
        {
            Description = 'Summary Entry Code';
        }
        field(60015; "Fecha de entrada"; Date)
        {
            Description = 'Date of Entry';
        }
        field(60020; "Tipo Cambio (1 day before)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            Editable = true;
            MinValue = 0;
        }
        field(60022; "Tipo Cambio (USD)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            Editable = true;
            MinValue = 0;
        }
        field(60023; "Tipo Cambio (JPY)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }

        field(50000; "Lot Creation Date"; Date)//NV-Lot From 14018077->50000
        { }
    }
    keys
    {
        key(RPTSort; "Mfg. Lot No.")
        { }
    }
}
