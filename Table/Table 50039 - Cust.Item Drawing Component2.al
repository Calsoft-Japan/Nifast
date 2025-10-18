table 50039 "Cust./Item Drawing Component2"
{
    // NF1.00:CIS.NG    08/04/16 Create New Missing table for NV Series in NAV 2015 (Save As the Old Table  - 37015303)

    //TODO
    /*  DrillDownPageID = 37015305;
     LookupPageID = 37015305; */
    //TODO

    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            // cleaned
            TableRelation = Item;
        }
        field(2; "Parent Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(3; "Parent Drawing No."; Code[30])
        {
            NotBlank = true;
        }
        field(4; "Parent Revision No."; Code[20])
        {
            // cleaned
        }
        field(10; "Drawing No."; Code[30])
        {
            NotBlank = true;
        }
        field(20; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(30; "Revision Date"; Date)
        {
            // cleaned
        }
        field(35; Description; Text[50])
        {
            // cleaned
        }
        field(38; "Drawing Type"; Option)
        {
            OptionMembers = " ",Customer,Internal,Supplier,"None","Standard Part";
        }
    }
    keys
    {
        key(Key1; "Parent Item No.", "Parent Customer No.", "Parent Drawing No.", "Parent Revision No.", "Drawing No.", "Revision No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
    /*   CustItemDrawing: Record 50039;
      ItemCrossReference: Record 5717; */
}
