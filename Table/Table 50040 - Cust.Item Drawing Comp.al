table 50040 "Cust./Item Drawing Comp"
{
    // 080416: JRR Copied from 37b range tables
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
     /*    CustItemDrawing: Record 37015302;
        ItemCrossReference: Record 5717; */
}
