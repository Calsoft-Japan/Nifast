tableextension 50018 "Customer Ext" extends "Customer"
{
    fields
    {
        field(50000; "Freight Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
            TableRelation = "Freight Code";
        }
        field(50001; "Custom Broker"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50002; "DUNS Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(50003; "Export Pediment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
            TableRelation = "Mex Export Pediment"."Pedimento Virtual No." where("Customer No." = field("No."));
        }
        field(50004; "Due Date Calculation"; DateFormula)
        {
            Description = 'NIF';
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Terms"."Due Date Calculation" where("Code" = field("Payment Terms Code")));
        }
        field(50005; "Default Model Year"; Code[10])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Customer Model Year".Code where("Customer No." = field("No."),
                                                                Default = const(true)));
            TableRelation = "Customer Model Year".Code where("Customer No." = field("No."));
        }
        field(50006; "SCAC Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Added on 9/29/17 for Canada ASN';
        }
        field(50007; "Mode of Transport"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Added on 9/29/17 for Canada ASN';
        }
        field(50008; "Japanese=A, Non Japanese=B"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Customs Clearance by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "EDI ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'VP EDI use';
        }
        field(50011; "CISCO Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CISCO Code';
        }
        field(50100; "Master Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(50101; "No. of Relations"; Integer)
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Master Customer No." = field("Master Customer No.")));
        }
        field(50102; "Master Customer Name"; Text[100])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Master Customer No.")));
        }
        field(50500; "Original No."; Code[30])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("NIF Cross Reference"."Orig. No." where(Type = filter(Customer)));

        }
        field(60000; "Port of Discharge"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF Puerto de Desembarque';
        }
        field(60005; "Pitex/Maquila No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        /* modify("Shipping Agent Code")
         {
             trigger OnAfterValidate()
             begin
                 // >> Shipping
                 SalesSetup.GET;
                 IF ("Shipping Agent Code" <> xRec."Shipping Agent Code") AND SalesSetup."Enable Shipping" THEN
                     IF "Shipping Agent Code" = '' THEN
                         "E-Ship Agent Service" := ''
                     ELSE BEGIN
                         ShippingAgent.GET("Shipping Agent Code");
                         VALIDATE(
                           "E-Ship Agent Service",
                           EShipAgentService.DefaultShipAgentService(ShippingAgent, "Country/Region Code"));

                         //ShippingAgent.SETRANGE(Code,"Shipping Agent Code");
                         "SCAC Code" := ShippingAgent."SCAC Code";
                         "Mode of Transport" := ShippingAgent."Mode of Transport";

                         IF CurrFieldNo = FIELDNO("Shipping Agent Code") THEN
                             EShipAgentService.CheckNameAddressCustomer(ShippingAgent, Rec);
                     END;
                 // << Shipping
             end;
         }*/
        modify("Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                // >> Shipping
                if "Country/Region Code" <> xRec."Country/Region Code" then
                    if "Shipping Agent Code" <> '' then begin
                        xRec."Shipping Agent Code" := '';
                        this.VALIDATE("Shipping Agent Code");
                    end;
                // << Shipping
            end;
        }
        field(70000; "Past Due Date"; Date)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Min("Cust. Ledger Entry"."Due Date" WHERE("Customer No." = FIELD("No."),
                                                                                                          "Document Type" = CONST(Invoice),
                                                                                                          Open = CONST(True)));
            Description = 'NV';
            Editable = false;
        }
        field(70001; "Review Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            Description = 'NV';
        }
        field(70002; "Call Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            Description = 'NV';
        }
        field(70003; "Hold Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            Description = 'NV';
        }
        field(70004; "Default Ship-To Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
            Description = 'NV - FB';
        }
        field(70005; "Account Opened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "Inside Salesperson"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(True),
                                                                                                   Sales = CONST(True));
        }
        field(70007; "Purchase Order Required"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Credit Update"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "Default Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("No."));
            Description = 'NV - FB';
        }
        field(70010; "Broker/Agent Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            ; Description = 'NV - FB NF1.00:CIS.NG  10-10-15';
        }
        field(70011; "Tool Repair Priority"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70012; "Tool Repair Tech"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(True));
            Description = 'NV';
        }
        field(70013; "No Cr. Mgmt. Comment"; Boolean)
        {
            // DataClassification = ToBeClassified;
            //FieldClass = FlowField;
            Description = 'NV    NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(70014; "Delivery Route"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NV - FB';
        }
        field(70015; "Delivery Stop"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NV-FB';
        }
        field(70016; "Default Contract Ending Date"; Date)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Lookup("Price Contract"."Ending Date" WHERE("No." = FIELD("Default Contract No.")));
        }

    }

    keys
    {
        key(MyFieldKey; "Master Customer No.")
        {

        }
    }
    trigger OnAfterInsert()
    begin
        //>>NIF 06-13-06  RTT      #11033
        "Master Customer No." := "No.";
        //<<NIF 06-13-06  RTT      #11033

    end;

    procedure MasterAmount(CalcType: Option Balance,"Balance (LCY)","Balance Due","Balance Due (LCY)","Outstanding Orders (LCY)","Shipped Not Invoiced (LCY)"): Decimal;
    var
        Cust: Record Customer;
        TotalAmount: Decimal;
        UseAmount: Decimal;
    begin
        if "Master Customer No." = '' then
            exit;     //JRR

        Cust.SETCURRENTKEY("Master Customer No.");
        this.COPYFILTER("Date Filter", Cust."Date Filter");
        this.COPYFILTER("Global Dimension 1 Filter", Cust."Global Dimension 1 Filter");
        this.COPYFILTER("Global Dimension 2 Filter", Cust."Global Dimension 2 Filter");
        this.COPYFILTER("Currency Filter", Cust."Currency Filter");

        Cust.SETFILTER("No.", this.BuildMasterFilterString());
        Cust.FIND('-');
        repeat
            case CalcType of
                CalcType::Balance:
                    begin          //0
                        Cust.CALCFIELDS(Balance);
                        UseAmount := Cust.Balance;
                    end;
                CalcType::"Balance (LCY)":
                    begin  //1
                        Cust.CALCFIELDS("Balance (LCY)");
                        UseAmount := Cust."Balance (LCY)";
                    end;
                CalcType::"Balance Due":
                    begin    //2
                        Cust.CALCFIELDS("Balance Due");
                        UseAmount := Cust."Balance Due";
                    end;
                CalcType::"Balance Due (LCY)":
                    begin    //3
                        Cust.CALCFIELDS("Balance Due (LCY)");
                        UseAmount := Cust."Balance Due (LCY)";
                    end;
                CalcType::"Outstanding Orders (LCY)":
                    UseAmount := this.CalcReleaseOrderOutAmt(Cust);

                CalcType::"Shipped Not Invoiced (LCY)":
                    begin   //5
                        Cust.CALCFIELDS("Shipped Not Invoiced (LCY)");
                        UseAmount := Cust."Shipped Not Invoiced (LCY)";
                    end;
            end;

            TotalAmount := TotalAmount + UseAmount;
        until Cust.NEXT() = 0;

        exit(TotalAmount);
    end;

    procedure BuildMasterFilterString(): Text[1024];
    var
        Cust: Record Customer;
        FilterString: Text[1024];
    begin
        if "Master Customer No." = '' then
            exit("No.");

        Cust.SETCURRENTKEY("Master Customer No.");
        Cust.SETRANGE("Master Customer No.", "Master Customer No.");
        if Cust.ISEMPTY then
            exit("No.");

        Cust.FIND('-');
        repeat
            if FilterString = '' then
                FilterString := Cust."No."
            else
                FilterString := FilterString + '|' + Cust."No.";
        until Cust.NEXT() = 0;

        exit(FilterString);
    end;

    procedure "Master Credit Limit"(): Decimal;
    var
        Cust: Record Customer;
    begin
        if not Cust.GET("Master Customer No.") then
            exit("Credit Limit (LCY)")
        else
            exit(Cust."Credit Limit (LCY)");
    end;

    procedure ShowMasterCustomerList();
    var
        Cust: Record 18;
    begin
        if "Master Customer No." = '' then
            Cust.SETRANGE("No.", "No.")
        else
            Cust.SETFILTER("No.", this.BuildMasterFilterString());

        //  PAGE.RUN(PAGE::"Master Customer List",Cust); TODO
    end;

    procedure CalcReleaseOrderOutAmt(LcCust: Record 18): Decimal;
    var
        SalesHeader: Record 36;
        SalesLine: Record 37;
        OustandingAmt: Decimal;
    begin
        //WC1.01.Begin
        OustandingAmt := 0;
        CLEAR(SalesHeader);
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("Bill-to Customer No.", LcCust."No.");
        //SalesHeader.SETRANGE(Status,SalesHeader.Status::Released);
        if SalesHeader.FIND('-') then
            repeat
                if (SONO = SalesHeader."No.") then begin
                    CLEAR(SalesLine);
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine.CALCSUMS("Outstanding Amount (LCY)");
                    OustandingAmt += SalesLine."Outstanding Amount (LCY)";
                end else
                    if SalesHeader.Status = SalesHeader.Status::Released then begin
                        CLEAR(SalesLine);
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.CALCSUMS("Outstanding Amount (LCY)");
                        OustandingAmt += SalesLine."Outstanding Amount (LCY)";
                    end;

            until SalesHeader.NEXT = 0;
        exit(OustandingAmt);
        //WC1.01.End
    end;

    procedure GetCurrentSO(LcSONo: Code[20]);
    begin
        SONO := LcSONo;
    end;




    var
        SalesSetup: Record "Sales & Receivables Setup";
        SONO: Code[20];
}
