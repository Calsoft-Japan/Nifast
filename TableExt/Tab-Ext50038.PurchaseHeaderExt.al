tableextension 50038 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //>>IST 052005 DPC #9806
                PurchLine.RESET();
                PurchLine.SETRANGE("Document Type", "Document Type");
                PurchLine.SETRANGE("Document No.", "No.");
                PurchLine.SETFILTER(Quantity, '<>%1', 0);
                PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                PurchLine.MODIFYALL("Contract Note No.", "Contract Note No.");
                //<<IST 052005 DPC #9806
            end;
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //>>IST 052005 DPC #9806
                PurchLine.RESET;
                PurchLine.SETRANGE("Document Type", "Document Type");
                PurchLine.SETRANGE("Document No.", "No.");
                PurchLine.SETFILTER(Quantity, '<>%1', 0);
                PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                PurchLine.MODIFYALL("Exchange Contract No.", "Exchange Contract No.");
                //<<IST 052005 DPC #9806x
            end;
        }
        field(50002; "MOSP Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '4x contract #9806';

        }
        field(50004; "Total USD Value"; Decimal)
        {
            Description = 'Forex';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."USD Value" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                      "Document No." = FIELD("No.")));
        }
        field(50005; "Sail-on Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
            trigger OnValidate()
            begin
                PurchLine.RESET();
                PurchLine.SETRANGE("Document Type", "Document Type");
                PurchLine.SETRANGE("Document No.", "No.");
                PurchLine.SETFILTER(Quantity, '<>%1', 0);
                PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                PurchLine.SETRANGE("Sail-on Date", 0D);
                PurchLine.MODIFYALL("Sail-on Date", "Sail-on Date");

            end;
        }
        field(50007; "Vessel Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50008; "Assembly Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG  10/06/15';
            Editable = false;
            TableRelation = "Assembly Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(50020; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = ToBeClassified;
        }
        field(50030; "Ship by Date"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Aduana E/S';
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
            trigger OnValidate()
            begin
                //-AKK1606.01--
                UpdatePurchLines(FIELDCAPTION("Entry/Exit Date"), true);
                //+AKK1606.01++
            end;
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
            trigger OnValidate()
            begin
                //-AKK1606.01--
                UpdatePurchLines(FIELDCAPTION("Entry/Exit Date"), true);
                //+AKK1606.01++
            end;
        }
        field(60000; "Patente Orignal"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Custom Agent License No.';
        }
        field(60002; "Aduana E/S"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Customer Agent E/S';
        }
        field(60010; "Pediment No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Summary Entry No.';
        }
        field(60012; "CVE Pedimento"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Summary Entry Code';
        }
        field(60015; "Fecha de entrada"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Date of Entry';
        }
        field(60020; "Tipo Cambio (1 day before)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(60022; "Tipo Cambio (USD)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            trigger OnValidate()
            begin
                //>> NF1.00:CIS.NG    07/27/16
                IF CurrFieldNo = 0 THEN
                    SuspendStatusChk_gBln := TRUE;
                //>> NF1.00:CIS.NG    07/27/16

                //>>NIF 050506 RTT
                IF "Tipo Cambio (USD)" <> xRec."Tipo Cambio (USD)" THEN BEGIN
                    UpdateCurrencyFactor();
                    VALIDATE("Currency Factor");
                END;
                //<<NIF 050506 RTT

                //>> NF1.00:CIS.NG    07/27/16
                IF CurrFieldNo = 0 THEN
                    SuspendStatusChk_gBln := FALSE;
                //<< NF1.00:CIS.NG    07/27/16
            end;
        }
        field(60023; "Tipo Cambio (JPY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            trigger OnValidate()
            begin
                //>>NIF 050506 RTT
                IF "Tipo Cambio (JPY)" <> xRec."Tipo Cambio (JPY)" THEN BEGIN
                    UpdateCurrencyFactor();
                    VALIDATE("Currency Factor");
                END;
                //<<NIF 050506 RTT
            end;
        }
        modify("Currency Code")
        {
            trigger OnAfterValidate()
            begin
                //>>NIF 050506 RTT
                //>>NIF 032807
                //IF (STRPOS(COMPANYNAME,'Mexi')<>0) AND ("Document Type"="Document Type"::Order) THEN BEGIN
                IF (STRPOS(COMPANYNAME, 'Mexi') <> 0) AND
                  (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice)) THEN BEGIN
                    //<<NIF 032807
                    GLSetup.GET;
                    IF "Currency Code" = GLSetup."LCY Code" THEN BEGIN
                        VALIDATE("Tipo Cambio (USD)", 0);
                        VALIDATE("Tipo Cambio (JPY)", 0);
                    END ELSE IF "Currency Code" = GLSetup."Additional Reporting Currency" THEN
                            VALIDATE("Tipo Cambio (JPY)", 1);
                END;
                //<<NIF 050506 RTT

            end;
        }
        modify("Purchaser Code")
        {
            TableRelation = "Salesperson/Purchaser".Code;
            Description = 'NV';
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                PurchLine.SETRANGE("Sales Order Line No.");
                PurchLine.SETFILTER("Special Order Sales Line No.", '<>0');
                IF NOT PurchLine.ISEMPTY THEN
                    ERROR(
                      Text006,
                      FIELDCAPTION("Sell-to Customer No."));
            end;
        }

        modify("Order Address Code")
        {
            trigger OnBeforeValidate()
            VAR
                NVM: Codeunit 50021;
            begin
                //>>NV
                IF NVM.CheckSoftBlock(1, "Buy-from Vendor No.", "Order Address Code", '', "Document Type", SoftBlockError) THEN
                    ERROR(SoftBlockError);
                //<<NV
            end;
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                //>> NV
                UpdatePurchLines(FIELDCAPTION(Status), true);
                //<< NV

            end;
        }
        field(14017610; "Entered User ID"; cODE[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            //TestTableRelation =false;
            Description = '20-->50';
            trigger OnValidate()
            var
                LoginMgt: Codeunit 418;
            begin
                //LoginMgt.ValidateUserID("Entered User ID");
                LoginMgt.DisplayUserInformation("Entered User ID");
            end;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("Entered User ID");
                LoginMgt.DisplayUserInformation("Entered User ID");
            end;
        }
        field(14017611; "Entered Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14017612; "Entered Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(14017620; "Bill of Lading No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017621; "Carrier Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(14017622; "Carrier Trailer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017630; "Priority Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017640; "Ship-to PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017650; "Broker/Agent Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14017660; "Outstanding Gross Weight"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Gross Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                                     "Document No." = FIELD("No.")));
            Editable = false;
        }
        field(14017661; "Outstanding Net Weight"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Gross Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                                                                                     "Document No." = FIELD("No.")));
            Editable = FALSE;
        }
        field(14017930; "Rework No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017931; "Rework Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }


    trigger OnAfterInsert()
    begin
        //>>NV
        IF "Purchaser Code" = '' THEN BEGIN
            PurchRep.SETRANGE("Navision User ID", USERID);
            //PurchRep.SETRANGE(Purchase, TRUE);
            IF PurchRep.FIND('-') THEN
                "Purchaser Code" := PurchRep.Code;
        END;
        // VALIDATE("Entered User ID", USERID);
        // rec."Entered Date" := TODAY;
        // "Entered Time" := TIME;
        //<<NV
    end;

    var

        SuspendStatusChk_gBln: Boolean;
        SoftBlockError: Text[80];
        PurchRep: Record 13;
        GLSetup: Record "General Ledger Setup";
        Text006: Label 'ENU=You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1';

}

