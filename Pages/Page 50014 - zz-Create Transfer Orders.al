page 50014 "zz-Create Transfer Orders"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Worksheet;
    UsageCategory = Administration;
    ApplicationArea = All;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(VendNo; VendNo)
                {
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;
                    ToolTip = 'Specifies the value of the Vendor No. field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(FromLocationCode; FromLocationCode)
                {
                    Caption = 'From Location Code';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the From Location Code field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(ToLocationCode; ToLocationCode)
                {
                    Caption = 'To Location Code';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the To Location Code field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(VesselName; VesselName)
                {
                    Caption = 'Vessel Name';
                    TableRelation = "Shipping Vessels";
                    ToolTip = 'Specifies the value of the Vessel Name field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(SailOnDate; SailOnDate)
                {
                    Caption = 'Sail On Date';
                    ToolTip = 'Specifies the value of the Sail On Date field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
            }
            group(General1)
            {
                field(Select; RcptLines.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                    Caption = 'Select';
                }
                field("Document No."; RcptLines."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Caption = 'Document No.';
                }
                field(Type; RcptLines.Type)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("No."; RcptLines."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field(Description; RcptLines.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Location Code"; RcptLines."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Shortcut Dimension 1 Code"; RcptLines."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Responsibility Center"; RcptLines."Responsibility Center")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Caption = 'Responsibility Center';
                }
                field("Unit of Measure Code"; RcptLines."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field(Quantity; RcptLines.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Vessel Name"; RcptLines."Vessel Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                    Caption = 'Vessel Name';
                }
                field("Sail-on Date"; RcptLines."Sail-on Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sail-on Date field.';
                    Caption = 'Sail-on Date';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Select All")
            {
                Caption = 'Select All';
                Promoted = true;
                Image = Select;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Select All action.';

                trigger OnAction()
                begin
                    RcptLines.MODIFYALL(Select, TRUE);
                    CurrPage.UPDATE();
                end;
            }
            action("Create Transfers")
            {
                Caption = 'Create Transfers';
                Promoted = true;
                Image = Create;
                PromotedCategory = Process;
                ToolTip = 'Executes the Create Transfers action.';

                trigger OnAction()
                var
                    ILE: Record "Item Ledger Entry";
                    ResEntry: Record "Reservation Entry";
                    RespCtr: Record "Responsibility Center";
                    TransHeader: Record "Transfer Header";
                    TransLine: Record "Transfer Line";
                    ResEntryNo: Integer;
                    tLineNo: Integer;
                begin
                    RcptLines.SETRANGE(Select, TRUE);
                    IF RcptLines.FIND('-') THEN BEGIN
                        ResEntry.LOCKTABLE();
                        TransHeader.LOCKTABLE();
                        TransLine.LOCKTABLE();
                        //First - Create the Master Header
                        TransHeader.INIT();
                        TransHeader."No. Series" := 'I-TOTN';
                        TransHeader.VALIDATE("No.");
                        TransHeader.INSERT(TRUE);
                        TransHeader.VALIDATE("Transfer-from Code", FromLocationCode);
                        TransHeader.VALIDATE("Transfer-to Code", ToLocationCode);
                        TransHeader.VALIDATE("In-Transit Code", 'INTERDIV');
                        TransHeader.MODIFY(TRUE);
                        CLEAR(tLineNo);
                        //Create the Lines for the Master Header
                        RcptLines.FIND('-');
                        REPEAT
                            CLEAR(TransLine);
                            tLineNo := tLineNo + 10000;
                            TransLine.INIT();
                            TransLine.VALIDATE("Document No.", TransHeader."No.");
                            TransLine.VALIDATE("Line No.", tLineNo);
                            TransLine.VALIDATE("Item No.", RcptLines."No.");
                            TransLine.VALIDATE("Unit of Measure Code", RcptLines."Unit of Measure Code");
                            TransLine.VALIDATE(Quantity, RcptLines.Quantity);
                            TransLine.VALIDATE("Shortcut Dimension 1 Code", RcptLines."Shortcut Dimension 1 Code");
                            TransLine.VALIDATE("Shortcut Dimension 2 Code", RcptLines."Shortcut Dimension 2 Code");
                            //TransLine.Validate("", );
                            TransLine.INSERT(TRUE);
                            //Now, Insert the Item Tracking Lines for this transfer
                            ILE.SETCURRENTKEY("Document No.", "Posting Date");
                            ILE.SETRANGE("Document No.", RcptLines."Document No.");
                            ILE.SETRANGE("Posting Date", RcptLines."Posting Date");
                            ILE.SETRANGE("Item No.", RcptLines."No.");
                            ILE.SETFILTER("Lot No.", '<>%1', ' ');
                            ResEntry.FIND('+');
                            ResEntryNo := ResEntry."Entry No.";
                            IF ILE.FIND('-') THEN
                                REPEAT
                                    ResEntryNo := ResEntryNo + 1;
                                    CLEAR(ResEntry);
                                    ResEntry.INIT();
                                    ResEntry.VALIDATE("Entry No.", ResEntryNo);
                                    ResEntry.VALIDATE("Item No.", RcptLines."No.");
                                    ResEntry.VALIDATE("Location Code", FromLocationCode);
                                    ResEntry.VALIDATE("Quantity (Base)", -ILE.Quantity);
                                    ResEntry.VALIDATE("Reservation Status", ResEntry."Reservation Status"::Surplus);
                                    ResEntry.VALIDATE(Description, 'MARK');
                                    ResEntry.VALIDATE("Creation Date", WORKDATE());
                                    ResEntry.VALIDATE("Source Type", 5741);
                                    ResEntry.VALIDATE("Source ID", TransLine."Document No.");
                                    ResEntry.VALIDATE("Source Ref. No.", TransLine."Line No.");
                                    ResEntry.VALIDATE("Shipment Date", TransHeader."Shipment Date");
                                    ResEntry.VALIDATE("Created By", USERID);
                                    ResEntry.VALIDATE(Positive, FALSE);
                                    ResEntry.VALIDATE("Qty. per Unit of Measure", TransLine."Qty. per Unit of Measure");
                                    ResEntry.VALIDATE(Quantity, -TransLine.Quantity);
                                    ResEntry.VALIDATE("Lot No.", ILE."Lot No.");
                                    //ResEntry.Validate("", "");
                                    ResEntry.INSERT(TRUE);
                                UNTIL ILE.NEXT() = 0;
                        UNTIL RcptLines.NEXT() = 0;
                        //Now, loop thru the Resp Ctrs and create the transfers for each of them
                        IF RespCtr.FIND('-') THEN
                            REPEAT
                                RcptLines.SETRANGE("Responsibility Center", RespCtr.Code);
                                IF RcptLines.COUNT > 0 THEN BEGIN
                                    IF RespCtr.Code <> ToLocationCode THEN BEGIN //Can't create a hdr w/ same To & From

                                        //First - Create the Resp Ctr Header
                                        CLEAR(TransHeader);
                                        TransHeader.INIT();
                                        TransHeader."No. Series" := 'I-TOTN';
                                        TransHeader.VALIDATE("No.");
                                        TransHeader.INSERT(TRUE);
                                        TransHeader.VALIDATE("Transfer-from Code", ToLocationCode);
                                        TransHeader.VALIDATE("Transfer-to Code", RespCtr."Location Code");
                                        TransHeader.VALIDATE("In-Transit Code", 'INTERDIV');
                                        TransHeader.MODIFY(TRUE);
                                    END;
                                    CLEAR(tLineNo);
                                    //Create the Lines for the Resp Ctr Header
                                    RcptLines.FIND('-');
                                    REPEAT
                                        IF RespCtr.Code <> ToLocationCode THEN BEGIN //Can't create a hdr w/ same To & From
                                            CLEAR(TransLine);
                                            tLineNo := tLineNo + 10000;
                                            TransLine.INIT();
                                            TransLine.VALIDATE("Document No.", TransHeader."No.");
                                            TransLine.VALIDATE("Line No.", tLineNo);
                                            TransLine.VALIDATE("Item No.", RcptLines."No.");
                                            TransLine.VALIDATE("Unit of Measure Code", RcptLines."Unit of Measure Code");
                                            TransLine.VALIDATE(Quantity, RcptLines.Quantity);
                                            TransLine.VALIDATE("Shortcut Dimension 1 Code", RcptLines."Shortcut Dimension 1 Code");
                                            TransLine.VALIDATE("Shortcut Dimension 2 Code", RcptLines."Shortcut Dimension 2 Code");
                                            //TransLine.Validate("", );
                                            TransLine.INSERT(TRUE);
                                            //Now, Insert the Item Tracking Lines for this transfer
                                            ILE.SETCURRENTKEY("Document No.", "Posting Date");
                                            ILE.SETRANGE("Document No.", RcptLines."Document No.");
                                            ILE.SETRANGE("Posting Date", RcptLines."Posting Date");
                                            ILE.SETRANGE("Item No.", RcptLines."No.");
                                            ILE.SETFILTER("Lot No.", '<>%1', ' ');
                                            ResEntry.FIND('+');
                                            ResEntryNo := ResEntry."Entry No.";
                                            IF ILE.FIND('-') THEN
                                                REPEAT
                                                    ResEntryNo := ResEntryNo + 1;
                                                    CLEAR(ResEntry);
                                                    ResEntry.INIT();
                                                    ResEntry.VALIDATE("Entry No.", ResEntryNo);
                                                    ResEntry.VALIDATE("Item No.", RcptLines."No.");
                                                    ResEntry.VALIDATE("Location Code", FromLocationCode);
                                                    ResEntry.VALIDATE("Quantity (Base)", -ILE.Quantity);
                                                    ResEntry.VALIDATE("Reservation Status", ResEntry."Reservation Status"::Surplus);
                                                    ResEntry.VALIDATE(Description, 'MARK');
                                                    ResEntry.VALIDATE("Creation Date", WORKDATE());
                                                    ResEntry.VALIDATE("Source Type", 5741);
                                                    ResEntry.VALIDATE("Source ID", TransLine."Document No.");
                                                    ResEntry.VALIDATE("Source Ref. No.", TransLine."Line No.");
                                                    ResEntry.VALIDATE("Shipment Date", TransHeader."Shipment Date");
                                                    ResEntry.VALIDATE("Created By", USERID);
                                                    ResEntry.VALIDATE(Positive, FALSE);
                                                    ResEntry.VALIDATE("Qty. per Unit of Measure", TransLine."Qty. per Unit of Measure");
                                                    ResEntry.VALIDATE(Quantity, -TransLine.Quantity);
                                                    ResEntry.VALIDATE("Lot No.", ILE."Lot No.");
                                                    //ResEntry.Validate("", "");
                                                    ResEntry.INSERT(TRUE);
                                                UNTIL ILE.NEXT() = 0;
                                        END;
                                        //Flag the line as having been created
                                        RcptLines."Transfer Order Created" := TRUE;
                                        RcptLines.MODIFY();
                                    UNTIL RcptLines.NEXT() = 0;
                                END;
                            UNTIL RespCtr.NEXT() = 0;
                    END;

                    SetFormFilter();
                end;
            }
        }
    }

    var
        RcptLines: Record "Purch. Rcpt. Line" temporary;
        RealRcptLines: Record "Purch. Rcpt. Line";
        FromLocationCode: Code[10];
        ToLocationCode: Code[10];
        VendNo: Code[20];
        VesselName: Code[50];
        SailOnDate: Date;

    procedure SetFormFilter()
    begin
        RcptLines.DELETEALL();
        CLEAR(RealRcptLines);
        RealRcptLines.SETRANGE("Buy-from Vendor No.", VendNo);
        RealRcptLines.SETRANGE("Location Code", FromLocationCode);
        RealRcptLines.SETRANGE("Vessel Name", VesselName);
        RealRcptLines.SETRANGE("Sail-on Date", SailOnDate);
        RealRcptLines.SETRANGE("Transfer Order Created", FALSE);

        IF RealRcptLines.FIND('-') THEN
            REPEAT
                RcptLines := RealRcptLines;
                RcptLines.INSERT();
            UNTIL RealRcptLines.NEXT() = 0;
        CurrPage.UPDATE(FALSE);  //NF1.00:CIS.NG  09-05-15
    end;
}

