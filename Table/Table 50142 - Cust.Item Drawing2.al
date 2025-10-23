table 50142 "Cust./Item Drawing2"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Lot Entry Functionality Renumber)
    // >> NIF
    // Fields Modified:
    //   Drawing No. (Not Blank = No)
    //   Revision No. (Not Blank = Yes)
    // << NIF

    DrillDownPageId = 50148;
    LookupPageId = 50148;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            // cleaned
            TableRelation = Item;
        }
        field(2; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(3; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(4; "Revision No."; Code[20])
        {
            NotBlank = true;
        }
        field(5; "Revision Date"; Date)
        {
            // cleaned
        }
        field(6; Active; Boolean)
        {
            trigger OnValidate()
            begin

                //make sure another drawing is not active for this customer and item
                if Active then begin
                    CustItemDrawing.SETRANGE("Item No.", "Item No.");
                    CustItemDrawing.SETRANGE("Customer No.", "Customer No.");
                    CustItemDrawing.SETRANGE(Active, true);
                    if CustItemDrawing.FIND('-') then
                        repeat
                            if (CustItemDrawing."Drawing No." <> "Drawing No.") or ("Revision No." <> CustItemDrawing."Revision No.") then
                                ERROR('Drawing %1, Revision %2 is already active for Item %3 Customer %4',
                                    CustItemDrawing."Drawing No.", CustItemDrawing."Revision No.", CustItemDrawing."Item No.", CustItemDrawing."Customer No.");
                        until CustItemDrawing.NEXT() = 0;
                end;
            end;

        }
        field(7; "Drawing Type"; Option)
        {
            OptionMembers = " ",Customer,Internal,Supplier,None,"Standard Part";
        }
        field(10; Components; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Cust./Item Drawing Comp" where("Parent Item No." = field("Item No."),
                                                                 "Parent Customer No." = field("Customer No."),
                                                                 "Parent Drawing No." = FIELD("Drawing No."),
                                                                 "Parent Revision No." = FIELD("Revision No.")));
            Editable = false;

        }
        field(11; "PPAP Approval"; Boolean)
        {
            // cleaned
        }
        field(12; "First Article Approval"; Boolean)
        {
            // cleaned
        }
        field(13; "First Article Waiver"; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Item No.", "Customer No.", "Drawing No.", "Revision No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CustItemDrawing: Record 50142;
    //  ItemCrossReference: Record 5717;
}
