page 50140 "FB Tag Journal"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = Table50141;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrBatchName;CurrBatchName)
                {
                    Caption = 'Batch Name';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SAVERECORD;
                        FBManagement.LookupName(CurrBatchName,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        FBManagement.CheckName(CurrBatchName,Rec);
                          CurrBatchNameOnAfterValidate;
                    end;
                }
            }
            repeater()
            {
                field("Order Date";"Order Date")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("Ship-to Code";"Ship-to Code")
                {
                }
                field("Tag No.";"Tag No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Contract No.";"Contract No.")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field(Quantity;Quantity)
                {
                }
                field("Quantity Type";"Quantity Type")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Required Date";"Required Date")
                {
                }
                field("Customer Bin";"Customer Bin")
                {
                }
                field("Salesperson Code";"Salesperson Code")
                {
                    Visible = false;
                }
                field("Inside Salesperson Code";"Inside Salesperson Code")
                {
                    Visible = false;
                }
                field("Purchase Price";"Purchase Price")
                {
                    Visible = false;
                }
                field("Sale Price";"Sale Price")
                {
                    Visible = false;
                }
                field("Order Time";"Order Time")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        FBManagement.PostTagJnl(Rec);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetUpNewLine(xRec);
    end;

    trigger OnOpenPage()
    begin
        FBManagement.OpenJnl(CurrBatchName,Rec);
    end;

    var
        FBManagement: Codeunit "50133";
        CurrBatchName: Code[10];

    local procedure CurrBatchNameOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        FBManagement.SetName(CurrBatchName,Rec);
        CurrPage.UPDATE(FALSE);
    end;
}

