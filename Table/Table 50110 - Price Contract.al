table 50110 "Price Contract"
{
    // RTT 01-12-06 new fields "Default Replenishment Method" and "Default Method of Fullfillment"
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)
    // 
    // SM 001 - 4/20/17 - Extended number of Character on Address2 from 30 to 50

    LookupPageID = 50113;
    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                //TODO
                /*  IF "No." <> xRec."No." THEN BEGIN
                     SalesSetup.GET();
                     NoSeriesMgt.TestManual(SalesSetup."Price Contract Nos.");
                     "No. Series" := '';
                 END; */
                //TODO
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                //TODO
                /*  IF ("Customer No." <> '') THEN BEGIN
                     Cust.GET("Customer No.");
                     VALIDATE("Ship-to Code", Cust."Default Ship-To Code");
                     "Customer Name" := Cust.Name;
                 END; */
                //TODO

                IF (xRec."Customer No." <> "Customer No.") THEN
                    HandleRename(Rec, xRec);
            end;
        }
        field(3; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Description; Text[80])
        {
            // cleaned
        }
        field(20; "Starting Date"; Date)
        {
            NotBlank = true;
            trigger OnValidate()
            begin
                IF (xRec."Starting Date" <> "Starting Date") THEN
                    HandleRename(Rec, xRec);
            end;

        }
        field(21; "Ending Date"; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                UpdateLines(FIELDNAME("Ending Date"), FALSE);
            end;

        }
        field(24; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(25; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; "External Document No."; Code[20])
        {
            // cleaned
        }
        field(50; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));

            trigger OnValidate()
            var
            //SellToCustTemplate: Record 5105;
            begin
                Cust.GET("Customer No.");
                "Payment Terms Code" := Cust."Payment Terms Code";

                IF ("Ship-to Code" <> '')
                THEN BEGIN
                    IF xRec."Ship-to Code" <> '' THEN BEGIN
                        Cust.GET("Customer No.");
                        IF Cust."Location Code" <> '' THEN
                            VALIDATE("Location Code", Cust."Location Code");
                    END;
                    ShipToAddr.GET("Customer No.", "Ship-to Code");
                    "Ship-to Name" := ShipToAddr.Name;
                    "Ship-to Name 2" := ShipToAddr."Name 2";
                    "Ship-to Address" := ShipToAddr.Address;
                    "Ship-to Address 2" := ShipToAddr."Address 2";
                    "Ship-to City" := ShipToAddr.City;
                    "Ship-to Post Code" := ShipToAddr."Post Code";
                    "Ship-to County" := ShipToAddr.County;
                    VALIDATE("Ship-to Country Code", ShipToAddr."Country/Region Code");
                    "Ship-to Contact" := ShipToAddr.Contact;
                    "Shipment Method Code" := ShipToAddr."Shipment Method Code";
                    IF ShipToAddr."Location Code" <> '' THEN
                        VALIDATE("Location Code", ShipToAddr."Location Code");
                    "Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
                    "Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
                    "Tax Area Code" := ShipToAddr."Tax Area Code";
                    "Tax Liable" := ShipToAddr."Tax Liable";
                    "Broker/Agent Code" := ShipToAddr."Broker/Agent Code";
                    //TODO
                    /*  "Delivery Route" := ShipToAddr."Delivery Route";
                     "Delivery Stop" := ShipToAddr."Delivery Stop"; */
                    //TODO
                    "UPS Zone" := ShipToAddr."UPS Zone";
                    "Place of Export" := ShipToAddr."Place of Export";
                    "Service Zone Code" := ShipToAddr."Service Zone Code";
                    IF ShipToAddr."Phone No." <> '' THEN "Phone No." := ShipToAddr."Phone No.";
                    IF ShipToAddr."Salesperson Code" <> '' THEN "Salesperson Code" := ShipToAddr."Salesperson Code";
                    //TODO
                    // IF ShipToAddr."Inside Salesperson" <> '' THEN "Inside Salesperson" := ShipToAddr."Inside Salesperson";
                    //TODO
                END ELSE BEGIN
                    Cust.GET("Customer No.");
                    "Ship-to Name" := Cust.Name;
                    "Ship-to Name 2" := Cust."Name 2";
                    "Ship-to Address" := Cust.Address;
                    "Ship-to Address 2" := Cust."Address 2";
                    "Ship-to City" := Cust.City;
                    "Ship-to Post Code" := Cust."Post Code";
                    "Ship-to County" := Cust.County;
                    VALIDATE("Ship-to Country Code", Cust."Country/Region Code");
                    "Ship-to Contact" := Cust.Contact;
                    "Shipment Method Code" := Cust."Shipment Method Code";
                    IF Cust."Location Code" <> '' THEN
                        VALIDATE("Location Code", Cust."Location Code");
                    "Shipping Agent Code" := Cust."Shipping Agent Code";
                    "Shipping Agent Service Code" := Cust."Shipping Agent Service Code";
                    "Phone No." := Cust."Phone No.";
                    "Tax Area Code" := Cust."Tax Area Code";
                    "Tax Liable" := Cust."Tax Liable";
                    "Payment Terms Code" := Cust."Payment Terms Code";
                    //TODO
                    /*   "Broker/Agent Code" := Cust."Broker/Agent Code";
                      "Delivery Route" := Cust."Delivery Route";
                      "Delivery Stop" := Cust."Delivery Stop"; */
                    //TODO
                    "UPS Zone" := Cust."UPS Zone";
                    "Place of Export" := Cust."Place of Export";
                    "Service Zone Code" := Cust."Service Zone Code";
                    IF Cust."Phone No." <> '' THEN "Phone No." := Cust."Phone No.";
                    IF Cust."Salesperson Code" <> '' THEN "Salesperson Code" := Cust."Salesperson Code";
                    //TODO
                    // IF Cust."Inside Salesperson" <> '' THEN "Inside Salesperson" := Cust."Inside Salesperson";
                    //TODO
                END;
            end;

        }
        field(51; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(52; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(53; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(54; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(55; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = IF ("Ship-to Country Code" = CONST()) "Post Code".City
            ELSE IF ("Ship-to Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country Code"));

            trigger OnLookup()
            begin
                //>>CIS.001 Fixed during upgrade
                //PostCode.LookUpCity("Ship-to City","Ship-to Post Code",TRUE);
                //>>CIS.001 Fixed during upgrade
            end;

            trigger OnValidate()
            begin
                //>>CIS.001 Fixed during upgrade
                //PostCode.ValidateCity("Ship-to City","Ship-to Post Code");
                PostCode.ValidateCity("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                //<<CIS.001 Fixed during upgrade
            end;

        }
        field(56; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(57; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to ZIP Code';
            TableRelation = IF ("Ship-to Country Code" = CONST()) "Post Code"
            ELSE IF ("Ship-to Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Ship-to Country Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //>>CIS.001 Fixed during upgrade
                //PostCode.LookUpPostCode("Ship-to City","Ship-to Post Code",TRUE);
                //>>CIS.001 Fixed during upgrade
            end;

            trigger OnValidate()
            begin
                //>>CIS.001 Fixed during upgrade
                //PostCode.ValidatePostCode("Ship-to City","Ship-to Post Code");
                PostCode.ValidatePostCode("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                //>>CIS.001 Fixed during upgrade
            end;

        }
        field(58; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to State';
        }
        field(59; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
        }
        field(60; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(70; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(71; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
                    VALIDATE("Shipping Agent Service Code", '');
            end;
        }
        field(72; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(80; "Payment Terms Code"; Code[10])
        {
            // cleaned
            TableRelation = "Payment Terms";
        }
        field(85; "Salesperson Code"; Code[10])
        {
            // cleaned
            TableRelation = "Salesperson/Purchaser";
        }
        field(86; "Location Code"; Code[10])
        {
            TableRelation = Location;

            trigger OnValidate()
            begin
                "Shipping Location Code" := "Location Code";
            end;
        }
        field(87; "Shipping Location Code"; Code[10])
        {
            // cleaned
            TableRelation = Location;
        }
        field(89; "Selling Location Code"; Code[10])
        {
            // cleaned
            //TODO
            /*  TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false)); */
            //TODO
        }
        field(90; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(92; "E-Mail"; Text[80])
        {
            // cleaned
        }
        field(94; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(100; "No. Series"; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(110; "Total Value"; Decimal)
        {
            // cleaned
        }
        field(120; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(122; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
        }
        field(124; "UPS Zone"; Code[2])
        {
            Caption = 'UPS Zone';
        }
        field(140; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(141; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(200; Comments; Boolean)
        {
            // cleaned
            CalcFormula = Exist("Price Contract Comment Line" WHERE("Price Contract No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50000; "Default Repl. Method"; Option)
        {
            Caption = 'Default Repl. Method';
            Description = 'NV';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(50010; "Def. Method of Fullfillment"; Option)
        {
            Description = 'NV';
            OptionCaption = 'Standard,FillBill';
            OptionMembers = Standard,FillBill;
        }
        field(50108; "Inside Salesperson"; Code[10])
        {
            // cleaned
            //TODO
            /*   TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(false),
                                                                Sales = CONST(false)); */
            //TDOD
        }
        field(50117; "Broker/Agent Code"; Code[10])
        {
            Description = 'NF1.00:CIS.NG  10-10-15';
        }
        field(50147; "Delivery Route"; Code[10])
        {
            // cleaned
        }
        field(50148; "Delivery Stop"; Code[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DeleteLines();
        PriceContractCommentLine.SETRANGE("Price Contract No.", "No.");
        PriceContractCommentLine.DELETEALL();
    end;

    trigger OnInsert()
    begin
        //TODO
        /*   IF "No." = '' THEN BEGIN
              SalesSetup.GET();
              SalesSetup.TESTFIELD("Price Contract Nos.");
              NoSeriesMgt.InitSeries(SalesSetup."Price Contract Nos.", xRec."No. Series", 0D, "No.", "No. Series");
          END; */
        //TODO

        IF GETFILTER("Customer No.") <> '' THEN
            IF GETRANGEMIN("Customer No.") = GETRANGEMAX("Customer No.") THEN
                VALIDATE("Customer No.", GETRANGEMIN("Customer No."));

        "Creation Date" := TODAY;
    end;

    trigger OnModify()
    begin

        "Last Date Modified" := TODAY;
    end;

    var
        Cust: Record 18;
        ShipToAddr: Record 222;
        PostCode: Record 225;
        //SalesSetup: Record 311;
        //Contract: Record 50110;
        PriceContractCommentLine: Record 50111;
    //NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldContract: Record 50110): Boolean
    begin
        //TODO
        /*   Contract := Rec;
          SalesSetup.GET();
          SalesSetup.TESTFIELD("Price Contract Nos.");
          IF NoSeriesMgt.SelectSeries(SalesSetup."Price Contract Nos.", OldContract."No. Series", Contract."No. Series") THEN BEGIN
              NoSeriesMgt.SetSeries(Contract."No.");
              Rec := Contract;
              EXIT(TRUE);
          END; */
        //TODO
    end;

    procedure HandleRename(Contract: Record 50110; xContract: Record 50110)
    var
        xSalesPriceLine: Record 7002;
        SalesPriceLine: Record 7002;
    begin
        xSalesPriceLine.SETRANGE("Contract No.", Contract."No.");
        xSalesPriceLine.SETRANGE("Sales Code", xContract."Customer No.");
        xSalesPriceLine.SETRANGE("Starting Date", xContract."Starting Date");

        IF xSalesPriceLine.FIND('-') THEN
            REPEAT
                SalesPriceLine.INIT();
                SalesPriceLine.TRANSFERFIELDS(xSalesPriceLine);
                SalesPriceLine."Starting Date" := Contract."Starting Date";
                SalesPriceLine."Sales Code" := Contract."Customer No.";
                SalesPriceLine.INSERT(TRUE);
                xSalesPriceLine.DELETE(TRUE);
            UNTIL xSalesPriceLine.NEXT() = 0;
    end;

    procedure UpdateLines(ChangedFieldName: Text[100]; AskQuestion: Boolean)
    var
        SalesPriceLine: Record 7002;
        Question: Text[250];
        UpdateLinesQstLbl: Label 'You have changed %1.\Do you want to update the lines?', Comment = '%1 = Changed field name';
    begin
        if AskQuestion then begin
            Question := StrSubstNo(UpdateLinesQstLbl, ChangedFieldName);

            if not Dialog.Confirm(Question, true) then
                exit;
        end;

        SalesPriceLine.SetRange("Contract No.", "No.");
        case ChangedFieldName of
            FieldName("Ending Date"):
                SalesPriceLine.ModifyAll("Ending Date", "Ending Date");
        end;
    end;


    procedure DeleteLines()
    var
        SalesPriceLine: Record 7002;
    begin
        SalesPriceLine.SETRANGE("Contract No.", "No.");
        IF SalesPriceLine.FIND('-') THEN BEGIN
            IF NOT CONFIRM('Existing contract lines will be deleted. Do you want to continue?') THEN
                ERROR('Operation Canceled.');
            SalesPriceLine.DELETEALL(TRUE);
        END;
    end;
}
