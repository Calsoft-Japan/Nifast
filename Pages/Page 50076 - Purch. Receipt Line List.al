page 50076 "Purch. Receipt Line List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // >> NIF
    // Fields Added:
    //   Sail-on Date (#10044)
    //   Vessel Name  (#10044)
    // << NIF

    Caption = 'Purch. Receipt Lines';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purch. Rcpt. Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the receipt number.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field(VendorNames; VendorName())
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies either the name of or a description of the item or general ledger account.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location where the receipt line is registered.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                }
                field("Sail-on Date"; Rec."Sail-on Date")
                {
                    ToolTip = 'Specifies the value of the Sail-on Date field.';
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Visible = false;
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = true;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    Visible = false;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Order No."; Rec."Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the line number of the order that created the entry.';
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number that the vendor uses for this item.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Visible = false;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Visible = false;
                    ToolTip = 'Specifies the quantity per unit of measure of the item that was received.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Show Document action.';

                    trigger OnAction()
                    var
                        PurchRcptHeader: Record "Purch. Rcpt. Header";
                    begin
                        PurchRcptHeader.GET(Rec."Document No.");
                        PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader);
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Executes the Item &Tracking Lines action.';

                    trigger OnAction()
                    begin
                        Rec.ShowItemTrackingLines();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Type, Rec.Type::Item);
        Rec.SETFILTER(Quantity, '<>0');
        Rec.SETRANGE(Correction, FALSE);
        Rec.SETRANGE("Job No.", '');
        Rec.FILTERGROUP(0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush();
    end;

    var
        FromPurchRcptLine: Record "Purch. Rcpt. Line";
        TempPurchRcptLine: Record "Purch. Rcpt. Line" temporary;
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        AssignItemChargePurch: Codeunit "Item Charge Assgnt. (Purch.)";
        UnitCost: Decimal;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    procedure Initialize(NewItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; NewUnitCost: Decimal)
    begin
        ItemChargeAssgntPurch := NewItemChargeAssgntPurch;
        UnitCost := NewUnitCost;
    end;

    local procedure IsFirstDocLine(): Boolean
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        TempPurchRcptLine.RESET();
        TempPurchRcptLine.COPYFILTERS(Rec);
        TempPurchRcptLine.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempPurchRcptLine.FIND('-') THEN BEGIN
            Rec.FILTERGROUP(2);
            PurchRcptLine.COPYFILTERS(Rec);
            Rec.FILTERGROUP(0);
            PurchRcptLine.SETRANGE("Document No.", Rec."Document No.");
            PurchRcptLine.FindFirst();
            TempPurchRcptLine := PurchRcptLine;
            TempPurchRcptLine.INSERT();
        END;
        IF Rec."Line No." = TempPurchRcptLine."Line No." THEN
            EXIT(TRUE);
    end;

    procedure VendorName(): Text[50]
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
    begin
        IF NOT PurchRcptHdr.GET(Rec."Document No.") THEN
            EXIT('')
        ELSE
            EXIT(PurchRcptHdr."Buy-from Vendor Name");
    end;

    local procedure LookupOKOnPush()
    begin
        FromPurchRcptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(FromPurchRcptLine);
        IF FromPurchRcptLine.FIND('-') THEN BEGIN
            ItemChargeAssgntPurch."Unit Cost" := UnitCost;
            AssignItemChargePurch.CreateRcptChargeAssgnt(FromPurchRcptLine, ItemChargeAssgntPurch);
        END;
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine() THEN
            "Document No.Emphasize" := TRUE
        ELSE
            "Document No.HideValue" := TRUE;
    end;
}

