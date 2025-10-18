page 50113 "Price Contract List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    11/02/15 Fix the Page Type
    // NIF 01-23-06 RTT removed RunObject link for Contract->Card menu
    //                  - added code at OnPush

    CardPageID = "Price Contract Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Price Contract";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name field.';
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
                    ToolTip = 'Executes the &Card action.';

                    trigger OnAction()
                    var
                        PriceContract: Record "Price Contract";
                        PriceContractCard: Page "Price Contract Card";
                    begin
                        CLEAR(PriceContractCard);


                        PriceContract.SETFILTER("Customer No.", Rec.GETFILTER("Customer No."));
                        PriceContractCard.SETTABLEVIEW(PriceContract);
                        IF Rec."No." <> '' THEN
                            PriceContractCard.SETRECORD(Rec)
                        ELSE
                            IF NOT CONFIRM('Do you want to create a Price Contract?') THEN BEGIN
                                MESSAGE('Operation Canceled.');
                                EXIT;
                            END;

                        PriceContractCard.RUN();
                    end;
                }
            }
        }
    }
}

