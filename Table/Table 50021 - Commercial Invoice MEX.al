table 50021 "Commercial Invoice MEX"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            // cleaned
        }
        field(2; "Virtural Operation No."; Code[10])
        {
            // cleaned
        }
        field(6; "Customer No."; Code[20])
        {
            // cleaned
        }
        field(7; "Country of Origin"; Code[10])
        {
            // cleaned
        }
        field(10; "Item No."; Code[20])
        {
            // cleaned
        }
        field(20; "Custom Agent License No."; Code[10])
        {
            Description = 'Patente Orignal';
        }
        field(23; "Customer Agent E/S"; Code[10])
        {
            Description = 'Aduana E/S';
        }
        field(26; "Summary Entry No."; Code[10])
        {
            Description = 'Pediment No.';
        }
        field(29; "Summary Entry Code"; Code[10])
        {
            Description = 'CVE Pedimento';
        }
        field(32; "Date of Entry"; Date)
        {
            Description = 'Fecha de entrada';
        }
        field(35; Quantity; Decimal)
        {
            // cleaned
        }
        field(38; Weight; Decimal)
        {
            // cleaned
        }
        field(50; "Line Amount"; Decimal)
        {
            // cleaned
        }
        field(52; "Tax Amount"; Decimal)
        {
            // cleaned
        }
        field(55; "Amount Incl Tax"; Decimal)
        {
            // cleaned
        }
        field(70; "Doc No"; Code[20])
        {
            // cleaned
        }
        field(71; "Doc Line No"; Integer)
        {
            // cleaned
        }
        field(50001; "Invoice No"; Code[20])
        {
            // cleaned
        }
    }

    procedure GetInfo(CustNo: Code[20]; DateFilter: Text[30]; ShowStatus: Boolean; var TempSalesHdr: Record "Sales Header" temporary)
    var
        SalesInvHdr: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        UseEntryNo: Integer;
        ItemEntryRel: Record "Item Entry Relation";
        ValueEntryRel: Record "Value Entry Relation";
        LotNoInfo: Record "Lot No. Information";
        RowText: Text[100];
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ValueEntryRelation: Record "Value Entry Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        EntryNo: Integer;
        d: Dialog;
        VirtualInvoice: Record "Commercial Invoice MEX";
        RemLineAmount: Decimal;
        RemLineAmtIncTax: Decimal;
        LineAmount: Decimal;
        LineAmtIncTax: Decimal;
        QtyFactor: Decimal;
    begin
        IF VirtualInvoice.FIND('+') THEN
            EntryNo := VirtualInvoice."Entry No." + 1;

        IF ShowStatus THEN
            d.OPEN('Reading #1######## #2########');
        SalesInvHdr.SETCURRENTKEY("Sell-to Customer No.");
        SalesInvHdr.SETRANGE("Sell-to Customer No.", CustNo);
        SalesInvHdr.SETFILTER("Posting Date", DateFilter);
        SalesInvHdr.SETRANGE("Exclude from Virtual Inv.", FALSE);
        IF SalesInvHdr.FIND('-') THEN
            REPEAT
                IF ShowStatus THEN
                    d.UPDATE(1, SalesInvHdr."No.");
                SalesInvLine.SETRANGE("Document No.", SalesInvHdr."No.");
                SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
                SalesInvLine.SETFILTER(Quantity, '<>0');
                IF SalesInvLine.FIND('-') THEN BEGIN
                    EntryNo := EntryNo + 1;
                    RemLineAmount := SalesInvLine."Line Amount";
                    RemLineAmtIncTax := SalesInvLine."Amount Including VAT";

                    IF NOT TempSalesHdr.GET(TempSalesHdr."Document Type"::Invoice, SalesInvHdr."No.") THEN BEGIN
                        TempSalesHdr.INIT;
                        TempSalesHdr."Document Type" := TempSalesHdr."Document Type"::Invoice;
                        TempSalesHdr."No." := SalesInvHdr."No.";
                        TempSalesHdr."Posting Date" := SalesInvHdr."Posting Date";
                        TempSalesHdr."Mex. Factura No." := SalesInvHdr."Mex. Factura No.";
                        TempSalesHdr.INSERT;
                    END;

                    REPEAT
                        RowText := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line", 0,
                                                        SalesInvLine."Document No.", '', 0, SalesInvLine."Line No.");
                        ValueEntryRelation.SETCURRENTKEY("Source RowId");
                        ValueEntryRelation.SETRANGE("Source RowId", RowText);
                        IF ValueEntryRelation.FIND('-') THEN BEGIN
                            REPEAT
                                IF ShowStatus THEN
                                    d.UPDATE(2, SalesInvLine."No.");
                                ValueEntry.GET(ValueEntryRelation."Value Entry No.");
                                ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                                IF ValueEntry."Invoiced Quantity" <> 0 THEN BEGIN
                                    QtyFactor := -ValueEntry."Invoiced Quantity" / SalesInvLine.Quantity;
                                    LineAmount := ROUND(SalesInvLine."Line Amount" * QtyFactor, 0.01);
                                    LineAmtIncTax := ROUND(SalesInvLine."Amount Including VAT" * QtyFactor, 0.01);
                                    AddToRecordSet(ItemLedgEntry, LineAmount, LineAmtIncTax, -ValueEntry."Invoiced Quantity",
                                       SalesInvLine."Document No.", SalesInvLine."Line No.", EntryNo);
                                    EntryNo := EntryNo + 1;
                                END;
                            UNTIL ValueEntryRelation.NEXT = 0;
                        END;
                    UNTIL SalesInvLine.NEXT = 0;
                END;
            UNTIL SalesInvHdr.NEXT = 0;


        SalesCrMemoHdr.SETCURRENTKEY("Sell-to Customer No.");
        SalesCrMemoHdr.SETRANGE("Sell-to Customer No.", CustNo);
        SalesCrMemoHdr.SETFILTER("Posting Date", DateFilter);
        SalesCrMemoHdr.SETRANGE("Exclude from Virtual Inv.", FALSE);
        IF SalesCrMemoHdr.FIND('-') THEN
            REPEAT
                IF ShowStatus THEN
                    d.UPDATE(1, SalesCrMemoHdr."No.");
                SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHdr."No.");
                SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::Item);
                SalesCrMemoLine.SETFILTER(Quantity, '<>0');
                IF SalesCrMemoLine.FIND('-') THEN BEGIN
                    EntryNo := EntryNo + 1;
                    RemLineAmount := SalesCrMemoLine."Line Amount";
                    RemLineAmtIncTax := SalesCrMemoLine."Amount Including VAT";

                    IF NOT TempSalesHdr.GET(TempSalesHdr."Document Type"::"Credit Memo", SalesCrMemoHdr."No.") THEN BEGIN
                        TempSalesHdr.INIT;
                        TempSalesHdr."Document Type" := TempSalesHdr."Document Type"::"Credit Memo";
                        TempSalesHdr."No." := SalesCrMemoHdr."No.";
                        TempSalesHdr."Posting Date" := SalesCrMemoHdr."Posting Date";
                        TempSalesHdr."Mex. Factura No." := SalesCrMemoHdr."Mex. Factura No.";
                        TempSalesHdr.INSERT;
                    END;

                    REPEAT
                        RowText := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Cr.Memo Line", 0,
                                                        SalesCrMemoLine."Document No.", '', 0, SalesCrMemoLine."Line No.");
                        ValueEntryRelation.SETCURRENTKEY("Source RowId");
                        ValueEntryRelation.SETRANGE("Source RowId", RowText);
                        IF ValueEntryRelation.FIND('-') THEN BEGIN
                            REPEAT
                                IF ShowStatus THEN
                                    d.UPDATE(2, SalesCrMemoLine."No.");
                                EntryNo := EntryNo + 1;
                                ValueEntry.GET(ValueEntryRelation."Value Entry No.");
                                ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                                IF ValueEntry."Invoiced Quantity" <> 0 THEN BEGIN
                                    QtyFactor := ValueEntry."Invoiced Quantity" / SalesCrMemoLine.Quantity;
                                    LineAmount := ROUND(SalesCrMemoLine."Line Amount" * QtyFactor, 0.01);
                                    LineAmtIncTax := ROUND(SalesCrMemoLine."Amount Including VAT" * QtyFactor, 0.01);
                                    AddToRecordSet(ItemLedgEntry, -LineAmount, -LineAmtIncTax, -ValueEntry."Invoiced Quantity",
                                       SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", EntryNo);
                                    EntryNo := EntryNo + 1;
                                END;
                            UNTIL ValueEntryRelation.NEXT = 0;
                        END;
                    UNTIL SalesCrMemoLine.NEXT = 0;
                END;
            UNTIL SalesCrMemoHdr.NEXT = 0;
    end;

    procedure AddToRecordSet(ItemLedgEntry: Record "Item Ledger Entry"; Amt: Decimal; AmtInclTax: Decimal; Qty: Decimal; DocNo: Code[20]; DocLineNo: Integer; EntryNo: Integer)
    var
        LotNoInfo: Record "Lot No. Information";
        Item: Record Item;
        CVEPedimento: Record "CVE Pedimento";
    begin

        //            TempItemLedgEntry.Quantity := ;
        IF NOT LotNoInfo.GET(ItemLedgEntry."Item No.", '', ItemLedgEntry."Lot No.") THEN
            CLEAR(LotNoInfo);

        /*
        IF CVEPedimento.GET(LotNoInfo."CVE Pedimento") THEN
          IF NOT CVEPedimento."Include on Virtual Invoice" THEN
            EXIT;
        */
        Item.GET(ItemLedgEntry."Item No.");

        SETRANGE("Virtural Operation No.", Item."HS Tariff Code");
        SETRANGE("Country of Origin", LotNoInfo."Country of Origin");
        SETRANGE("Item No.", Item."No.");
        SETRANGE("Custom Agent License No.", LotNoInfo."Patente Original");
        SETRANGE("Customer Agent E/S", LotNoInfo."Aduana E/S");
        SETRANGE("Summary Entry No.", LotNoInfo."Pediment No.");
        SETRANGE("Summary Entry Code", LotNoInfo."CVE Pedimento");
        SETRANGE("Date of Entry", LotNoInfo."Fecha de entrada");
        //SETRANGE("Doc No",DocNo);
        //SETRANGE("Doc Line No",DocLineNo);

        IF FIND('-') THEN BEGIN
            Quantity := Quantity + Qty;
            Weight := Weight + (Item."Gross Weight" * Qty);
            "Line Amount" := "Line Amount" + Amt;
            "Tax Amount" := "Tax Amount" + (AmtInclTax - Amt);
            "Amount Incl Tax" := "Amount Incl Tax" + AmtInclTax;
            MODIFY;
        END ELSE BEGIN
            "Entry No." := EntryNo;
            "Customer No." := ItemLedgEntry."Source No.";
            "Virtural Operation No." := Item."HS Tariff Code";
            "Country of Origin" := LotNoInfo."Country of Origin";
            "Item No." := Item."No.";
            "Custom Agent License No." := LotNoInfo."Patente Original";
            "Customer Agent E/S" := LotNoInfo."Aduana E/S";
            "Summary Entry No." := LotNoInfo."Pediment No.";
            "Summary Entry Code" := LotNoInfo."CVE Pedimento";
            "Date of Entry" := LotNoInfo."Fecha de entrada";
            Quantity := Qty;
            Weight := Item."Gross Weight" * Quantity;
            "Line Amount" := Amt;
            "Tax Amount" := AmtInclTax - Amt;
            "Amount Incl Tax" := AmtInclTax;
            "Doc No" := DocNo;
            "Doc Line No" := DocLineNo;
            INSERT;
        END;

        RESET;

    end;
}
