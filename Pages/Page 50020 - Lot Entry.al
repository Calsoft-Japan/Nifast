page 50020 "Lot Entry"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Caption = 'Lot Entry';
    InsertAllowed = false;
    PageType = Card;
    Permissions = TableData 6550=rimd;
    SourceTable = Table50002;

    layout
    {
        area(content)
        {
            group()
            {
                field(;'')
                {
                    CaptionClass = FORMAT (HeaderString[1]);
                    Editable = false;
                }
                field(;'')
                {
                    CaptionClass = FORMAT (HeaderString[2]);
                    Editable = false;
                }
                field(;'')
                {
                    CaptionClass = FORMAT (HeaderString[3]);
                    Editable = false;
                }
                field(QtyAssigned;QtyAssigned)
                {
                    Caption = 'Qty. Assigned';
                    DecimalPlaces = 0:2;
                    Editable = false;
                }
                field(QtyOutstanding;QtyOutstanding)
                {
                    Caption = 'Qty. Outstanding';
                    DecimalPlaces = 0:2;
                    Editable = false;
                }
                field(QtyRemaining;QtyRemaining)
                {
                    Caption = 'Qty. Remaining';
                    DecimalPlaces = 0:2;
                    Editable = false;
                }
            }
            repeater()
            {
                field("Order Line No.";"Order Line No.")
                {
                    Editable = false;
                }
                field("Item No.";"Item No.")
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Editable = false;
                }
                field(Quantity;Quantity)
                {
                    DecimalPlaces = 0:2;
                }
                field("Expiration Date";"Expiration Date")
                {
                    Visible = false;
                }
                field("Lot No.";"Lot No.")
                {

                    trigger OnAssistEdit()
                    var
                        ItemTrackingMgt: Codeunit "6500";
                        SourceQuantityArray: array [5] of Decimal;
                        CurrentSignFactor: Integer;
                        ColorOfQuantityArray: array [3] of Integer;
                        MaxQuantity: Decimal;
                        Location: Record "14";
                    begin
                        MaxQuantity := CalcQtyOutstanding - CalcQtyAssigned + Quantity;

                        //determine whether location is WMS to pick lookup method
                        IF NOT Location.GET("Location Code") THEN
                          CLEAR(Location);

                        IF Location."Bin Mandatory" THEN
                          ItemTrackingMgt.AssistEditLotSerialNoWMS(Rec,MaxQuantity)
                        ELSE
                          ItemTrackingMgt.AssistEditLotSerialNo2(Rec,
                            CurrentSignFactor * SourceQuantityArray[1] < 0,CurrentSignFactor,1,MaxQuantity);

                        CurrPage.UPDATE;
                    end;
                }
                field("Inspected Parts";"Inspected Parts")
                {
                }
                field("CVE Pediment No.";"CVE Pediment No.")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = "CVE Pediment No.Visible";
                }
                field("Revision No.";"Revision No.")
                {
                    Visible = false;
                }
                field("External Lot No.";"External Lot No.")
                {
                    Caption = 'Mfg. Lot No.';
                }
                field("Creation Date";"Creation Date")
                {
                }
                field("Country of Origin";"Country of Origin")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClearLines)
            {
                Caption = '&Clear Lines';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    NVM: Codeunit "50021";
                begin
                    NVM.ClearLotEntryLines("Document Type","Document No.",Rec);
                end;
            }
            action(SuggestLines)
            {
                Caption = '&Suggest Lines';
                Image = SuggestReconciliationLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    NVM: Codeunit "50021";
                begin
                    NVM.SuggestLotEntryLines("Document Type","Document No.",Rec);
                end;
            }
            action(SplitLines)
            {
                Caption = '&Split Lines';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SplitLinesVisible;

                trigger OnAction()
                begin
                    SplitLines;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "CVE Pediment No.Visible" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        //>>NIF 051206 RTT #10775
        IF STRPOS(COMPANYNAME,'Mexi')=0 THEN
          "CVE Pediment No.Visible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        QtyAssigned: Decimal;
        QtyOutstanding: Decimal;
        QtyRemaining: Decimal;
        SalesHeader: Record "36";
        TransferHeader: Record "5740";
        HeaderString: array [3] of Text[100];
        [InDataSet]
        "CVE Pediment No.Visible": Boolean;
        [InDataSet]
        SplitLinesVisible: Boolean;

    procedure GetHeaderText()
    var
        WhseShptLine: Record "7321";
        PurchHeader: Record "38";
    begin
        //if already have header text then exit
        IF HeaderString[1]<>'' THEN
          EXIT;

        //otherwise proceed

        CLEAR(HeaderString);

        CASE "Document Type" OF
          "Document Type"::"Whse. Shipment":
          BEGIN
             IF NOT WhseShptLine.GET("Document No.","Order Line No.") THEN
                CLEAR(WhseShptLine);

            CASE WhseShptLine."Source Type" OF
              DATABASE::"Sales Line":
                 IF SalesHeader.GET(WhseShptLine."Source Subtype",WhseShptLine."Source No.") THEN
                   BEGIN
                   HeaderString[1] := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                   HeaderString[2] := SalesHeader."Sell-to Customer No." + ' ' + SalesHeader."Ship-to Name";
                 END;

             DATABASE::"Transfer Line":
               IF TransferHeader.GET(WhseShptLine."Source No.") THEN
                 BEGIN
                   HeaderString[1] := 'Transfer Order ' + TransferHeader."No.";
                   HeaderString[2] := 'Transfer From: ' + TransferHeader."Transfer-from Code" + ' ' + TransferHeader."Transfer-from Name";
                   HeaderString[3] := 'Transfer To: ' + TransferHeader."Transfer-to Code" + ' ' + TransferHeader."Transfer-to Name";
                 END;
            END;
          END;

          "Document Type"::"Transfer Order":
            IF TransferHeader.GET("Document No.") THEN
              BEGIN
                HeaderString[1] := 'Transfer Order ' + TransferHeader."No.";
                HeaderString[2] := 'Transfer From: ' + TransferHeader."Transfer-from Code" + ' ' + TransferHeader."Transfer-from Name";
                HeaderString[3] := 'Transfer To: ' + TransferHeader."Transfer-to Code" + ' ' + TransferHeader."Transfer-to Name";
              END;
          "Document Type"::"Purchase Order":
            IF PurchHeader.GET(PurchHeader."Document Type"::Order,"Document No.") THEN
              BEGIN
                HeaderString[1] := 'Purchase Order ' + PurchHeader."No.";
                HeaderString[2] := PurchHeader."Buy-from Vendor No." + ' ' + PurchHeader."Buy-from Vendor Name";
              END;
          ELSE BEGIN
            IF SalesHeader.GET("Document Type","Document No.") THEN
              BEGIN
                HeaderString[1] := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                HeaderString[2] := SalesHeader."Sell-to Customer No." + ' ' + SalesHeader."Ship-to Name";
              END;
          END;
        END;   //END CASE
    end;

    procedure SplitLines()
    var
        LotEntry: Record "50002";
    begin
        LotEntry.COPY(Rec);
        SplitLine(LotEntry);
        CurrPage.UPDATE(FALSE);
    end;

    procedure CalcQuantities()
    begin
        QtyAssigned := CalcQtyAssigned;
        QtyOutstanding := CalcQtyOutstanding;

        QtyRemaining := QtyOutstanding - QtyAssigned;
    end;

    procedure CheckQuantities(var ErrorMsg: Text[250]): Boolean
    var
        LotEntry: Record "50002";
    begin
        LotEntry.SETRANGE("Document Type","Document Type");
        LotEntry.SETRANGE("Document No.","Document No.");
        LotEntry.FIND('-');
        REPEAT
          //IF (CalcQtyAssigned<>CalcQtyOutstanding) THEN
          IF (CalcQtyAssigned<>CalcQtyToShip) THEN
            BEGIN
              ErrorMsg := STRSUBSTNO('Check Item %1, Line %2. Quantities do not match.',LotEntry."Item No.",LotEntry."Order Line No.");
              EXIT(FALSE);
            END;

          IF (LotEntry."Lot No."='') THEN
            BEGIN
              ErrorMsg := STRSUBSTNO('Check Item %1, Lot is blank. Quantities do not match.',LotEntry."Item No.");
              EXIT(FALSE);
            END;

        UNTIL LotEntry.NEXT=0;

        EXIT(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    var
        Location: Record "14";
    begin
        xRec := Rec;
        GetHeaderText;
        CalcQuantities;

        //show suggest lines only if location is bin enabled
        //CurrForm.SuggestLines.VISIBLE("Document Type" = "Document Type"::"Whse. Shipment");
        //CurrForm.ClearLines.VISIBLE("Document Type" = "Document Type"::"Whse. Shipment");
        SplitLinesVisible := "Document Type" <> "Document Type"::"Purchase Order";
        CurrPage.EDITABLE("Document Type" <> "Document Type"::"Purchase Order");
    end;

    local procedure LookupOKOnPush()
    var
        ErrorMsg: Text[250];
    begin
        IF NOT CheckQuantities(ErrorMsg) THEN
         BEGIN
           IF "Document Type"="Document Type"::"Whse. Shipment" THEN
             EXIT
           ELSE
            MESSAGE('%1',ErrorMsg);
         END;
    end;
}

