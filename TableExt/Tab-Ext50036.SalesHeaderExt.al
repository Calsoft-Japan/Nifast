tableextension 50036 "Sales Header Ext" extends "Sales Header"
{
    DrillDownPageId = "Sales List";
    fields
    {
        field(50000; "Freight Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Freight Code";
            Caption = 'Freight Code';
        }
        field(50001; "Date Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'CIS.001 Added as Biztalk is gone';
            Caption = 'Date Sent';
        }
        field(50002; "Time Sent"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Time Sent';
        }
        field(50003; "ASN Ship-to Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'ASN Ship-to Code';
        }
        field(50005; "Model Year"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Model Year".Code where("Customer No." = field("Sell-to Customer No."));
            Caption = 'Model Year';

            trigger OnValidate();
            begin
                //>>NIF 07-06-05
                Rec.UpdateSalesLines(FieldCaption("Model Year"), false);
                //<<NIF 07-06-05
            end;
        }
        field(50006; "SCAC Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'SCAC Code';
        }
        field(50007; "Mode of Transport"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mode of Transport';
        }
        field(50051; "Ship Authorization No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ship Authorization No.';
        }
        field(50200; "PPS Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'PPS Order';
        }
        field(50205; "PPS File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'PPS File Name';
        }
        field(50206; "EDI PO ID"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EDI.01';
            Editable = false;
            Caption = 'EDI PO ID';
        }
        field(50207; "EDI Batch ID"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EDI.01';
            Editable = false;
            Caption = 'EDI Batch ID';
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
            trigger OnValidate();
            begin
                //-AKK1606.01--
                Rec.UpdateSalesLines(Rec.FieldCaption("Entry/Exit Date"), true);
                //+AKK1601.01++
            end;
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
            trigger OnValidate();
            begin
                //-AKK1606.01--
                Rec.UpdateSalesLines(Rec.FieldCaption("Entry/Exit No."), true);
                //+AKK1601.01++
            end;
        }
        field(51000; "Blanket Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const("Blanket Order"));
            Caption = 'Blanket Order No.';
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mex. Factura No.';
            trigger OnValidate();
            var
                SlsHdr2: Record "Sales Header";
                SlsInv: Record "Sales Invoice Header";
                CLE: Record "Cust. Ledger Entry";
            begin
                //>>NIF 050806 MAK #10775
                if STRPOS(COMPANYNAME, 'Mexi') <> 0 then begin
                    if "Mex. Factura No." <> '' then begin
                        SlsHdr2.SETFILTER("No.", '<>%1', "No.");
                        SlsHdr2.SETRANGE("Mex. Factura No.", "Mex. Factura No.");
                        if not SlsHdr2.IsEmpty() then
                            ERROR('Mex. Factura No. %1 is already used on %2 %3', "Mex. Factura No.", FORMAT(SlsHdr2."Document Type"),
                                   FORMAT(SlsHdr2."No."));
                    end;
                    if "Mex. Factura No." <> '' then begin
                        SlsInv.SETRANGE("Mex. Factura No.", "Mex. Factura No.");
                        if not SlsInv.IsEmpty() then
                            ERROR('Mex. Factura No. %1 is already used on Posted Invoice %2', "Mex. Factura No.", FORMAT(SlsInv."No."));
                    end;
                    if "Mex. Factura No." <> '' then begin
                        CLE.SETRANGE("Mex. Factura No.", "Mex. Factura No.");
                        if not CLE.IsEmpty() then
                            ERROR('Mex. Factura No. %1 is in use elsewhere in the system!');
                    end;
                end;
                //<<NIF 050806 MAK #10775
            end;

        }
        field(60000; "EDI Control No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'EDI Control No.';
        }
        field(60001; "EDI No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'EDI No. Series';
        }
        field(60101; "Plant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plant Code';
            trigger OnValidate();
            begin
                //>>NIF 07-06-05
                Rec.UpdateSalesLines(Rec.FieldCaption("Plant Code"), false);
                //<<NIF 07-06-05
            end;
        }
        field(60102; "Dock Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dock Code';
            trigger OnValidate();
            begin
                //>>NIF 07-06-05
                Rec.UpdateSalesLines(Rec.FieldCaption("Dock Code"), false);
                //<<NIF 07-06-05
            end;
        }

        field(50004; "Third Party Ship. Account No."; Code[20])//BC Upgrade 14000717->50004
        {
            Caption = 'Third Party Ship. Account No.';
        }

        field(50008; "Inside Salesperson Code"; Code[10])//BC Upgrade 14017617->50008
        {
            Caption = 'Inside Salesperson Code';
        }
        field(70000; "Entered Date"; Date)
        {
        }
        field(70001; "Entered Time"; Time)
        {
        }
        field(70002; "Tool Repair Tech"; code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(true));
        }
        field(70003; "Phone No."; text[30])
        {
        }
        field(70004; "Fax No."; text[30])
        {
        }
        field(70005; "E-Mail"; text[80])
        {
        }
        field(70006; "Priority Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70007; "Ship-to PO No."; code[20])
        {
        }
        field(70008; "Contract No."; code[20])
        {
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
            trigger OnValidate()
            var
                Contract: Record "Price Contract";
                Cust: Record Customer;
            begin
                IF ("Sell-to Customer No." = xRec."Sell-to Customer No.") AND ("Contract No." = xRec."Contract No.") THEN
                    EXIT;

                //use Contract info if "Contract No." is not blank, else revert to customer defaults
                IF ("Contract No." <> '')
                THEN BEGIN
                    Contract.GET("Contract No.");

                    //shipping info
                    "Ship-to Name" := Contract."Ship-to Name";
                    "Ship-to Name 2" := Contract."Ship-to Name 2";
                    "Ship-to Address" := Contract."Ship-to Address";
                    "Ship-to Address 2" := Contract."Ship-to Address 2";
                    "Ship-to City" := Contract."Ship-to City";
                    "Ship-to Post Code" := Contract."Ship-to Post Code";
                    "Ship-to County" := Contract."Ship-to County";
                    VALIDATE("Ship-to Country/Region Code", Contract."Ship-to Country Code");
                    "Ship-to Contact" := Contract."Ship-to Contact";
                    "Shipment Method Code" := Contract."Shipment Method Code";
                    //>> NIF 07-06-05 RTT
                    //"Tax Area Code" := Contract."Tax Area Code";
                    //"Tax Liable" := Contract."Tax Liable";
                    IF Contract."Tax Area Code" <> '' THEN BEGIN
                        "Tax Area Code" := Contract."Tax Area Code";
                        "Tax Liable" := Contract."Tax Liable";
                    END;
                    //<< NIF 07-06-05 RTT
                    IF Contract."Location Code" <> '' THEN
                        VALIDATE("Location Code", Contract."Location Code");
                    //>> NIF 07-06-05 RTT
                    //"Shipping Agent Code" := Contract."Shipping Agent Code";
                    IF Contract."Shipping Agent Code" <> '' THEN "Shipping Agent Code" := Contract."Shipping Agent Code";
                    //<< NIF 07-06-05 RTT
                    "Shipping Agent Service Code" := Contract."Shipping Agent Service Code";
                    "Phone No." := Contract."Phone No.";
                    //>> NIF 07-06-05 RTT
                    //IF Contract."Tax Area Code" <> '' THEN
                    //  "Tax Area Code" := Contract."Tax Area Code";
                    //"Tax Liable" := Contract."Tax Liable";
                    //<< NIF 07-06-05 RTT
                    IF Contract."Phone No." <> '' THEN "Phone No." := Contract."Phone No.";
                    IF Contract."Salesperson Code" <> '' THEN "Salesperson Code" := Contract."Salesperson Code";
                    IF Contract."Inside Salesperson" <> '' THEN "Inside Salesperson Code" := Contract."Inside Salesperson";
                    IF Contract."Broker/Agent Code" <> '' THEN "Broker/Agent Code" := Contract."Broker/Agent Code";

                    //invoicing/other info
                    IF Contract."Payment Terms Code" <> '' THEN VALIDATE("Payment Terms Code", Contract."Payment Terms Code");
                    IF Contract."External Document No." <> '' THEN VALIDATE("External Document No.", Contract."External Document No.");
                END ELSE BEGIN
                    //restore default shipping info
                    GetCust("Sell-to Customer No.");
                    VALIDATE("Ship-to Code", Cust."Default Ship-To Code");

                    //restore default billing info
                    GetCust("Bill-to Customer No.");
                    VALIDATE("Payment Terms Code", Cust."Payment Terms Code");
                    "External Document No." := '';
                END;

                //now, recreate sales lines
                IF ("Contract No." <> xRec."Contract No.") AND ("Sell-to Customer No." = xRec."Sell-to Customer No.") THEN
                    RecreateSalesLines(FIELDCAPTION("Contract No."));


                IF xRec."Shipping Agent Code" <> "Shipping Agent Code" THEN
                    MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Code"));
                IF xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code" THEN
                    MessageIfSalesLinesExist(FIELDCAPTION("Shipping Agent Service Code"));
                IF xRec."Tax Liable" <> "Tax Liable" THEN
                    VALIDATE("Tax Liable");
            end;
        }
        field(70009; "Quote Expiration Date"; Date)
        {
        }
        field(70010; "NV Quote No."; code[20])
        {
        }
        field(70011; "Return No."; code[20])
        {
        }
        field(70012; "Broker/Agent Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70013; "Outstanding Gross Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Gross Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                                  "Document No." = FIELD("No.")));
            Editable = false;
        }
        field(70014; "Outstanding Net Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Gross Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                                  "Document No." = FIELD("No.")));
            Editable = false;
        }
        field(70015; "Sales Desk Worksheet"; Boolean)
        {
            trigger OnValidate()
            begin
                IF "Document Type" <> "Document Type"::Quote THEN ERROR('Document Type must be Quote');
            end;
        }
        field(70016; "Sales Counter Invoice"; Boolean)
        {
            trigger OnValidate()
            begin
                IF "Document Type" <> "Document Type"::Invoice THEN ERROR('Document Type must be Invoice');
            end;
        }
        field(70017; "Tool Repair Priority"; Boolean)
        {
        }
        field(70018; "Manufacturer Code"; code[5])
        {
            TableRelation = Manufacturer.Code;
        }
        field(70019; "Serial No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            begin
                //>> NF1.00:CIS.CM 09-29-15
                //IF Tool.GET("Manufacturer Code","Serial No.") THEN BEGIN
                // IF Tool.Stolen THEN MESSAGE('Tool has been reported STOLEN');
                // "Tool Model No." := Tool."Tool Model No.";
                // "Tool Item No." := Tool."Tool Item No.";
                // "Tool Description" := Tool.Description;
                //END;
                //<< NF1.00:CIS.CM 09-29-15
            end;
        }
        field(70020; "Tool Model No."; code[20])
        {
        }
        field(70021; "Tool Item No."; code[20])
        {
            TableRelation = Item."No.";
        }
        field(70022; "Tool Description"; Text[50])
        {
        }
        field(70023; "Tool Repair Ticket"; Boolean)
        {
        }
        field(70024; "No;Tool Repair Status"; code[10])
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }
        field(70025; "Tool Repair Parts Warranty"; DateFormula)
        {
        }
        field(70026; "Tool Repair Labor Warranty"; DateFormula)
        {
        }
        field(70027; "No;Cr. Mgmt. Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }
        field(70028; "FB Order No."; code[20])
        {
        }
        field(70029; "Delivery Route"; code[10])
        {
            trigger OnValidate()
            begin
                UpdateSalesLines(FIELDCAPTION("Delivery Route"), FALSE);
            end;
        }
        field(70030; "Delivery Stop"; code[10])
        {
            trigger OnValidate()
            begin
                UpdateSalesLines(FIELDCAPTION("Delivery Stop"), FALSE);
            end;
        }
    }
    procedure InsertCustomerComments(Cust2: Record Customer);
    var
        SOComments: Record "Sales Comment Line";
        CustComments: Record "Comment Line";
        LineNo: Integer;
        NIFText001: Label 'Existing Comment Lines have been deleted and\';
        NIFText002: Label 'replaced with comments from the current Sell-To Customer. \\';
        NIFText003: Label 'Please review any new comment lines.';
    begin
        CustComments.SETRANGE("Table Name", CustComments."Table Name"::Customer);
        CustComments.SETRANGE("No.", Cust2."No.");
        //CustComments.SETRANGE("Include in Sales Orders", true); //TODO
        LineNo := 100;
        //>>NIF MAK 071205                  //NOTE: This section will delete any existing ORDER comments in case the customer no. changes
        if CustComments.FIND('-') then begin
            SOComments.SETRANGE("Document Type", "Document Type");
            SOComments.SETRANGE("No.", "No.");
            if SOComments.FIND('-') then begin
                SOComments.DELETEALL();
                MESSAGE(NIFText001 + NIFText002 + NIFText003);
            end;
        end;
        //<<NIF MAK 071205
        if CustComments.FIND('-') then
            repeat
                SOComments.INIT();
                SOComments."Document Type" := "Document Type";
                SOComments."No." := "No.";
                SOComments."Line No." := LineNo;
                SOComments.Date := WORKDATE();
                SOComments.Code := CustComments.Code;
                SOComments.Comment := CustComments.Comment;
                //>> NIF 06-28-05 RTT

                SOComments."Print On Quote" := CustComments."Print On Sales Quote";
                SOComments."Print On Pick Ticket" := CustComments."Print On Pick Ticket";
                SOComments."Print On Order Confirmation" := CustComments."Print On Order Confirmation";
                SOComments."Print On Shipment" := CustComments."Print On Shipment";
                SOComments."Print On Invoice" := CustComments."Print On Sales Invoice";
                SOComments."Print On Credit Memo" := false;
                SOComments."Print On Return Authorization" := false;
                SOComments."Print On Return Receipt" := false;
                //<< NIF 06-28-05 RTT

                SOComments.INSERT(true);
                LineNo := LineNo + 100;
            until CustComments.NEXT() = 0;
    end;

    procedure GetMultipleContacts(CustomerNo: Code[20]; NameText: Text[30]): Text[30];
    var
    // SRSetup: Record 311;
    begin
        //SRSetup.GET; 
        // if SRSetup."Multiple Contacts" then begin
        //     //>> NF1.00:CIS.CM 09-29-15
        //     //MultipleContact.SETRANGE(Type,MultipleContact.Type::"0");
        //     //MultipleContact.SETRANGE("No.",CustomerNo);
        //     //IF PAGE.RUNMODAL(PAGE::Page14017613,MultipleContact) = ACTION::LookupOK THEN
        //     // EXIT(MultipleContact.Name);
        //     //<< NF1.00:CIS.CM 09-29-15
        // end;
        exit(NameText);
    end;
}
