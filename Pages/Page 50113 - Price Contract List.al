page 50113 "Price Contract List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    11/02/15 Fix the Page Type
    // NIF 01-23-06 RTT removed RunObject link for Contract->Card menu
    //                  - added code at OnPush

    CardPageID = "Price Contract Card";
    Editable = false;
    PageType = List;
    SourceTable = Table50110;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field("No.";"No.")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("Customer Name";"Customer Name")
                {
                }
                field(Description;Description)
                {
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                }
                field("Starting Date";"Starting Date")
                {
                }
                field("Ending Date";"Ending Date")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Ship-to Name";"Ship-to Name")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Contract")
            {
                Caption = '&Contract';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PriceContract: Record "50110";
                        PriceContractCard: Page "50112";
                    begin
                        CLEAR(PriceContractCard);


                        PriceContract.SETFILTER("Customer No.",GETFILTER("Customer No."));
                        PriceContractCard.SETTABLEVIEW(PriceContract);
                        IF Rec."No." <> '' THEN
                          PriceContractCard.SETRECORD(Rec)
                        ELSE IF NOT CONFIRM('Do you want to create a Price Contract?') THEN BEGIN
                          MESSAGE('Operation Canceled.');
                          EXIT;
                        END;

                        PriceContractCard.RUN;
                    end;
                }
            }
        }
    }
}

