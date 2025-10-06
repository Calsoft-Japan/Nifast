page 50011 "xxCreate Transfer Orders"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SourceTable = Table121;

    layout
    {
        area(content)
        {
            group()
            {
                field(VendNo;VendNo)
                {
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(FromLocationCode;FromLocationCode)
                {
                    Caption = 'From Location Code';
                    TableRelation = Location;

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(ToLocationCode;ToLocationCode)
                {
                    Caption = 'To Location Code';
                    TableRelation = Location;

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(VesselName;VesselName)
                {
                    Caption = 'Vessel Name';
                    TableRelation = "Shipping Vessels";

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(SailOnDate;SailOnDate)
                {
                    Caption = 'Sail On Date';

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
            }
            repeater()
            {
                field(Select;Select)
                {
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
        area(processing)
        {
            action("Select All")
            {
                Caption = 'Select All';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    MODIFYALL(Select, TRUE);
                    CurrPage.UPDATE();
                end;
            }
            action("Create Transfers")
            {
                Caption = 'Create Transfers';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TransHeader: Record "5740";
                    TransLine: Record "5741";
                    tLineNo: Integer;
                    RespCtr: Record "5714";
                    ILE: Record "32";
                    ResEntry: Record "337";
                    ResEntryNo: Integer;
                begin
                    SETRANGE(Select, TRUE);
                    IF FIND('-') THEN
                      BEGIN
                        ResEntry.LOCKTABLE;
                        TransHeader.LOCKTABLE;
                        TransLine.LOCKTABLE;
                        //First - Create the Master Header
                        TransHeader.INIT;
                        TransHeader."No. Series" := 'I-TOTN';
                        TransHeader.VALIDATE("No.");
                        TransHeader.INSERT(TRUE);
                        TransHeader.VALIDATE("Transfer-from Code",  FromLocationCode);
                        TransHeader.VALIDATE("Transfer-to Code", ToLocationCode);
                        TransHeader.VALIDATE("In-Transit Code", 'INTERDIV');
                        TransHeader.MODIFY(TRUE);
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
                          TransLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
                          TransLine.VALIDATE(Quantity, Quantity);
                          TransLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                          TransLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                          //TransLine.Validate("", );
                          TransLine.INSERT(TRUE);
                          //Now, Insert the Item Tracking Lines for this transfer
                          ILE.SETCURRENTKEY("Document No.", "Posting Date");
                          ILE.SETRANGE("Document No.", "Document No.");
                          ILE.SETRANGE("Posting Date", "Posting Date");
                          ILE.SETRANGE("Item No.", "No.");
                          ILE.SETFILTER("Lot No.", '<>%1', ' ');
                          ResEntry.FIND('+');
                          ResEntryNo := ResEntry."Entry No.";
                          IF ILE.FIND('-') THEN
                            REPEAT
                              ResEntryNo := ResEntryNo + 1;
                              CLEAR(ResEntry);
                              ResEntry.INIT;
                              ResEntry.VALIDATE("Entry No.", ResEntryNo);
                              ResEntry.VALIDATE("Item No.", "No.");
                              ResEntry.VALIDATE("Location Code", FromLocationCode);
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
                              ResEntry.VALIDATE("Lot No.", ILE."Lot No.");
                              //ResEntry.Validate("", "");
                              ResEntry.INSERT(TRUE);
                            UNTIL ILE.NEXT = 0;
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
                                  TransHeader."No. Series" := 'I-TOTN';
                                  TransHeader.VALIDATE("No.");
                                  TransHeader.INSERT(TRUE);
                                  TransHeader.VALIDATE("Transfer-from Code",  ToLocationCode);
                                  TransHeader.VALIDATE("Transfer-to Code", RespCtr."Location Code");
                                  TransHeader.VALIDATE("In-Transit Code", 'INTERDIV');
                                  TransHeader.MODIFY(TRUE);
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
                                  //TransLine.Validate("", );
                                  TransLine.INSERT(TRUE);
                                  //Now, Insert the Item Tracking Lines for this transfer
                                  ILE.SETCURRENTKEY("Document No.", "Posting Date");
                                  ILE.SETRANGE("Document No.", "Document No.");
                                  ILE.SETRANGE("Posting Date", "Posting Date");
                                  ILE.SETRANGE("Item No.", "No.");
                                  ILE.SETFILTER("Lot No.", '<>%1', ' ');
                                  ResEntry.FIND('+');
                                  ResEntryNo := ResEntry."Entry No.";
                                  IF ILE.FIND('-') THEN
                                    REPEAT
                                      ResEntryNo := ResEntryNo + 1;
                                      CLEAR(ResEntry);
                                      ResEntry.INIT;
                                      ResEntry.VALIDATE("Entry No.", ResEntryNo);
                                      ResEntry.VALIDATE("Item No.", "No.");
                                      ResEntry.VALIDATE("Location Code", FromLocationCode);
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
                                      ResEntry.VALIDATE("Lot No.", ILE."Lot No.");
                                      //ResEntry.Validate("", "");
                                      ResEntry.INSERT(TRUE);
                                    UNTIL ILE.NEXT = 0;
                                END;
                                //Flag the line as having been created
                                "Transfer Order Created" := TRUE;
                                MODIFY;
                              UNTIL NEXT = 0;
                              END;
                          UNTIL RespCtr.NEXT = 0;
                      END;

                    SetFormFilter;
                end;
            }
        }
    }

    var
        Vend: Record "23";
        VendNo: Code[20];
        FromLocation: Record "14";
        FromLocationCode: Code[10];
        FromBin: Record "7354";
        ToLocation: Record "14";
        ToLocationCode: Code[10];
        ReceiptLines: Record "121";
        VesselName: Code[50];
        SailOnDate: Date;

    procedure SetFormFilter()
    begin
        CLEAR(Rec);
        SETRANGE("Buy-from Vendor No.", VendNo);
        SETRANGE("Location Code", FromLocationCode);
        SETRANGE("Vessel Name", VesselName);
        SETRANGE("Sail-on Date", SailOnDate);
        SETRANGE("Transfer Order Created", FALSE);
        CurrPage.UPDATE(FALSE);  //NF1.00:CIS.NG  09-05-15
    end;
}

