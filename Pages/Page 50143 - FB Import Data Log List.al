page 50143 "FB Import Data Log List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50138;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                    Editable = false;
                }
                field("Line No.";"Line No.")
                {
                    Editable = false;
                }
                field("Import File Name";"Import File Name")
                {
                    Editable = false;
                }
                field("Import Date";"Import Date")
                {
                    Editable = false;
                }
                field("Import Time";"Import Time")
                {
                    Editable = false;
                }
                field("Customer No.";"Customer No.")
                {
                    Editable = false;
                }
                field("Contract No.";"Contract No.")
                {
                    Editable = false;
                }
                field("Location Code";"Location Code")
                {
                    Editable = false;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    Editable = false;
                }
                field("Item No.";"Item No.")
                {
                    Editable = false;
                }
                field("Lot No.";"Lot No.")
                {
                    Editable = false;
                }
                field("Tag No.";"Tag No.")
                {
                    Editable = false;
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Editable = false;
                }
                field("Variant Code";"Variant Code")
                {
                    Editable = false;
                }
                field(Quantity;Quantity)
                {
                    Editable = false;
                }
                field("Quantity Type";"Quantity Type")
                {
                    Editable = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Editable = false;
                }
                field("External Document No.";"External Document No.")
                {
                    Editable = false;
                }
                field("Order Date";"Order Date")
                {
                    Editable = false;
                }
                field("Order Time";"Order Time")
                {
                    Editable = false;
                }
                field("Salesperson Code";"Salesperson Code")
                {
                    Editable = false;
                }
                field("Inside Salesperson Code";"Inside Salesperson Code")
                {
                    Editable = false;
                }
                field("Required Date";"Required Date")
                {
                    Editable = false;
                }
                field("Customer Bin";"Customer Bin")
                {
                    Editable = false;
                }
                field("Purchase Price";"Purchase Price")
                {
                    Editable = false;
                }
                field("Sale Price";"Sale Price")
                {
                    Editable = false;
                }
                field("Error Messages";"Error Messages")
                {
                    Editable = false;
                }
                field("FB Order Exists";"FB Order Exists")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Create Orders")
                {
                    Caption = 'Create Orders';
                    Image = "Order";
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        SETRANGE("Error Messages",0);
                        SETRANGE("FB Order Exists",FALSE);
                        IF FIND('-') THEN REPEAT
                          FBManagement.LoadFBOrders(Rec);
                        UNTIL NEXT = 0;
                        SETRANGE("Error Messages");
                        SETRANGE("FB Order Exists");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    var
        FBManagement: Codeunit "50133";
}

