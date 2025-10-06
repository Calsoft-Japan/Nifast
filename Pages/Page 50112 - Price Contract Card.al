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
    SourceTable = Table50110;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("Customer No.";"Customer No.")
                {

                    trigger OnValidate()
                    begin
                        COMMIT;
                    end;
                }
                field("Customer Name";"Customer Name")
                {
                }
                field(Description;Description)
                {
                }
                field("Starting Date";"Starting Date")
                {
                }
                field("Ending Date";"Ending Date")
                {
                }
                field("FB Order Type";"FB Order Type")
                {
                }
                field("Default Repl. Method";"Default Repl. Method")
                {
                }
                field("Def. Method of Fullfillment";"Def. Method of Fullfillment")
                {
                }
                field("Creation Date";"Creation Date")
                {
                }
                field("Last Date Modified";"Last Date Modified")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                }
                field("Salesperson Code";"Salesperson Code")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Selling Location Code";"Selling Location Code")
                {
                }
                field("Total Value";"Total Value")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                }
            }
            part(PriceContractLines;50114)
            {
                SubPageLink = Contract No.=FIELD(No.);
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code";"Ship-to Code")
                {
                }
                field("Ship-to Name";"Ship-to Name")
                {
                }
                field("Ship-to Name 2";"Ship-to Name 2")
                {
                }
                field("Ship-to Address";"Ship-to Address")
                {
                }
                field("Ship-to Address 2";"Ship-to Address 2")
                {
                }
                field("Ship-to City";"Ship-to City")
                {
                }
                field("Ship-to County";"Ship-to County")
                {
                    Caption = 'Ship-to State / ZIP Code';
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                }
                field("Phone No.";"Phone No.")
                {
                }
                field("Ship-to Country Code";"Ship-to Country Code")
                {
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code";"Shipping Agent Service Code")
                {
                }
                field("Shipping Location Code";"Shipping Location Code")
                {
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
                separator()
                {
                }
                action("Insert UOM Lines")
                {
                    Caption = 'Insert UOM Lines';

                    trigger OnAction()
                    begin
                        CurrPage.PriceContractLines.PAGE.InsertUOMLines;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("&Contract")
            {
                Caption = '&Contract';
                action("Copy Contract")
                {
                    Caption = 'Copy Contract';

                    trigger OnAction()
                    begin
                        //CopyPriceContract.SetPriceContract(Rec);
                        //CopyPriceContract.RUNMODAL;
                        //CLEAR(CopyPriceContract);
                    end;
                }
                separator()
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
                PromotedCategory = Process;
                RunObject = Page 21;
                RunPageLink = No.=FIELD(Customer No.);
                ToolTip = 'Customer Card';
            }
        }
    }

    var
        ContBusRelation: Record "5054";
        Contact: Record "5050";
        ShipToAddr: Record "222";
        Customer: Record "18";
        ">>NIF": Integer;
        CrossRefNo: Code[30];
        CrossRefDesc: Text[50];
}

