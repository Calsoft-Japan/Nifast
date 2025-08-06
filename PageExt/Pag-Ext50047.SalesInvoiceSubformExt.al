pageextension 50047 "Sales Invoice Subform Ext" extends "Sales Invoice Subform"
{
    //Version NAVW18.00,NAVNA8.00,NV4.30,NIF.N15.C9IN.001;

    layout
    {
        moveafter(ShortcutDimCode8; "Description 2")
        addafter("Description 2")
        {
            field("Substitution Available"; Rec."Substitution Available")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore("&Line")
        {
            group("NewVision")
            {
                action("Vendor Card")
                {
                    CaptionML = ENU = 'Vendor Card';
                    trigger OnAction()
                    BEGIN
                        //{CurrPage.SalesLines.FORM.}
                        Rec.ShowVendor;
                    END;
                }
                action("Item Vendor")
                {
                    CaptionML = ENU = 'Item Vendor';
                    trigger OnAction()
                    BEGIN
                        //This functionality was copied from page #43. Unsupported part was commented. Please check it.
                        //{CurrPage.SalesLines.FORM.}
                        Rec.ShowItemVendor;
                    end;
                }
            }
        }
    }
    LOCAL PROCEDURE LineCommentOnPush();
    BEGIN
        Rec.ShowLineComments;
    END;

    LOCAL PROCEDURE PurchaseOrderExistsOnPush();
    BEGIN
        Rec.ShowPurchaseOrderLines;
    END;

    LOCAL PROCEDURE RequisitionExistsOnPush();
    BEGIN
        Rec.ShowRequisitionLines;
    END;
}