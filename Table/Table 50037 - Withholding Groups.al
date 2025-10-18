table 50037 "Withholding Groups"
{
    // //Before

    Caption = 'Tax WithHolding Setup';
    DrillDownPageID = 50155;
    LookupPageID = 50155;
    fields
    {
        field(1; "Withholding Group"; Code[10])
        {
            Caption = 'Withholding Group';
        }
        field(2; "Withholding Percentage"; Decimal)
        {
            Caption = 'Withholding Percentage';
        }
        field(3; "Purch Withholding Account"; Code[20])
        {
            Caption = 'Purch Withholding Account';
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Income Tax"; Boolean)
        {
            Caption = 'Income Tax';
            trigger OnValidate()
            begin
                IF "Income Tax" = TRUE THEN
                    "VAT Tax" := FALSE;
            end;

        }
        field(5; "VAT Tax"; Boolean)
        {
            Caption = 'VAT Tax';
            trigger OnValidate()
            begin
                IF "VAT Tax" = TRUE THEN
                    "Income Tax" := FALSE;
            end;
        }
    }
    keys
    {
        key(Key1; "Withholding Group")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Withholding Group", "Withholding Percentage", "Purch Withholding Account", "Income Tax", "VAT Tax")
        {
        }
    }
}
