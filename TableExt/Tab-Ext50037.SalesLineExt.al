tableextension 50037 "Sales Line Ext" extends "Sales Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.60,NV4.35,NIF1.104,NMX1.000,NIF.N15.C9IN.001,AP6.01.001,AKK1606.01, SM 001,CIS.IoT

    fields
    {
        modify("No.")
        {
            Description = 'AKK1606';
        }
        modify("Drop Shipment")
        {
            trigger OnAfterValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                // Shipping
                // Qty. to Ship has been set to zero for not accidentially shipping the line when posting.
                // This is not a Shipping Specific problem but and general "Feature" in Navision
                IF "Drop Shipment" THEN BEGIN
                    SalesSetup.GET();
                    IF SalesSetup."LAX Blank Drop Ship Qty.toShip" THEN
                        VALIDATE("Qty. to Ship", 0);
                END;
                // Shipping
            end;
        }
        modify("Blanket Order Line No.")
        {
            trigger OnAfterValidate()
            var
                SalesLine2: Record "Sales Line";
            begin
                SalesLine2.GET("Document Type"::"Blanket Order", "Blanket Order No.", "Blanket Order Line No.");
                VALIDATE("Location Code", SalesLine2."Location Code");
                VALIDATE("Unit of Measure Code", SalesLine2."Unit of Measure Code");
                VALIDATE("Unit Price", SalesLine2."Unit Price");
                VALIDATE("Line Discount %", SalesLine2."Line Discount %");
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            var
                Res: Record Resource;
                Item: Record Item;
            begin
                // << Shipping
                CASE Type OF
                    Type::Item:
                        begin
                            Item.Get("No.");
                            Rec."LAX Dimmed Weight" := Item."LAX Dimmed Weight" * "Qty. per Unit of Measure";
                        End;
                    Type::Resource:
                        BEGIN
                            Res.GET("No.");
                            "Gross Weight" := Res."LAX Gross Weight";
                            "Net Weight" := Res."LAX Net Weight";
                            "LAX Dimmed Weight" := Res."LAX Dimmed Weight";
                            "Unit Volume" := Res."LAX Unit Volume";
                        END;
                END;
                // >> Shipping 
            end;
        }
        field(50000; "EDI Line No."; Integer)
        {
            Editable = false;
        }
        field(50005; "Certificate No."; Code[30])
        {
        }
        field(50010; "Drawing No."; Code[30])
        {
        }
        field(50020; "Revision No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Cust./Item Drawing2"."Revision No." WHERE("Item No." = FIELD("No."),
                                                                                            "Customer No." = FILTER(''));
        }
        field(50025; "Revision Date"; Date)
        {
        }
        field(50027; "Revision No. (Label Only)"; Code[20])
        {
        }
        field(50030; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50100; "Storage Location"; Code[10])
        {
        }
        field(50105; "Line Supply Location"; Code[10])
        {
        }
        field(50110; "Deliver To"; Code[10])
        {
        }
        field(50115; "Receiving Area"; Code[10])
        {
        }
        field(50120; "Ran No."; Code[20])
        {
        }
        field(50125; "Container No."; Code[20])
        {
        }
        field(50130; "Kanban No."; Code[20])
        {
        }
        field(50135; "Res. Mfg."; Code[20])
        {
        }
        field(50140; "Release No."; Code[20])
        {
        }
        field(50145; "Mfg. Date"; Date)
        {
        }
        field(50150; "Man No."; Code[20])
        {
        }
        field(50155; "Delivery Order No."; Code[20])
        {
        }
        field(50157; "Plant Code"; Code[10])
        {
        }
        field(50160; "Dock Code"; Code[10])
        {
        }
        field(50165; "Box Weight"; Decimal)
        {
        }
        field(50170; "Store Address"; Text[50])
        {
        }
        field(50175; "FRS No."; Code[10])
        {
        }
        field(50180; "Main Route"; Code[10])
        {
        }
        field(50185; "Line Side Address"; Text[50])
        {
        }
        field(50190; "Sub Route Number"; Code[10])
        {
        }
        field(50195; "Special Markings"; Text[30])
        {
        }
        field(50200; "Eng. Change No."; Code[20])
        {
        }
        field(50205; "Group Code"; Code[20])
        {
        }
        field(50500; "Model Year"; Code[10])
        {
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
        field(50803; "IoT Lot No."; Code[20])
        {
            Description = 'CIS.Ram IoT';
        }


        /*  field(14000350; "EDI Ship Confirmed"; Boolean)
         {
             Caption = 'EDI Ship Confirmed';
             Editable = false;
         }

         field(14000351; "EDI Item Cross Ref."; Code[20])
         {
             Caption = 'EDI Item Cross Ref.';
         }

         field(14000352; "EDI Unit of Measure"; Code[10])
         {
             Caption = 'EDI Unit of Measure';
         }

         field(14000353; "EDI Unit Price"; Decimal)
         {
             Caption = 'EDI Unit Price';
         }

         field(14000354; "EDI Price Discrepancy"; Boolean)
         {
             Caption = 'EDI Price Discrepancy';
         }

         field(14000355; "EDI Segment Group"; Integer)
         {
             Caption = 'EDI Segment Group';
             Editable = false;
         }

         field(14000356; "EDI Original Qty."; Decimal)
         {
             Caption = 'EDI Original Qty.';
             DecimalPlaces = 0 : 5;
             Editable = false;
         }

         field(14000357; "EDI Status Pending"; Boolean)
         {
             Caption = 'EDI Status Pending';
             Editable = false;
         }

         field(14000358; "EDI Release No."; Code[20])
         {
             Caption = 'EDI Release No.';
         }

         field(14000359; "EDI Ship Req. Date"; Date)
         {
             Caption = 'EDI Ship Req. Date';
         }

         field(14000360; "EDI Kanban No."; Code[20])
         {
             Caption = 'EDI Kanban No.';
         }

         field(14000361; "EDI Line Type"; Option)
         {
             Caption = 'EDI Line Type';
             OptionCaption = ' ,Forecast,Release,Change,Forecast & Release,Recreate';
             OptionMembers = "",Forecast,Release,Change,"Forecast & Release",Recreate;
         }

         field(14000362; "EDI Line Status"; Option)
         {
             Caption = 'EDI Line Status';
             OptionCaption = ' ,New,Order Exists,Shipment Exists,Release Created,Change Made,Cancellation,Add Item,Closed';
             OptionMembers = "",New,"Order Exists","Shipment Exists","Release Created","Change Made",Cancellation,"Add Item",Closed;
         }

         field(14000363; "EDI Cumulative Quantity"; Decimal)
         {
             Caption = 'EDI Cumulative Quantity';
         }

         field(14000364; "EDI Forecast Begin Date"; Date)
         {
             Caption = 'EDI Forecast Begin Date';
         }

         field(14000365; "EDI Forecast End Date"; Date)
         {
             Caption = 'EDI Forecast End Date';
         }

         field(14000366; "EDI Code"; Code[35])
         {
             Caption = 'EDI Code';
         }

         field(14000602; "Over Receive"; Boolean)
         {
             Caption = 'Over Receive';
             Editable = false;
         }
        field(14000603; "Over Receive Verified"; Boolean)
        {
            Caption = 'Over Receive Verified';
            trigger OnValidate()
            begin
                if "Over Receive Verified" then
                    TestField("Over Receive");
            end;
        }

        field(14000701; "Shipping Charge"; Boolean)
        {
            Caption = 'Shipping Charge';
        }

        field(14000702; "Dimmed Weight"; Decimal)
        {
            Caption = 'Dimmed Weight';
            DecimalPlaces = 0 : 5;
        }

        field(14000703; "Pack"; Boolean)
        {
            Caption = 'Pack';
            Editable = false;
        }

        field(14000704; "Rate Quoted"; Boolean)
        {
            Caption = 'Rate Quoted';
            trigger OnValidate()
            var
                ShippingAgent: Record 291;
            begin
                if "Rate Quoted" then begin
                    TestField("Quantity Shipped", 0);

                    GetSalesHeader();
                    SalesHeader.TestField("Shipping Agent Code");
                    ShippingAgent.Get(SalesHeader."Shipping Agent Code");
                    TestField(Type, ShippingAgent."Prepaid Freight Type");
                    TestField("No.", ShippingAgent."Prepaid Freight Code");
                end;
            end;
        }
         

        field(14000705; "Std. Pack Unit of Measure Code"; Code[10])
        {
            Caption = 'Std. Pack Unit of Measure Code';
            TableRelation = if (Type = Type::Item) then "Item Unit of Measure".Code where ("Item No." = field("No."));

            trigger OnValidate()
            begin
                TestField(Type, Type::Item);
                TestField("No.");

                if "Std. Pack Unit of Measure Code" <> '' then begin
                    GetItem();
                    "Qty. per Std. Pack" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Std. Pack Unit of Measure Code");
                end else
                    "Qty. per Std. Pack" := 0;

                "Std. Pack Quantity" := CalcStdPackQty("Quantity (Base)");
                "Package Quantity" := CalcPackageQty("Std. Pack Quantity");
                "Std. Pack Qty. to Ship" := CalcStdPackQty("Qty. to Ship (Base)");
                "Package Qty. to Ship" := CalcPackageQty("Std. Pack Qty. to Ship");
            end;
        }
       

        field(14000706; "Std. Pack Quantity"; Decimal)
        {
            Caption = 'Std. Pack Quantity';
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            Editable = false;
        }

        field(14000707; "Qty. per Std. Pack"; Decimal)
        {
            Caption = 'Qty. per Std. Pack';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14000708; "Std. Pack Qty. to Ship"; Decimal)
        {
            Caption = 'Std. Pack Qty. to Ship';
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            Editable = false;
        }

        field(14000709; "Std. Packs per Package"; Integer)
        {
            Caption = 'Std. Packs per Package';
            trigger OnValidate()
            begin
                if "Std. Packs per Package" <> 0 then
                    TestField("Std. Pack Unit of Measure Code");

                "Package Quantity" := CalcPackageQty("Std. Pack Quantity");
                "Package Qty. to Ship" := CalcPackageQty("Std. Pack Qty. to Ship");
            end;
        }
        field(14000710; "Package Quantity"; Decimal)
        {
            Caption = 'Package Quantity';
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            Editable = false;
        }

        field(14000711; "Package Qty. to Ship"; Decimal)
        {
            Caption = 'Package Qty. to Ship';
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            Editable = false;
        }

        field(14000712; "E-Ship Whse. Outst. Qty (Base)"; Decimal)
        {
            Caption = 'E-Ship Whse. Outst. Qty (Base)';
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)"
        where(
            "Activity Type" = filter(Pick),
            "Source Type" = const(37),
            "Source Subtype" = field("Document Type"),
            "Source No." = field("Document No."),
            "Source Line No." = field("Line No."),
            "Action Type" = filter(' ' | Take),
            "Breakbulk No." = filter(0)
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14000713; "Shipping Charge BOL No."; Code[20])
        {
            Caption = 'Shipping Charge BOL No.';
            TableRelation = "LAX Bill of Lading";
        }

        field(14000714; "E-Ship Whse. Outstanding Qty."; Decimal)
        {
            Caption = 'E-Ship Whse. Outstanding Qty.';
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding"
        where(
            "Activity Type" = filter(Pick),
            "Source Type" = const(37),
            "Source Subtype" = field("Document Type"),
            "Source No." = field("Document No."),
            "Source Line No." = field("Line No."),
            "Action Type" = filter(' ' | Take),
            "Breakbulk No." = filter(0)
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14000715; "Required Shipping Agent Code"; Code[10])
        {
            Caption = 'Required Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            var
                PackageLine: Record "Package Line";
            begin
                if "Required Shipping Agent Code" <> '' then
                    TestField("LAX Pack");

                if "Required Shipping Agent Code" <> xRec."Required Shipping Agent Code" then begin
                    if CurrFieldNo = FieldNo("Required Shipping Agent Code") then begin
                        PackageLine.Reset();
                        PackageLine.SetCurrentKey("Source Type", "Source Subtype", "Source ID", "No.", "Variant Code", Type);
                        PackageLine.SetRange("Source Type", Database::"Sales Header");
                        PackageLine.SetRange("Source Subtype", "Document Type");
                        PackageLine.SetRange("Source ID", "Document No.");
                        PackageLine.SetRange(Type, Type);
                        PackageLine.SetRange("No.", "No.");
                        PackageLine.SetRange("Variant Code", "Variant Code");
                        if PackageLine.Find('-') then
                            Message(Text14000701);
                    end;

                    Validate("Required E-Ship Agent Service", '');
                    Validate("LAX Allow Other ShipAgent/Serv", false);
                end;
            end;
        }

        field(14000716; "Required E-Ship Agent Service"; Code[30])
        {
            Caption = 'Required E-Ship Agent Service';
            TableRelation = "LAX EShip Agent Service".Code where("Shipping Agent Code" = field("Required Shipping Agent Code"));

            trigger OnValidate()
            var
                PackageLine: Record "Package Line";
                ShippingAgent: Record "Shipping Agent";
                EShipAgentService: Record "LAX EShip Agent Service";
            begin
                if "Required E-Ship Agent Service" <> '' then begin
                    TestField("LAX Pack");
                    GetSalesHeader();
                    TestField("Required Shipping Agent Code");
                    ShippingAgent.Get("Required Shipping Agent Code");
                    EShipAgentService.Get(
                        "Required Shipping Agent Code", "Required E-Ship Agent Service", SalesHeader."World Wide Service");
                    if EShipAgentService.UPSCanadianShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code") then
                        EShipAgentService.TestField("UPS Canadian Service");
                    if EShipAgentService.UPSPuertoRicoShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code") then
                        EShipAgentService.TestField("UPS Puerto Rico Service");
                end;

                if ("Required E-Ship Agent Service" <> xRec."Required E-Ship Agent Service") and
                   (CurrFieldNo = FieldNo("Required E-Ship Agent Service")) then begin
                    PackageLine.Reset();
                    PackageLine.SetCurrentKey("Source Type", "Source Subtype", "Source ID", "No.", "Variant Code", Type);
                    PackageLine.SetRange("Source Type", Database::"Sales Header");
                    PackageLine.SetRange("Source Subtype", "Document Type");
                    PackageLine.SetRange("Source ID", "Document No.");
                    PackageLine.SetRange(Type, Type);
                    PackageLine.SetRange("No.", "No.");
                    PackageLine.SetRange("Variant Code", "Variant Code");
                    if PackageLine.Find('-') then
                        Message(Text14000701);
                end;
            end;

            trigger OnLookup()
            var
                ShippingAgent: Record "Shipping Agent";
                EShipAgentService: Record "LAX EShip Agent Service";
            begin
                GetSalesHeader();
                TestField("Required Shipping Agent Code");
                ShippingAgent.Get("Required Shipping Agent Code");
                EShipAgentService.Reset();
                EShipAgentService.SetRange("Shipping Agent Code", ShippingAgent.Code);
                EShipAgentService.SetRange(
                    "World Wide Service",
                    EShipAgentService.InternationalShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"));
                if EShipAgentService.UPSCanadianShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code") then
                    EShipAgentService.SetRange("UPS Canadian Service", true);
                if EShipAgentService.UPSPuertoRicoShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code") then
                    EShipAgentService.SetRange("UPS Puerto Rico Service", true);
                if PAGE.RunModal(0, EShipAgentService) = Action::LookupOK then
                    Validate("Required E-Ship Agent Service", EShipAgentService.Code);
            end;
        }

        field(14000717; "Allow Other Ship. Agent/Serv."; Boolean)
        {
            trigger OnValidate()
            begin
                if "Allow Other Ship. Agent/Serv." then begin
                    TestField("LAX Pack");
                    TestField("Required Shipping Agent Code");
                    TestField("Required E-Ship Agent Service");
                end;
            end;
        }

        field(14000718; "E-Ship Whse. Ship. Qty (Base)"; Decimal)
        {
            Caption = 'E-Ship Whse. Ship. Qty (Base)';
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship (Base)"
        where(
            "Source Type" = const(37),
            "Source Subtype" = field("Document Type"),
            "Source No." = field("Document No."),
            "Source Line No." = field("Line No.")
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14000719; "E-Ship Whse. Shipment Qty."; Decimal)
        {
            Caption = 'E-Ship Whse. Shipment Qty.';
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship"
        where(
            "Source Type" = const(37),
            "Source Subtype" = field("Document Type"),
            "Source No." = field("Document No."),
            "Source Line No." = field("Line No.")
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14000720; "E-Ship Agent Code"; Code[10])
        {
            Caption = 'E-Ship Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                GetSalesHeader();

                if ("E-Ship Agent Code" <> xRec."E-Ship Agent Code") and (xRec."E-Ship Agent Code" <> '') then
                    Validate("E-Ship Agent Service", '');

                if "LAX EShip Agent Code" <> '' then begin
                    ShippingAgent.Get("E-Ship Agent Code");
                    Validate("E-Ship Agent Service", EShipAgentService.DefaultShipAgentService(ShippingAgent, SalesHeader."Ship-to Country/Region Code"));
                end;

                if "E-Ship Agent Code" <> xRec."E-Ship Agent Code" then begin
                    if "E-Ship Agent Code" <> '' then begin
                        Validate("Shipping Payment Type", SalesHeader."Shipping Payment Type");
                        Validate("Shipping Insurance", SalesHeader."Shipping Insurance");
                    end else begin
                        Validate("Shipping Payment Type", "Shipping Payment Type"::Prepaid);
                        Validate("Shipping Insurance", "Shipping Insurance"::" ");
                    end;

                    if CurrFieldNo = FieldNo("E-Ship Agent Code") then
                        if "E-Ship Agent Code" <> '' then
                            Validate("Shipping Agent Code", "E-Ship Agent Code")
                        else
                            Validate("Shipping Agent Code", SalesHeader."Shipping Agent Code");

                    if "Shipping Payment Type" = "Shipping Payment Type"::Prepaid then
                        Validate("Third Party Ship. Account No.", '')
                    else
                        if ShippingAccount.GetPrimaryShippingAccountNo(
                            "E-Ship Agent Code",
                            ShippingAccount."Ship-to Type"::Customer,
                            SalesHeader."Sell-to Customer No.",
                            SalesHeader."Ship-to Code")
                        then
                            Validate("Third Party Ship. Account No.", ShippingAccount."Account No.")
                        else
                            Validate("Third Party Ship. Account No.", '');
                end;
            end;
        }

        field(14000721; "E-Ship Agent Service"; Code[30])
        {
            Caption = 'E-Ship Agent Service';

            trigger OnValidate()
            begin
                GetSalesHeader();

                if "E-Ship Agent Service" <> '' then begin
                    TestField("E-Ship Agent Code");
                    ShippingAgent.Get("E-Ship Agent Code");
                    EShipAgentService.ValidateEShipAgentService(ShippingAgent, "E-Ship Agent Service", SalesHeader."Ship-to Country/Region Code");
                end;
            end;

            trigger OnLookup()
            begin
                GetSalesHeader();
                TestField("E-Ship Agent Code");
                ShippingAgent.Get("E-Ship Agent Code");
                EShipAgentService.LookupEShipAgentService(ShippingAgent, "E-Ship Agent Service", SalesHeader."Ship-to Country/Region Code");
                if PAGE.RunModal(0, EShipAgentService) = Action::LookupOK then
                    Validate("E-Ship Agent Service", EShipAgentService.Code);
            end;
        }

        field(14000722; "Shipping Payment Type"; Option)
        {
            Caption = 'Shipping Payment Type';
            OptionCaption = 'Prepaid,Third Party,Freight Collect,Consignee';
            OptionMembers = Prepaid,ThirdParty,FreightCollect,Consignee;

            trigger OnValidate()
            begin
                GetSalesHeader();

                if "Shipping Payment Type" = "Shipping Payment Type"::Prepaid then
                    Validate("Third Party Ship. Account No.", '')
                else
                    if ShippingAccount.GetPrimaryShippingAccountNo(
                        "E-Ship Agent Code",
                        ShippingAccount."Ship-to Type"::Customer,
                        SalesHeader."Sell-to Customer No.",
                        SalesHeader."Ship-to Code")
                    then
                        Validate("Third Party Ship. Account No.", ShippingAccount."Account No.");
            end;
        }

        field(14000723; "Third Party Ship. Account No."; Code[20])
        {
            Caption = 'Third Party Ship. Account No.';

            trigger OnValidate()
            begin
                GetSalesHeader();
                ShippingAccount."Shipping Agent Code" := "E-Ship Agent Code";
                ShippingAccount.TestShippingAccountNo("Third Party Ship. Account No.");

                if ("Third Party Ship. Account No." <> '') and
               ("Shipping Payment Type" <> "Shipping Payment Type"::Prepaid) then begin
                    Clear(ShippingAccount);

                    if not ShippingAccount.Get(
                        ShippingAccount."Ship-to Type"::Customer,
                        SalesHeader."Sell-to Customer No.",
                        SalesHeader."Ship-to Code",
                        "E-Ship Agent Code",
                        "Third Party Ship. Account No.") then begin
                        ShippingAccount.Reset();
                        ShippingAccount.SetCurrentKey("Shipping Agent Code", "Account No.");
                        ShippingAccount.SetRange("Shipping Agent Code", "E-Ship Agent Code");
                        ShippingAccount.SetRange("Account No.", "Third Party Ship. Account No.");
                        if not ShippingAccount.Find('-') then;
                    end;

                    if (ShippingAccount."Account No." <> '') and
                       ("Shipping Payment Type" <> "Shipping Payment Type"::Prepaid) then
                        "Shipping Insurance" := ShippingAccount."Shipping Insurance";
                end;
            end;

            trigger OnLookup()
            begin
                GetSalesHeader();

                if ShippingAccount.LookupThirdPartyAccountNo(
                    "E-Ship Agent Code",
                    ShippingAccount."Ship-to Type"::Customer,
                    SalesHeader."Sell-to Customer No.",
                    SalesHeader."Ship-to Code") then
                    Validate("Third Party Ship. Account No.", ShippingAccount.GetLookupAccountNo);
            end;
        }

        field(14000724; "Shipping Insurance"; Option)
        {
            Caption = 'Shipping Insurance';
            OptionCaption = ' ,Never,Always';
            OptionMembers = " ","Never","Always";
        }

        field(14000725; "E-Ship Invt. Outst. Qty (Base)"; Decimal)
        {
            Caption = 'E-Ship Invt. Outst. Qty (Base)';
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)"
        where(
            "Activity Type" = filter("Invt. Pick"),
            "Source Type" = const(37),
            "Source Subtype" = field("Document Type"),
            "Source No." = field("Document No."),
            "Source Line No." = field("Line No."),
            "Action Type" = filter(' ' | Take),
            "Breakbulk No." = filter(0)
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14000726; "E-Ship Invt. Outstanding Qty."; Decimal)
        {
            Caption = 'E-Ship Invt. Outstanding Qty.';
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding"
        where(
            "Activity Type" = filter("Invt. Pick"),
            "Source Type" = const(37),
            "Source Subtype" = field("Document Type"),
            "Source No." = field("Document No."),
            "Source Line No." = field("Line No."),
            "Action Type" = filter(' ' | Take),
            "Breakbulk No." = filter(0)
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
         */


        field(14017611; "Order Date"; Date)
        {
            Description = 'NV - FB';
        }

        field(14017612; "Manufacturer Code"; Code[50])
        {
            TableRelation = Manufacturer.Name;
        }

        field(14017614; "Tool Repair Tech"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code where("Repair Tech" = const(true));
        }

        field(14017615; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code where(Sales = const(true));
            Description = 'NV - FB';
        }

        field(14017616; "Inside Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code where("Inside Sales" = const(true));
            Description = 'NV - FB';
        }

        field(14017617; "NV Posting Date"; Date)
        {
        }

        field(14017618; "External Document No."; Code[20])
        {
            Description = 'NV - FB';
        }

        field(14017619; "Line Amount to Ship"; Decimal)
        {
            Editable = false;
        }

        field(14017620; "Line Amount to Invoice"; Decimal)
        {
            Editable = false;
        }

        field(14017621; "List Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }

        field(14017624; "Alt. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14017625; "Alt. Qty. UOM"; Code[10])
        {
            Editable = false;
        }

        field(14017626; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            var
                ItemUOMRec2: Record "Item Unit of Measure";
            begin
                if ItemUOMRec2.Get("No.", "Alt. Price UOM") then begin
                    Validate("Line Discount Amount", 0);
                    if ItemUOMRec2."Alt. Base Qty." = 0 then
                        Validate("Unit Price", "Alt. Price" * ItemUOMRec2."Qty. per Unit of Measure")
                    else
                        Validate("Unit Price", "Alt. Price" * ItemUOMRec2."Alt. Base Qty.");
                end;
                UpdateAmounts();
            end;
        }

        field(14017627; "Alt. Price UOM"; Code[10])
        {
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));

            trigger OnValidate()
            begin
                Validate("Alt. Price");
                Validate("Alt. Sales Cost");
            end;
        }
        field(14017628; "Alt. Sales Cost"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }

        field(14017631; "Net Unit Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }

        field(14017633; "Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            InitValue = false;
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }

        field(14017640; "Ship-to PO No."; Code[20])
        {
        }

        field(14017641; "Shipping Advice"; Option)
        {
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;

            trigger OnValidate()
            begin
                WhseValidateSourceLine.SalesLineVerifyChange(Rec, xRec);
            end;
        }

        field(14017642; "Purchase Order Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Purchase Line"
        where(
            Type = const(Item),
            "No." = field("No."),
            "Outstanding Quantity" = filter('<>0')
        ));
            Editable = true;
        }

        field(14017645; "Contract No."; Code[20])
        {
            TableRelation = "Price Contract" where("Customer No." = field("Sell-to Customer No."));
            Caption = 'NV - FB';
            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                if ("Contract No." <> xRec."Contract No.") then begin
                    if "Contract No." <> '' then begin
                        SalesHeader := GetSalesHeader();
                        TestField("Contract No.", SalesHeader."Contract No.");
                    end;
                    UpdateUnitPrice(FieldNo("Contract No."));
                end;
            end;
        }

        field(14017649; "Requisition Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Requisition Line"
        where(
            Type = field(Type),
            "No." = field("No.")
        ));
            Editable = false;
        }

        field(14017650; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(14017667; "Status"; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            Editable = false;
        }

        field(14017671; "Tag No."; Code[20])
        {
        }

        field(14017672; "Customer Bin"; Text[12])
        {
        }

        field(14017748; "Outstanding Gross Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017749; "Outstanding Net Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017750; "Line Gross Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14017751; "Line Net Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14017752; "Ship-to Code"; Code[10])
        {
            Description = 'NV - FB';
        }

        field(14017753; "Line Cost"; Decimal)
        {
            Editable = false;
        }

        field(14017756; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(14017757; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }

        field(14017758; "Vendor Item No."; Text[20])
        {
        }

        field(14017800; "Tool Repair Order No."; Code[20])
        {
        }

        field(14017903; "BOM Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component"
        where("Parent Item No." = field("No.")));
            Editable = false;
        }

        field(14017904; "Prod. Kit Order No."; Code[20])
        {
        }

        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV - FB';
        }

        field(37015331; "FB Line No."; Integer)
        {
            Description = 'NV - FB';
        }

        field(37015332; "FB Tag No."; Code[20])
        {
            Description = 'NV - FB';
        }

        field(37015333; "FB Customer Bin"; Code[20])
        {
            Description = 'NV - FB';
        }

        field(37015680; "Delivery Route"; Code[10])
        {
        }

        field(37015681; "Delivery Stop"; Code[10])
        {
        }



    }

    Var
        ShippingAgent: Record 291;
        SalesSetup: Record 311;
        NIFItemCrossRef: Record 5777;
        NVM: Codeunit 50021;
        WhseValidateSourceLine: Codeunit 5777;
        SalesPrice: Record 7002;
        RunFromEDI: Boolean;
        EDITemp: Boolean;
        Text14000701: Label 'Packages already exist for this line.';

    PROCEDURE CalcStdPackQty(Qty: Decimal): Decimal;
    BEGIN
        IF "LAX Qty. per Std. Pack" <> 0 THEN
            EXIT(ROUND(Qty / "LAx Qty. per Std. Pack", 0.00001))
        ELSE
            EXIT(0);
    END;

    PROCEDURE CalcPackageQty(Qty: Decimal): Decimal;
    BEGIN
        IF "LAX Std. Packs per Package" <> 0 THEN
            EXIT(ROUND(Qty / "LAX Std. Packs per Package", 0.00001))
        ELSE
            EXIT(0);
    END;

    PROCEDURE CalcEShipWhseOutstQtyBase(LocationPacking: Boolean; LocationCode: Code[10]) QtyBase: Decimal;
    VAR
        SalesLine: Record 37;
    BEGIN
        QtyBase := 0;

        SalesLine.COPY(Rec);
        IF LocationPacking THEN
            SalesLine.SETRANGE("Location Code", LocationCode);
        IF SalesLine.FIND('-') THEN
            REPEAT
                SalesLine.CALCFIELDS("LAX EShip Invt Outst Qty(Base)");
                //>> NF1.00:CIS.NG    10/12/16
                //IF (SalesLine."Qty. to Ship (Base)" = 0) OR (SalesLine."E-Ship Invt. Outst. Qty (Base)"<> 0)
                IF (SalesLine."Qty. to Ship (Base)" = 0) AND (SalesLine."LAX EShip Invt Outst Qty(Base)" <> 0)
                //<< NF1.00:CIS.NG    10/12/16
                THEN BEGIN
                    SalesLine.CALCFIELDS(
                      "LAX EShip Whse Outst.Qty(Base)", "LAX EShip Whse Ship. Qty(Base)");
                    QtyBase :=
                      QtyBase +
                      SalesLine."LAX EShip Whse Outst.Qty(Base)" + SalesLine."LAX EShip Whse Ship. Qty(Base)" +
                      SalesLine."LAX EShip Invt Outst Qty(Base)";
                END;
            UNTIL SalesLine.NEXT = 0;
    END;


    /*  LOCAL PROCEDURE UpdateRequiredShippingAgent();
     VAR
         RequiredShippingAgent: Record 14000722;
         ShippingAgent: Record 291;
         EShipAgentService: Record 14000708;
     BEGIN
         IF NOT "LAX Pack" THEN
             EXIT;

         CLEAR(RequiredShippingAgent);
         IF NOT RequiredShippingAgent.GET(Type, "No.", SalesHeader."Shipping Agent Code")
         THEN BEGIN
             RequiredShippingAgent.RESET;
             RequiredShippingAgent.SETRANGE(Type, Type);
             RequiredShippingAgent.SETRANGE(Code, "No.");
             RequiredShippingAgent.SETRANGE("Use for All Shipping Agents", TRUE);
             IF NOT RequiredShippingAgent.FIND('-') THEN
               ;
         END;

         IF RequiredShippingAgent."Shipping Agent Code" <> '' THEN BEGIN
             GetSalesHeader();

             VALIDATE("LAX Req. Shipping Agent Code", RequiredShippingAgent."Shipping Agent Code");
             ShippingAgent.GET("LAX Req. Shipping Agent Code");
             CASE TRUE OF
                 EShipAgentService.InternationalShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"):
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Required Int. Ship. Agent Serv");
                 EShipAgentService.UPSCanadianShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"):
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Req. UPS CA Ship. Agent Serv.");
                 EShipAgentService.UPSPuertoRicoShipment(ShippingAgent, SalesHeader."Ship-to Country/Region Code"):
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Req. UPS PR Ship. Agent Serv.");
                 ELSE
                     VALIDATE("LAX Req. E-Ship Agent Service", RequiredShippingAgent."Required Dom. Ship. Agent Serv");
             END;
             VALIDATE("LAX Allow Other ShipAgent/Serv", RequiredShippingAgent."Allow Other Service");
         END;
     END;
  */
    PROCEDURE SetRunFromEDI(EDI: Boolean);
    BEGIN
        // >> EDI
        IF EDI THEN
            RunFromEDI := TRUE
        ELSE
            RunFromEDI := FALSE;
        // << EDI
    END;

    PROCEDURE SetEDITemp(EDI: Boolean);
    BEGIN
        // >> EDI
        IF EDI THEN
            EDITemp := TRUE
        ELSE
            EDITemp := FALSE;
        // << EDI
    END;

    PROCEDURE AllowInWarehousePosting(): Boolean;
    BEGIN
        EXIT("LAX Shipping Charge" OR ((Type = Type::Resource) AND "LAX Pack"));
    END;


    PROCEDURE "<<NIF fcn>>"();
    BEGIN
    END;

    PROCEDURE ShowSpecialFields();
    VAR
        SalesLine: Record 37;
        Specialfields: Page 50006;
    BEGIN
        IF (Type <> Type::Item) OR ("No." = '') THEN
            EXIT;
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "Document No.");
        SalesLine.SETRANGE("Line No.", "Line No.");
        Specialfields.SETTABLEVIEW(SalesLine);
        Specialfields.RUN();
    END;

    PROCEDURE CheckParcelQty(VAR OrderQty: Decimal): Boolean;
    VAR
        Item: Record 27;
        OrderMultiple: Decimal;
        ParcelOrderQty: Decimal;
        TextConst001: Label 'Item %1 has a Standard Net Pack of %2 .\', Comment = '%1=ItemNo.,%2=OrderMultiple';
        TextConst002: Label 'A quantity of %3 %7 would create an even Pack quantity of %4.\\', Comment = '%3=ParcleOrderQty,%7=ItemBaseUnitOfMeasure,%4=ParcelOrderQty DIV OrderMultiple';
        TextConst003: Label 'Do you want to change the quantity from %5 to %6?', Comment = '%5=OrderQty,%6=ParcelOrderQty';
    BEGIN
        //function passes and returns qty through variable
        //also returns TRUE if qty was changed
        //if qty is zero, exit
        IF OrderQty <= 1 THEN
            EXIT;

        //if no "Units per Parcel", then exit
        IF "Units per Parcel" = 0 THEN
            EXIT;

        Item.GET("No.");
        OrderMultiple := "Units per Parcel";

        //if multiple divides qty cleanly, exit
        IF OrderQty MOD OrderMultiple = 0 THEN
            EXIT;

        //otherwise, propose new qty
        ParcelOrderQty := ((OrderQty DIV OrderMultiple) + 1) * OrderMultiple;

        //exit if not confirmed
        IF GUIALLOWED THEN  //NF1.00:CIS.NG  10/30/15
            IF NOT CONFIRM(
              STRSUBSTNO(TextConst001 + TextConst002 + TextConst003,
                             Item."No.", OrderMultiple,
                                ParcelOrderQty, ParcelOrderQty DIV OrderMultiple,
                                   OrderQty, ParcelOrderQty, Item."Base Unit of Measure"))
                 THEN
                EXIT;
        //NF1.00:CIS.NG  10/30/15

        //if confirmed, pass back new quantity
        OrderQty := ParcelOrderQty;

        EXIT(TRUE);
    END;

    PROCEDURE DeleteLineComments();
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //SalesLineCommentLine.RESET;
        //SalesLineCommentLine.SETRANGE("Document Type","Document Type");
        //SalesLineCommentLine.SETRANGE("No.","Document No.");
        //SalesLineCommentLine.SETRANGE("Doc. Line No.","Line No.");
        //SalesLineCommentLine.DELETEALL;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE UpdateSpecialOrderCost();
    var
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
    BEGIN
        SalesHeader := GetSalesHeader();
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
            "Unit Cost" :=
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCY(
                  GetDate(), SalesHeader."Currency Code",
                  "Unit Cost (LCY)", SalesHeader."Currency Factor"),
                  Currency."Unit-Amount Rounding Precision")
        END ELSE
            "Unit Cost" := "Unit Cost (LCY)";
    END;

    PROCEDURE InsertLineComments();
    VAR
        CommentLine: Record 97;
    BEGIN

        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.SETRANGE("Include in Sales Orders", TRUE);
        IF CommentLine.FIND('-') THEN
            REPEAT
            //>> NF1.00:CIS.CM 09-29-15
            //SalesLineCommentLine.INIT;
            //SalesLineCommentLine."Document Type" := "Document Type";
            //SalesLineCommentLine."No." := "Document No.";
            //SalesLineCommentLine."Doc. Line No." := "Line No.";
            //SalesLineCommentLine."Line No." := CommentLine."Line No.";
            //SalesLineCommentLine.Code := CommentLine.Code;
            //SalesLineCommentLine.Comment := CommentLine.Comment;
            //SalesLineCommentLine."Print On Quote" := CommentLine."Print On Sales Quote";
            //SalesLineCommentLine."Print On Pick Ticket" := CommentLine."Print On Pick Ticket";
            //SalesLineCommentLine."Print On Order Confirmation" := CommentLine."Print On Order Confirmation";
            //SalesLineCommentLine."Print On Shipment" := CommentLine."Print On Shipment";
            //SalesLineCommentLine."Print On Invoice" := CommentLine."Print On Sales Invoice";
            //SalesLineCommentLine.INSERT(TRUE);
            //<< NF1.00:CIS.CM 09-29-15
            UNTIL CommentLine.NEXT() = 0;

    END;

    PROCEDURE CheckIfLineComments(): Boolean;
    VAR
        CommentLine: Record 97;
    BEGIN
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.SETRANGE("Include in Sales Orders", TRUE);
        EXIT(CommentLine.FIND('-'));

    END;

    PROCEDURE GetAltUOM();
    VAR
        ItemUOMRec: Record 5404;
    BEGIN

        IF "Quantity (Base)" = 0 THEN EXIT;
        ItemUOMRec.RESET;
        ItemUOMRec.SETRANGE("Item No.", "No.");
        ItemUOMRec.SETRANGE("Sales Qty Alt.", TRUE);

        IF NOT ItemUOMRec.ISEMPTY THEN BEGIN
            ItemUOMRec.FIND('-');

            //>> NIF 03/17/0
            IF ItemUOMRec."Alt. Base Qty." < 1 THEN
                "Alt. Quantity" := "Quantity (Base)" / ItemUOMRec."Qty. per Unit of Measure"
            ELSE
                //<< NIF
                "Alt. Quantity" := "Quantity (Base)" * ItemUOMRec."Alt. Base Qty.";
            "Alt. Qty. UOM" := ItemUOMRec.Code;
            "Alt. Price UOM" := ItemUOMRec."Sales Price Per Alt.";
            //>> NIF 06-21-05
            //use current uom if existing one is blank
            //END
        END ELSE BEGIN
            "Alt. Quantity" := "Quantity (Base)" * "Qty. per Unit of Measure";
            "Alt. Qty. UOM" := "Unit of Measure Code";
            "Alt. Price UOM" := "Unit of Measure Code";
        END;
        //<< NIF 06-21-05 

    END;

    PROCEDURE GetAltPrice(CalledByFieldNo: Integer);
    VAR
        ItemUOMRec: Record 5404;
    BEGIN

        //>> NIF RTT 04-25-05
        //if alt. price was entered, then do not recalc
        IF (CalledByFieldNo = FIELDNO("Alt. Price")) THEN
            EXIT;
        //<< NIF RTT 04-25-05

        IF "Alt. Price UOM" = '' THEN EXIT;
        ItemUOMRec.GET("No.", "Alt. Price UOM");
        IF ItemUOMRec."Alt. Base Qty." <> 0 THEN BEGIN
            "Alt. Price" := ROUND("Net Unit Price" / ItemUOMRec."Alt. Base Qty.", 0.01, '>');
            "Alt. Sales Cost" := ROUND("Unit Cost" / ItemUOMRec."Alt. Base Qty.", 0.01, '>');
            //>> NIF 06-12-05
            //  END;
        END
        ELSE BEGIN
            "Alt. Price" := ROUND("Net Unit Price" / ItemUOMRec."Qty. per Unit of Measure", 0.01, '>');
            "Alt. Sales Cost" := ROUND("Unit Cost" / ItemUOMRec."Qty. per Unit of Measure", 0.01, '>');
        END;
        //<< NIF 06-12-05 

    END;

    PROCEDURE UpdateWeight();
    BEGIN

        "Line Gross Weight" := Quantity * "Gross Weight";
        "Line Net Weight" := Quantity * "Net Weight";
        "Outstanding Gross Weight" := "Outstanding Quantity" * "Gross Weight";
        "Outstanding Net Weight" := "Outstanding Quantity" * "Net Weight";

    END;

    PROCEDURE ShowVendor();
    VAR
        Vendor: Record 23;
        Item: Record 27;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN
            IF Item.GET("No.") AND (Item."Vendor No." <> '') THEN BEGIN
                Vendor.SETRANGE("No.", Item."Vendor No.");
                PAGE.RUN(PAGE::"Vendor Card", Vendor);
            END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE ShowItemVendor();
    VAR
        ItemVendor: Record 99;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            ItemVendor.SETRANGE("Item No.", "No.");
            PAGE.RUN(PAGE::"Item Vendor Catalog", ItemVendor);
        END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE ShowPurchaseOrderLines();
    VAR
        PurchLine: Record 39;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            PurchLine.SETRANGE(Type, PurchLine.Type::Item);
            PurchLine.SETRANGE("No.", "No.");
            PurchLine.SETFILTER("Outstanding Quantity", '<>0');
            PAGE.RUN(0, PurchLine);
        END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE ShowRequisitionLines();
    VAR
        ReqLine: Record 246;
    BEGIN
        //>> NF1.00:CIS.NG 09-01-15
        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            ReqLine.SETRANGE(Type, ReqLine.Type::Item);
            ReqLine.SETRANGE("No.", "No.");
            PAGE.RUN(0, ReqLine);
        END;
        //<< NF1.00:CIS.NG 09-01-15
    END;

    PROCEDURE HasTypeToFillMandatotyFields(): Boolean;
    BEGIN
        EXIT(Type <> Type::" ");
    END;

}
