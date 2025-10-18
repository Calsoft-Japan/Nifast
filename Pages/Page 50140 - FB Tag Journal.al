page 50140 "FB Tag Journal"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "FB Tag Journal Line";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrBatchName; CurrBatchName)
                {
                    Caption = 'Batch Name';
                    ToolTip = 'Specifies the value of the Batch Name field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SAVERECORD();
                        FBManagement.LookupName(CurrBatchName, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        FBManagement.CheckName(CurrBatchName, Rec);
                        CurrBatchNameOnAfterValidate();
                    end;
                }
            }
            repeater(Generals)
            {
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field("Tag No."; Rec."Tag No.")
                {
                    ToolTip = 'Specifies the value of the Tag No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity Type"; Rec."Quantity Type")
                {
                    ToolTip = 'Specifies the value of the Quantity Type field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field.';
                }
                field("Inside Salesperson Code"; Rec."Inside Salesperson Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Inside Salesperson Code field.';
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Purchase Price field.';
                }
                field("Sale Price"; Rec."Sale Price")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Sale Price field.';
                }
                field("Order Time"; Rec."Order Time")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Order Time field.';
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
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the Post action.';

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
        FBManagement.OpenJnl(CurrBatchName, Rec);
    end;

    var
        FBManagement: Codeunit "FB Management";
        CurrBatchName: Code[10];

    local procedure CurrBatchNameOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        FBManagement.SetName(CurrBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;
}

