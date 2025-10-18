page 50144 "FB Processed Order"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/26/15 Fill-Bill Functionality (Added field "Shipping Location" on general tab)
    // rtt 12-14-05 Added "Import Time"
    //              -changed caption from "Import Date" to "Import Date/Time"

    Editable = false;
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "FB Header";
    SourceTableView = WHERE(Status = CONST(Processed));

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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Ship-To Code"; Rec."Ship-To Code")
                {
                    ToolTip = 'Specifies the value of the Ship-To Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Shipping Location"; Rec."Shipping Location")
                {
                    ToolTip = 'Specifies the value of the Shipping Location field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Import Data Log No."; Rec."Import Data Log No.")
                {
                    ToolTip = 'Specifies the value of the Import Data Log No. field.';
                }
                field("Import Date"; Rec."Import Date")
                {
                    Caption = 'Import Date/Time';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Import Date/Time field.';
                }
                field("Import Time"; Rec."Import Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Import Time field.';
                }
                field("Import File Name"; Rec."Import File Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Import File Name field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Inside Salesperson Code"; Rec."Inside Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Inside Salesperson Code field.';
                }
                field("FB Order Type"; Rec."FB Order Type")
                {
                    ToolTip = 'Specifies the value of the FB Order Type field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                }
            }
            part(FBProcessedOrderSubform; "FB Processed Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part("Item Information"; "Item Information")
            {
                Caption = 'Item Information';
                Provider = FBProcessedOrderSubform;
                SubPageLink = "Item No." = FIELD("Item No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Order)
            {
                Caption = 'Order';
                group(Documents)
                {
                    Caption = 'Documents';
                    Image = Document;
                    action("Sales Orders")
                    {
                        Caption = 'Sales Orders';
                        Image = "Order";
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        RunObject = Page "Sales List";
                        RunPageLink = "Document Type" = CONST(Order),
                                      "FB Order No." = FIELD("No.");
                        ToolTip = 'Executes the Sales Orders action.';
                    }
                    separator(" ")
                    {
                    }
                }
            }
        }
        area(processing)
        {
            action(ContractBtn)
            {
                Caption = 'Contracts';
                Image = ContactPerson;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Contracts action.';

                trigger OnAction()
                var
                    PriceContract: Record "Price Contract";
                    PriceContractList: Page "Price Contract List";
                begin
                    PriceContract.SETRANGE("Customer No.", Rec."Sell-to Customer No.");
                    IF NOT PriceContract.ISEMPTY THEN BEGIN
                        PriceContractList.SETTABLEVIEW(PriceContract);
                        PriceContractList.RUNMODAL();
                    END;
                end;
            }
            action(ShiptoBtn)
            {
                Caption = 'Ship-to';
                Image = ShipAddress;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "Ship-to Address";
                RunPageLink = "Customer No." = FIELD("Sell-to Customer No."),
                              Code = FIELD("Ship-To Code");
                ToolTip = 'Executes the Ship-to action.';
            }
            action(SelltoBtn)
            {
                Caption = 'Sell-to Customer';
                Image = Customer;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "Customer Card";
                RunPageLink = "No." = FIELD("Sell-to Customer No.");
                ToolTip = 'Executes the Sell-to Customer action.';
            }
        }
    }

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;
}

