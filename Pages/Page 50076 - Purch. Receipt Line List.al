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
    SourceTable = Table121;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document No.";"Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field(VendorName;VendorName)
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                }
                field("Sail-on Date";"Sail-on Date")
                {
                }
                field("Vessel Name";"Vessel Name")
                {
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                    Visible = false;
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = true;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Indirect Cost %";"Indirect Cost %")
                {
                    Visible = false;
                }
                field("Quantity Invoiced";"Quantity Invoiced")
                {
                    Visible = false;
                }
                field("Order No.";"Order No.")
                {
                    Visible = false;
                }
                field("Order Line No.";"Order Line No.")
                {
                    Visible = false;
                }
                field("Vendor Item No.";"Vendor Item No.")
                {
                    Visible = false;
                }
                field("Unit Cost";"Unit Cost")
                {
                    Visible = false;
                }
                field("Prod. Order No.";"Prod. Order No.")
                {
                    Visible = false;
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field("Qty. per Unit of Measure";"Qty. per Unit of Measure")
                {
                    Visible = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Visible = false;
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

                    trigger OnAction()
                    var
                        PurchRcptHeader: Record "120";
                    begin
                        PurchRcptHeader.GET("Document No.");
                        PAGE.RUN(PAGE::"Posted Purchase Receipt",PurchRcptHeader);
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
    end;

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    trigger OnOpenPage()
    begin
        FILTERGROUP(2);
        SETRANGE(Type,Type::Item);
        SETFILTER(Quantity,'<>0');
        SETRANGE(Correction,FALSE);
        SETRANGE("Job No.",'');
        FILTERGROUP(0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        FromPurchRcptLine: Record "121";
        TempPurchRcptLine: Record "121" temporary;
        ItemChargeAssgntPurch: Record "5805";
        AssignItemChargePurch: Codeunit "5805";
        UnitCost: Decimal;
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;

    procedure Initialize(NewItemChargeAssgntPurch: Record "5805";NewUnitCost: Decimal)
    begin
        ItemChargeAssgntPurch := NewItemChargeAssgntPurch;
        UnitCost := NewUnitCost;
    end;

    local procedure IsFirstDocLine(): Boolean
    var
        PurchRcptLine: Record "121";
    begin
        TempPurchRcptLine.RESET;
        TempPurchRcptLine.COPYFILTERS(Rec);
        TempPurchRcptLine.SETRANGE("Document No.","Document No.");
        IF NOT TempPurchRcptLine.FIND('-') THEN BEGIN
          FILTERGROUP(2);
          PurchRcptLine.COPYFILTERS(Rec);
          FILTERGROUP(0);
          PurchRcptLine.SETRANGE("Document No.","Document No.");
          PurchRcptLine.FIND('-');
          TempPurchRcptLine := PurchRcptLine;
          TempPurchRcptLine.INSERT;
        END;
        IF "Line No." = TempPurchRcptLine."Line No." THEN
          EXIT(TRUE);
    end;

    procedure VendorName(): Text[50]
    var
        PurchRcptHdr: Record "120";
    begin
        IF NOT PurchRcptHdr.GET("Document No.") THEN
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
          AssignItemChargePurch.CreateRcptChargeAssgnt(FromPurchRcptLine,ItemChargeAssgntPurch);
        END;
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF IsFirstDocLine THEN
          "Document No.Emphasize" := TRUE
        ELSE
          "Document No.HideValue" := TRUE;
    end;
}

