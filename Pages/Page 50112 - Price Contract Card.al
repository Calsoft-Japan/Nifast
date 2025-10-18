page 50112 "Price Contract Card"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    11/02/15 Fix the Page Type
    // //>>NIF
    // rtt 12-07-05 New field "FB Order Type" to General Tab
    // rtt 12-09-05 New Contract menu option - "Labels"
    // rtt 12-12-05 New menu Line->Cross References
    // //<< NIF

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Price Contract";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Caption = 'Customer No.';

                    trigger OnValidate()
                    begin
                        COMMIT();
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    Caption = 'Customer Name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    Caption = 'Starting Date';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                    Caption = 'Ending Date';
                }
                field("FB Order Type"; Rec."FB Order Type")
                {
                    ToolTip = 'Specifies the value of the FB Order Type field.';
                    Caption = 'FB Order Type';
                }
                field("Default Repl. Method"; Rec."Default Repl. Method")
                {
                    ToolTip = 'Specifies the value of the Default Repl. Method field.';
                    Caption = 'Default Repl. Method';
                }
                field("Def. Method of Fullfillment"; Rec."Def. Method of Fullfillment")
                {
                    ToolTip = 'Specifies the value of the Def. Method of Fullfillment field.';
                    Caption = 'Def. Method of Fullfillment';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                    Caption = 'Creation Date';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                    Caption = 'Last Date Modified';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    Caption = 'External Document No.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                    Caption = 'Payment Terms Code';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                    Caption = 'Salesperson Code';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Selling Location Code"; Rec."Selling Location Code")
                {
                    ToolTip = 'Specifies the value of the Selling Location Code field.';
                    Caption = 'Selling Location Code';
                }
                field("Total Value"; Rec."Total Value")
                {
                    ToolTip = 'Specifies the value of the Total Value field.';
                    Caption = 'Total Value';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.';
                    Caption = 'Tax Liable';
                }
            }
            part(PriceContractLines; "Price Contract Subform")
            {
                SubPageLink = "Contract No." = FIELD("No.");
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                    Caption = 'Ship-to Code';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name field.';
                    Caption = 'Ship-to Name';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                    Caption = 'Ship-to Name 2';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address field.';
                    Caption = 'Ship-to Address';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field.';
                    Caption = 'Ship-to Address 2';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                    Caption = 'Ship-to City';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    Caption = 'Ship-to State / ZIP Code';
                    ToolTip = 'Specifies the value of the Ship-to State / ZIP Code field.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to ZIP Code field.';
                    Caption = 'Ship-to ZIP Code';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the value of the Ship-to Contact field.';
                    Caption = 'Ship-to Contact';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    Caption = 'Phone No.';
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Country Code field.';
                    Caption = 'Ship-to Country Code';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                    Caption = 'Shipment Method Code';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                    Caption = 'Shipping Agent Code';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                    Caption = 'Shipping Agent Service Code';
                }
                field("Shipping Location Code"; Rec."Shipping Location Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Location Code field.';
                    Caption = 'Shipping Location Code';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                separator(" ")
                {
                }
                action("Insert UOM Lines")
                {
                    Caption = 'Insert UOM Lines';
                    Image = Insert;
                    ToolTip = 'Executes the Insert UOM Lines action.';

                    trigger OnAction()
                    begin
                        CurrPage.PriceContractLines.PAGE.InsertUOMLines();
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("&Contract")
            {
                Caption = '&Contract';
                /* action("Copy Contract")
                {
                    Caption = 'Copy Contract';
                    Image = CopyDocument;
                    ToolTip = 'Executes the Copy Contract action.';

                    trigger OnAction()
                    begin
                        //CopyPriceContract.SetPriceContract(Rec);
                        //CopyPriceContract.RUNMODAL;
                        //CLEAR(CopyPriceContract);
                    end;
                } */
                separator("  ")
                {
                }
            }
        }
        area(processing)
        {
            action("Customer Card")
            {
                Caption = 'Customer Card';
                Promoted = true;
                Image = Customer;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page 21;
                RunPageLink = "No." = FIELD("Customer No.");
                ToolTip = 'Executes the Customer Card action.';
            }
        }
    }
}

