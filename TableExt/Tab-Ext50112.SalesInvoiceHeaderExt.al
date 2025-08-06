tableextension 50112 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Freight Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Posted Shipment Posting Date"; Date)
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."Posting Date" WHERE("Order No." = FIELD("Order No.")));
        }
        field(50002; "Mex IVA"; Code[10])
        {
            DateFormula = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Manufacturer."IVA Code" WHERE(IVA = FIELD("Tax Liable")));
        }
        field(50003; "Exchange Rate"; Decimal)
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Currency Exchange Rate"."Relational Exch. Rate Amount" WHERE("Starting Date" = FIELD("Posting Date")));
        }
        field(50004; "Country Name"; Text[30])
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Country/Region".Name WHERE(Code = FIELD("Sell-to Country/Region Code")));
        }
        field(50005; "PSH#"; Code[20])
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."No." WHERE("Order No." = FIELD("Order No."),
                                                                                                         "No." = FILTER(<> 'PSH100619')));
        }
        field(50007; "FX Rate on Order Creation Date"; Decimal)
        {
            DecimalPlaces = 1 : 6;
            FieldClass = FlowField;
            CalcFormula = Lookup("Currency Exchange Rate"."Relational Exch. Rate Amount" WHERE("Currency Code" = FIELD("Currency Code"),
                                                                                                                                     "Starting Date" = FIELD("Order Date")));

        }
        field(50008; "Amount in C$ from G/L 600"; Decimal)
        {
            // cleaned
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry".Amount WHERE("Document No." = FIELD("No."),
                                                                                                "G/L Account No." = CONST('600')));
        }
        field(50009; "FX Rate on Inv Posting Date"; Decimal)
        {
            DecimalPlaces = 1 : 6;
            FieldClass = FlowField;
            CalcFormula = Lookup("Currency Exchange Rate"."Relational Exch. Rate Amount" WHERE("Currency Code" = FIELD("Currency Code"),
                                                                                                                                     "Starting Date" = FIELD("Posting Date")));
        }
        field(50010; "Amount from G/L 730(Add)"; Decimal)
        {
            Description = 'SM 03-11-20';
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = CONST('730'),
                                                                                                                   "Document No." = FIELD("No.")));

        }
        field(50011; "Amount from G/L 730(LCY)"; Decimal)
        {
            Description = 'SM 03-11-20';
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = CONST('730'),
                                                                                             "Document No." = FIELD("No.")));

        }
        field(50051; "Ship Authorization No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51000; "Blanket Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SlsHdr: Record 36;
                SlsInv2: Record 112;
                CLE: Record 21;
            begin
                //>>NIF 050806 MAK #10775
                IF STRPOS(COMPANYNAME, 'Mexi') <> 0 THEN BEGIN
                    IF "Mex. Factura No." <> '' THEN BEGIN
                        SlsHdr.SETRANGE("Mex. Factura No.", "Mex. Factura No.");
                        IF SlsHdr.FIND('-') THEN
                            ERROR('Mex. Factura No. %1 is already used on %2 %3', "Mex. Factura No.", FORMAT(SlsHdr."Document Type"),
                                  FORMAT(SlsHdr."No."));
                    END;
                    IF "Mex. Factura No." <> '' THEN BEGIN
                        SlsInv2.SETFILTER("No.", '<>%1', FORMAT("No."));
                        SlsInv2.SETRANGE("Mex. Factura No.", "Mex. Factura No.");
                        IF SlsInv2.FIND('-') THEN
                            ERROR('Mex. Factura No. %1 is already used on Posted Invoice %2', "Mex. Factura No.", FORMAT(SlsInv2."No."));
                    END;
                    IF "Mex. Factura No." <> '' THEN BEGIN
                        CLE.SETRANGE("Mex. Factura No.", "Mex. Factura No.");
                        IF CLE.FIND('-') THEN
                            ERROR('Mex. Factura No. %1 is in use elsewhere in the system!');
                    END;
                END;
                //<<NIF 050806 MAK #10775
            end;

        }
        field(52001; "Exclude from Virtual Inv."; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

        }
        field(60000; "EDI Control No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "EDI No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60101; "Plant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60102; "Dock Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Inside Salesperson Code"; Code[10])//NV-FB BC Upgrade From 14017617->50006
        { }
    }

    // PROCEDURE ExportSIInvtoTxt_gFnc(VAR SIHeader_vRec: Record 112);
    // VAR
    //     OutputFile_lFile: File;
    //     SalesReceivableSetup_lRec: Record 311;
    //     FileName_lTxt: Text[250];
    //     Stream: OutStream;
    //     Txt50150_lTxt: Label 'ENU=Sales Invoice %1 has been exported into Text file Successfully.';
    //     XMLP: XMLport 50010;
    //     Txt50151_lTxt: Label 'ENU=Sales Invoice %1 file is already been generated. Do you want to Process again?';
    // BEGIN
    //     //AKK1612.01-NS
    //     SalesReceivableSetup_lRec.GET;
    //     SalesReceivableSetup_lRec.TESTFIELD(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path");
    //     FileName_lTxt := FORMAT(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path") + '\' + 'SALINV' + SIHeader_vRec."No." + '.txt';
    //     IF FILE.EXISTS(FileName_lTxt) THEN BEGIN
    //         IF CONFIRM(Txt50151_lTxt, FALSE, SIHeader_vRec."No.") THEN BEGIN
    //             OutputFile_lFile.CREATE(FileName_lTxt);
    //             OutputFile_lFile.CREATEOUTSTREAM(Stream);
    //             XMLP.GetInvNo_gFnc(SIHeader_vRec."No.");
    //             //    XMLPORT.EXPORT(XMLPORT::"Export Sales Invoice to Txt",Stream,SIHeader_vRec);
    //             XMLP.SETTABLEVIEW(SIHeader_vRec);
    //             XMLP.SETDESTINATION(Stream);
    //             XMLP.EXPORT;
    //             OutputFile_lFile.CLOSE;
    //             MESSAGE(Txt50150_lTxt, SIHeader_vRec."No.");
    //         END;
    //     END ELSE BEGIN
    //         OutputFile_lFile.CREATE(FileName_lTxt);
    //         OutputFile_lFile.CREATEOUTSTREAM(Stream);
    //         XMLP.GetInvNo_gFnc(SIHeader_vRec."No.");
    //         //XMLPORT.EXPORT(XMLPORT::"Export Sales Invoice to Txt",Stream,SIHeader_vRec);
    //         XMLP.SETTABLEVIEW(SIHeader_vRec);
    //         XMLP.SETDESTINATION(Stream);
    //         XMLP.EXPORT;
    //         OutputFile_lFile.CLOSE;
    //         MESSAGE(Txt50150_lTxt, SIHeader_vRec."No.");
    //     END;

    //     //AKK1612.01-NE
    // END;

    // PROCEDURE ExportSIInvtoTxt2_gFnc(VAR SIHeader_vRec: Record 112);
    // VAR
    //     OutputFile_lFile: File;
    //     SalesReceivableSetup_lRec: Record 311;
    //     FileName_lTxt: Text[250];
    //     Stream: OutStream;
    //     Txt50150_lTxt: Label 'ENU=Sales Invoice %1 has been exported into Text file Successfully.';
    //     XMLP: XMLport 50010;
    //     Txt50151_lTxt: Label 'ENU=Sales Invoice %1 file is already been generated. Do you want to Process again?';
    // BEGIN
    //     //AKK1612.01-NS
    //     SalesReceivableSetup_lRec.GET;
    //     SalesReceivableSetup_lRec.TESTFIELD(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path");
    //     FileName_lTxt := FORMAT(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path") + '\' + 'SALINV' + SIHeader_vRec."No." + '.txt';
    //     OutputFile_lFile.CREATE(FileName_lTxt);
    //     OutputFile_lFile.CREATEOUTSTREAM(Stream);
    //     XMLP.GetInvNo_gFnc(SIHeader_vRec."No.");
    //     XMLP.SETTABLEVIEW(SIHeader_vRec);
    //     XMLP.SETDESTINATION(Stream);
    //     XMLP.EXPORT;
    //     OutputFile_lFile.CLOSE;
    //     //AKK1612.01-NE
    // END; TODO

}
