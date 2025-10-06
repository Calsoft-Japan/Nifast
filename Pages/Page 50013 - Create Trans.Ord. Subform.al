page 50013 "Create Trans.Ord. Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  09-01-16 Fix the Code to Create the Tracking Line for Receipt Entry on transfer order created
    // //>>NIF
    //   //MAK 030106  Added a SetRange to eliminat lines marked as "Correction" from coming in.  Lines get marked
    //                   this way if you do an "Undo Receipt" on them.  This prevents the lines that were "undone"
    //                   from coming into the grid.

    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    Permissions = TableData 121=rimd;
    SourceTable = Table121;
    SourceTableView = SORTING(Document No.,Line No.)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Select;Select)
                {
                }
                field(TrOrdCreated;"Transfer Order Created")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        MESSAGE('this was just validated!');
                    end;
                }
                field("Document No.";"Document No.")
                {
                    Editable = false;
                }
                field(Type;Type)
                {
                    Editable = false;
                }
                field("No.";"No.")
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Location Code";"Location Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    Editable = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Editable = false;
                }
                field(Quantity;Quantity)
                {
                    Editable = false;
                }
                field("Vessel Name";"Vessel Name")
                {
                    Editable = false;
                }
                field("Sail-on Date";"Sail-on Date")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        SetSubFormFilter(VendNo, FromLocationCode, VesselName,SailOnDate,ToLocationCode);
    end;

    var
        Window: Dialog;
        Vend: Record "23";
        FromLocation: Record "14";
        ToLocation: Record "14";
        FromBin: Record "7354";
        ReceiptLines: Record "121";
        TempPurchRcptLine: Record "121" temporary;
        TransHeader: Record "5740";
        TransLine: Record "5741";
        RespCtr: Record "5714";
        ILE: Record "32";
        ResEntry: Record "337";
        InventorySetup: Record "313";
        IER: Record "6507";
        VendNo: Code[20];
        FromLocationCode: Code[10];
        ToLocationCode: Code[10];
        VesselName: Code[50];
        SailOnDate: Date;
        NIF00001: Label 'Creating Transfer Order #1##############';
        NIF00002: Label 'Processing Complete';
        tLineNo: Integer;
        ResEntryNo: Integer;

    procedure SetSubFormFilter(tVendNo: Code[20];tFromLocationCode: Code[10];tVesselName: Code[50];tSailOnDate: Date;tToLocationCode: Code[10]) ReturnCount: Integer
    begin
        CLEAR(Rec);
        SETFILTER(Quantity, '>0');
        SETRANGE("Buy-from Vendor No.", tVendNo);
        SETRANGE("Location Code", tFromLocationCode);
        SETRANGE("Vessel Name", tVesselName);
        SETRANGE("Sail-on Date", tSailOnDate);
        SETRANGE("Transfer Order Created", FALSE);

        SETRANGE(Correction, FALSE);    //>>NIF MAK 030106

        VendNo := tVendNo;
        FromLocationCode := tFromLocationCode;
        VesselName := tVesselName;
        SailOnDate := tSailOnDate;
        ToLocationCode := tToLocationCode;

        ReturnCount := Rec.COUNT;
        CurrPage.UPDATE(FALSE);  //NF1.00:CIS.NG  09-05-15
    end;

    procedure PopulateTempTable()
    begin
        IF Rec.FIND('-') THEN
          REPEAT
            TempPurchRcptLine.INIT;
            TempPurchRcptLine := Rec;
            TempPurchRcptLine.INSERT;
          UNTIL Rec.NEXT = 0;
    end;

    procedure CreateTransfers()
    begin
        Window.OPEN(NIF00001);

        InventorySetup.GET();
        InventorySetup.TESTFIELD("Auto. Transfer Order Nos.");
        InventorySetup.TESTFIELD("Default In-Transit Location");

        ToLocation.GET(ToLocationCode);
        IF ToLocation."Bin Mandatory" THEN
          ToLocation.TESTFIELD("Receipt Bin Code");
        FromLocation.GET(FromLocationCode);
        IF FromLocation."Bin Mandatory" THEN
          FromLocation.TESTFIELD("Receipt Bin Code");

        ///WITH TempPurchRcptLine DO BEGIN
        SETRANGE(Select, TRUE);
        IF FIND('-') THEN
          BEGIN
            ResEntry.LOCKTABLE;
            TransHeader.LOCKTABLE;
            TransLine.LOCKTABLE;
            //First - Create the Master Header
            TransHeader.INIT;
            TransHeader."No. Series" := InventorySetup."Auto. Transfer Order Nos.";
            TransHeader.VALIDATE("No.");
            TransHeader.INSERT(TRUE);
            TransHeader.VALIDATE("Transfer-from Code",  FromLocationCode);
            TransHeader.VALIDATE("Transfer-to Code", ToLocationCode);
            TransHeader.VALIDATE("In-Transit Code", InventorySetup."Default In-Transit Location");
            TransHeader.VALIDATE("Vessel Name", "Vessel Name");
            TransHeader.VALIDATE("Sail-On Date", "Sail-on Date");
            TransHeader.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");  //>>IST MAK 022106
            TransHeader.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");  //>>IST MAK 022106
            TransHeader.MODIFY(TRUE);
            Window.UPDATE(1, TransHeader."No.");
            CLEAR(tLineNo);
            //Create the Lines for the Master Header
            FIND('-');
            REPEAT
              CLEAR(TransLine);
              tLineNo := tLineNo + 10000;
              TransLine.INIT;
              TransLine.VALIDATE("Document No.", TransHeader."No.");
              TransLine.VALIDATE("Line No.", tLineNo);
              TransLine.VALIDATE("Item No.", "No.");
              IF FromLocation."Bin Mandatory" THEN
                TransLine.VALIDATE("Transfer-from Bin Code", FromLocation."Receipt Bin Code");
              IF ToLocation."Bin Mandatory" THEN
                TransLine.VALIDATE("Transfer-To Bin Code", ToLocation."Receipt Bin Code");
              TransLine.INSERT(TRUE);
              TransLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
              TransLine.VALIDATE(Quantity, Quantity);
              TransLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
              TransLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
              //>>NIF MAK 091905
              TransLine.VALIDATE("Source PO No.", "Order No.");
              TransLine.VALIDATE("Contract Note No.", "Contract Note No.");
              //<<NIF MAK 091905
              TransLine.MODIFY(TRUE);
              //Now, Insert the Item Tracking Lines for this transfer
              IER.SETCURRENTKEY("Source ID","Source Type","Source Subtype","Source Ref. No.","Source Prod. Order Line","Source Batch Name"
        );
              IER.SETRANGE("Source Type", 121);
              IER.SETRANGE("Source ID", "Document No.");
              IER.SETRANGE("Source Subtype", 0);
              IER.SETRANGE("Source Ref. No.", "Line No.");
              ResEntry.FIND('+');
              ResEntryNo := ResEntry."Entry No.";
              IF IER.FIND('-') THEN
                REPEAT
                  ResEntryNo := ResEntryNo + 1;
                  CLEAR(ResEntry);
                  ResEntry.INIT;
                  ResEntry.VALIDATE("Entry No.", ResEntryNo);
                  ResEntry.VALIDATE("Item No.", "No.");
                  ResEntry.VALIDATE("Location Code", FromLocationCode);
                  ILE.GET(IER."Item Entry No.");
                  ResEntry.VALIDATE("Quantity (Base)", -ILE.Quantity);
                  ResEntry.VALIDATE("Reservation Status", ResEntry."Reservation Status"::Surplus);
                  ResEntry.VALIDATE(Description, 'MARK');
                  ResEntry.VALIDATE("Creation Date", WORKDATE);
                  ResEntry.VALIDATE("Source Type", 5741);
                  ResEntry.VALIDATE("Source ID", TransLine."Document No.");
                  ResEntry.VALIDATE("Source Ref. No.", TransLine."Line No.");
                  ResEntry.VALIDATE("Shipment Date", TransHeader."Shipment Date");
                  ResEntry.VALIDATE("Created By", USERID);
                  ResEntry.VALIDATE(Positive, FALSE);
                  ResEntry.VALIDATE("Qty. per Unit of Measure", TransLine."Qty. per Unit of Measure");
                  ResEntry.VALIDATE(Quantity, -TransLine.Quantity);
                  ResEntry.VALIDATE("Lot No.", IER."Lot No.");
                  //ResEntry.Validate("", "");
                  ResEntry.INSERT(TRUE);


                  //>>NF1.00:CIS.NG  09-01-16  //Create Tracking Entry for Receipt
                  ResEntryNo := ResEntryNo + 1;
                  CLEAR(ResEntry);
                  ResEntry.INIT;
                  ResEntry.VALIDATE("Entry No.", ResEntryNo);
                  ResEntry.VALIDATE("Item No.", "No.");
                  ResEntry.VALIDATE("Location Code",ToLocationCode);
                  ILE.GET(IER."Item Entry No.");
                  ResEntry.VALIDATE("Quantity (Base)",ILE.Quantity);
                  ResEntry.VALIDATE("Reservation Status", ResEntry."Reservation Status"::Surplus);
                  ResEntry.VALIDATE(Description, 'MARK');
                  ResEntry.VALIDATE("Creation Date", WORKDATE);
                  ResEntry.VALIDATE("Source Type", 5741);
                  ResEntry.VALIDATE("Source Subtype",1);
                  ResEntry.VALIDATE("Source ID", TransLine."Document No.");
                  ResEntry.VALIDATE("Source Ref. No.", TransLine."Line No.");
                  ResEntry.VALIDATE("Expected Receipt Date", TransHeader."Shipment Date");
                  ResEntry.VALIDATE("Created By", USERID);
                  ResEntry.VALIDATE(Positive, TRUE);
                  ResEntry.VALIDATE("Qty. per Unit of Measure", TransLine."Qty. per Unit of Measure");
                  ResEntry.VALIDATE(Quantity, TransLine.Quantity);
                  ResEntry.VALIDATE("Lot No.", IER."Lot No.");
                  //ResEntry.Validate("", "");
                  ResEntry.INSERT(TRUE);
                  //<<NF1.00:CIS.NG  09-01-16


                UNTIL IER.NEXT = 0;
            UNTIL NEXT = 0;
            //Now, loop thru the Resp Ctrs and create the transfers for each of them
            IF RespCtr.FIND('-') THEN
              REPEAT
                SETRANGE("Responsibility Center", RespCtr.Code);
                IF COUNT > 0 THEN
                  BEGIN
                  IF RespCtr.Code <> ToLocationCode THEN  //Can't create a hdr w/ same To & From
                    BEGIN
                      //First - Create the Resp Ctr Header
                      CLEAR(TransHeader);
                      TransHeader.INIT;
                      TransHeader."No. Series" := InventorySetup."Auto. Transfer Order Nos.";
                      TransHeader.VALIDATE("No.");
                      TransHeader.INSERT(TRUE);
                      TransHeader.VALIDATE("Transfer-from Code",  ToLocationCode);
                      TransHeader.VALIDATE("Transfer-to Code", RespCtr."Location Code");
                      TransHeader.VALIDATE("In-Transit Code", InventorySetup."Default In-Transit Location");
                      TransHeader.VALIDATE("Vessel Name",  "Vessel Name");
                      TransHeader.VALIDATE("Sail-On Date", "Sail-on Date");
                      TransHeader.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");  //>>IST MAK 022106
                      TransHeader.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");  //>>IST MAK 022106
                      TransHeader.MODIFY(TRUE);
                      Window.UPDATE(1, TransHeader."No.");
                    END;
                  CLEAR(tLineNo);
                  //Create the Lines for the Resp Ctr Header
                  FIND('-');
                  REPEAT
                  IF RespCtr.Code <> ToLocationCode THEN  //Can't create a hdr w/ same To & From
                    BEGIN
                      CLEAR(TransLine);
                      tLineNo := tLineNo + 10000;
                      TransLine.INIT;
                      TransLine.VALIDATE("Document No.", TransHeader."No.");
                      TransLine.VALIDATE("Line No.", tLineNo);
                      TransLine.VALIDATE("Item No.", "No.");
                      TransLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
                      TransLine.VALIDATE(Quantity, Quantity);
                      TransLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                      TransLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                      //>>NIF MAK 091905
                      TransLine.VALIDATE("Source PO No.", "Order No.");
                      TransLine.VALIDATE("Contract Note No.", "Contract Note No.");
                      //<<NIF MAK 091905
                      IF FromLocation."Bin Mandatory" THEN
                        TransLine."Transfer-To Bin Code" := FromLocation."Receipt Bin Code";       //NOTE: To & From Bins are
                      IF ToLocation."Bin Mandatory" THEN                                           //      flipped for this section
                        TransLine."Transfer-from Bin Code" := ToLocation."Receipt Bin Code";
                      //TransLine.Validate("", );
                      TransLine.INSERT(TRUE);
                      //Now, Insert the Item Tracking Lines for this transfer
                      IER.SETCURRENTKEY("Source ID","Source Type","Source Subtype","Source Ref. No.","Source Prod. Order Line",
                                        "Source Batch Name");
                      IER.SETRANGE("Source Type", 121);
                      IER.SETRANGE("Source ID", "Document No.");
                      IER.SETRANGE("Source Subtype", 0);
                      IER.SETRANGE("Source Ref. No.", "Line No.");
                      ResEntry.FIND('+');
                      ResEntryNo := ResEntry."Entry No.";
                      IF IER.FIND('-') THEN
                        REPEAT
                          ResEntryNo := ResEntryNo + 1;
                          CLEAR(ResEntry);
                          ResEntry.INIT;
                          ResEntry.VALIDATE("Entry No.", ResEntryNo);
                          ResEntry.VALIDATE("Item No.", "No.");
                          ResEntry.VALIDATE("Location Code", ToLocationCode);
                          ILE.GET(IER."Item Entry No.");
                          ResEntry.VALIDATE("Quantity (Base)", -ILE.Quantity);
                          ResEntry.VALIDATE("Reservation Status", ResEntry."Reservation Status"::Surplus);
                          ResEntry.VALIDATE(Description, 'MARK');
                          ResEntry.VALIDATE("Creation Date", WORKDATE);
                          ResEntry.VALIDATE("Source Type", 5741);
                          ResEntry.VALIDATE("Source ID", TransLine."Document No.");
                          ResEntry.VALIDATE("Source Ref. No.", TransLine."Line No.");
                          ResEntry.VALIDATE("Shipment Date", TransHeader."Shipment Date");
                          ResEntry.VALIDATE("Created By", USERID);
                          ResEntry.VALIDATE(Positive, FALSE);
                          ResEntry.VALIDATE("Qty. per Unit of Measure", TransLine."Qty. per Unit of Measure");
                          ResEntry.VALIDATE(Quantity, -TransLine.Quantity);
                          ResEntry.VALIDATE("Lot No.", IER."Lot No.");
                          //ResEntry.Validate("", "");
                          ResEntry.INSERT(TRUE);

                          //>>NF1.00:CIS.NG  09-01-16 Create the Entry for Receipt
                          ResEntryNo := ResEntryNo + 1;
                          CLEAR(ResEntry);
                          ResEntry.INIT;
                          ResEntry.VALIDATE("Entry No.", ResEntryNo);
                          ResEntry.VALIDATE("Item No.", "No.");
                          ResEntry.VALIDATE("Location Code", RespCtr."Location Code");
                          ILE.GET(IER."Item Entry No.");
                          ResEntry.VALIDATE("Quantity (Base)", ILE.Quantity);
                          ResEntry.VALIDATE("Reservation Status", ResEntry."Reservation Status"::Surplus);
                          ResEntry.VALIDATE(Description, 'MARK');
                          ResEntry.VALIDATE("Creation Date", WORKDATE);
                          ResEntry.VALIDATE("Source Type", 5741);
                          ResEntry.VALIDATE("Source Subtype",1);
                          ResEntry.VALIDATE("Source ID", TransLine."Document No.");
                          ResEntry.VALIDATE("Source Ref. No.", TransLine."Line No.");
                          ResEntry.VALIDATE("Expected Receipt Date", TransHeader."Shipment Date");
                          ResEntry.VALIDATE("Created By", USERID);
                          ResEntry.VALIDATE(Positive, TRUE);
                          ResEntry.VALIDATE("Qty. per Unit of Measure", TransLine."Qty. per Unit of Measure");
                          ResEntry.VALIDATE(Quantity, TransLine.Quantity);
                          ResEntry.VALIDATE("Lot No.", IER."Lot No.");
                          //ResEntry.Validate("", "");
                          ResEntry.INSERT(TRUE);
                          //<<NF1.00:CIS.NG  09-01-16 Create the Entry for Receipt


                        UNTIL IER.NEXT = 0;
                    END;
                    //Flag the line as having been created
                    "Transfer Order Created" := TRUE;
                    MODIFY;
                  UNTIL NEXT = 0;
                  END;
              UNTIL RespCtr.NEXT = 0;
          END;
        ///END;                        //This is ending the "With TempPurchRcptLine Do Begin"
        Window.CLOSE;
        //EXIT;
        //////MODIFYALL("Transfer Order Created", TRUE);
        //////CurrForm.UPDATE();

        //////CurrForm.UPDATECONTROLS;

        //CLEAR(VendNo);
        //CLEAR(FromLocationCode);
        //CLEAR(VesselName);
        //CLEAR(SailOnDate);
        //CLEAR(ToLocationCode);
        SetSubFormFilter(VendNo, FromLocationCode, VesselName, SailOnDate, ToLocationCode);

        //MESSAGE(NIF00002);
    end;

    procedure SelectAll()
    begin
        MODIFYALL(Select, TRUE);
        CurrPage.UPDATE();
    end;

    procedure DeselectAll()
    begin
        MODIFYALL(Select, FALSE);
        CurrPage.UPDATE();
    end;
}

