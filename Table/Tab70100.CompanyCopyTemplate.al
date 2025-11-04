table 70100 "Company Copy Template"
{
    // CC1.5, Company Copy, Emiel Romein eromein@home.nl

    DataPerCompany = false;
    //TODO
    //LookupPageID = 70000;
    fields
    {
        field(1; Name; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            // cleaned
        }
        field(3; "From Company"; Text[30])
        {
            // cleaned
            TableRelation = Company;
        }
        field(4; "To Company"; Text[30])
        {
            // cleaned
            TableRelation = Company;
        }
        field(5; "Commit After Table Copy"; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        "Table".SETRANGE("Template Name", Name);
        "Table".DELETEALL := TRUE;
    end;

    var
        "Table": Record "Company Copy Table";

}
