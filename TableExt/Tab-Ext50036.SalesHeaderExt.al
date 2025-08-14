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
