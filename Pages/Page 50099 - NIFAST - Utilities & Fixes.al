page 50099 "NIFAST - Utilities & Fixes"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = Card;
    Permissions = TableData 112=rimd;

    layout
    {
    }

    actions
    {
        area(processing)
        {
            action("Update Sales Lines w/ Ext. Doc. No.")
            {
                Caption = 'Update Sales Lines w/ Ext. Doc. No.';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    mSalesLine: Record "37";
                    mSalesHeader: Record "36";
                begin
                    Window.OPEN('Processing #1##############################');

                    IF mSalesLine.FIND('-') THEN
                      REPEAT
                        CLEAR(mSalesHeader);
                        Window.UPDATE(1, FORMAT(mSalesLine."Document Type") + ' - ' + FORMAT(mSalesLine."Document No."));
                        mSalesHeader.GET(mSalesLine."Document Type", mSalesLine."Document No.");
                        IF mSalesLine."External Document No." = '' THEN
                          BEGIN
                            mSalesLine."External Document No." := mSalesHeader."External Document No.";
                            mSalesLine.MODIFY(FALSE);
                          END;
                      UNTIL mSalesLine.NEXT = 0;

                    Window.CLOSE;
                end;
            }
            action("'Remove ""On Hold"" ")
            {
                Caption = 'Remove "On Hold" = NO from Pstd Sls Inv';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    mSlsInvHdr: Record "112";
                begin
                    Window.OPEN('Processing #1##############################');

                    mSlsInvHdr.SETRANGE("Location Code", 'IBN');

                    IF mSlsInvHdr.FIND('-') THEN
                      REPEAT
                        Window.UPDATE(1, FORMAT(mSlsInvHdr."No."));
                        mSlsInvHdr."On Hold" := '';
                        mSlsInvHdr.MODIFY;
                      UNTIL mSlsInvHdr.NEXT = 0;

                    Window.CLOSE;
                end;
            }
        }
    }

    var
        Window: Dialog;
}

