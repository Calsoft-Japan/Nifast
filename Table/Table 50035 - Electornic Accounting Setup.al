table 50035 "Electornic Accounting Setup"
{
    Caption = 'Electronic Accouting Setup';
    fields
    {
        field(1; "Entry No"; Integer)
        {
            // cleaned
        }
        field(10; "SAT XML Path"; Text[250])
        {
            Caption = 'SAT XML Path';
        }
        field(20; "Check Element Code"; Code[10])
        {
            Caption = 'Check Element Code';
            TableRelation = "SAT Payment Method Codes".Code;
            ValidateTableRelation = false;
        }
        field(30; "Transfer Element Code"; Code[10])
        {
            Caption = 'Transfer Element Code';
            TableRelation = "SAT Payment Method Codes".Code;
            ValidateTableRelation = false;
        }
        field(40; "Nationals Operations Code"; Code[10])
        {
            Caption = 'Nationals Operations Code';

            TableRelation = "Gen. Business Posting Group";
        }
        field(50; "Foreign Operations Code"; Code[10])
        {
            Caption = 'Foreign Operations Code';
            TableRelation = "Gen. Business Posting Group";
        }
        field(60; "EA Sales - Chk VAT Em"; Boolean)
        {
            Caption = 'Sales - Validate VAT Registration No Emisor';
        }
        field(70; "EA Sales - Chk VAT Rc"; Boolean)
        {
            Caption = 'Sales - Validate VAT Registration No Receptor';
        }
        field(80; "EA Purch - Chk VAT Em"; Boolean)
        {
            Caption = 'Purchase - Validate VAT Registratio No Emisor';
        }
        field(90; "EA Purch - Chk VAT Rc"; Boolean)
        {
            Caption = 'Purchase - Validate VAT Registration No Receptor';
        }
        field(100; "EA Validate Date"; Boolean)
        {
            Caption = 'Validate Date';
        }
        field(110; "EA Chk Amount"; Boolean)
        {
            Caption = 'Validate Amount';
        }
        field(120; "EA Variant Amount"; Decimal)
        {
            Caption = 'Variant on Amount';
        }
        field(130; "EA Chk UUID"; Boolean)
        {
            Caption = 'Validate UUID';
        }
    }
    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}
