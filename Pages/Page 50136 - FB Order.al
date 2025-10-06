page 50136 "FB Order"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // rtt 12-13-05 Added "Shipping Location Code" to General tab
    // rtt 12-14-05 Added "Import Time"
    //              -changed caption from "Import Date" to "Import Date/Time"
    // rtt 12-15-05 Moved Contract No. to below Customer No.

    PageType = Document;
    SourceTable = Table50136;
    SourceTableView = WHERE(Status=FILTER(New|Errors));

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
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Contract No.";"Contract No.")
                {
                }
                field("Ship-To Code";"Ship-To Code")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Shipping Location";"Shipping Location")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Import Data Log No.";"Import Data Log No.")
                {
                    Editable = false;
                }
                field("Import Date";"Import Date")
                {
                    Caption = 'Import Date/Time';
                    Editable = false;
                }
                field("Import Time";"Import Time")
                {
                    Editable = false;
                }
                field("Import File Name";"Import File Name")
                {
                    Editable = false;
                }
                field("Order Date";"Order Date")
                {
                }
                field("Salesperson Code";"Salesperson Code")
                {
                }
                field("Inside Salesperson Code";"Inside Salesperson Code")
                {
                }
                field("FB Order Type";"FB Order Type")
                {
                }
                field("Sales Order No.";"Sales Order No.")
                {
                    Editable = false;
                }
                field(Status;Status)
                {
                    Editable = false;
                }
            }
            part(;50137)
            {
                SubPageLink = Document No.=FIELD(No.);
            }
        }
        area(factboxes)
        {
            part("Item Information";50101)
            {
                Caption = 'Item Information';
                Provider = Control1240410022;
                SubPageLink = Item No.=FIELD(Item No.);
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
                action("Process Order")
                {
                    Caption = 'Process Order';
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        SETRANGE("No.","No.");
                        FBManagement.ProcessFBOrder(Rec);
                        SETRANGE("No.");
                        CurrPage.UPDATE;
                    end;
                }
                action("Process Batch")
                {
                    Caption = 'Process Batch';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
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
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PriceContract: Record "50110";
                    PriceContractList: Page "50113";
                begin
                    PriceContract.SETRANGE("Customer No.","Sell-to Customer No.");
                    IF NOT PriceContract.ISEMPTY THEN BEGIN
                      PriceContractList.SETTABLEVIEW(PriceContract);
                      PriceContractList.RUNMODAL;
                    END;
                end;
            }
            action(ShiptoBtn)
            {
                Caption = 'Ship-to';
                Image = ShipAddress;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 300;
                RunPageLink = Customer No.=FIELD(Sell-to Customer No.),
                              Code=FIELD(Ship-To Code);
            }
            action(SelltoBtn)
            {
                Caption = 'Sell-to Customer';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 21;
                RunPageLink = No.=FIELD(Sell-to Customer No.);
            }
        }
    }

    var
        FBManagement: Codeunit "50133";
        FBHeader: Record "50136";

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;
}

