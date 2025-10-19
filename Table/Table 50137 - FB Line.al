table 50137 "FB Line"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // Date     Init   Proj  Desc
    // 011206   RTT  #10566  new function DefaultContractLineValues
    // 011206   RTT  #10566  code at OnValidate() to call DefaultContractLineValues(): Item No,Unit of Measure,Contract
    fields
    {
        field(10; "Document No."; Code[20])
        {
            // cleaned
            TableRelation = "FB Header"."No.";
        }
        field(20; "Line No."; Integer)
        {
            // cleaned
        }
        field(25; "Order Date"; Date)
        {
            // cleaned
        }
        field(30; "Sell-to Customer No."; Code[20])
        {
            // cleaned
        }
        field(40; "Ship-To Code"; Code[10])
        {
            // cleaned
        }
        field(45; "Location Code"; Code[10])
        {
            // cleaned
        }
        field(50; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                //>>NIF 011206 $10571 #10571
                IF ("Tag No." = '') AND ("Item No." <> '') AND ("Contract No." <> '') THEN
                    DefaultContractLineValues();
                //<<NIF 011206 $10571 #10571
            end;
        }
        field(52; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(60; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(70; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                //>>NIF 011206 $10571 #10571
                IF ("Tag No." = '') AND ("Item No." <> '') AND ("Contract No." <> '') THEN
                    DefaultContractLineValues();
                //<<NIF 011206 $10571 #10571
            end;
        }
        field(80; "Tag No."; Code[20])
        {
            TableRelation = IF ("Item No." = FILTER(<> '')) "FB Tag" WHERE("Customer No." = FIELD("Sell-to Customer No."),
                                                                       "Ship-to Code" = FIELD("Ship-To Code"),
                                                                       "Location Code" = FIELD("Location Code"),
                                                                       "Item No." = FIELD("Item No."))
            ELSE
            "FB Tag" WHERE("Customer No." = FIELD("Sell-to Customer No."),
                                                                                            "Ship-to Code" = FIELD("Ship-To Code"),
                                                                                            "Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            begin
                IF "Tag No." <> '' THEN BEGIN
                    FBHeader.GET("Document No.");
                    IF FBTag.GET("Tag No.") THEN BEGIN
                        VALIDATE("Item No.", FBTag."Item No.");
                        VALIDATE("Variant Code", FBTag."Variant Code");
                        VALIDATE("Unit of Measure Code", FBTag."Unit of Measure Code");
                        "Customer Bin" := FBTag."Customer Bin";
                        "External Document No." := FBTag."External Document No.";
                        VALIDATE("Selling Location", FBTag."Selling Location");
                        VALIDATE("Shipping Location", FBTag."Shipping Location");
                        IF FBTag."Contract No." <> '' THEN
                            IF ("Contract No." = '') OR
                               (("Contract No." <> '') AND (FBTag."Contract No." <> "Contract No.")) THEN
                                ERROR('Tag Contract No. does not match Order Contract No.');
                        "Replenishment Method" := FBTag."Replenishment Method";
                        VALIDATE("Cross-Reference No.", FBTag."Cross-Reference No.");
                    END;
                END;
            end;

        }
        field(85; "Lot No."; Code[20])
        {
            // cleaned
            TableRelation = "Lot No. Information" WHERE("Item No." = FIELD("Item No."),
                                                         "Variant Code" = FIELD("Variant Code"));
        }
        field(90; "Customer Bin"; Code[20])
        {
            // cleaned
        }
        field(100; "Sales Order No."; Code[20])
        {
            // cleaned
        }
        field(101; "Sales Order Line No."; Integer)
        {
            // cleaned
        }
        field(102; "Transfer Order No."; Code[20])
        {
            // cleaned
        }
        field(103; "Transfer Order Line No."; Integer)
        {
            // cleaned
        }
        field(110; Status; Option)
        {
            OptionCaption = 'New,Errors,Processed';
            OptionMembers = New,Errors,Processed;
        }
        field(120; "FB Order Type"; Option)
        {
            OptionCaption = ' ,Consigned,Non-Consigned';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
        field(140; "External Document No."; Code[20])
        {
            // cleaned
        }
        field(170; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" WHERE(Sales = CONST(true));

            trigger OnValidate()
            var
            /*   ">>LT_NV": ;
              LTEXT14170180: Label 'Sales Lines exist. All Lines will be changed to the new value.';
              LTEXT14170181: Label 'Operation Canceled'; */
            begin
            end;

        }
        field(175; "Inside Salesperson Code"; Code[10])
        {
            // cleaned

            TableRelation = "Salesperson/Purchaser" WHERE("Inside Sales" = CONST(true));

        }
        field(180; "Selling Location"; Code[10])
        {
            // cleaned

            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false));

        }
        field(190; "Shipping Location"; Code[10])
        {
            // cleaned

            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                              "Rework Location" = CONST(false));

        }
        field(200; "Contract No."; Code[20])
        {
            TableRelation = "Price Contract"."No." WHERE("Customer No." = FIELD("Sell-to Customer No."),
                                                        "Ship-to Code" = FIELD("Ship-To Code"),
                                                        "Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            begin
                //>>NIF 011206 $10571 #10571
                IF ("Tag No." = '') AND ("Item No." <> '') AND ("Contract No." <> '') THEN
                    DefaultContractLineValues();
                //<<NIF 011206 $10571 #10571
            end;
        }
        field(300; "Replenishment Method"; Option)
        {
            Caption = 'Replenishment Method';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(900; "Import Data Log No."; Code[20])
        {
            // cleaned
        }
        field(901; "Import Data Log Line No."; Integer)
        {
            // cleaned
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            trigger OnLookup()
            begin
                CrossReferenceNoLookUp();
            end;

            trigger OnValidate()
            var
                ReturnedCrossRef: Record 5777;
            begin
                ReturnedCrossRef.INIT();
                IF "Cross-Reference No." <> '' THEN BEGIN

                    DistIntegration.ICRLookupFBItem(Rec, ReturnedCrossRef);

                    VALIDATE("Item No.", ReturnedCrossRef."Item No.");
                    IF ReturnedCrossRef."Variant Code" <> '' THEN
                        VALIDATE("Variant Code", ReturnedCrossRef."Variant Code");

                    IF ReturnedCrossRef."Unit of Measure" <> '' THEN
                        VALIDATE("Unit of Measure Code", ReturnedCrossRef."Unit of Measure");
                END;

                "Unit of Measure (Cross Ref.)" := ReturnedCrossRef."Unit of Measure";
                "Cross-Reference Type" := ReturnedCrossRef."Reference Type".AsInteger();
                "Cross-Reference Type No." := ReturnedCrossRef."Reference Type No.";
                "Cross-Reference No." := ReturnedCrossRef."Reference No.";
            end;


        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';

        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Import Data Log No.", "Import Data Log Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
        DistIntegration: Codeunit 5702;
        FBTag: Record 50134;
        FBHeader: Record 50136;
        ItemAvailByDate: Page 157;
        ItemAvailByVar: Page 5414;
        ItemAvailByLoc: Page 492;
        Text001: Label 'Change %1 from %2 to %3?', Comment = '%1 = Field name being changed, %2 = Previous value, %3 = Updated value.';

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        TESTFIELD("Item No.");
        Item.RESET();
        Item.GET("Item No.");
        Item.SETRANGE("No.", "Item No.");
        Item.SETRANGE("Date Filter", 0D, "Order Date");

        CASE AvailabilityType OF
            AvailabilityType::Date:
                BEGIN
                    Item.SETRANGE("Variant Filter", "Variant Code");
                    Item.SETRANGE("Location Filter", "Location Code");
                    CLEAR(ItemAvailByDate);
                    ItemAvailByDate.LOOKUPMODE(TRUE);
                    ItemAvailByDate.SETRECORD(Item);
                    ItemAvailByDate.SETTABLEVIEW(Item);
                    IF ItemAvailByDate.RUNMODAL() = ACTION::LookupOK THEN
                        IF "Order Date" <> ItemAvailByDate.GetLastDate() THEN
                            IF CONFIRM(
                                 Text001, TRUE, FIELDCAPTION("Order Date"), "Order Date",
                                 ItemAvailByDate.GetLastDate())
                            THEN BEGIN
                                IF CurrFieldNo <> 0 THEN
                                    xRec := Rec;
                                VALIDATE("Order Date", ItemAvailByDate.GetLastDate());
                            END;
                END;
            AvailabilityType::Variant:
                BEGIN
                    Item.SETRANGE("Location Filter", "Location Code");
                    CLEAR(ItemAvailByVar);
                    ItemAvailByVar.LOOKUPMODE(TRUE);
                    ItemAvailByVar.SETRECORD(Item);
                    ItemAvailByVar.SETTABLEVIEW(Item);
                    IF ItemAvailByVar.RUNMODAL() = ACTION::LookupOK THEN
                        IF "Variant Code" <> ItemAvailByVar.GetLastVariant() THEN
                            IF CONFIRM(
                                 Text001, TRUE, FIELDCAPTION("Variant Code"), "Variant Code",
                                 ItemAvailByVar.GetLastVariant())
                            THEN BEGIN
                                IF CurrFieldNo = 0 THEN
                                    xRec := Rec;
                                VALIDATE("Variant Code", ItemAvailByVar.GetLastVariant());
                            END;
                END;
            AvailabilityType::Location:
                BEGIN
                    Item.SETRANGE("Variant Filter", "Variant Code");
                    CLEAR(ItemAvailByLoc);
                    ItemAvailByLoc.LOOKUPMODE(TRUE);
                    ItemAvailByLoc.SETRECORD(Item);
                    ItemAvailByLoc.SETTABLEVIEW(Item);
                    IF ItemAvailByLoc.RUNMODAL() = ACTION::LookupOK THEN
                        IF "Location Code" <> ItemAvailByLoc.GetLastLocation() THEN
                            IF CONFIRM(
                                 Text001, TRUE, FIELDCAPTION("Location Code"), "Location Code",
                                 ItemAvailByLoc.GetLastLocation())
                            THEN BEGIN
                                IF CurrFieldNo = 0 THEN
                                    xRec := Rec;
                                VALIDATE("Location Code", ItemAvailByLoc.GetLastLocation());
                            END;
                END;
        END;
    end;

    procedure CrossReferenceNoLookUp()
    var
        ItemCrossReference: Record 5777;
    begin
        ItemCrossReference.RESET();
        ItemCrossReference.SETCURRENTKEY("Reference Type", "Reference Type No.");
        ItemCrossReference.SETFILTER("Reference Type", '%1|%2',
                                     ItemCrossReference."Reference Type"::Customer,
                                     ItemCrossReference."Reference Type"::" ");
        ItemCrossReference.SETFILTER("Reference Type No.", '%1|%2', "Sell-to Customer No.", '');
        IF PAGE.RUNMODAL(PAGE::"Item Reference List", ItemCrossReference) = ACTION::LookupOK THEN
            VALIDATE("Cross-Reference No.", ItemCrossReference."Reference No.");
    end;

    procedure ">>NIF"()
    begin
    end;

    procedure DefaultContractLineValues()
    var
        SalesPrice: Record 7002;
        FBHeader_: Record 50136;
        //"Price Contract": Record 50110;
        FBMgt: Codeunit 50133;
    begin
        //exit if came from an import
        FBHeader_.GET("Document No.");
        IF FBHeader_."Import File Name" <> '' THEN
            EXIT;

        IF NOT FBMgt.GetContractLine(SalesPrice, Rec) THEN
            EXIT;

        IF SalesPrice.FindFirst() THEN BEGIN
            "External Document No." := SalesPrice."External Document No.";
            "Replenishment Method" := SalesPrice."Replenishment Method";
            "FB Order Type" := SalesPrice."FB Order Type";
            "Customer Bin" := SalesPrice."Customer Bin";
        END;
    end;
}
