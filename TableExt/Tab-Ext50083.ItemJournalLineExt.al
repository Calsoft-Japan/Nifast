tableextension 50083 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(50000; "Mfg. Lot No."; Code[30])
        {
            // cleaned
            TableRelation = "Cust./Item Drawing2"."Revision No." WHERE("Item No." = FIELD("Item No."),
                                                                                                             "Customer No." = FILTER(''));
        }
        field(50010; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50011; "Revision No."; Code[20])
        {
            // cleaned
            trigger OnValidate()
            begin
                IF "Revision No." = '' THEN BEGIN
                    "Drawing No." := '';
                    "Revision Date" := 0D;
                END;
            end;
        }
        field(50012; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50013; "PIJ Lot No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  06-29-16';
            Editable = false;
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            // cleaned
            TableRelation = "Country/Region";
        }
        field(52010; Manufacturer; Code[50])
        {
            // cleaned
            TableRelation = Manufacturer;
        }
        field(60022; "Tipo Cambio (ACY)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(60023; "Adjustment Batch Entry"; Boolean)
        {
            Description = 'NF1.00:CIS.NG 07-21-16';
            Editable = false;
        }

        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                IF (rec."Entry Type" <= rec."Entry Type"::Transfer) AND (Quantity <> 0) THEN
                    TESTFIELD("Item No.");

            end;
        }
        modify("Qty. (Phys. Inventory)")
        {
            trigger OnAfterValidate()
            begin
                UpdateTracking_gFnc(TRUE);
            end;

            trigger OnBeforeValidate()
            begin
                UpdateTracking_gFnc(TRUE);
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                //>>NV
                TestItemSoftBlock(rec);
                //<<NV

            end;
        }

    }

    PROCEDURE TestItemSoftBlock(ItemJournalLine: record "Item Journal Line");
    BEGIN
        CASE ItemJournalLine."Entry Type" OF
            ItemJournalLine."Entry Type"::Sale:

                IF NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 0, SoftBlockError) THEN
                    ERROR(SoftBlockError);
            ItemJournalLine."Entry Type"::Purchase:

                IF NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 1, SoftBlockError) THEN
                    ERROR(SoftBlockError);
            ItemJournalLine."Entry Type"::Transfer:

                IF NVM.CheckSoftBlock(2, ItemJournalLine."Item No.", ItemJournalLine."Location Code", ItemJournalLine."Variant Code", 2, SoftBlockError) THEN
                    ERROR(SoftBlockError);
        END;
    END;


    LOCAL PROCEDURE UpdateTracking_gFnc(DelOnly_iBln: Boolean);
    VAR
        ReservationEntry_lRec: Record 337;
        LotNo_lCod: Code[20];
        Multipiler_lInt: Integer;
    BEGIN
        //>>NF1.00:CIS.NG  06-29-16  Generate the Actual Reservation Entry with Qty when user enter the Phy Inv Qty
        IF CurrFieldNo = 0 THEN
            EXIT;

        CLEAR(LotNo_lCod);
        ReservationEntry_lRec.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        ReservationEntry_lRec.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry_lRec.SETFILTER("Source Subtype", '2|3');
        ReservationEntry_lRec.SETRANGE("Source ID", "Journal Template Name");
        ReservationEntry_lRec.SETRANGE("Source Batch Name", "Journal Batch Name");
        ReservationEntry_lRec.SETRANGE("Source Ref. No.", "Line No.");
        ReservationEntry_lRec.SETFILTER("Lot No.", '<>%1', '');
        IF (ReservationEntry_lRec.ISEMPTY) AND ("PIJ Lot No." = '') THEN
            EXIT;

        IF ReservationEntry_lRec.FINDFIRST() THEN
            LotNo_lCod := ReservationEntry_lRec."Lot No.";

        ReservationEntry_lRec.DELETEALL();

        IF "PIJ Lot No." <> '' THEN
            LotNo_lCod := "PIJ Lot No."
        ELSE
            "PIJ Lot No." := LotNo_lCod;

        IF DelOnly_iBln THEN
            EXIT;

        MODIFY(TRUE);

        IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN BEGIN
            ReservationEntry_lRec.Positive := TRUE;
            Multipiler_lInt := 1;
        END ELSE BEGIN
            ReservationEntry_lRec.Positive := FALSE;
            Multipiler_lInt := -1;
            //EXIT;
        END;


        ReservationEntry_lRec.RESET();
        ReservationEntry_lRec.INIT();
        ReservationEntry_lRec."Item No." := "Item No.";
        ReservationEntry_lRec."Location Code" := "Location Code";
        ReservationEntry_lRec."Quantity (Base)" := Multipiler_lInt * "Quantity (Base)";
        ReservationEntry_lRec."Reservation Status" := ReservationEntry_lRec."Reservation Status"::Prospect;
        ReservationEntry_lRec.Description := Description;
        ReservationEntry_lRec."Creation Date" := TODAY();
        ReservationEntry_lRec."Source Type" := 83;

        IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN BEGIN
            ReservationEntry_lRec."Source Subtype" := 2;
            ReservationEntry_lRec."Expected Receipt Date" := "Posting Date";
        END ELSE BEGIN
            ReservationEntry_lRec."Source Subtype" := 3;
            ReservationEntry_lRec."Shipment Date" := "Posting Date";
        END;

        ReservationEntry_lRec."Source ID" := "Journal Template Name";
        ReservationEntry_lRec."Source Batch Name" := "Journal Batch Name";
        ReservationEntry_lRec."Source Ref. No." := "Line No.";

        ReservationEntry_lRec."Created By" := USERID();

        ReservationEntry_lRec."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
        ReservationEntry_lRec.Quantity := Multipiler_lInt * Quantity;
        ReservationEntry_lRec."Qty. to Handle (Base)" := Multipiler_lInt * "Quantity (Base)";
        ReservationEntry_lRec."Qty. to Invoice (Base)" := Multipiler_lInt * "Quantity (Base)";
        ReservationEntry_lRec."Lot No." := LotNo_lCod;
        ReservationEntry_lRec."Item Tracking" := ReservationEntry_lRec."Item Tracking"::"Lot No.";
        ReservationEntry_lRec.INSERT(TRUE);
        "PIJ Lot No." := LotNo_lCod;
        //<<NF1.00:CIS.NG  06-29-16
    END;

    PROCEDURE IsPurchaseReturn(): Boolean;
    BEGIN
        EXIT(
          ("Document Type" IN ["Document Type"::"Purchase Credit Memo",
                               "Document Type"::"Purchase Return Shipment"]) AND
          (Quantity < 0));
    END;


    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];


}
