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
            TableRelation = "Mex Export Pediment"."Pedimento Virtual No." WHERE("Customer No." = FIELD("No."));
        }
        field(50004; "Due Date Calculation"; DateFormula)
        {
            Description = 'NIF';
            FieldClass = FlowField;
            CalcFormula = Lookup("Payment Terms"."Due Date Calculation" WHERE("Code" = FIELD("Payment Terms Code")));
        }
        field(50005; "Default Model Year"; Code[10])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Customer Model Year".Code WHERE("Customer No." = FIELD("No."),
                                                                Default = CONST(True)));
            TableRelation = "Customer Model Year".Code WHERE("Customer No." = FIELD("No."));
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
            CalcFormula = Count(Customer WHERE("Master Customer No." = FIELD("Master Customer No.")));
        }
        field(50102; "Master Customer Name"; Text[100])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Master Customer No.")));
        }
        field(50500; "Original No."; Code[30])
        {
            Description = 'NIF';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("NIF Cross Reference"."Orig. No." WHERE(Type = FILTER(Customer)));

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
                IF "Country/Region Code" <> xRec."Country/Region Code" THEN
                    IF "Shipping Agent Code" <> '' THEN BEGIN
                        xRec."Shipping Agent Code" := '';
                        VALIDATE("Shipping Agent Code");
                    END;
                // << Shipping
            end;
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

    // PROCEDURE MasterAmount(CalcType: 'Balance Balance (LCY),Balance Due,Balance Due (LCY),Outstanding Orders (LCY),Shipped Not Invoiced (LCY)'): Decimal;
    // VAR
    //     Cust: Record 18;
    //     FilterString: Text[1024];
    //     TotalAmount: Decimal;
    //     UseAmount: Decimal;
    // BEGIN
    //     IF "Master Customer No." = '' THEN
    //         EXIT;     //JRR

    //     Cust.SETCURRENTKEY("Master Customer No.");
    //     COPYFILTER("Date Filter", Cust."Date Filter");
    //     COPYFILTER("Global Dimension 1 Filter", Cust."Global Dimension 1 Filter");
    //     COPYFILTER("Global Dimension 2 Filter", Cust."Global Dimension 2 Filter");
    //     COPYFILTER("Currency Filter", Cust."Currency Filter");

    //     Cust.SETFILTER("No.", BuildMasterFilterString());
    //     Cust.FIND('-');
    //     REPEAT
    //         CASE CalcType OF
    //             CalcType::Balance:
    //                 BEGIN          //0
    //                     Cust.CALCFIELDS(Balance);
    //                     UseAmount := Cust.Balance;
    //                 END;
    //             CalcType::"Balance (LCY)":
    //                 BEGIN  //1
    //                     Cust.CALCFIELDS("Balance (LCY)");
    //                     UseAmount := Cust."Balance (LCY)";
    //                 END;
    //             CalcType::"Balance Due":
    //                 BEGIN    //2
    //                     Cust.CALCFIELDS("Balance Due");
    //                     UseAmount := Cust."Balance Due";
    //                 END;
    //             CalcType::"Balance Due (LCY)":
    //                 BEGIN    //3
    //                     Cust.CALCFIELDS("Balance Due (LCY)");
    //                     UseAmount := Cust."Balance Due (LCY)";
    //                 END;
    //             CalcType::"Outstanding Orders (LCY)":
    //                 BEGIN     //4

    //                     //WC1.01.Begin
    //                     //Cust.CALCFIELDS("Outstanding Orders (LCY)");
    //                     //UseAmount := Cust."Outstanding Orders (LCY)";
    //                     //WC1.01.End
    //                     UseAmount := CalcReleaseOrderOutAmt(Cust);

    //                 END;
    //             CalcType::"Shipped Not Invoiced (LCY)":
    //                 BEGIN   //5
    //                     Cust.CALCFIELDS("Shipped Not Invoiced (LCY)");
    //                     UseAmount := Cust."Shipped Not Invoiced (LCY)";
    //                 END;
    //         END;

    //         TotalAmount := TotalAmount + UseAmount;
    //     UNTIL Cust.NEXT = 0;

    //     EXIT(TotalAmount);
    // END;//TO dO

    PROCEDURE BuildMasterFilterString(): Text[1024];
    VAR
        FilterString: Text[1024];
        Cust: Record 18;
    BEGIN
        IF "Master Customer No." = '' THEN
            EXIT("No.");

        Cust.SETCURRENTKEY("Master Customer No.");
        Cust.SETRANGE("Master Customer No.", "Master Customer No.");
        IF Cust.ISEMPTY THEN
            EXIT("No.");

        Cust.FIND('-');
        REPEAT
            IF FilterString = '' THEN
                FilterString := Cust."No."
            ELSE
                FilterString := FilterString + '|' + Cust."No.";
        UNTIL Cust.NEXT = 0;

        EXIT(FilterString);
    END;

    PROCEDURE "Master Credit Limit"(): Decimal;
    VAR
        Cust: Record 18;
    BEGIN
        IF NOT Cust.GET("Master Customer No.") THEN
            EXIT("Credit Limit (LCY)")
        ELSE
            EXIT(Cust."Credit Limit (LCY)");
    END;

    PROCEDURE ShowMasterCustomerList();
    VAR
        Cust: Record 18;
    BEGIN
        IF "Master Customer No." = '' THEN
            Cust.SETRANGE("No.", "No.")
        ELSE
            Cust.SETFILTER("No.", BuildMasterFilterString());

        //  PAGE.RUN(PAGE::"Master Customer List",Cust); TODO
    END;

    PROCEDURE CalcReleaseOrderOutAmt(LcCust: Record 18): Decimal;
    VAR
        SalesHeader: Record 36;
        SalesLine: Record 37;
        OustandingAmt: Decimal;
    BEGIN
        //WC1.01.Begin
        OustandingAmt := 0;
        CLEAR(SalesHeader);
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("Bill-to Customer No.", LcCust."No.");
        //SalesHeader.SETRANGE(Status,SalesHeader.Status::Released);
        IF SalesHeader.FIND('-') THEN
            REPEAT
                IF (SONO = SalesHeader."No.") THEN BEGIN
                    CLEAR(SalesLine);
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine.CALCSUMS("Outstanding Amount (LCY)");
                    OustandingAmt += SalesLine."Outstanding Amount (LCY)";
                END ELSE BEGIN
                    IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                        CLEAR(SalesLine);
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.CALCSUMS("Outstanding Amount (LCY)");
                        OustandingAmt += SalesLine."Outstanding Amount (LCY)";
                    END;
                END;
            UNTIL SalesHeader.NEXT = 0;
        EXIT(OustandingAmt);
        //WC1.01.End
    END;

    PROCEDURE GetCurrentSO(LcSONo: Code[20]);
    BEGIN
        SONO := LcSONo;
    END;




    var
        SalesSetup: Record "Sales & Receivables Setup";
        SONO: Code[20];
}
