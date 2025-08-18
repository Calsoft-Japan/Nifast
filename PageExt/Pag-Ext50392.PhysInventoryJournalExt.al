pageextension 50392 "Phys. Inventory Journal Ext" extends "Phys. Inventory Journal"
{
    layout
    {

    }
    actions
    {
        addafter("Test Report")
        {
            // action("Conversion Inventory")
            // {

            //     CaptionML = ENU = 'Conversion Inventory';
            //     Visible = FALSE;
            //     trigger OnAction()
            //     BEGIN
            //         //>> NF1.00:CIS.NG 09-03-15
            //         //InitCalc.SetItemJnlLine(Rec);
            //         //InitCalc.RUNMODAL;
            //         //CLEAR(InitCalc);
            //         //<< NF1.00:CIS.NG 09-03-15
            //     END;
            // }
            action("Test Report - NIF")
            {

                CaptionML = ENU = 'Test Report - NIF';
                ToolTip = 'Test report';
                Image = Report;
                trigger OnAction()
                VAR
                    ItemJnlBatch: Record 233;
                    TestReportNIF: Report 50053;
                BEGIN
                    ItemJnlBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlBatch.SETRANGE(Name, Rec."Journal Batch Name");
                    TestReportNIF.SETTABLEVIEW(ItemJnlBatch);

                    TestReportNIF.RUN;
                END;
            }
        }
        addafter("Bin Contents")
        {
            action("Lot Bin Contents")
            {

                CaptionML = ENU = 'Lot Bin Content';
                ToolTip = ' Lot for Bin contents';
                Image = BinContent;
                trigger OnAction()
                VAR
                    Item: Record 27;
                    ItemTrackingMgmt: Codeunit 6500;
                //">>NIF_LV": Integer;
                BEGIN
                    IF NOT Item.GET(Rec."Item No.") THEN
                        EXIT;

                    IF Item."Item Tracking Code" = '' THEN
                        EXIT;

                    IF Rec."Location Code" <> '' THEN
                        Item.SETRANGE("Location Filter", Rec."Location Code");

                    ItemTrackingMgmt.LotBinContentLookup(Item);
                END;

            }
        }
        addafter("P&osting")
        {
            action("Physical Inv. Count")
            {
                CaptionML = ENU = 'Physical Inv. Count';
                ToolTip = 'Physical Invenroty count';
                Image = Inventory;
                trigger OnAction()
                BEGIN
                    ItemJnlLine := Rec;
                    ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                    REPORT.RUN(REPORT::"Physical Inventory Count", TRUE, FALSE, ItemJnlLine);
                END;
            }
            action("Physical Inv. List")
            {

                CaptionML = ENU = 'Physical Inv. List';
                ToolTip = 'Physical Inventory list';
                Image = Inventory;
                trigger OnAction()
                BEGIN
                    ItemJnlLine := Rec;
                    ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                    REPORT.RUN(REPORT::"Phys. Inventory List", TRUE, FALSE, ItemJnlLine);
                END;
            }
        }
    }
    var
        ItemJnlLine: Record "Item Journal Line";
        // "//AKK1606.01--": Integer;
        wLibro: Code[10];
        wSeccion: Code[10];
    // "//AKK1606.01++": Integer;

    trigger OnDeleteRecord(): Boolean
    begin
        //>> NIF 10-06-05 RTT #10386
        //delete any zero reserv entries
        ClearZeroReservEntries();
        //<< NIF 10-06-05 RTT #10386
    end;

    PROCEDURE ClearZeroReservEntries();
    VAR
        ReservEntry: Record 337;
    BEGIN
        ReservEntry.SETCURRENTKEY(
            "Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SETFILTER("Source Subtype", '2|3');
        ReservEntry.SETRANGE("Source ID", Rec."Journal Template Name");
        ReservEntry.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
        ReservEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
        ReservEntry.SETRANGE(Quantity, 0);
        ReservEntry.SETRANGE("Qty. to Handle (Base)", 0);
        ReservEntry.SETRANGE("Quantity Invoiced (Base)", 0);
        ReservEntry.SETRANGE("Quantity (Base)", 0);
        IF ReservEntry.ISEMPTY THEN
            EXIT;

        ReservEntry.DELETEALL(TRUE);
    END;

    PROCEDURE LotString(): Text[1024];
    VAR
        ReservEntry: Record 337;
        LotText: Text[1024];
        Counter: Integer;
    BEGIN
        CLEAR(LotText);
        CLEAR(Counter);
        ReservEntry.SETCURRENTKEY(
            "Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");

        ReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SETFILTER("Source Subtype", '2|3');
        ReservEntry.SETRANGE("Source ID", REc."Journal Template Name");
        ReservEntry.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
        ReservEntry.SETRANGE("Source Ref. No.", REc."Line No.");
        ReservEntry.SETFILTER("Lot No.", '<>%1', '');
        IF ReservEntry.ISEMPTY THEN
            EXIT('');

        IF ReservEntry.FIND('-') THEN
            REPEAT
                Counter := Counter + 1;
                IF Counter > 1 THEN
                    LotText := LotText + ',' + ReservEntry."Lot No."
                ELSE
                    LotText := ReservEntry."Lot No.";
            UNTIL (ReservEntry.NEXT() = 0) OR (STRLEN(LotText) > 1000);

        EXIT(LotText);
    END;

    PROCEDURE fValida();
    VAR
        rItemJnlLine: Record 83;
    BEGIN
        //-AKK1606.01--
        rItemJnlLine.RESET();
        rItemJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        rItemJnlLine.SETRANGE("Journal Template Name", wLibro);
        rItemJnlLine.SETRANGE("Journal Batch Name", wSeccion);
        rItemJnlLine.SETFILTER("Entry Type", '%1|%2', rItemJnlLine."Entry Type"::"Positive Adjmt.",
        rItemJnlLine."Entry Type"::Purchase);
        rItemJnlLine.SETRANGE(National, FALSE);
        IF rItemJnlLine.FINDSET() THEN
            REPEAT
                rItemJnlLine.TESTFIELD("Entry/Exit Point");
                rItemJnlLine.TESTFIELD("Entry/Exit No.");
                rItemJnlLine.TESTFIELD("Entry/Exit Date");
            UNTIL rItemJnlLine.NEXT() = 0;
        //+AKK1606.01++
    END;

}
