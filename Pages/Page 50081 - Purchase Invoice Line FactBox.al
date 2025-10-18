page 50081 "Purchase Invoice Line FactBox"
{
    // NF1.00:CIS.NG  09-01-15 Merged during upgrade. Sava as the standard page 9100 - "Purchase Line FactBox"

    Caption = 'Purchase Line Details';
    PageType = CardPart;
    UsageCategory = None;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Item No.';
                Lookup = false;
                ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field(Availability; STRSUBSTNO('%1', PurchInfoPaneMgt.CalcAvailability(Rec)))
            {
                Caption = 'Availability';
                //DecimalPlaces = 2 : 0;
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the value of the Availability field.';

                trigger OnDrillDown()
                begin
                    ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent());
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field(CalcNoOfPurchase; STRSUBSTNO('%1', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
            {
                Caption = 'Purchase Prices';
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the value of the Purchase Prices field.';

                trigger OnDrillDown()
                begin
                    ShowPrices();
                    CurrPage.UPDATE();
                end;
            }
            field(CalcNoOfPurchLineDisc; STRSUBSTNO('%1', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
            {
                Caption = 'Purchase Line Discounts';
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the value of the Purchase Line Discounts field.';

                trigger OnDrillDown()
                begin
                    ShowLineDisc();
                    CurrPage.UPDATE();
                end;
            }
            group("New Vision")
            {
                Caption = 'New Vision';
                field(LDate; LDate[1])
                {
                    Caption = 'Last Purchase';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Purchase field.';
                }
                field(Inventory; LocationItem.Inventory)
                {
                    Caption = 'Location Qty';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Qty field.';
                }
                field(LDec3; LDec[3])
                {
                    CaptionClass = GetCaptions1();
                    Editable = false;
                    ToolTip = 'Specifies the value of the LDec[3] field.';
                }
                field(LDec4; LDec[4])
                {
                    CaptionClass = GetCaptions2();
                    Caption = '<Control1102622004>';
                    Editable = false;
                    ToolTip = 'Specifies the value of the <Control1102622004> field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //>>NV
        NVM.UpdatePurchaseLineInfo(Rec, LDec, LDate, LineItem, LocationItem);
        //<<NV
    end;

    var
        LineItem: Record Item;
        LocationItem: Record Item;
        PurchHeader: Record "Purchase Header";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        NVM: Codeunit "NewVision Management_New";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
        LDate: array[10] of Date;
        LDec: array[20] of Decimal;
        Text50000: Label 'Invoice Amount';
        Text50001: Label 'Invoice Weight';
        Text50002: Label 'Order Amount';
        Text50003: Label 'Order Weight';

    procedure ShowDetails()
    var
        Item: Record Item;
    begin
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            Item.GET(Rec."No.");
            PAGE.RUN(PAGE::"Item Card", Item);
        END;
    end;

    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    /*  local procedure "<<NF>>"()
     begin
     end; */

    local procedure GetCaptions1(): Text[30]
    begin
        //>> NF1.00:CIS.NG  09-01-15
        IF Rec."Document Type" = Rec."Document Type"::Invoice THEN
            EXIT(Text50000)
        ELSE
            EXIT(Text50002);
        //<< NF1.00:CIS.NG  09-01-15
    end;

    local procedure GetCaptions2(): Text[30]
    begin
        //>> NF1.00:CIS.NG  09-01-15
        IF Rec."Document Type" = Rec."Document Type"::Invoice THEN
            EXIT(Text50001)
        ELSE
            EXIT(Text50003);
        //<< NF1.00:CIS.NG  09-01-15
    end;
}

