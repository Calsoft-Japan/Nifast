page 50114 "Price Contract Subform"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.CM    10/24/15 Update for New Vision Removal Task
    // NF1.00:CIS.NG    11/02/15 Fix the Page Type
    // >>NIF
    // Functions Added:
    //   GetCrossRefInfo
    //   InsertUOMLines
    //   ShowCrossRef
    //   PrintLabel
    // Fields/Globals Added:
    //   CrossRefNo
    //   CrossRefDesc
    //   "Customer Cross Ref No."
    //   "Customer Cross Ref. Desc." (visible=No)
    // Code Added:
    //   Form - OnAfterGetCurrRecord
    // 
    // 12-06-05 RTT           new function GetCrossRefInfo; called at Form-OnAfterGetCurrRecord
    // 12-13-05 RTT           new field "Revision No." (Visible=No)
    // 12-14-05 RTT           new field "No. of customer Bins" (Visible=No, DecimalPlaces=0:2, BlankZero=Yes)
    // <<NIF

    PageType = ListPart;
    SourceTable = Table7002;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Item No.";"Item No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field("Item Description";"Item Description")
                {
                }
                field("Customer Cross Ref No.";"Customer Cross Ref No.")
                {
                }
                field("Customer Cross Ref. Desc.";"Customer Cross Ref. Desc.")
                {
                    Visible = false;
                }
                field("Revision No.";"Revision No.")
                {
                    Visible = false;
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Contract Customer No.";"Contract Customer No.")
                {
                }
                field("Contract Ship-to Code";"Contract Ship-to Code")
                {
                }
                field("Contract Location Code";"Contract Location Code")
                {
                }
                field("No. of Customer Bins";"No. of Customer Bins")
                {
                    BlankZero = true;
                    DecimalPlaces = 0:2;
                    Visible = false;
                }
                field("Currency Code";"Currency Code")
                {
                    Visible = false;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Minimum Quantity";"Minimum Quantity")
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Price Includes VAT";"Price Includes VAT")
                {
                    Visible = false;
                }
                field("Est. Usage";"Est. Usage")
                {
                }
                field("Actual Usage";"Actual Usage")
                {
                }
                field("Allow Line Disc.";"Allow Line Disc.")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Alt. Price";"Alt. Price")
                {
                }
                field("Alt. Price UOM";"Alt. Price UOM")
                {
                }
                field("VAT Bus. Posting Gr. (Price)";"VAT Bus. Posting Gr. (Price)")
                {
                    Visible = false;
                }
                field("Method of Fullfillment";"Method of Fullfillment")
                {
                }
                field("Min. Qty. on Hand";"Min. Qty. on Hand")
                {
                }
                field("Initial Stocking Qty.";"Initial Stocking Qty.")
                {
                }
                field("Contract Ship Location Code";"Contract Ship Location Code")
                {
                }
                field("FB Order Type";"FB Order Type")
                {
                }
                field("Replenishment Method";"Replenishment Method")
                {
                }
                field("Reorder Quantity";"Reorder Quantity")
                {
                }
                field("Min. Quantity";"Min. Quantity")
                {
                }
                field("Max. Quantity";"Max. Quantity")
                {
                }
                field("FB Tags";"FB Tags")
                {
                }
                field("Customer Bin";"Customer Bin")
                {
                }
                field(CrossRefNo;CrossRefNo)
                {
                    Caption = 'Cross Ref. No./Desc';
                    Editable = false;
                }
                field(CrossRefDesc;CrossRefDesc)
                {
                    Caption = 'Cross Ref. No.';
                    Editable = false;
                }
                field("Sales Code";"Sales Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Contract")
            {
                Caption = '&Contract';
                action("&Labels")
                {
                    Caption = '&Labels';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _PrintLabel;

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _ShowLineComments;

                    end;
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _ShowBlanketOrders;

                    end;
                }
                action("Cross References")
                {
                    Caption = 'Cross References';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _ShowCrossRef;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        Item: Record "27";
        ItemAvailByDate: Page "157";
        ItemAvailByVar: Page "5414";
        ItemAvailByLoc: Page "492";
        Text012: Label 'Change %1 from %2 to %3?';
        LDate: array [4] of Date;
        CommentLine: Record "97";
        LDec: array [20] of Decimal;
        PriceContract: Record "50110";
        ">>NIF": Integer;
        CrossRefNo: Code[30];
        CrossRefDesc: Text[50];

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        TESTFIELD("Item No.");
        Item.RESET;
        Item.GET("Item No.");
        Item.SETRANGE("No.","Item No.");
        Item.SETRANGE("Date Filter",0D,"Ending Date");

        CASE AvailabilityType OF
          AvailabilityType::Date:
            BEGIN
              Item.SETRANGE("Variant Filter","Variant Code");
              Item.SETRANGE("Location Filter","Contract Location Code");
              CLEAR(ItemAvailByDate);
              ItemAvailByDate.LOOKUPMODE(TRUE);
              ItemAvailByDate.SETRECORD(Item);
              ItemAvailByDate.SETTABLEVIEW(Item);
              IF ItemAvailByDate.RUNMODAL = ACTION::LookupOK THEN
                IF "Ending Date" <> ItemAvailByDate.GetLastDate THEN
                  IF CONFIRM(
                       Text012,TRUE,FIELDCAPTION("Ending Date"),"Ending Date",
                       ItemAvailByDate.GetLastDate)
                  THEN BEGIN
                    VALIDATE("Ending Date",ItemAvailByDate.GetLastDate);
                  END;
            END;
          AvailabilityType::Variant:
            BEGIN
              Item.SETRANGE("Location Filter","Contract Location Code");
              CLEAR(ItemAvailByVar);
              ItemAvailByVar.LOOKUPMODE(TRUE);
              ItemAvailByVar.SETRECORD(Item);
              ItemAvailByVar.SETTABLEVIEW(Item);
              IF ItemAvailByVar.RUNMODAL = ACTION::LookupOK THEN
                IF "Variant Code" <> ItemAvailByVar.GetLastVariant THEN
                  IF CONFIRM(
                       Text012,TRUE,FIELDCAPTION("Variant Code"),"Variant Code",
                       ItemAvailByVar.GetLastVariant)
                  THEN BEGIN
                    VALIDATE("Variant Code",ItemAvailByVar.GetLastVariant);
                  END;
            END;
          AvailabilityType::Location:
            BEGIN
              Item.SETRANGE("Variant Filter","Variant Code");
              CLEAR(ItemAvailByLoc);
              ItemAvailByLoc.LOOKUPMODE(TRUE);
              ItemAvailByLoc.SETRECORD(Item);
              ItemAvailByLoc.SETTABLEVIEW(Item);
              IF ItemAvailByLoc.RUNMODAL = ACTION::LookupOK THEN
                IF "Contract Location Code" <> ItemAvailByLoc.GetLastLocation THEN
                  IF CONFIRM(
                       Text012,TRUE,FIELDCAPTION("Contract Location Code"),"Contract Location Code",
                       ItemAvailByLoc.GetLastLocation)
                  THEN BEGIN
                    VALIDATE("Contract Location Code",ItemAvailByLoc.GetLastLocation);
                  END;
            END;
        END;
    end;

    procedure CalcAvailability(): Decimal
    var
        AvailableToPromise: Codeunit "5790";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        AvailabilityDate: Date;
        LookaheadDateformula: DateFormula;
    begin
        AvailabilityDate := "Ending Date";

        Item.RESET;
        Item.SETRANGE("Date Filter",0D,AvailabilityDate);
        Item.SETRANGE("Variant Filter","Variant Code");
        Item.SETRANGE("Location Filter","Contract Location Code");

        EXIT(
          AvailableToPromise.QtyAvailabletoPromise(
            Item,
            GrossRequirement,
            ScheduledReceipt,
            AvailabilityDate,
            PeriodType,
            LookaheadDateformula));
    end;

    procedure ItemCommentExists(): Boolean
    begin
        IF Item.GET("Item No.") THEN BEGIN
          Item.CALCFIELDS(Comment);
          EXIT(Item.Comment);
        END;
    end;

    procedure _ShowLineComments()
    begin
        ShowLineComments;
    end;

    procedure ShowLineComments()
    begin
        ShowLineComments;
    end;

    procedure _ShowBlanketOrders()
    begin
        ShowBlanketOrders;
    end;

    procedure ShowBlanketOrders()
    begin
        ShowBlanketOrders;
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure GetCrossRefInfo(var CrossRefNo: Code[30];var CrossRefDesc: Text[50])
    var
        ItemCrossRef: Record "5717";
    begin
        CLEAR(CrossRefNo);
        CLEAR(CrossRefDesc);

        ItemCrossRef.SETCURRENTKEY(
          "Item No.","Variant Code","Unit of Measure","Cross-Reference Type","Cross-Reference Type No.","Cross-Reference No.");
        ItemCrossRef.SETRANGE("Item No.","Item No.");
        ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::Customer);
        ItemCrossRef.SETRANGE("Cross-Reference Type No.","Sales Code");
        IF ItemCrossRef.FIND('-') THEN BEGIN
          CrossRefNo := ItemCrossRef."Cross-Reference No.";
          CrossRefDesc := ItemCrossRef.Description;
        END;
    end;

    procedure InsertUOMLines()
    var
        SalesPrice: Record "7002";
        SalesPrice2: Record "7002";
        ItemUOM: Record "5404";
        ItemUOM2: Record "5404";
        UnitOfMeas: Record "204";
        UnitOfMeas2: Record "204";
        LineCount: Integer;
        NoLinesToInsert: Integer;
        d: Dialog;
        UseUOM: Code[10];
        i: Integer;
    begin

        d.OPEN('Number of lines to insert #1.');
        d.INPUT(1,NoLinesToInsert);

        IF (NoLinesToInsert<=0) THEN
          ERROR('Number must be greater than zero.')
        ELSE IF (NoLinesToInsert>20) THEN
          ERROR('Maximum is 20.');

        //find number of times on contract already
        SalesPrice.SETCURRENTKEY("Item No.","Sales Type","Sales Code","Starting Date","Currency Code",
            "Variant Code","Unit of Measure Code","Minimum Quantity","Contract No.");
        SalesPrice.SETRANGE("Item No.","Item No.");
        SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::Customer);
        SalesPrice.SETRANGE("Sales Code","Sales Code");
        SalesPrice.SETRANGE("Starting Date","Starting Date");
        SalesPrice.SETRANGE("Currency Code","Currency Code");
        SalesPrice.SETRANGE("Variant Code","Variant Code");
        SalesPrice.SETRANGE("Minimum Quantity","Minimum Quantity");
        SalesPrice.SETRANGE("Contract No.","Contract No.");
        SalesPrice.FIND('+');

        UseUOM := INCSTR(SalesPrice."Unit of Measure Code");
        IF UseUOM = '' THEN
          UseUOM := SalesPrice."Unit of Measure Code" + '01';

        UnitOfMeas.GET("Unit of Measure Code");
        ItemUOM.GET("Item No.","Unit of Measure Code");

        LineCount := SalesPrice.COUNT;

        FOR i := 1 TO NoLinesToInsert DO BEGIN
          SalesPrice2.INIT;
          SalesPrice2.TRANSFERFIELDS(SalesPrice);
          SalesPrice2."Unit of Measure Code" := UseUOM;
          SalesPrice2."Customer Bin" := '';
          SalesPrice2.INSERT;

          IF NOT ItemUOM2.GET(SalesPrice2."Item No.",SalesPrice2."Unit of Measure Code") THEN BEGIN
             ItemUOM2.TRANSFERFIELDS(ItemUOM);
             ItemUOM2.Code := SalesPrice2."Unit of Measure Code";
             ItemUOM2.INSERT;
          END;

          IF NOT UnitOfMeas2.GET(SalesPrice2."Unit of Measure Code") THEN BEGIN
            UnitOfMeas2.TRANSFERFIELDS(UnitOfMeas);
            UnitOfMeas2.Code := SalesPrice2."Unit of Measure Code";
            UnitOfMeas2.INSERT;
          END;

          UseUOM := INCSTR(UseUOM);
        END;
    end;

    procedure _ShowCrossRef()
    var
        ItemCrossRef: Record "5717";
    begin
        ItemCrossRef.SETRANGE("Item No.","Item No.");
        PAGE.RUN(PAGE::"Item Cross Reference Entries",ItemCrossRef);
    end;

    procedure ShowCrossRef()
    var
        ItemCrossRef: Record "5717";
    begin
        ItemCrossRef.SETRANGE("Item No.","Item No.");
        PAGE.RUN(PAGE::"Item Cross Reference Entries",ItemCrossRef);
    end;

    procedure _PrintLabel()
    var
        ContractLine: Record "7002";
        ContractLabel: Report "50035";
    begin
        CLEAR(ContractLine);
        ContractLine.SETRANGE("Item No.","Item No.");
        ContractLine.SETRANGE("Sales Type","Sales Type");
        ContractLine.SETRANGE("Sales Code","Sales Code");
        ContractLine.SETRANGE("Unit of Measure Code","Unit of Measure Code");
        ContractLine.SETRANGE("Contract No.","Contract No.");
        ContractLine.SETRANGE("Customer Bin","Customer Bin");
        ContractLabel.InitializeRequest('',1,TRUE);
        ContractLabel.SETTABLEVIEW(ContractLine);
        ContractLabel.RUN;
    end;

    procedure PrintLabel()
    var
        ContractLine: Record "7002";
        ContractLabel: Report "50035";
    begin
        CLEAR(ContractLine);
        ContractLine.SETRANGE("Item No.","Item No.");
        ContractLine.SETRANGE("Sales Type","Sales Type");
        ContractLine.SETRANGE("Sales Code","Sales Code");
        ContractLine.SETRANGE("Unit of Measure Code","Unit of Measure Code");
        ContractLine.SETRANGE("Contract No.","Contract No.");
        ContractLine.SETRANGE("Customer Bin","Customer Bin");
        ContractLabel.InitializeRequest('',1,TRUE);
        ContractLabel.SETTABLEVIEW(ContractLine);
        ContractLabel.RUN;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CALCFIELDS("Blanket Orders");
        //>>NIF 12-06-05
        GetCrossRefInfo(CrossRefNo,CrossRefDesc);
        //<< NIF 12-06-05
    end;
}

