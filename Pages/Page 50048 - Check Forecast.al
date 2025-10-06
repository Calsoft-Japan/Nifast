page 50048 "Check Forecast"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // WC5240.114 01.25.2010 KAW Copied Check Availability form and modified

    Caption = 'Check Forecast';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    InstructionalText = 'Shipment in this month will exceed forecast. Do you still want to record the quantity?';
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ConfirmationDialog;
    SourceTable = Table27;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field(InventoryQty;InventoryQty)
                {
                    Caption = 'Inventory';
                    DecimalPlaces = 0:5;
                    Editable = false;
                }
                field(ForecastQty;ForecastQty)
                {
                    Caption = 'Forecast';
                    DecimalPlaces = 0:5;
                    Editable = false;
                }
                field(ShipmentQty;ShipmentQty)
                {
                    Caption = 'Shipment';
                    DecimalPlaces = 0:5;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        COPY(Item2);
    end;

    var
        SalesSetup: Record "311";
        OldSalesLine: Record "37";
        CompanyInfo: Record "79";
        Item2: Record "27";
        SalesShipment: Record "111";
        SalesHeader: Record "36";
        ForecastLog: Record "50026";
        OldQtytoShip: Decimal;
        ItemNo: Code[20];
        UnitOfMeasureCode: Code[10];
        QtyPerUnitOfMeasure: Decimal;
        SetupDataIsPresent: Boolean;
        InventoryQty: Decimal;
        ForecastQty: Decimal;
        ShipmentQty: Decimal;
        BegDate: Date;
        EndDate: Date;
        GenerationDate: Date;
        PostingDate: Date;
        QtytoShip: Decimal;
        AvailToPromise: Codeunit "5790";
        SalesQty: Decimal;
        Text19041947: Label 'Shipment in this month will exceed forecast. Do you still want to record the quantity?';

    procedure SalesLineShowWarning(SalesLine: Record "37"): Boolean
    begin
        IF SalesLine."Drop Shipment" THEN
          EXIT(FALSE);

        OldSalesLine := SalesLine;
        OldQtytoShip := 0;
        IF OldSalesLine.FIND THEN // Find previous quantity
          IF (OldSalesLine."Document Type" = OldSalesLine."Document Type"::Order) AND
             (OldSalesLine."No." = SalesLine."No.") AND
             (OldSalesLine."Variant Code" = SalesLine."Variant Code") AND
             (OldSalesLine."Location Code" = SalesLine."Location Code") AND
             (OldSalesLine."Bin Code" = SalesLine."Bin Code") AND
             NOT OldSalesLine."Drop Shipment"
          THEN
            OldQtytoShip := OldSalesLine.Quantity;

        EXIT(
          ShowWarning(
            SalesLine."No.",
            SalesLine."Variant Code",
            SalesLine."Location Code",
            SalesLine."Unit of Measure Code",
            SalesLine."Qty. per Unit of Measure",
            SalesLine.Quantity,
            SalesHeader."Posting Date"));
    end;

    local procedure ShowWarning(ItemNo2: Code[20];ItemVariantCode: Code[10];ItemLocationCode: Code[10];UnitOfMeasureCode2: Code[10];QtyPerUnitOfMeasure2: Decimal;OldQtytoShip: Decimal;OldPostingDate: Date): Boolean
    begin
        ItemNo := ItemNo2;
        UnitOfMeasureCode := UnitOfMeasureCode2;
        QtyPerUnitOfMeasure := QtyPerUnitOfMeasure2;
        PostingDate := OldPostingDate;
        QtytoShip := OldQtytoShip;

        GET(ItemNo);
        SETRANGE("No.","No.");
        SETRANGE("Variant Filter",ItemVariantCode);
        SETRANGE("Location Filter",ItemLocationCode);
        SETRANGE("Drop Shipment Filter",FALSE);

        Item2.COPY(Rec);

        Calculate;

        IF ForecastQty = 0 THEN
          EXIT(FALSE);

        EXIT(ShipmentQty > ForecastQty);
    end;

    local procedure Calculate()
    var
        SalesLine: Record "37" temporary;
    begin
        CALCFIELDS(Inventory,"Reserved Qty. on Inventory");
        InventoryQty := Inventory - "Reserved Qty. on Inventory";

        SalesHeader.GET(OldSalesLine."Document Type",OldSalesLine."Document No.");
        EndDate := CALCDATE('CM',SalesHeader."Posting Date");
        BegDate := (EndDate - DATE2DMY(EndDate,1)) + 1;
        GenerationDate := CALCDATE('-3M',BegDate);
        //MESSAGE('bd is %1,ed is %2, fd is %3',FORMAT(BegDate),FORMAT(EndDate),FORMAT(GenerationDate));

        ForecastQty := 0;
        //ForecastQty := SalesLine.GetForecastQty(OldSalesLine."No.",OldSalesLine."Sell-to Customer No.",GenerationDate,BegDate);
        //MESSAGE('f is %1',FORMAT(ForecastQty));

        SalesQty := 0;
        //SalesQty := SalesLine.GetSalesQty(OldSalesLine."Document No.", OldSalesLine."Sell-to Customer No.",
        //                                             OldSalesLine."No.",2,BegDate,EndDate);
        //MESSAGE('sales is %1',FORMAT(SalesQty));

        ShipmentQty := 0;
        //ShipmentQty := SalesLine.GetShippedQty(OldSalesLine."Document No.", OldSalesLine."Sell-to Customer No.",
        //                                             OldSalesLine."No.",2,BegDate,EndDate);
        //MESSAGE('shipped is %1',FORMAT(ShipmentQty));

        //MESSAGE('qty is %1',FORMAT(QtytoShip));

        ShipmentQty := ShipmentQty + SalesQty + QtytoShip;
        //MESSAGE('total is %1',FORMAT(ShipmentQty));
    end;
}

