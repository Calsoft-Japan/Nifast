page 50143 "FB Import Data Log List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FB Import Data Log";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Import File Name"; Rec."Import File Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Import File Name field.';
                }
                field("Import Date"; Rec."Import Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Import Date field.';
                }
                field("Import Time"; Rec."Import Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Import Time field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Tag No."; Rec."Tag No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Tag No. field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity Type"; Rec."Quantity Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity Type field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Order Time"; Rec."Order Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Order Time field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Inside Salesperson Code"; Rec."Inside Salesperson Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Inside Salesperson Code field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Purchase Price field.';
                }
                field("Sale Price"; Rec."Sale Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sale Price field.';
                }
                field("Error Messages"; Rec."Error Messages")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Error Messages field.';
                }
                field("FB Order Exists"; Rec."FB Order Exists")
                {
                    ToolTip = 'Specifies the value of the FB Order Exists field.';
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
                    ToolTip = 'Executes the Create Orders action.';

                    trigger OnAction()
                    begin
                        Rec.SETRANGE("Error Messages", 0);
                        Rec.SETRANGE("FB Order Exists", FALSE);
                        IF Rec.FIND('-') THEN
                            REPEAT
                                FBManagement.LoadFBOrders(Rec);
                            UNTIL Rec.NEXT() = 0;
                        Rec.SETRANGE("Error Messages");
                        Rec.SETRANGE("FB Order Exists");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    var
        FBManagement: Codeunit "FB Management";
}

