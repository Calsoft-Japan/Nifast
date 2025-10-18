table 70780 "Conv. Export Document Setup"
{
    Caption = 'Conv. Export Document Setup';
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(11; "Print U.S. Cert. of Origin"; Boolean)
        {
            Caption = 'Print U.S. Cert. of Origin';
            InitValue = true;
        }
        field(12; "Print NAFTA Cert. of Origin"; Boolean)
        {
            Caption = 'Print NAFTA Cert. of Origin';
            InitValue = true;
        }
        field(13; "Print Commercial Invoice"; Boolean)
        {
            Caption = 'Print Commercial Invoice';
            InitValue = true;
        }
        field(14; "Comm. Invoice Detail Summary"; Option)
        {
            Caption = 'Comm. Invoice Detail Summary';
            OptionCaption = 'By Item No.,By Schedule B Code';
            OptionMembers = "By Item No.","By Schedule B Code";
        }
        field(15; "Print S.E.D."; Boolean)
        {
            Caption = 'Print S.E.D.';
        }
        field(16; "One Copy Export Doc Per Shpmt"; Boolean)
        {
            Caption = 'One Copy Export Doc Per Shpmt';
        }
        field(17; "Tariff Number on Export Docs"; Boolean)
        {
            Caption = 'Tariff Number on Export Docs';
        }
        field(18; "Export Document Long Name Type"; Option)
        {
            Caption = 'Export Document Long Name Type';
            OptionCaption = 'Error,Warning (Truncate),Auto Truncate';
            OptionMembers = Error,"Warning (Truncate)","Auto Truncate";
        }
        field(19; "Export Doc. Long Address Type"; Option)
        {
            Caption = 'Export Doc. Long Address Type';
            OptionCaption = 'Error,Warning (Truncate),Auto Truncate';
            OptionMembers = Error,"Warning (Truncate)","Auto Truncate";
        }
        field(20; "Exp. Src. Doc. Long Name Type"; Option)
        {
            Caption = 'Exp. Src. Doc. Long Name Type';
            OptionCaption = 'Error,Warning (Truncate),Auto Truncate,Only Warning,No Check';
            OptionMembers = Error,"Warning (Truncate)","Auto Truncate","Only Warning","No Check";
        }
        field(21; "Exp. Src. Doc. Long Addr. Type"; Option)
        {
            Caption = 'Exp. Src. Doc. Long Addr. Type';
            OptionCaption = 'Error,Warning (Truncate),Auto Truncate,Only Warning,No Check';
            OptionMembers = Error,"Warning (Truncate)","Auto Truncate","Only Warning","No Check";
        }
        field(22; "Export Doc. Weight As"; Option)
        {
            Caption = 'Export Doc. Weight As';
            OptionCaption = 'Actual Weight,Package Weight Equally,Package Weight by Value';
            OptionMembers = "Actual Weight","Package Weight Equally","Package Weight by Value";
        }
        field(23; "Export Doc Package Weight"; Integer)
        {
            Caption = 'Export Doc Package Weight';
        }
        field(24; "Export Rpts. Excl. Pkg. Disc."; Boolean)
        {
            Caption = 'Export Rpts. Excl. Pkg. Disc.';
        }
        field(25; "AES Commodity Minimum Value"; Decimal)
        {
            Caption = 'AES Commodity Minimum Value';
            InitValue = 2.500;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}
