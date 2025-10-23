page 50011 "xxCreate Transfer Orders"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Worksheet;
    UsageCategory = Administration;
    RefreshOnActivate = true;
    SourceTable = "Purch. Rcpt. Line";
    ApplicationArea = All;

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
            repeater(General1)
            {
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the receipt number.';
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies either the name of or a description of the item or general ledger account.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code for the location where the receipt line is registered.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Sail-on Date"; Rec."Sail-on Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sail-on Date field.';
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
                    Rec.MODIFYALL(Select, TRUE);
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
                    Rec.SETRANGE(Select, TRUE);
                    IF Rec.FIND('-') THEN BEGIN
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
                        Rec.FIND('-');
                        REPEAT
                            CLEAR(TransLine);
                            tLineNo := tLineNo + 10000;
                            TransLine.INIT();
                            TransLine.VALIDATE("Document No.", TransHeader."No.");
                            TransLine.VALIDATE("Line No.", tLineNo);
                            TransLine.VALIDATE("Item No.", Rec."No.");
                            TransLine.VALIDATE("Unit of Measure Code", Rec."Unit of Measure Code");
                            TransLine.VALIDATE(Quantity, Rec.Quantity);
                            TransLine.VALIDATE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                            TransLine.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                            //TransLine.Validate("", );
                            TransLine.INSERT(TRUE);
                            //Now, Insert the Item Tracking Lines for this transfer
                            ILE.SETCURRENTKEY("Document No.", "Posting Date");
                            ILE.SETRANGE("Document No.", Rec."Document No.");
                            ILE.SETRANGE("Posting Date", Rec."Posting Date");
                            ILE.SETRANGE("Item No.", Rec."No.");
                            ILE.SETFILTER("Lot No.", '<>%1', ' ');
                            ResEntry.FIND('+');
                            ResEntryNo := ResEntry."Entry No.";
                            IF ILE.FIND('-') THEN
                                REPEAT
                                    ResEntryNo := ResEntryNo + 1;
                                    CLEAR(ResEntry);
                                    ResEntry.INIT();
                                    ResEntry.VALIDATE("Entry No.", ResEntryNo);
                                    ResEntry.VALIDATE("Item No.", Rec."No.");
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
                        UNTIL Rec.NEXT() = 0;
                        //Now, loop thru the Resp Ctrs and create the transfers for each of them
                        IF RespCtr.FIND('-') THEN
                            REPEAT
                                Rec.SETRANGE("Responsibility Center", RespCtr.Code);
                                IF Rec.COUNT > 0 THEN BEGIN
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
                                    Rec.FIND('-');
                                    REPEAT
                                        IF RespCtr.Code <> ToLocationCode THEN BEGIN  //Can't create a hdr w/ same To & From

                                            CLEAR(TransLine);
                                            tLineNo := tLineNo + 10000;
                                            TransLine.INIT();
                                            TransLine.VALIDATE("Document No.", TransHeader."No.");
                                            TransLine.VALIDATE("Line No.", tLineNo);
                                            TransLine.VALIDATE("Item No.", Rec."No.");
                                            TransLine.VALIDATE("Unit of Measure Code", Rec."Unit of Measure Code");
                                            TransLine.VALIDATE(Quantity, Rec.Quantity);
                                            TransLine.VALIDATE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                            TransLine.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                            //TransLine.Validate("", );
                                            TransLine.INSERT(TRUE);
                                            //Now, Insert the Item Tracking Lines for this transfer
                                            ILE.SETCURRENTKEY("Document No.", "Posting Date");
                                            ILE.SETRANGE("Document No.", Rec."Document No.");
                                            ILE.SETRANGE("Posting Date", Rec."Posting Date");
                                            ILE.SETRANGE("Item No.", Rec."No.");
                                            ILE.SETFILTER("Lot No.", '<>%1', ' ');
                                            ResEntry.FIND('+');
                                            ResEntryNo := ResEntry."Entry No.";
                                            IF ILE.FIND('-') THEN
                                                REPEAT
                                                    ResEntryNo := ResEntryNo + 1;
                                                    CLEAR(ResEntry);
                                                    ResEntry.INIT();
                                                    ResEntry.VALIDATE("Entry No.", ResEntryNo);
                                                    ResEntry.VALIDATE("Item No.", Rec."No.");
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
                                        Rec."Transfer Order Created" := TRUE;
                                        Rec.MODIFY();
                                    UNTIL Rec.NEXT() = 0;
                                END;
                            UNTIL RespCtr.NEXT() = 0;
                    END;

                    SetFormFilter();
                end;
            }
        }
    }

    var
        FromLocationCode: Code[10];
        ToLocationCode: Code[10];
        VendNo: Code[20];
        VesselName: Code[50];
        SailOnDate: Date;

    procedure SetFormFilter()
    begin
        CLEAR(Rec);
        Rec.SETRANGE("Buy-from Vendor No.", VendNo);
        Rec.SETRANGE("Location Code", FromLocationCode);
        Rec.SETRANGE("Vessel Name", VesselName);
        Rec.SETRANGE("Sail-on Date", SailOnDate);
        Rec.SETRANGE("Transfer Order Created", FALSE);
        CurrPage.UPDATE(FALSE);  //NF1.00:CIS.NG  09-05-15
    end;
}

