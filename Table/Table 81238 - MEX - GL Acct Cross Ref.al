table 81238 "MEX - G/L Acct Cross Ref"
{
    fields
    {
        field(1; "Old Acct No."; Code[30])
        {
            // cleaned
        }
        field(2; Name; Text[80])
        {
            // cleaned
        }
        field(3; "Navision Acct. No."; Code[20])
        {
            // cleaned
        }
        field(10; "Navision Acct. Exists"; Boolean)
        {
            CalcFormula = Exist("G/L Account" WHERE("No." = FIELD("Navision Acct. No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Navision Account Type"; Option)
        {
            CalcFormula = Lookup("G/L Account"."Account Type" WHERE("No." = FIELD(FILTER("Navision Acct. No."))));
            Caption = 'Account Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            var
               /*  GLEntry: Record 17;
                GLBudgetEntry: Record 96; */
            begin
            end;

        }
        field(12; "Navision Account Name"; Text[50])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("Navision Acct. No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Seg1; Code[10])
        {
            // cleaned
        }
        field(21; Seg2; Code[10])
        {
            // cleaned
        }
        field(22; Seg3; Code[10])
        {
            // cleaned
        }
        field(50; Comment; Text[30])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Old Acct No.")
        {
        }
    }

    fieldgroups
    {
    }
}
