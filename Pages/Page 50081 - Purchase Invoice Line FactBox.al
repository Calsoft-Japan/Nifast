page 50081 "Purchase Invoice Line FactBox"
{
    // NF1.00:CIS.NG  09-01-15 Merged during upgrade. Sava as the standard page 9100 - "Purchase Line FactBox"

    Caption = 'Purchase Line Details';
    PageType = CardPart;
    SourceTable = Table39;

    layout
    {
        area(content)
        {
            field("No.";"No.")
            {
                Caption = 'Item No.';
                Lookup = false;

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field(Availability;STRSUBSTNO('%1',PurchInfoPaneMgt.CalcAvailability(Rec)))
            {
                Caption = 'Availability';
                DecimalPlaces = 2:0;
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                begin
                    ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec,ItemAvailFormsMgt.ByEvent);
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field(STRSUBSTNO('%1',PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec));STRSUBSTNO('%1',PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
            {
                Caption = 'Purchase Prices';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                begin
                    ShowPrices;
                    CurrPage.UPDATE;
                end;
            }
            field(STRSUBSTNO('%1',PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec));STRSUBSTNO('%1',PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
            {
                Caption = 'Purchase Line Discounts';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                begin
                    ShowLineDisc;
                    CurrPage.UPDATE;
                end;
            }
            group("New Vision")
            {
                Caption = 'New Vision';
                field(LDate[1];LDate[1])
                {
                    Caption = 'Last Purchase';
                    Editable = false;
                }
                field(LocationItem.Inventory;LocationItem.Inventory)
                {
                    Caption = 'Location Qty';
                    DecimalPlaces = 0:5;
                    Editable = false;
                }
                field(LDec[3];LDec[3])
                {
                    CaptionClass = GetCaptions1;
                    Editable = false;
                }
                field(LDec[4];LDec[4])
                {
                    CaptionClass = GetCaptions2;
                    Caption = '<Control1102622004>';
                    Editable = false;
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
        NVM.UpdatePurchaseLineInfo(Rec,LDec,LDate,LineItem,LocationItem);
        //<<NV
    end;

    var
        PurchHeader: Record "38";
        PurchPriceCalcMgt: Codeunit "7010";
        PurchInfoPaneMgt: Codeunit "7181";
        ItemAvailFormsMgt: Codeunit "353";
        LDec: array [20] of Decimal;
        LDate: array [10] of Date;
        NVM: Codeunit "50021";
        LocationItem: Record "27";
        LineItem: Record "27";
        Text50000: Label 'Invoice Amount';
        Text50001: Label 'Invoice Weight';
        Text50002: Label 'Order Amount';
        Text50003: Label 'Order Weight';

    procedure ShowDetails()
    var
        Item: Record "27";
    begin
        IF Type = Type::Item THEN BEGIN
          Item.GET("No.");
          PAGE.RUN(PAGE::"Item Card",Item);
        END;
    end;

    procedure ShowPrices()
    begin
        PurchHeader.GET("Document Type","Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader,Rec);
    end;

    procedure ShowLineDisc()
    begin
        PurchHeader.GET("Document Type","Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader,Rec);
    end;

    local procedure "<<NF>>"()
    begin
    end;

    local procedure GetCaptions1(): Text[30]
    begin
        //>> NF1.00:CIS.NG  09-01-15
        IF "Document Type" = "Document Type"::Invoice THEN
          EXIT(Text50000)
        ELSE
          EXIT(Text50002);
        //<< NF1.00:CIS.NG  09-01-15
    end;

    local procedure GetCaptions2(): Text[30]
    begin
        //>> NF1.00:CIS.NG  09-01-15
        IF "Document Type" = "Document Type"::Invoice THEN
          EXIT(Text50001)
        ELSE
          EXIT(Text50003);
        //<< NF1.00:CIS.NG  09-01-15
    end;
}

