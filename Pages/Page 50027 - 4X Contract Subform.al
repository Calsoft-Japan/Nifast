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
    SourceTable = Table50008;
    SourceTableView = SORTING(Document Type,Document No.)
                      WHERE(Document Type=CONST(Order),
                            Contract Note No.=FILTER(<>''));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                    Editable = false;
                }
                field("Document No.";"Document No.")
                {
                    Editable = false;
                }
                field("Document Line No.";"Document Line No.")
                {
                    Editable = false;
                }
                field("Item No.";"Item No.")
                {
                    Editable = false;
                }
                field("Item Description";"Item Description")
                {
                    Editable = false;
                }
                field(Quantity;Quantity)
                {
                    Editable = false;
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                    Editable = false;
                }
                field("Ext. Cost";"Ext. Cost")
                {
                    Editable = false;
                }
                field("Location Code";"Location Code")
                {
                    Editable = false;
                }
                field("Division No.";"Division No.")
                {
                    Editable = false;
                }
                field("Contract Note No.";"Contract Note No.")
                {
                    Editable = false;
                }
                field("Exchange Contract No.";"Exchange Contract No.")
                {
                    Editable = false;
                    Visible = false;
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

                trigger OnAction()
                begin
                    //This functionality was copied from page #50028. Unsupported part was commented. Please check it.
                    /*CurrPage.Subform.PAGE.*/
                    DeleteSeleted;
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

    var
        TransferExtendedText: Codeunit "378";
        ShortcutDimCode: array [8] of Code[20];
        LDec: array [20] of Decimal;
        LDate: array [10] of Date;
        LocationItem: Record "27";
        LineItem: Record "27";
        PurchHeader: Record "38";
        "4X Purchase Header": Record "50008";

    procedure DeleteSeleted()
    begin
        "Exchange Contract No." := '';
        MODIFY(FALSE);
    end;

    procedure SetView(var "4x Purchase Header": Record "50008")
    begin
        Rec := "4x Purchase Header";
    end;
}

