page 50027 "4X Contract Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Contract Quote Subform';
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "4X Purchase Header";
    SourceTableView = SORTING("Document Type", "Document No.")
                      WHERE("Document Type" = CONST(Order),
                            "Contract Note No." = FILTER(<> ''));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
                field("Ext. Cost"; Rec."Ext. Cost")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ext. Cost field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Division No."; Rec."Division No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Division No. field.';
                }
                field("Contract Note No."; Rec."Contract Note No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Note No. field.';
                }
                field("Exchange Contract No."; Rec."Exchange Contract No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Exchange Contract No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Remove Line")
            {
                Caption = '&Remove Line';
                Image = RemoveLine;
                ToolTip = 'Executes the &Remove Line action.';

                trigger OnAction()
                begin
                    //This functionality was copied from page #50028. Unsupported part was commented. Please check it.
                    /*CurrPage.Subform.PAGE.*/
                    DeleteSeleted();
                    //This functionality was copied from page #50028. Unsupported part was commented. Please check it.
                    /*CurrPage.Subform.PAGE.*/
                    //UPDATECONTROLS;

                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec."Exchange Contract No." := '';
        Rec.MODIFY(FALSE);
    end;

    procedure DeleteSeleted()
    begin
        Rec."Exchange Contract No." := '';
        Rec.MODIFY(FALSE);
    end;

    procedure SetView(var "4x Purchase Header": Record "4X Purchase Header")
    begin
        Rec := "4x Purchase Header";
    end;
}

