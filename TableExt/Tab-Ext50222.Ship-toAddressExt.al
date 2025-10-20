tableextension 50222 "Ship-to Address Ext" extends "Ship-to Address"
{
    fields
    {
        modify("Shipping Agent Code")
        {
            trigger OnBeforeValidate()
            begin
                // >> Shipping
                SalesSetup.GET;
                IF ("Shipping Agent Code" <> xRec."Shipping Agent Code") AND SalesSetup."LAX Enable Shipping" THEN
                    IF "Shipping Agent Code" = '' THEN
                        "LAX E-Ship Agent Service" := ''
                    ELSE BEGIN
                        ShippingAgent.GET("Shipping Agent Code");
                        VALIDATE(
                          "LAX E-Ship Agent Service",
                          EShipAgentService.DefaultShipAgentService(ShippingAgent, "Country/Region Code"));

                        IF CurrFieldNo = FIELDNO("Shipping Agent Code") THEN
                            EShipAgentService.CheckNameAddressShipToAddress(ShippingAgent, Rec);
                    END;
                // << Shipping 
            end;
        }
        modify("Country/Region Code")
        {
            trigger OnBeforeValidate()
            begin
                // >> Shipping
                IF "Country/Region Code" <> xRec."Country/Region Code" THEN
                    IF "Shipping Agent Code" <> '' THEN BEGIN
                        xRec."Shipping Agent Code" := '';
                        VALIDATE("Shipping Agent Code");
                    END;
                // << Shipping
            end;
        }
        modify("E-Mail")
        {
            trigger OnBeforeValidate()
            begin
                // >> Shipping
                IF "E-Mail" <> '' THEN BEGIN
                    SalesSetup.GET();

                    IF SalesSetup."LAX Enable E-Mail" THEN
                        EMailListEntry.InsertNewEMailListEntry(
                          Contact, "E-Mail", DATABASE::"Ship-to Address", 0, "Customer No.", Code, TRUE);
                END;
                // << Shipping 
            end;
        }
        field(50000; "Freight Code"; Code[10])
        {
            // cleaned
            TableRelation = "Freight Code";
        }
        //TODO
        /*  field(14000352; "Effective Date"; Date)
         {
             Caption = 'Effective Date';
         }

         field(14000353; "Open Date"; Date)
         {
             Caption = 'Open Date';
         }

         field(14000354; "Close Date"; Date)
         {
             Caption = 'Close Date';
         }

         field(14000355; "Change Date"; Date)
         {
             Caption = 'Change Date';
         }

         field(14000356; "EDI Internal Doc. No."; Code[10])
         {
             Caption = 'EDI Internal Doc. No.';
             Editable = false;
         }

         field(14000357; "Dist. Center Ext. Code"; Code[10])
         {
             Caption = 'Dist. Center Ext. Code';
         }

         field(14000701; "E-Ship Agent Service"; Code[30])
         {
             TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));

             // Placeholder for OnValidate logic
             trigger OnValidate()
             var
                 ShippingAgent: Record "Shipping Agent";
                 EShipAgentService: Codeunit "E-Ship Agent Service";
             begin
                 if "E-Ship Agent Service" <> '' then begin
                     TESTFIELD("Shipping Agent Code");
                     ShippingAgent.GET("Shipping Agent Code");
                     EShipAgentService.ValidateEShipAgentService(ShippingAgent, "E-Ship Agent Service", "Country/Region Code");

                     if EShipAgentService."Default Shipping Agent Service" <> '' then
                         if "Shipping Agent Service Code" <> EShipAgentService."Default Shipping Agent Service" then
                             VALIDATE("Shipping Agent Service Code", EShipAgentService."Default Shipping Agent Service");
                 end;
             end;

             trigger OnLookup()
             var
                 ShippingAgent: Record "Shipping Agent";
                 EShipAgentService: Codeunit "E-Ship Agent Service";
             begin
                 TESTFIELD("Shipping Agent Code");
                 ShippingAgent.GET("Shipping Agent Code");
                 EShipAgentService.LookupEShipAgentService(ShippingAgent, "E-Ship Agent Service", "Country/Region Code");
                 if PAGE.RUNMODAL(0, EShipAgentService) = ACTION::LookupOK then
                     VALIDATE("E-Ship Agent Service", EShipAgentService.Code);
             End;
         }
  
        field(14000702; "Free Freight"; Boolean)
        {
            Caption = 'Free Freight';

            trigger OnValidate()
            begin
                if not "Free Freight" then
                    "No Free Freight Lines on Order" := false;
            end;
        }

        field(14000703; "Residential Delivery"; Boolean)
        {
            Caption = 'Residential Delivery';
        }

        field(14000704; "Blind Shipment"; Boolean)
        {
            Caption = 'Blind Shipment';

            trigger OnValidate()
            begin
                if "Blind Shipment" then
                    "Double Blind Shipment" := false;
            end;
        }

        field(14000705; "Double Blind Ship-from Cust No"; Code[20])
        {
            Caption = 'Double Blind Ship-from Cust No';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if "Double Blind Ship-from Cust No" <> '' then
                    TESTFIELD("Double Blind Shipment");
            end;
        }

        field(14000706; "Double Blind Shipment"; Boolean)
        {
            Caption = 'Double Blind Shipment';

            trigger OnValidate()
            begin
                if "Double Blind Shipment" then
                    "Blind Shipment" := false
                else
                    "Double Blind Ship-from Cust No" := '';
            end;
        }

        field(14000707; "No Free Freight Lines on Order"; Boolean)
        {
            Caption = 'No Free Freight Lines on Order';

            trigger OnValidate()
            begin
                TESTFIELD("Free Freight");
            end;
        }

        field(14000708; "Shipping Payment Type"; Option)
        {
            Caption = 'Shipping Payment Type';
            OptionCaption = 'Prepaid,Third Party,Freight Collect,Consignee';
            OptionMembers = Prepaid,"Third Party","Freight Collect",Consignee;

            trigger OnValidate()
            var
                ShippingAgent: Record "Shipping Agent";
                ShippingAccount: Codeunit "Shipping Account";
            begin
                if ShippingAgent.GET("Shipping Agent Code") then
                    ShippingAccount.ValidateShippingAccount(
                        ShippingAgent,
                        "Shipping Payment Type",
                        ShippingAccount."Ship-to Type"::Customer,
                        "Customer No.",
                        Code
                    );
            end;
        }

        field(14000709; "Shipping Insurance"; Option)
        {
            Caption = 'Shipping Insurance';
            OptionCaption = ' ,Never,Always';
            OptionMembers = " ",Never,Always;
        }
        field(14000821; "External No."; Code[20])
        {
            Caption = 'External No.';
        }

        field(14000822; "Distribition Center"; Boolean)
        {
            Caption = 'Distribition Center';

            trigger OnValidate()
            begin
                TESTFIELD("Dist. Center Ship-to Code", '');
            end;
        }

        field(14000823; "Dist. Center Ship-to Code"; Code[20])
        {
            Caption = 'Dist. Center Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));

            trigger OnValidate()
            begin
                TESTFIELD("Distribition Center", false);
            end;
        }

        field(14000841; "Packing Rule Code"; Code[10])
        {
            Caption = 'Packing Rule Code';
            TableRelation = "Packing Rule";
        }

        field(14000901; "E-Mail Rule Code"; Code[10])
        {
            Caption = 'E-Mail Rule Code';
            TableRelation = "E-Mail Rule";
        }

        field(14017610; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        */
        //TODO

        field(14017617; "Inside Salesperson"; Code[10])
        {
            Caption = 'Inside Salesperson';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(true), Sales = CONST(true));
        }

        field(14017650; "Broker/Agent Code"; Code[10])
        {
            Caption = 'Broker/Agent Code';
            Description = 'NF1.00:CIS.NG  10-10-15';
        }

        field(37015680; "Delivery Route"; Code[10])
        {
            Caption = 'Delivery Route';
        }

        field(37015681; "Delivery Stop"; Code[10])
        {
            Caption = 'Delivery Stop';
        }


    }
    var
        ShippingAgent: Record 291;
        EShipAgentService: Record 14000708;
        SalesSetup: Record 311;
        EMailListEntry: Record 14000908;
        ShippingAccount: Record 14000714;

    trigger OnAfterInsert()
    var
        Cust: Record Customer;
    begin
        Cust.GET("Customer No.");
        // >> Shipping
        "Shipping Agent Code" := Cust."Shipping Agent Code";
        "LAX E-Ship Agent Service" := Cust."LAX E-Ship Agent Service";
        "LAX Free Freight" := Cust."LAX Free Freight";
        "LAX Residential Delivery" := Cust."LAX Residential Delivery";
        "LAX Blind Shipment" := Cust."LAX Blind Shipment";
        "LAX Dbl Blind Ship-from CustNo" := Cust."LAX Dbl Blind Ship-from CustNo";
        "LAX Double Blind Shipment" := Cust."LAX Double Blind Shipment";
        "LAX No Free Frght Lines on Ord" := Cust."LAX No Free Frght Lines on Ord";
        "LAX Packing Rule Code" := Cust."LAX Packing Rule Code";
        "LAX Shipping Payment Type" := Cust."LAX Shipping Payment Type";
        "LAX Shipping Insurance" := Cust."LAX Shipping Insurance";
        // << Shipping 
    end;

    trigger OnDelete()
    begin
        // >> Shipping
        EMailListEntry.RESET;
        EMailListEntry.SETRANGE("Table ID", DATABASE::"Ship-to Address");
        EMailListEntry.SETRANGE(Type, 0);
        EMailListEntry.SETRANGE(Code, "Customer No.");
        EMailListEntry.SETRANGE("Code 2", Code);
        EMailListEntry.DELETEALL();

        ShippingAccount.RESET;
        ShippingAccount.SETRANGE("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
        ShippingAccount.SETRANGE("Ship-to No.", "Customer No.");
        ShippingAccount.SETRANGE("Ship-to Code", Code);
        ShippingAccount.DELETEALL();
        // << Shipping 
    end;
}
