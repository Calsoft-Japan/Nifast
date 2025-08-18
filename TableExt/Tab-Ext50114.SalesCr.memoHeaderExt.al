tableextension 50114 "Sales Cr.Memo Header Ext" extends "Sales Cr.Memo Header"
{
    // version NAVW18.00,NAVNA8.00,SE0.60,NIF1.050,NMX1.002,NIF.N15.C9IN.001,MEI,CE 1.2,AKK1612.01
    fields
    {
        field(50000; "Freight Code"; Code[10])
        {
            // cleaned
            TableRelation = "Freight Code";
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
            Editable = false;
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
            Editable = false;
        }
        field(51000; "Blanket Order No."; Code[20])
        {
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            // cleaned
            trigger OnValidate();
            var
                CLE: Record 21;
            //">>NIF_LV": Integer;
            begin
                //>>NIF RTT 050906
                CLE.SETRANGE("Customer No.", "Bill-to Customer No.");
                CLE.SETRANGE("Document Type", CLE."Document Type"::"Credit Memo");
                CLE.SETRANGE("Document No.", "No.");
                IF CLE.FIND('-') THEN BEGIN
                    CLE."Mex. Factura No." := "Mex. Factura No.";
                    CLE.MODIFY();
                END;
                //<<NIF RTT 050906
            end;
        }
        field(52001; "Exclude from Virtual Inv."; Boolean)
        {
            // cleaned
            trigger OnValidate();
            var
            /* SlsHdr: Record 36;
            SlsInv2: Record 112;
            CLE: Record 21; */
            begin
            end;
        }
        field(55000; "XML - UUID"; Code[36])
        {
            CaptionML = ENU = 'UUID',
                        ESP = 'UUID';
            Description = 'CE 1.2';
        }
        field(55010; "XML - Invoice Folio"; Code[50])
        {
            CaptionML = ENU = 'Invoice Folio',
                        ESP = 'Folio Factura';
            Description = 'CE 1.2';
        }
        field(55020; "XML - Certified No"; Text[20])
        {
            CaptionML = ENU = 'Certified No',
                        ESP = 'Núm. Certificado';
            Description = 'CE 1.2';
        }
        field(55030; "XML - SAT Certified No"; Text[20])
        {
            CaptionML = ENU = 'SAT Certified No',
                        ESP = 'Núm Certificado SAT';
            Description = 'CE 1.2';
        }
        field(55040; "XML - Date/Time Stamped"; Text[50])
        {
            CaptionML = ENU = 'Date/Time Stamped',
                        ESP = 'Fecha/Hora Timbrado';
            Description = 'CE 1.2';
        }
        field(55050; "XML - VAT Registration No"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            Description = 'CE 1.2';
        }
        field(55051; "XML - VAT Receptor"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            Description = 'CE 1.2';
        }
        field(55060; "XML - Total Invoice"; Decimal)
        {
            CaptionML = ENU = 'Total Invoice',
                        ESP = 'Total Factura';
            Description = 'CE 1.2';
        }
        field(55070; "XML - Payment Method"; Code[50])
        {
            CaptionML = ENU = 'Payment Method',
                        ESP = 'Método de Pago';
            Description = 'CE 1.2';
        }
        field(55080; "XML - Currency"; Code[50])
        {
            CaptionML = ENU = 'Currency',
                        ESP = 'Moneda';
            Description = 'CE 1.2';
        }
        field(55090; "XML - Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'Currency Factor',
                        ESP = 'Tipo de Cambio';
            Description = 'CE 1.2';
        }
        field(55300; XML; BLOB)
        {
            CaptionML = ENU = 'XML',
                        ESP = 'XML';
            Description = 'CE 1.2';
        }
        field(55310; PDF; BLOB)
        {
            CaptionML = ENU = 'PDF',
                        ESP = 'PDF';
            Description = 'CE 1.2';
        }

        field(50001; "Inside Salesperson Code"; Code[10])//NV-FB 14017617->50001 BC Upgrade
        { }
        //TODO
        /* field(14017610; "Entered User ID"; Code[50])
        {
            Description = '20-->50 NF1.00:CIS.NG  10-10-15';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit 418;
            begin
            end;

            trigger OnValidate();
            var
                LoginMgt: Codeunit 418;
            begin
            end;
        } 
         field(14017617;"Inside Salesperson Code";Code[10])
        {
            Description = 'NV-FB';
            TableRelation = Salesperson/Purchaser.Code WHERE (Inside Sales=CONST(Yes),
                                                              Sales=CONST(Yes));
        }
        field(14017618;"Phone No.";Text[30])
        {
            Description = 'NV-FB';
        }
          field(14017645;"Contract No.";Code[20])
        {
            Description = 'NV-FB';
            TableRelation = "Price Contract" WHERE (Customer No.=FIELD(Sell-to Customer No.));
        }
        field(14017650;"Broker/Agent Code";Code[10])
        {
            Description = 'NV-FB';
        }
         field(14018050;"Cr. Mgmt. Comment";Boolean)
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }*/
        //TODO
    }

    trigger OnAfterDelete()
    begin
        //>> NV 4.32 05.21.04 JWW: Added for Cr. Mgmt
        //CreditManagement.DeleteDocComments(9,"No.");  //NF1.00:CIS.CM 09-29-15
        //<< NV 4.32 05.21.04 JWW: Added for Cr. Mgmt
    end;

    /*   PROCEDURE ExportSICrMemotoTxt_gFnc(VAR SCrmHeader_vRec: Record 114);
      VAR
          OutputFile_lFile: File;
          SalesReceivableSetup_lRec: Record 311;
          FileName_lTxt: Text[250];
          Stream: OutStream;
          Txt50150_lTxt: Label 'Sales Invoice %1 has been exported into Text file Successfully.';
          XMLP: XMLport 50011;
          Txt50151_lTxt: Label 'Sales Invoice %1 file is already been generated. Do you want to Process again?';
      BEGIN
          //AKK1612.01-NS
          SalesReceivableSetup_lRec.GET;
          SalesReceivableSetup_lRec.TESTFIELD(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path");
          FileName_lTxt := FORMAT(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path") + '\' + 'SALCRMO' + SCrmHeader_vRec."No." + '.txt';
          IF FILE.EXISTS(FileName_lTxt) THEN BEGIN
              IF CONFIRM(Txt50151_lTxt, FALSE, SCrmHeader_vRec."No.") THEN BEGIN
                  OutputFile_lFile.CREATE(FileName_lTxt);
                  OutputFile_lFile.CREATEOUTSTREAM(Stream);
                  XMLP.GetCrMemoNo_gFnc(SCrmHeader_vRec."No.");
                  //XMLPORT.EXPORT(XMLPORT::"Export Sales Invoice to Txt",Stream,SIHeader_vRec);
                  XMLP.SETTABLEVIEW(SCrmHeader_vRec);
                  XMLP.SETDESTINATION(Stream);
                  XMLP.EXPORT;
                  OutputFile_lFile.CLOSE;
                  MESSAGE(Txt50150_lTxt, SCrmHeader_vRec."No.");
              END;
          END ELSE BEGIN
              OutputFile_lFile.CREATE(FileName_lTxt);
              OutputFile_lFile.CREATEOUTSTREAM(Stream);
              XMLP.GetCrMemoNo_gFnc(SCrmHeader_vRec."No.");
              //XMLPORT.EXPORT(XMLPORT::"Export Sales Invoice to Txt",Stream,SIHeader_vRec);
              XMLP.SETTABLEVIEW(SCrmHeader_vRec);
              XMLP.SETDESTINATION(Stream);
              XMLP.EXPORT;
              OutputFile_lFile.CLOSE;
              MESSAGE(Txt50150_lTxt, SCrmHeader_vRec."No.");
          END;
          //AKK1612.01-NE
      END;
   */
    procedure ExportSICrMemotoTxt_gFnc(var SCrmHeader_vRec: Record "Sales Cr.Memo Header")
    var
    //TODO
    /*  SalesReceivableSetup_lRec: Record "Sales & Receivables Setup";
     TempBlob: Codeunit "Temp Blob";
     XMLP: XMLport 50011;
     FileName: Text;
     OutStr: OutStream;
     Txt50150_lTxt: Label 'Sales Invoice %1 has been exported into Text file successfully.', Comment = '%1=SCrmHeader_vRec."No."';
     Txt50151_lTxt: Label 'Sales Invoice %1 file has already been generated. Do you want to process again?', Comment = '%1=SCrmHeader_vRec."No."';
     InStr: InStream; */
    //TODO
    begin
        //TODO
        /*  SalesReceivableSetup_lRec.Get();
         SalesReceivableSetup_lRec.TestField("Export Sales Inv/Cr/Memo Path");

         FileName := FORMAT(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path") + '\' + 'SALCRMO' + SCrmHeader_vRec."No." + '.txt';

         if Confirm(Txt50151_lTxt, false, SCrmHeader_vRec."No.") then begin
             TempBlob.CreateOutStream(OutStr);
             XMLP.GetCrMemoNo_gFnc(SCrmHeader_vRec."No.");
             XMLP.SetTableView(SCrmHeader_vRec);
             XMLP.SetDestination(OutStr);
             XMLP.Export();
             TempBlob.CreateInStream(InStr);
             DownloadFromStream(InStr, '', '', 'Text Files (*.txt)|*.txt', FileName);

             Message(Txt50150_lTxt, SCrmHeader_vRec."No.");
         end; */
        //TODO
    End;


    /*    PROCEDURE ExportSICrMemotoTxt2_gFnc(VAR SCrmHeader_vRec: Record 114);
       VAR
           OutputFile_lFile: File;
           SalesReceivableSetup_lRec: Record 311;
           FileName_lTxt: Text[250];
           Stream: OutStream;
           Txt50150_lTxt: Label 'Sales Invoice %1 has been exported into Text file Successfully.';
           XMLP: XMLport 50011;
           Txt50151_lTxt: Label 'Sales Invoice %1 file is already been generated. Do you want to Process again?';
       BEGIN
           //AKK1612.01-NS
           SalesReceivableSetup_lRec.GET;
           SalesReceivableSetup_lRec.TESTFIELD(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path");
           FileName_lTxt := FORMAT(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path") + '\' + 'SALCRMO' + SCrmHeader_vRec."No." + '.txt';
           OutputFile_lFile.CREATE(FileName_lTxt);
           OutputFile_lFile.CREATEOUTSTREAM(Stream);
           XMLP.GetCrMemoNo_gFnc(SCrmHeader_vRec."No.");
           //XMLPORT.EXPORT(XMLPORT::"Export Sales Invoice to Txt",Stream,SIHeader_vRec);
           XMLP.SETTABLEVIEW(SCrmHeader_vRec);
           XMLP.SETDESTINATION(Stream);
           XMLP.EXPORT;
           OutputFile_lFile.CLOSE;
           //AKK1612.01-NE
       END; */

    procedure ExportSICrMemotoTxt2_gFnc(var SCrmHeader_vRec: Record "Sales Cr.Memo Header")
    var
    //TODO
    /*  SalesReceivableSetup_lRec: Record "Sales & Receivables Setup";
     TempBlob: Codeunit "Temp Blob";
     XMLP: XMLport 50011;
     FileName_lTxt: Text[250];
     Stream: OutStream;
     InStr: InStream; */
    //TODO
    /*   Txt50150_lTxt: Label 'Sales Invoice %1 has been exported into Text file Successfully.';
      Txt50151_lTxt: Label 'Sales Invoice %1 file is already been generated. Do you want to Process again?'; */
    begin
        //TODO
        /*   SalesReceivableSetup_lRec.Get();
          SalesReceivableSetup_lRec.TestField("Export Sales Inv/Cr/Memo Path");

          FileName_lTxt := FORMAT(SalesReceivableSetup_lRec."Export Sales Inv/Cr/Memo Path") + '\' + 'SALCRMO' + SCrmHeader_vRec."No." + '.txt';

          TempBlob.CreateOutStream(Stream);
          XMLP.GetCrMemoNo_gFnc(SCrmHeader_vRec."No.");
          XMLP.SetTableView(SCrmHeader_vRec);
          XMLP.SetDestination(Stream);
          XMLP.Export();

          TempBlob.CreateInStream(InStr);
          DownloadFromStream(InStr, '', '', '', FileName_lTxt); */
        //TODO
    end;


}
