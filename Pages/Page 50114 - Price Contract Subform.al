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
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Sales Price";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    Caption = 'Item No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Caption = 'Variant Code';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                    Caption = 'Item Description';
                }
                field("Customer Cross Ref No."; Rec."Customer Cross Ref No.")
                {
                    ToolTip = 'Specifies the value of the Customer Cross Ref No. field.';
                    Caption = 'Customer Cross Ref No.';
                }
                field("Customer Cross Ref. Desc."; Rec."Customer Cross Ref. Desc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Customer Cross Ref. Desc. field.';
                    Caption = 'Customer Cross Ref. Desc.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Revision No. field.';
                    Caption = 'Revision No.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    Caption = 'External Document No.';
                }
                field("Contract Customer No."; Rec."Contract Customer No.")
                {
                    ToolTip = 'Specifies the value of the Contract Customer No. field.';
                    Caption = 'Contract Customer No.';
                }
                field("Contract Ship-to Code"; Rec."Contract Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Contract Ship-to Code field.';
                    Caption = 'Contract Ship-to Code';
                }
                field("Contract Location Code"; Rec."Contract Location Code")
                {
                    ToolTip = 'Specifies the value of the Contract Location Code field.';
                    Caption = 'Contract Location Code';
                }
                field("No. of Customer Bins"; Rec."No. of Customer Bins")
                {
                    BlankZero = true;
                    //DecimalPlaces = 0 : 2;
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. of Customer Bins field.';
                    Caption = 'No. of Customer Bins';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    Caption = 'Currency Code';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ToolTip = 'Specifies the value of the Minimum Quantity field.';
                    Caption = 'Minimum Quantity';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Caption = 'Unit Price';
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Price Includes VAT field.';
                    Caption = 'Price Includes VAT';
                }
                field("Est. Usage"; Rec."Est. Usage")
                {
                    ToolTip = 'Specifies the value of the Est. Usage field.';
                    Caption = 'Est. Usage';
                }
                field("Actual Usage"; Rec."Actual Usage")
                {
                    ToolTip = 'Specifies the value of the Actual Usage field.';
                    Caption = 'Actual Usage';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.';
                    Caption = 'Allow Line Disc.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                    Caption = 'Allow Invoice Disc.';
                }
                field("Alt. Price"; Rec."Alt. Price")
                {
                    ToolTip = 'Specifies the value of the Alt. Price field.';
                    Caption = 'Alt. Price';
                }
                field("Alt. Price UOM"; Rec."Alt. Price UOM")
                {
                    ToolTip = 'Specifies the value of the Alt. Price UOM field.';
                    Caption = 'Alt. Price UOM';
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Gr. (Price) field.';
                    Caption = 'VAT Bus. Posting Gr. (Price)';
                }
                field("Method of Fullfillment"; Rec."Method of Fullfillment")
                {
                    ToolTip = 'Specifies the value of the Method of Fullfillment field.';
                    Caption = 'Method of Fullfillment';
                }
                field("Min. Qty. on Hand"; Rec."Min. Qty. on Hand")
                {
                    ToolTip = 'Specifies the value of the Min. Qty. on Hand field.';
                    Caption = 'Min. Qty. on Hand';
                }
                field("Initial Stocking Qty."; Rec."Initial Stocking Qty.")
                {
                    ToolTip = 'Specifies the value of the Initial Stocking Qty. field.';
                    Caption = 'Initial Stocking Qty.';
                }
                field("Contract Ship Location Code"; Rec."Contract Ship Location Code")
                {
                    ToolTip = 'Specifies the value of the Contract Ship Location Code field.';
                    Caption = 'Contract Ship Location Code';
                }
                field("FB Order Type"; Rec."FB Order Type")
                {
                    ToolTip = 'Specifies the value of the FB Order Type field.';
                    Caption = 'FB Order Type';
                }
                field("Replenishment Method"; Rec."Replenishment Method")
                {
                    ToolTip = 'Specifies the value of the Replenishment Method field.';
                    Caption = 'Replenishment Method';
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ToolTip = 'Specifies the value of the Reorder Quantity field.';
                    Caption = 'Reorder Quantity';
                }
                field("Min. Quantity"; Rec."Min. Quantity")
                {
                    ToolTip = 'Specifies the value of the Min. Quantity field.';
                    Caption = 'Min. Quantity';
                }
                field("Max. Quantity"; Rec."Max. Quantity")
                {
                    ToolTip = 'Specifies the value of the Max. Quantity field.';
                    Caption = 'Max. Quantity';
                }
                field("FB Tags"; Rec."FB Tags")
                {
                    ToolTip = 'Specifies the value of the FB Tags field.';
                    Caption = 'FB Tags';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                    Caption = 'Customer Bin';
                }
                field(CrossRefNo; CrossRefNo)
                {
                    Caption = 'Cross Ref. No./Desc';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cross Ref. No./Desc field.';
                }
                field(CrossRefDesc; CrossRefDesc)
                {
                    Caption = 'Cross Ref. No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cross Ref. No. field.';
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    ToolTip = 'Specifies the value of the Sales Code field.';
                    Caption = 'Sales Code';
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
                    Image = Picture;
                    ToolTip = 'Executes the &Labels action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _PrintLabel();

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
                    ToolTip = 'Executes the Comments action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _ShowLineComments();

                    end;
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    ToolTip = 'Executes the Blanket Orders action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _ShowBlanketOrders();

                    end;
                }
                action("Cross References")
                {
                    Caption = 'Cross References';
                    Image = ReferenceData;
                    ToolTip = 'Executes the Cross References action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50112. Unsupported part was commented. Please check it.
                        /*CurrPage.PriceContractLines.PAGE.*/
                        _ShowCrossRef();

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        Item: Record Item;
        ItemAvailByLoc: Page "Item Availability by Location";
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByVar: Page "Item Availability by Variant";
        CrossRefNo: Code[30];
        Text012: Label 'Change %1 from %2 to %3?', Comment = '%1%2%3';
        CrossRefDesc: Text[50];

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        Rec.TESTFIELD("Item No.");
        Item.RESET();
        Item.GET(Rec."Item No.");
        Item.SETRANGE("No.", Rec."Item No.");
        Item.SETRANGE("Date Filter", 0D, Rec."Ending Date");

        CASE AvailabilityType OF
            AvailabilityType::Date:
                BEGIN
                    Item.SETRANGE("Variant Filter", Rec."Variant Code");
                    Item.SETRANGE("Location Filter", Rec."Contract Location Code");
                    CLEAR(ItemAvailByDate);
                    ItemAvailByDate.LOOKUPMODE(TRUE);
                    ItemAvailByDate.SETRECORD(Item);
                    ItemAvailByDate.SETTABLEVIEW(Item);
                    IF ItemAvailByDate.RUNMODAL() = ACTION::LookupOK THEN
                        IF Rec."Ending Date" <> ItemAvailByDate.GetLastDate() THEN
                            IF CONFIRM(
                                 Text012, TRUE, Rec.FIELDCAPTION("Ending Date"), Rec."Ending Date",
                                 ItemAvailByDate.GetLastDate())
                            THEN
                                Rec.VALIDATE("Ending Date", ItemAvailByDate.GetLastDate());
                END;
            AvailabilityType::Variant:
                BEGIN
                    Item.SETRANGE("Location Filter", Rec."Contract Location Code");
                    CLEAR(ItemAvailByVar);
                    ItemAvailByVar.LOOKUPMODE(TRUE);
                    ItemAvailByVar.SETRECORD(Item);
                    ItemAvailByVar.SETTABLEVIEW(Item);
                    IF ItemAvailByVar.RUNMODAL() = ACTION::LookupOK THEN
                        IF Rec."Variant Code" <> ItemAvailByVar.GetLastVariant() THEN
                            IF CONFIRM(
                                 Text012, TRUE, Rec.FIELDCAPTION("Variant Code"), Rec."Variant Code",
                                 ItemAvailByVar.GetLastVariant())
                            THEN
                                Rec.VALIDATE("Variant Code", ItemAvailByVar.GetLastVariant());
                END;
            AvailabilityType::Location:
                BEGIN
                    Item.SETRANGE("Variant Filter", Rec."Variant Code");
                    CLEAR(ItemAvailByLoc);
                    ItemAvailByLoc.LOOKUPMODE(TRUE);
                    ItemAvailByLoc.SETRECORD(Item);
                    ItemAvailByLoc.SETTABLEVIEW(Item);
                    IF ItemAvailByLoc.RUNMODAL() = ACTION::LookupOK THEN
                        IF Rec."Contract Location Code" <> ItemAvailByLoc.GetLastLocation() THEN
                            IF CONFIRM(
                                 Text012, TRUE, Rec.FIELDCAPTION("Contract Location Code"), Rec."Contract Location Code",
                                 ItemAvailByLoc.GetLastLocation())
                            THEN
                                Rec.VALIDATE("Contract Location Code", ItemAvailByLoc.GetLastLocation());
                END;
        END;
    end;

    procedure CalcAvailability(): Decimal
    var
        AvailableToPromise: Codeunit "Available to Promise";
        LookaheadDateformula: DateFormula;
        AvailabilityDate: Date;
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: Option Day,Week,Month,Quarter,Year;
    begin
        AvailabilityDate := Rec."Ending Date";

        Item.RESET();
        Item.SETRANGE("Date Filter", 0D, AvailabilityDate);
        Item.SETRANGE("Variant Filter", Rec."Variant Code");
        Item.SETRANGE("Location Filter", Rec."Contract Location Code");

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
        IF Item.GET(Rec."Item No.") THEN BEGIN
            Item.CALCFIELDS(Comment);
            EXIT(Item.Comment);
        END;
    end;

    procedure _ShowLineComments()
    begin
        ShowLineComments();
    end;

    procedure ShowLineComments()
    begin
        ShowLineComments();
    end;

    procedure _ShowBlanketOrders()
    begin
        ShowBlanketOrders();
    end;

    procedure ShowBlanketOrders()
    begin
        ShowBlanketOrders();
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure GetCrossRefInfo(var CrossRefNoLVar: Code[30]; var CrossRefDescLVar: Text[50])
    var
        ItemCrossRef: Record "Item Reference";
    begin
        CLEAR(CrossRefNoLVar);
        CLEAR(CrossRefDescLVar);

        ItemCrossRef.SETCURRENTKEY(
          "Item No.", "Variant Code", "Unit of Measure", "Reference Type", "Reference Type No.", "Reference No.");
        ItemCrossRef.SETRANGE("Item No.", Rec."Item No.");
        ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);
        ItemCrossRef.SETRANGE("Reference Type No.", Rec."Sales Code");
        IF ItemCrossRef.FindFirst() THEN BEGIN
            CrossRefNoLVar := ItemCrossRef."Reference No.";
            CrossRefDescLVar := ItemCrossRef.Description;
        END;
    end;

    procedure InsertUOMLines()
    var
        ItemUOM: Record "Item Unit of Measure";
        ItemUOM2: Record "Item Unit of Measure";
        SalesPrice: Record "Sales Price";
        SalesPrice2: Record "Sales Price";
        UnitOfMeas: Record "Unit of Measure";
        UnitOfMeas2: Record "Unit of Measure";
        UseUOM: Code[10];
        d: Dialog;
        i: Integer;
        LineCount: Integer;
        NoLinesToInsert: Integer;
    begin

        d.OPEN('Number of lines to insert #1.');
        d.INPUT(1, NoLinesToInsert);

        IF (NoLinesToInsert <= 0) THEN
            ERROR('Number must be greater than zero.')
        ELSE
            IF (NoLinesToInsert > 20) THEN
                ERROR('Maximum is 20.');

        //find number of times on contract already
        SalesPrice.SETCURRENTKEY("Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code",
            "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Contract No.");
        SalesPrice.SETRANGE("Item No.", Rec."Item No.");
        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::Customer);
        SalesPrice.SETRANGE("Sales Code", Rec."Sales Code");
        SalesPrice.SETRANGE("Starting Date", Rec."Starting Date");
        SalesPrice.SETRANGE("Currency Code", Rec."Currency Code");
        SalesPrice.SETRANGE("Variant Code", Rec."Variant Code");
        SalesPrice.SETRANGE("Minimum Quantity", Rec."Minimum Quantity");
        SalesPrice.SETRANGE("Contract No.", Rec."Contract No.");
        SalesPrice.FIND('+');

        UseUOM := INCSTR(SalesPrice."Unit of Measure Code");
        IF UseUOM = '' THEN
            UseUOM := SalesPrice."Unit of Measure Code" + '01';

        UnitOfMeas.GET(Rec."Unit of Measure Code");
        ItemUOM.GET("Item No.", Rec."Unit of Measure Code");

        LineCount := SalesPrice.COUNT;

        FOR i := 1 TO NoLinesToInsert DO BEGIN
            SalesPrice2.INIT();
            SalesPrice2.TRANSFERFIELDS(SalesPrice);
            SalesPrice2."Unit of Measure Code" := UseUOM;
            SalesPrice2."Customer Bin" := '';
            SalesPrice2.INSERT();

            IF NOT ItemUOM2.GET(SalesPrice2."Item No.", SalesPrice2."Unit of Measure Code") THEN BEGIN
                ItemUOM2.TRANSFERFIELDS(ItemUOM);
                ItemUOM2.Code := SalesPrice2."Unit of Measure Code";
                ItemUOM2.INSERT();
            END;

            IF NOT UnitOfMeas2.GET(SalesPrice2."Unit of Measure Code") THEN BEGIN
                UnitOfMeas2.TRANSFERFIELDS(UnitOfMeas);
                UnitOfMeas2.Code := SalesPrice2."Unit of Measure Code";
                UnitOfMeas2.INSERT();
            END;

            UseUOM := INCSTR(UseUOM);
        END;
    end;

    procedure _ShowCrossRef()
    var
        ItemCrossRef: Record "Item Reference";
    begin
        ItemCrossRef.SETRANGE("Item No.", Rec."Item No.");
        PAGE.RUN(PAGE::"Item Reference Entries", ItemCrossRef);
    end;

    procedure ShowCrossRef()
    var
        ItemCrossRef: Record "Item Reference";
    begin
        ItemCrossRef.SETRANGE("Item No.", Rec."Item No.");
        PAGE.RUN(PAGE::"Item Reference Entries", ItemCrossRef);
    end;

    procedure _PrintLabel()
    var
        ContractLine: Record "Sales Price";
        ContractLabel: Report 50035;
    begin
        CLEAR(ContractLine);
        ContractLine.SETRANGE("Item No.", Rec."Item No.");
        ContractLine.SETRANGE("Sales Type", Rec."Sales Type");
        ContractLine.SETRANGE("Sales Code", Rec."Sales Code");
        ContractLine.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        ContractLine.SETRANGE("Contract No.", Rec."Contract No.");
        ContractLine.SETRANGE("Customer Bin", Rec."Customer Bin");
        ContractLabel.InitializeRequest('', 1, TRUE);
        ContractLabel.SETTABLEVIEW(ContractLine);
        ContractLabel.RUN();
    end;

    procedure PrintLabel()
    var
        ContractLine: Record "Sales Price";
        ContractLabel: Report 50035;
    begin
        CLEAR(ContractLine);
        ContractLine.SETRANGE("Item No.", Rec."Item No.");
        ContractLine.SETRANGE("Sales Type", Rec."Sales Type");
        ContractLine.SETRANGE("Sales Code", Rec."Sales Code");
        ContractLine.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
        ContractLine.SETRANGE("Contract No.", Rec."Contract No.");
        ContractLine.SETRANGE("Customer Bin", Rec."Customer Bin");
        ContractLabel.InitializeRequest('', 1, TRUE);
        ContractLabel.SETTABLEVIEW(ContractLine);
        ContractLabel.RUN();
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Rec.CALCFIELDS("Blanket Orders");
        //>>NIF 12-06-05
        GetCrossRefInfo(CrossRefNo, CrossRefDesc);
        //<< NIF 12-06-05
    end;
}

