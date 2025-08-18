pageextension 50047 "Sales Invoice Subform Ext" extends "Sales Invoice Subform"
{
    //Version NAVW18.00,NAVNA8.00,NV4.30,NIF.N15.C9IN.001;

    layout
    {
        addafter(ShortcutDimCode8)
        {
            /*   field("Purchase Order Exists"; Rec."Purchase Order Exists")
              {
                  Caption = 'Purchase Order Exists';
                  ToolTip = 'Specifies the value of the Purchase Order Exists Field.';
                  trigger OnValidate();
                  begin
                      PurchaseOrderExistsOnPush();
                  end;
              }
              field("Requisition Exists"; Rec."Requisition Exists")
              {
                  Caption = 'Requisition Exists';
                  ToolTip = 'Specifies the value of the Requisition Exists Field.';
                  trigger OnValidate();
                  begin
                      RequisitionExistsOnPush();
                  end;
              } */
        }
        moveafter(ShortcutDimCode8; "Description 2")
        addafter("Description 2")
        {
            field("Substitution Available"; Rec."Substitution Available")
            {
                ToolTip = 'Specifies the value of the Substitution Available Field.';
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
                    ToolTip = 'view the vendor card';
                    Image = Card;
                    CaptionML = ENU = 'Vendor Card';
                    trigger OnAction()
                    BEGIN
                        //{CurrPage.SalesLines.FORM.}
                        Rec.ShowVendor();
                    END;
                }
                action("Item Vendor")
                {
                    ToolTip = 'View the list of Item vendor';
                    Image = List;
                    CaptionML = ENU = 'Item Vendor';
                    trigger OnAction()
                    BEGIN
                        //This functionality was copied from page #43. Unsupported part was commented. Please check it.
                        //{CurrPage.SalesLines.FORM.}
                        Rec.ShowItemVendor();
                    end;
                }
            }
        }
    }
    /*    LOCAL PROCEDURE LineCommentOnPush();
       BEGIN
           Rec.ShowLineComments();
       END;

       LOCAL PROCEDURE PurchaseOrderExistsOnPush();
       BEGIN
           Rec.ShowPurchaseOrderLines();
       END;

       LOCAL PROCEDURE RequisitionExistsOnPush();
       BEGIN
           Rec.ShowRequisitionLines();
       END; */
}