page 50020 "Lot Entry"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Caption = 'Lot Entry';
    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    Permissions = TableData "Whse. Item Tracking Line" = rimd;
    SourceTable = "Lot Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(" "; '')
                {
                    CaptionClass = FORMAT(HeaderString[1]);
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("  "; '')
                {
                    CaptionClass = FORMAT(HeaderString[2]);
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field("   "; '')
                {
                    CaptionClass = FORMAT(HeaderString[3]);
                    Editable = false;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
                field(QtyAssigned; QtyAssigned)
                {
                    Caption = 'Qty. Assigned';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Assigned field.';
                }
                field(QtyOutstanding; QtyOutstanding)
                {
                    Caption = 'Qty. Outstanding';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Outstanding field.';
                }
                field(QtyRemaining; QtyRemaining)
                {
                    Caption = 'Qty. Remaining';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Remaining field.';
                }
            }
            group(Generals)
            {
                field("Order Line No."; Rec."Order Line No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';

                    trigger OnAssistEdit()
                    var
                        Location: Record Location;
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                        MaxQuantity: Decimal;
                        SourceQuantityArray: array[5] of Decimal;
                        CurrentSignFactor: Integer;
                    begin
                        MaxQuantity := Rec.CalcQtyOutstanding - Rec.CalcQtyAssigned + Rec.Quantity;

                        //determine whether location is WMS to pick lookup method
                        IF NOT Location.GET(Rec."Location Code") THEN
                            CLEAR(Location);

                        IF Location."Bin Mandatory" THEN
                            ItemTrackingMgt.AssistEditLotSerialNoWMS(Rec, MaxQuantity)
                        ELSE
                            ItemTrackingMgt.AssistEditLotSerialNo2(Rec,
                              CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1, MaxQuantity);

                        CurrPage.UPDATE();
                    end;
                }
                field("Inspected Parts"; Rec."Inspected Parts")
                {
                    ToolTip = 'Specifies the value of the Inspected Parts field.';
                }
                field("CVE Pediment No."; Rec."CVE Pediment No.")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = "CVE Pediment No.Visible";
                    ToolTip = 'Specifies the value of the CVE Pediment No. field.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
                field("External Lot No."; Rec."External Lot No.")
                {
                    Caption = 'Mfg. Lot No.';
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ToolTip = 'Specifies the value of the Country of Origin field.';
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
                Image = ClearFilter;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Clear Lines action.';

                trigger OnAction()
                var
                    NVM: Codeunit "NewVision Management_New";
                begin
                    NVM.ClearLotEntryLines(Rec."Document Type", Rec."Document No.", Rec);
                end;
            }
            action(SuggestLines)
            {
                Caption = '&Suggest Lines';
                Image = SuggestReconciliationLines;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Suggest Lines action.';

                trigger OnAction()
                var
                    NVM: Codeunit "NewVision Management_New";
                begin
                    NVM.SuggestLotEntryLines(Rec."Document Type", Rec."Document No.", Rec);
                end;
            }
            action(SplitLiness)
            {
                Caption = '&Split Lines';
                Promoted = true;
                Image = Split;
                PromotedCategory = Process;
                Visible = SplitLinesVisible;
                ToolTip = 'Executes the &Split Lines action.';

                trigger OnAction()
                begin
                    SplitLines();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        "CVE Pediment No.Visible" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        //>>NIF 051206 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN
            "CVE Pediment No.Visible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush();
    end;

    var
        SalesHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        "CVE Pediment No.Visible": Boolean;
        SplitLinesVisible: Boolean;
        QtyAssigned: Decimal;
        QtyOutstanding: Decimal;
        QtyRemaining: Decimal;
        HeaderString: array[3] of Text[100];

    procedure GetHeaderText()
    var
        PurchHeader: Record "Purchase Header";
        WhseShptLine: Record "Warehouse Shipment Line";
    begin
        //if already have header text then exit
        IF HeaderString[1] <> '' THEN
            EXIT;

        //otherwise proceed

        CLEAR(HeaderString);

        CASE Rec."Document Type" OF
            Rec."Document Type"::"Whse. Shipment":
                BEGIN
                    IF NOT WhseShptLine.GET(Rec."Document No.", Rec."Order Line No.") THEN
                        CLEAR(WhseShptLine);

                    CASE WhseShptLine."Source Type" OF
                        DATABASE::"Sales Line":
                            IF SalesHeader.GET(WhseShptLine."Source Subtype", WhseShptLine."Source No.") THEN BEGIN
                                HeaderString[1] := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                                HeaderString[2] := SalesHeader."Sell-to Customer No." + ' ' + SalesHeader."Ship-to Name";
                            END;

                        DATABASE::"Transfer Line":
                            IF TransferHeader.GET(WhseShptLine."Source No.") THEN BEGIN
                                HeaderString[1] := 'Transfer Order ' + TransferHeader."No.";
                                HeaderString[2] := 'Transfer From: ' + TransferHeader."Transfer-from Code" + ' ' + TransferHeader."Transfer-from Name";
                                HeaderString[3] := 'Transfer To: ' + TransferHeader."Transfer-to Code" + ' ' + TransferHeader."Transfer-to Name";
                            END;
                    END;
                END;

            Rec."Document Type"::"Transfer Order":
                IF TransferHeader.GET(Rec."Document No.") THEN BEGIN
                    HeaderString[1] := 'Transfer Order ' + TransferHeader."No.";
                    HeaderString[2] := 'Transfer From: ' + TransferHeader."Transfer-from Code" + ' ' + TransferHeader."Transfer-from Name";
                    HeaderString[3] := 'Transfer To: ' + TransferHeader."Transfer-to Code" + ' ' + TransferHeader."Transfer-to Name";
                END;
            Rec."Document Type"::"Purchase Order":
                IF PurchHeader.GET(PurchHeader."Document Type"::Order, Rec."Document No.") THEN BEGIN
                    HeaderString[1] := 'Purchase Order ' + PurchHeader."No.";
                    HeaderString[2] := PurchHeader."Buy-from Vendor No." + ' ' + PurchHeader."Buy-from Vendor Name";
                END;
            ELSE
                IF SalesHeader.GET(Rec."Document Type", Rec."Document No.") THEN BEGIN
                    HeaderString[1] := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                    HeaderString[2] := SalesHeader."Sell-to Customer No." + ' ' + SalesHeader."Ship-to Name";
                END;
        END;   //END CASE
    end;

    procedure SplitLines()
    var
        LotEntry: Record "Lot Entry";
    begin
        LotEntry.COPY(Rec);
        Rec.SplitLine(LotEntry);
        CurrPage.UPDATE(FALSE);
    end;

    procedure CalcQuantities()
    begin
        QtyAssigned := Rec.CalcQtyAssigned;
        QtyOutstanding := Rec.CalcQtyOutstanding;

        QtyRemaining := QtyOutstanding - QtyAssigned;
    end;

    procedure CheckQuantities(var ErrorMsg: Text[250]): Boolean
    var
        LotEntry: Record "Lot Entry";
        TextLbl: Label 'Check Item %1, Line %2. Quantities do not match.', Comment = '%1%2';
        Text00Lbl: Label 'Check Item %1, Lot is blank. Quantities do not match.', Comment = '%1';
    begin
        LotEntry.SETRANGE("Document Type", Rec."Document Type");
        LotEntry.SETRANGE("Document No.", Rec."Document No.");
        LotEntry.FIND('-');
        REPEAT
            //IF (CalcQtyAssigned<>CalcQtyOutstanding) THEN
            IF (Rec.CalcQtyAssigned() <> Rec.CalcQtyToShip()) THEN BEGIN
                ErrorMsg := STRSUBSTNO(TextLbl, LotEntry."Item No.", LotEntry."Order Line No.");
                EXIT(FALSE);
            END;

            IF (LotEntry."Lot No." = '') THEN BEGIN
                ErrorMsg := STRSUBSTNO(Text00Lbl, LotEntry."Item No.");
                EXIT(FALSE);
            END;

        UNTIL LotEntry.NEXT() = 0;

        EXIT(TRUE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetHeaderText();
        CalcQuantities();

        //show suggest lines only if location is bin enabled
        //CurrForm.SuggestLines.VISIBLE("Document Type" = "Document Type"::"Whse. Shipment");
        //CurrForm.ClearLines.VISIBLE("Document Type" = "Document Type"::"Whse. Shipment");
        SplitLinesVisible := Rec."Document Type" <> Rec."Document Type"::"Purchase Order";
        CurrPage.EDITABLE(Rec."Document Type" <> Rec."Document Type"::"Purchase Order");
    end;

    local procedure LookupOKOnPush()
    var
        ErrorMsg: Text[250];
    begin
        IF NOT CheckQuantities(ErrorMsg) THEN
            IF Rec."Document Type" = Rec."Document Type"::"Whse. Shipment" THEN
                EXIT
            ELSE
                MESSAGE('%1', ErrorMsg);
    end;
}

