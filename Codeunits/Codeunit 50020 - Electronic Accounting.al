codeunit 50020 "Electronic Accounting"
{

    trigger OnRun()
    begin
    end;

    var
        ElectronicAccSetup: Record 50035;
        TempBlob: Record 99008535 temporary;
        FileManagement: Codeunit 419;
        XMLDOMManagement: Codeunit 6224;
        AuxiliaryAccountNamespaceTxt: Label 'AuxiliarCtas', Locked = true;
        AuxiliaryAccountNodeTxt: Label 'AuxiliarCtas', Locked = true;
        BalanzaIdText: Label 'Balanza';
        BalanzaNamespaceTxt: Label 'BalanzaComprobacion', Locked = true;
        BalanzaNodeTxt: Label 'BCE', Locked = true;
        CatalogoIdText: Label 'Catalogo';
        CatalogoNamespaceTxt: Label 'CatalogoCuentas', Locked = true;
        CatalogoNodeTxt: Label 'catalogocuentas', Locked = true;
        NamespaceTxt: Label 'www.sat.gob.mx/esquemas/ContabilidadE/1_1/', Locked = true;
        NamespaceW3Txt: Label 'http://www.w3.org/2001/XMLSchema-instance', Locked = true;
        PolizasNamespaceTxt: Label 'PolizasPeriodo', Locked = true;
        PolizasNodeTxt: Label 'Polizas', Locked = true;
        WebClientErr: Label 'The import is not supported on the webclient.';

    local procedure "--Saves--"()
    begin
    end;

    procedure ImportXMLToSalesInvHeader(var SalesInvHeader: Record 112)
    var
        SalesInvXMLData: Record 50036;
        VATEm: Code[13];
        VATRc: Code[13];
        UUID: Code[36];
        Currency: Code[50];
        InvoiceFolio: Code[50];
        Payment: Code[50];
        CurrencyFactor: Decimal;
        Total: Decimal;
        FileDialogTxt: Label 'Import XML';
        ClientFileName: Text;
        ServerFileName: Text;
        CertifiedNo: Text[20];
        CertifiedSAT: Text[20];
        DateTime: Text[50];
        xmlDoc: XmlDocument;
    begin
        ElectronicAccSetup.FIND('-');
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);
        //Upload
        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.xml'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);

        //Extract
        xmlDoc := xmlDoc;
        xmlDoc.LoadXml(XMLWellFormed(ServerFileName));
        //xmlDoc.Load(ServerFileName);
        ExtractFiscalInformation(xmlDoc, UUID, InvoiceFolio, CertifiedNo, CertifiedSAT, DateTime, VATEm, VATRc, Total, Payment, Currency, CurrencyFactor);

        //VALIDATE
        SalesInvHeader.CALCFIELDS("Amount Including VAT");
        IF ElectronicAccSetup."EA Chk UUID" THEN FindUUID(UUID);
        IF ElectronicAccSetup."EA Validate Date" THEN ValidateDate(SalesInvHeader."Posting Date", GetDateFromStr(DateTime));
        IF ElectronicAccSetup."EA Sales - Chk VAT Em" THEN ValidateRFC(VATEm, SalesInvHeader."No.", 2);
        IF ElectronicAccSetup."EA Sales - Chk VAT Rc" THEN ValidateRFC(VATRc, SalesInvHeader."Sell-to Customer No.", 1);
        IF ElectronicAccSetup."EA Chk Amount" THEN ValidateAmount(SalesInvHeader."Amount Including VAT", Total);
        IF ElectronicAccSetup."EA Chk UUID" THEN FindUUID(UUID);


        IF NOT SalesInvXMLData.GET(SalesInvHeader."No.") THEN BEGIN
            SalesInvXMLData.INIT();
            SalesInvXMLData."No." := SalesInvHeader."No.";
            SalesInvXMLData.XML.IMPORT(ServerFileName);
            SalesInvXMLData."XML - UUID" := UUID;
            SalesInvXMLData."XML - Invoice Folio" := InvoiceFolio;
            SalesInvXMLData."XML - Certified No" := CertifiedNo;
            SalesInvXMLData."XML - SAT Certified No" := CertifiedSAT;
            SalesInvXMLData."XML - Date/Time Stamped" := DateTime;
            SalesInvXMLData."XML - VAT Registration No" := VATEm;
            SalesInvXMLData."XML - VAT Receptor" := VATRc;
            SalesInvXMLData."XML - Total Invoice" := Total;
            SalesInvXMLData."XML - Payment Method" := Payment;
            SalesInvXMLData."XML - Currency" := Currency;
            SalesInvXMLData."XML - Currency Factor" := CurrencyFactor;
            SalesInvXMLData.INSERT();
        END ELSE BEGIN
            SalesInvXMLData.XML.IMPORT(ServerFileName);
            SalesInvXMLData."XML - UUID" := UUID;
            SalesInvXMLData."XML - Invoice Folio" := InvoiceFolio;
            SalesInvXMLData."XML - Certified No" := CertifiedNo;
            SalesInvXMLData."XML - SAT Certified No" := CertifiedSAT;
            SalesInvXMLData."XML - Date/Time Stamped" := DateTime;
            SalesInvXMLData."XML - VAT Registration No" := VATEm;
            SalesInvXMLData."XML - VAT Receptor" := VATRc;
            SalesInvXMLData."XML - Total Invoice" := Total;
            SalesInvXMLData."XML - Payment Method" := Payment;
            SalesInvXMLData."XML - Currency" := Currency;
            SalesInvXMLData."XML - Currency Factor" := CurrencyFactor;
            SalesInvXMLData.MODIFY();
        END;

        UpdateDocsRelatedToSalesInvHeader(SalesInvHeader);
    end;

    procedure ImportXMLToSalesCrMHeader(var SalesCrMHeader: Record 114)
    var
        VATEm: Code[13];
        VATRc: Code[13];
        UUID: Code[36];
        Currency: Code[50];
        InvoiceFolio: Code[50];
        Payment: Code[50];
        CurrencyFactor: Decimal;
        Total: Decimal;
        FileDialogTxt: Label 'Import XML';
        ClientFileName: Text;
        ServerFileName: Text;
        CertifiedNo: Text[20];
        CertifiedSAT: Text[20];
        DateTime: Text[50];
        xmlDoc: XmlDocument;
    begin
        ElectronicAccSetup.FIND('-');
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);
        //Upload
        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.xml'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);

        //Extract
        xmlDoc := xmlDoc;
        //xmlDoc.Load(ServerFileName);
        xmlDoc.LoadXml(XMLWellFormed(ServerFileName));
        ExtractFiscalInformation(xmlDoc, UUID, InvoiceFolio, CertifiedNo, CertifiedSAT, DateTime, VATEm, VATRc, Total, Payment, Currency, CurrencyFactor);

        //Validate
        SalesCrMHeader.CALCFIELDS("Amount Including VAT");
        IF ElectronicAccSetup."EA Chk UUID" THEN FindUUID(UUID);
        IF ElectronicAccSetup."EA Validate Date" THEN ValidateDate(SalesCrMHeader."Posting Date", GetDateFromStr(DateTime));
        IF ElectronicAccSetup."EA Sales - Chk VAT Em" THEN ValidateRFC(VATEm, SalesCrMHeader."No.", 2);
        IF ElectronicAccSetup."EA Sales - Chk VAT Rc" THEN ValidateRFC(VATRc, SalesCrMHeader."Sell-to Customer No.", 1);
        IF ElectronicAccSetup."EA Chk Amount" THEN ValidateAmount(SalesCrMHeader."Amount Including VAT", Total);

        //Assign
        SalesCrMHeader.XML.IMPORT(ServerFileName);
        SalesCrMHeader."XML - UUID" := UUID;
        SalesCrMHeader."XML - Invoice Folio" := InvoiceFolio;
        SalesCrMHeader."XML - Certified No" := CertifiedNo;
        SalesCrMHeader."XML - SAT Certified No" := CertifiedSAT;
        SalesCrMHeader."XML - Date/Time Stamped" := DateTime;
        SalesCrMHeader."XML - VAT Registration No" := VATEm;
        SalesCrMHeader."XML - VAT Receptor" := VATRc;
        SalesCrMHeader."XML - Total Invoice" := Total;
        SalesCrMHeader."XML - Payment Method" := Payment;
        SalesCrMHeader."XML - Currency" := Currency;
        SalesCrMHeader."XML - Currency Factor" := CurrencyFactor;
        SalesCrMHeader.MODIFY();
        UpdateDocsRelatedToSalesCrMHeader(SalesCrMHeader);
    end;

    procedure ExportXMLFromSalesInvHeader(SalesInvHeader: Record 112)
    var
        SalesInvXMLData: Record 50036;
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNameXMl: Label 'XML File.xml';
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN BEGIN
            SalesInvXMLData.CALCFIELDS(XML);
            TempBlob.INIT;
            TempBlob."Primary Key" := 1;
            IF SalesInvXMLData.XML.HASVALUE THEN BEGIN
                TempBlob.Blob := SalesInvXMLData.XML;
                FileManagement.BLOBExport(TempBlob, FileNameXMl, TRUE);
            END ELSE
                MESSAGE(FieldEmpty);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure ExportXMLFromSalesCrMHeader(SalesCrMHeader: Record 114)
    var
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNameXMl: Label 'XML File.xml';
    begin
        TempBlob.INIT;
        TempBlob."Primary Key" := 1;
        SalesCrMHeader.CALCFIELDS(XML);
        IF SalesCrMHeader.XML.HASVALUE THEN BEGIN
            TempBlob.Blob := SalesCrMHeader.XML;
            FileManagement.BLOBExport(TempBlob, FileNameXMl, TRUE);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure DeleteFileFromSalesInvHeader(var SalesInvHeader: Record 112)
    var
        SalesInvXMLData: Record 50036;
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN SalesInvXMLData.DELETE();
        UpdateDocsRelatedToSalesInvHeader(SalesInvHeader);
    end;

    procedure DeleteFileFromSalesCrMHeader(var SalesCrMHeader: Record 114)
    begin
        SalesCrMHeader."XML - UUID" := '';
        SalesCrMHeader."XML - Invoice Folio" := '';
        SalesCrMHeader."XML - Certified No" := '';
        SalesCrMHeader."XML - SAT Certified No" := '';
        SalesCrMHeader."XML - Date/Time Stamped" := '';
        SalesCrMHeader."XML - VAT Registration No" := '';
        SalesCrMHeader."XML - VAT Receptor" := '';
        SalesCrMHeader."XML - Total Invoice" := 0.0;
        SalesCrMHeader."XML - Payment Method" := '';
        SalesCrMHeader."XML - Currency" := '';
        SalesCrMHeader."XML - Currency Factor" := 0.0;
        SalesCrMHeader.CALCFIELDS(XML, PDF);
        CLEAR(SalesCrMHeader.XML);
        CLEAR(SalesCrMHeader.PDF);
        SalesCrMHeader.MODIFY();
        UpdateDocsRelatedToSalesCrMHeader(SalesCrMHeader);
    end;

    procedure ImportXMLToPurchInvHeader(var PurchInvHeader: Record 122)
    var
        VATEm: Code[13];
        VATRc: Code[13];
        UUID: Code[36];
        Currency: Code[50];
        InvoiceFolio: Code[50];
        Payment: Code[50];
        CurrencyFactor: Decimal;
        Total: Decimal;
        FileDialogTxt: Label 'Import XML';
        ClientFileName: Text;
        ServerFileName: Text;
        CertifiedNo: Text[20];
        CertifiedSAT: Text[20];
        DateTime: Text[50];
        xmlDoc: XmlDocument;
    begin
        ElectronicAccSetup.FIND('-');
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);
        //Upload
        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.xml'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);
        //Extract
        xmlDoc := xmlDoc.XmlDocument;
        //xmlDoc.Load(ServerFileName);
        xmlDoc.LoadXml(XMLWellFormed(ServerFileName));
        ExtractFiscalInformation(xmlDoc, UUID, InvoiceFolio, CertifiedNo, CertifiedSAT, DateTime, VATEm, VATRc, Total, Payment, Currency, CurrencyFactor);

        //Validate
        PurchInvHeader.CALCFIELDS("Amount Including VAT");
        IF ElectronicAccSetup."EA Chk UUID" THEN FindUUID(UUID);
        IF ElectronicAccSetup."EA Validate Date" THEN ValidateDate(PurchInvHeader."Posting Date", GetDateFromStr(DateTime));
        IF ElectronicAccSetup."EA Purch - Chk VAT Em" THEN ValidateRFC(VATEm, PurchInvHeader."Buy-from Vendor No.", 3);
        IF ElectronicAccSetup."EA Purch - Chk VAT Rc" THEN ValidateRFC(VATRc, PurchInvHeader."No.", 2);
        IF ElectronicAccSetup."EA Chk Amount" THEN ValidateAmount(PurchInvHeader."Amount Including VAT", Total);

        //Assign
        PurchInvHeader.XML.IMPORT(ServerFileName);
        PurchInvHeader."XML - UUID" := UUID;
        PurchInvHeader."XML - Invoice Folio" := InvoiceFolio;
        PurchInvHeader."XML - Certified No" := CertifiedNo;
        PurchInvHeader."XML - SAT Certified No" := CertifiedSAT;
        PurchInvHeader."XML - Date/Time Stamped" := DateTime;
        PurchInvHeader."XML - VAT Registration No" := VATEm;
        PurchInvHeader."XML - VAT Receptor" := VATRc;
        PurchInvHeader."XML - Total Invoice" := Total;
        PurchInvHeader."XML - Payment Method" := Payment;
        PurchInvHeader."XML - Currency" := Currency;
        PurchInvHeader."XML - Currency Factor" := CurrencyFactor;
        PurchInvHeader.MODIFY();
        UpdateDocsRelatedToPurchInvHeader(PurchInvHeader);
    end;

    procedure ImportXMLToPurchCrMHeader(var PurchCrMHeader: Record 124)
    var
        VATEm: Code[13];
        VATRc: Code[13];
        UUID: Code[36];
        Currency: Code[50];
        InvoiceFolio: Code[50];
        Payment: Code[50];
        CurrencyFactor: Decimal;
        Total: Decimal;
        FileDialogTxt: Label 'Import XML';
        ClientFileName: Text;
        ServerFileName: Text;
        CertifiedNo: Text[20];
        CertifiedSAT: Text[20];
        DateTime: Text[50];
        xmlDoc: XmlDocument;
    begin
        ElectronicAccSetup.FIND('-');
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);
        //Upload
        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.xml'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);

        //Extract
        xmlDoc := xmlDoc;
        //xmlDoc.Load(ServerFileName);
        xmlDoc.LoadXml(XMLWellFormed(ServerFileName));
        ExtractFiscalInformation(xmlDoc, UUID, InvoiceFolio, CertifiedNo, CertifiedSAT, DateTime, VATEm, VATRc, Total, Payment, Currency, CurrencyFactor);

        //Validate
        PurchCrMHeader.CALCFIELDS("Amount Including VAT");
        IF ElectronicAccSetup."EA Chk UUID" THEN FindUUID(UUID);
        IF ElectronicAccSetup."EA Validate Date" THEN ValidateDate(PurchCrMHeader."Posting Date", GetDateFromStr(DateTime));
        IF ElectronicAccSetup."EA Purch - Chk VAT Em" THEN ValidateRFC(VATEm, PurchCrMHeader."Buy-from Vendor No.", 3);
        IF ElectronicAccSetup."EA Purch - Chk VAT Rc" THEN ValidateRFC(VATRc, PurchCrMHeader."No.", 2);
        IF ElectronicAccSetup."EA Chk Amount" THEN ValidateAmount(PurchCrMHeader."Amount Including VAT", Total);

        //Assign
        PurchCrMHeader.XML.IMPORT(ServerFileName);
        PurchCrMHeader."XML - UUID" := UUID;
        PurchCrMHeader."XML - Invoice Folio" := InvoiceFolio;
        PurchCrMHeader."XML - Certified No" := CertifiedNo;
        PurchCrMHeader."XML - SAT Certified No" := CertifiedSAT;
        PurchCrMHeader."XML - Date/Time Stamped" := DateTime;
        PurchCrMHeader."XML - VAT Registration No" := VATEm;
        PurchCrMHeader."XML - VAT Receptor" := VATRc;
        PurchCrMHeader."XML - Total Invoice" := Total;
        PurchCrMHeader."XML - Payment Method" := Payment;
        PurchCrMHeader."XML - Currency" := Currency;
        PurchCrMHeader."XML - Currency Factor" := CurrencyFactor;
        PurchCrMHeader.MODIFY();
        UpdateDocRelatedToPurchCrMHeader(PurchCrMHeader);
    end;

    procedure ExportXMLFromPurchInvHeader(PurchInvHeader: Record 122)
    var
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNameXMl: Label 'XML File.xml';
    begin
        TempBlob.INIT;
        TempBlob."Primary Key" := 1;
        PurchInvHeader.CALCFIELDS(XML);
        IF PurchInvHeader.XML.HASVALUE THEN BEGIN
            TempBlob.Blob := PurchInvHeader.XML;
            FileManagement.BLOBExport(TempBlob, FileNameXMl, TRUE);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure ExportXMLFromPurchCrMHeader(PurchCrMHeader: Record 124)
    var
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNameXMl: Label 'XML File.xml';
    begin
        TempBlob.INIT;
        TempBlob."Primary Key" := 1;
        PurchCrMHeader.CALCFIELDS(XML);
        IF PurchCrMHeader.XML.HASVALUE THEN BEGIN
            TempBlob.Blob := PurchCrMHeader.XML;
            FileManagement.BLOBExport(TempBlob, FileNameXMl, TRUE);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure DeleteFileFromPurchInvHeader(var PurchInvHeader: Record 122)
    begin
        PurchInvHeader."XML - UUID" := '';
        PurchInvHeader."XML - Invoice Folio" := '';
        PurchInvHeader."XML - Certified No" := '';
        PurchInvHeader."XML - SAT Certified No" := '';
        PurchInvHeader."XML - Date/Time Stamped" := '';
        PurchInvHeader."XML - VAT Registration No" := '';
        PurchInvHeader."XML - VAT Receptor" := '';
        PurchInvHeader."XML - Total Invoice" := 0.0;
        PurchInvHeader."XML - Payment Method" := '';
        PurchInvHeader."XML - Currency" := '';
        PurchInvHeader."XML - Currency Factor" := 0.0;
        PurchInvHeader.CALCFIELDS(PDF, XML);
        CLEAR(PurchInvHeader.XML);
        CLEAR(PurchInvHeader.PDF);
        PurchInvHeader.MODIFY();
        UpdateDocsRelatedToPurchInvHeader(PurchInvHeader);
    end;

    procedure DeleteFileFromPurchCrMHeader(var PurchCrMHeader: Record 124)
    begin
        PurchCrMHeader."XML - UUID" := '';
        PurchCrMHeader."XML - Invoice Folio" := '';
        PurchCrMHeader."XML - Certified No" := '';
        PurchCrMHeader."XML - SAT Certified No" := '';
        PurchCrMHeader."XML - Date/Time Stamped" := '';
        PurchCrMHeader."XML - VAT Registration No" := '';
        PurchCrMHeader."XML - VAT Receptor" := '';
        PurchCrMHeader."XML - Total Invoice" := 0.0;
        PurchCrMHeader."XML - Payment Method" := '';
        PurchCrMHeader."XML - Currency" := '';
        PurchCrMHeader."XML - Currency Factor" := 0.0;
        PurchCrMHeader.CALCFIELDS(PDF, XML);
        CLEAR(PurchCrMHeader.XML);
        CLEAR(PurchCrMHeader.PDF);
        PurchCrMHeader.MODIFY();
        UpdateDocRelatedToPurchCrMHeader(PurchCrMHeader);
    end;

    procedure ImportPDFToSalesInvHeader(var SalesInvHeader: Record 112)
    var
        SalesInvXMLData: Record 50036;
        FileDialogTxt: Label 'Import PDF';
        // WebClientErr: Label 'The import is not supported on the webclient.';
        ClientFileName: Text;
        ServerFileName: Text;
    begin
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);

        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.pdf'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN BEGIN
            SalesInvXMLData.PDF.IMPORT(ServerFileName);
            SalesInvXMLData.MODIFY();
        END ELSE BEGIN
            SalesInvXMLData.INIT();
            SalesInvXMLData."No." := SalesInvHeader."No.";
            SalesInvXMLData.PDF.IMPORT(ServerFileName);
            SalesInvXMLData.INSERT();
        END;
    end;

    procedure ImportPDFToSalesCrMHeader(var SalesCrMHeader: Record 114)
    var
        FileDialogTxt: Label 'Import PDF';
        // WebClientErr: Label 'The import is not supported on the webclient.';
        ClientFileName: Text;
        ServerFileName: Text;
    begin
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);

        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.pdf'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);
        SalesCrMHeader.PDF.IMPORT(ServerFileName);
        SalesCrMHeader.MODIFY();
    end;

    procedure ExportPDFFromSalesInvHeader(SalesInvHeader: Record 112)
    var
        SalesInvXMLData: Record 50036;
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNamePDF: Label 'PDF File.pdf';
    begin
        IF SalesInvXMLData.GET(SalesInvHeader) THEN BEGIN
            TempBlob.INIT;
            TempBlob."Primary Key" := 1;
            SalesInvXMLData.CALCFIELDS(PDF);
            IF SalesInvXMLData.PDF.HASVALUE THEN BEGIN
                TempBlob.Blob := SalesInvXMLData.PDF;
                FileManagement.BLOBExport(TempBlob, FileNamePDF, TRUE);
            END ELSE
                MESSAGE(FieldEmpty);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure ExportPDFFromSalesCrMHeader(SalesCrMHeader: Record 114)
    var
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNamePDF: Label 'PDF File.pdf';
    begin
        TempBlob.INIT;
        TempBlob."Primary Key" := 1;
        SalesCrMHeader.CALCFIELDS(PDF);
        IF SalesCrMHeader.PDF.HASVALUE THEN BEGIN
            TempBlob.Blob := SalesCrMHeader.PDF;
            FileManagement.BLOBExport(TempBlob, FileNamePDF, TRUE);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure ImportPDFToPurchInvHeader(var PurchInvHeader: Record 122)
    var
        FileDialogTxt: Label 'Import PDF';
        //  WebClientErr: Label 'The import is not supported on the webclient.';
        ClientFileName: Text;
        ServerFileName: Text;
    begin
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);

        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.pdf'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);
        PurchInvHeader.PDF.IMPORT(ServerFileName);
        PurchInvHeader.MODIFY();
    end;

    procedure ImportPDFToPurchCrMHeader(var PurchCrMHeader: Record 124)
    var
        FileDialogTxt: Label 'Import PDF';
        //  WebClientErr: Label 'The import is not supported on the webclient.';
        ClientFileName: Text;
        ServerFileName: Text;
    begin
        IF FileManagement.IsWebClient THEN
            ERROR(WebClientErr);

        ClientFileName := FileManagement.OpenFileDialog(FileDialogTxt, '', FileManagement.GetToFilterText('', '.pdf'));
        IF ClientFileName = '' THEN
            EXIT;
        ServerFileName := FileManagement.UploadFileSilent(ClientFileName);
        PurchCrMHeader.PDF.IMPORT(ServerFileName);
        PurchCrMHeader.MODIFY();
    end;

    procedure ExportPDFFromPurchInvHeader(PurchInvHeader: Record 122)
    var
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNamePDF: Label 'PDF File.pdf';
    begin
        TempBlob.INIT;
        TempBlob."Primary Key" := 1;
        PurchInvHeader.CALCFIELDS(PDF);
        IF PurchInvHeader.PDF.HASVALUE THEN BEGIN
            TempBlob.Blob := PurchInvHeader.PDF;
            FileManagement.BLOBExport(TempBlob, FileNamePDF, TRUE);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    procedure ExportPDFFromPurchCrmHeader(PurchCrMHeader: Record 124)
    var
        FieldEmpty: Label 'Field is empty, file doesn''t exist';
        FileNamePDF: Label 'PDF File.pdf';
    begin
        TempBlob.INIT;
        TempBlob."Primary Key" := 1;
        PurchCrMHeader.CALCFIELDS(PDF);
        IF PurchCrMHeader.PDF.HASVALUE THEN BEGIN
            TempBlob.Blob := PurchCrMHeader.PDF;
            FileManagement.BLOBExport(TempBlob, FileNamePDF, TRUE);
        END ELSE
            MESSAGE(FieldEmpty);
    end;

    local procedure "---Extract---"()
    begin
    end;

    local procedure ExtractFiscalInformation(xmlDoc: XmlDocument; var UUID: Code[36]; var FolioInvoice: Code[50]; var CertifiedNo: Text[20]; var SATCertifiedNo: Text[20]; var DateTimeStamped: Text[50]; var VAT: Code[13]; var "VAT Receptor": Code[13]; var TotalInvoice: Decimal; var PaymentMethod: Code[50]; var Currency: Code[50]; var CurrencyFactor: Decimal)
    var
        ImportFailedErr: Label 'The import failed. The XML document is not a valid electronic invoice.';
        NamespaceManager: XmlNamespaceManager;
        Node: XmlNode;
        NodeList: XmlNodeList;
    begin

        NamespaceManager := NamespaceManager.XmlNamespaceManager(xmlDoc.NameTable);
        NamespaceManager.AddNamespace('cfdi', 'http://www.sat.gob.mx/cfd/3');
        NamespaceManager.AddNamespace('tfd', 'http://www.sat.gob.mx/TimbreFiscalDigital');

        NodeList := xmlDoc.DocumentElement.SelectNodes('//cfdi:Complemento/tfd:TimbreFiscalDigital', NamespaceManager);
        IF NodeList.Count <> 0 THEN BEGIN
            Node := NodeList.Item(0);
            UUID := Node.Attributes.GetNamedItem('UUID').Value;
            SATCertifiedNo := Node.Attributes.GetNamedItem('noCertificadoSAT').Value;
            DateTimeStamped := Node.Attributes.GetNamedItem('FechaTimbrado').Value;
        END ELSE
            ERROR(ImportFailedErr);

        NodeList := xmlDoc.DocumentElement.SelectNodes('//cfdi:Emisor', NamespaceManager);
        IF NodeList.Count <> 0 THEN BEGIN
            Node := NodeList.Item(0);
            VAT := Node.Attributes.GetNamedItem('rfc').Value;
        END ELSE
            ERROR(ImportFailedErr);

        NodeList := xmlDoc.DocumentElement.SelectNodes('//cfdi:Comprobante', NamespaceManager);
        IF NodeList.Count <> 0 THEN BEGIN
            Node := NodeList.Item(0);
            EVALUATE(TotalInvoice, Node.Attributes.GetNamedItem('total').Value);
            PaymentMethod := COPYSTR(Node.Attributes.GetNamedItem('metodoDePago').Value, 1, 50);
            CertifiedNo := Node.Attributes.GetNamedItem('noCertificado').Value;

            IF HasAttribute(Node, 'serie') AND HasAttribute(Node, 'folio') THEN
                FolioInvoice := COPYSTR(Node.Attributes.GetNamedItem('serie').Value + '-' + Node.Attributes.GetNamedItem('folio').Value, 1, 50)
            ELSE IF HasAttribute(Node, 'folio') THEN FolioInvoice := COPYSTR(Node.Attributes.GetNamedItem('folio').Value, 1, 50);

            IF HasAttribute(Node, 'Moneda') THEN BEGIN
                Currency := COPYSTR(Node.Attributes.GetNamedItem('Moneda').Value, 1, 50);
                IF HasAttribute(Node, 'TipoCambio') THEN
                    IF NOT EVALUATE(CurrencyFactor, Node.Attributes.GetNamedItem('TipoCambio').Value) THEN
                        CurrencyFactor := 1.0
                    ELSE
                        CurrencyFactor := 1.0;

            END ELSE BEGIN
                Currency := 'MXN';
                CurrencyFactor := 1.0;
            END;
        END ELSE
            ERROR(ImportFailedErr);

        NodeList := xmlDoc.DocumentElement.SelectNodes('//cfdi:Receptor', NamespaceManager);
        IF NodeList.Count <> 0 THEN BEGIN
            Node := NodeList.Item(0);
            "VAT Receptor" := Node.Attributes.GetNamedItem('rfc').Value;
        END ELSE
            ERROR(ImportFailedErr);
    end;

    local procedure HasAttribute(xmlElement: XmlElement; AttributeName: Text): Boolean
    var
        Indice: Integer;
        xmlNode: XmlNode;
    begin
        IF NOT xmlElement.HasAttributes THEN EXIT(FALSE);

        xmlNode := xmlElement;
        FOR Indice := 0 TO xmlNode.Attributes.Count - 1 DO
            IF xmlNode.Attributes.ItemOf(Indice).Name = AttributeName THEN EXIT(TRUE);
        EXIT(FALSE)
    end;

    local procedure "---Validates---"()
    begin
    end;

    local procedure FindUUID(UUID: Code[36])
    var
        GLEntry: Record 17;
        CustLedgEntry: Record 21;
        VendLedgEntry: Record 25;
        SalesInvHeader: Record 112;
        SalesCrMHeader: Record 114;
        PurchInvHeader: Record 122;
        PurchCrMHeader: Record 124;
        SalesInvXMLData: Record 50036;
        Err_UUID_CLedger: Label 'UUID %1 already assigned at customer entry no %2', Comment = '%1 %2';
        Err_UUID_GL: Label 'UUID %1 already assigned at account entry no %2', Comment = '%1 %2';
        Err_UUID_PCrM: Label 'UUID %1 already assigned at Pruchase Credit Memo %2', Comment = '%1 %2';
        Err_UUID_PInv: Label 'UUID %1 already assigned at  purchase invoice %2', Comment = '%1 %2';
        Err_UUID_VCrM: Label 'UUID %1 already assigned at sales credit memo %2', Comment = '%1 %2';
        Err_UUID_VInv: Label 'UUID %1 already assigned at sales invoice %2', Comment = '%1 %2';
        Err_UUID_VLedger: Label 'UUID %1 already assigned at Vendor entry no %2', Comment = '%1 %2';
    begin
        PurchInvHeader.RESET();
        PurchCrMHeader.RESET();
        VendLedgEntry.RESET();
        GLEntry.RESET();
        SalesInvHeader.RESET();
        SalesCrMHeader.RESET();
        CustLedgEntry.RESET();
        SalesInvXMLData.RESET();

        PurchInvHeader.SETFILTER("XML - UUID", UUID);
        IF PurchInvHeader.FIND('-') THEN ERROR(Err_UUID_PInv, UUID, PurchInvHeader."No.");

        PurchCrMHeader.SETFILTER("XML - UUID", UUID);
        IF PurchCrMHeader.FIND('-') THEN ERROR(Err_UUID_PCrM, UUID, PurchCrMHeader."No.");

        VendLedgEntry.SETFILTER("XML - UUID", UUID);
        IF VendLedgEntry.FIND('-') THEN ERROR(Err_UUID_VLedger, UUID, VendLedgEntry."Entry No.");

        GLEntry.SETFILTER("XML - UUID", UUID);
        IF GLEntry.FIND('-') THEN ERROR(Err_UUID_GL, UUID, GLEntry."Entry No.");

        SalesInvXMLData.SETFILTER("XML - UUID", UUID);
        IF SalesInvXMLData.FIND('-') THEN ERROR(Err_UUID_VInv, UUID, SalesInvXMLData."No.");

        SalesCrMHeader.SETFILTER("XML - UUID", UUID);
        IF SalesCrMHeader.FIND('-') THEN ERROR(Err_UUID_VCrM, UUID, SalesCrMHeader."No.");

        CustLedgEntry.SETFILTER("XML - UUID", UUID);
        IF CustLedgEntry.FIND('-') THEN ERROR(Err_UUID_CLedger, UUID, CustLedgEntry."Entry No.");
    end;

    local procedure ValidateRFC(RFC: Code[13]; No: Code[20]; Doc: Integer)
    var
        Customer: Record 18;
        Vendor: Record 23;
        CompanyInformation: Record 79;
        Err_PurchEm: Label 'VAT %1 it doesn''t match with VAT %2 registered to vendor %3', Comment = '%1 %2 %3';
        Err_SalesEm_PurchRc: Label 'VAT %1  it doesn''t match with VAT %2 registered to company', Comment = '%1 %2';
        Err_SalesRc: Label 'VAT %1 it doesn''t match with VAT %2  registered by customer %3', Comment = '%1 %2 %3';
    begin
        CASE Doc OF
            1:
                BEGIN //Sales - Receptor
                    Customer.GET(No);
                    IF RFC <> Customer."VAT Registration No." THEN ERROR(Err_SalesRc, RFC, Customer."VAT Registration No.", Customer.Name);
                END;
            2:
                BEGIN//Sales - Emisor & Purch - Receptor
                    CompanyInformation.RESET();
                    CompanyInformation.FIND('-');
                    IF RFC <> CompanyInformation."VAT Registration No." THEN ERROR(Err_SalesEm_PurchRc, RFC, CompanyInformation."VAT Registration No.");
                END;
            3:
                BEGIN
                    Vendor.GET(No);
                    IF Vendor."VAT Registration No." <> RFC THEN ERROR(Err_PurchEm, RFC, Vendor."VAT Registration No.", Vendor.Name);
                END;
        END;
    end;

    local procedure ValidateAmount(DocAmount: Decimal; FileAmount: Decimal)
    var
        GeneralLedgerSetup: Record 50035;
        minAmount: Decimal;
        plusAmount: Decimal;
        eText001: Label 'The amount in the document %1 does not match with the amount in XMl file %2.',Comment = '%1 %2';
    begin
        GeneralLedgerSetup.GET();
        plusAmount := DocAmount + GeneralLedgerSetup."EA Variant Amount";
        minAmount := DocAmount - GeneralLedgerSetup."EA Variant Amount";
        IF NOT ((FileAmount <= plusAmount) AND (FileAmount >= minAmount)) THEN
            ERROR(eText001, DocAmount, FileAmount);
    end;

    local procedure ValidateDate(DocDate: Date; FileDate: Date)
    var
        GeneralLedgerSetup: Record 98;
        eText001: Label 'The Date in the document %1 does not match with the Date in XMl file %2.', Comment = '%1 %2';
    begin
        GeneralLedgerSetup.GET();
        IF DocDate <> FileDate THEN ERROR(eText001, FORMAT(DocDate), FORMAT(FileDate));
    end;

    local procedure GetDateFromStr(DateStr: Text): Date
    var
        day: Integer;
        month: Integer;
        year: Integer;
    begin
        EVALUATE(year, COPYSTR(DateStr, 1, 4));
        EVALUATE(month, COPYSTR(DateStr, 6, 2));
        EVALUATE(day, COPYSTR(DateStr, 9, 2));

        EXIT(DMY2DATE(day, month, year));
    end;

    local procedure "---Status--"()
    begin
    end;

    procedure PurchInvHeaderHavePDF(PurchInv: Record 122) result: Boolean
    begin
        IF PurchInv.PDF.HASVALUE THEN EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure PurchCrMemoHdrHavePDF(PurchCrMemo: Record 124) result: Boolean
    begin
        IF PurchCrMemo.PDF.HASVALUE THEN EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure SalesInvHeaderHavePDF(SalesInvHeader: Record 112) result: Boolean
    var
        SalesInvXMLData: Record 50036;
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN
            IF SalesInvXMLData.PDF.HASVALUE THEN EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure SalesCrMemoHdrHavePDF(SalesCrMemoHdr: Record 114) result: Boolean
    begin
        IF SalesCrMemoHdr.PDF.HASVALUE THEN EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure "---TransferFields---"()
    begin
    end;

    procedure TransferGenJnlLineToDtldCVLedgEntryBuf(GenJnlLine: Record 81; var DtldCVLedgEntryBuf: Record 383)
    begin
        DtldCVLedgEntryBuf."XML - UUID" := GenJnlLine."XML - UUID";
        DtldCVLedgEntryBuf."XML - Invoice Folio" := GenJnlLine."XML - Invoice Folio";
        DtldCVLedgEntryBuf."XML - Certified No" := GenJnlLine."XML - Certified No";
        DtldCVLedgEntryBuf."XML - SAT Certified No" := GenJnlLine."XML - SAT Certified No";
        DtldCVLedgEntryBuf."XML - Date/Time Stamped" := GenJnlLine."XML - Date/Time Stamped";
        DtldCVLedgEntryBuf."XML - VAT Registration No" := GenJnlLine."XML - VAT Registration No";
        DtldCVLedgEntryBuf."XML - VAT Receptor" := GenJnlLine."XML - VAT Receptor";
        DtldCVLedgEntryBuf."XML - Total Invoice" := GenJnlLine."XML - Total Invoice";
        DtldCVLedgEntryBuf."XML - Payment Method" := GenJnlLine."XML - Payment Method";
        DtldCVLedgEntryBuf."XML - Currency" := GenJnlLine."XML - Currency";
        DtldCVLedgEntryBuf."XML - Currency Factor" := GenJnlLine."XML - Currency Factor";
    end;

    procedure TrasnferCVLedgEntryBufToCustLedgEntry(CVLedgEntryBuf: Record 382; var CutLedgEntry: Record 21)
    begin
        CutLedgEntry."XML - UUID" := CVLedgEntryBuf."XML - UUID";
        CutLedgEntry."XML - Invoice Folio" := CVLedgEntryBuf."XML - Invoice Folio";
        CutLedgEntry."XML - Certified No" := CVLedgEntryBuf."XML - Certified No";
        CutLedgEntry."XML - SAT Certified No" := CVLedgEntryBuf."XML - SAT Certified No";
        CutLedgEntry."XML - Date/Time Stamped" := CVLedgEntryBuf."XML - Date/Time Stamped";
        CutLedgEntry."XML - VAT Registration No" := CVLedgEntryBuf."XML - VAT Registration No";
        CutLedgEntry."XML - VAT Receptor" := CVLedgEntryBuf."XML - VAT Receptor";
        CutLedgEntry."XML - Total Invoice" := CVLedgEntryBuf."XML - Total Invoice";
        CutLedgEntry."XML - Payment Method" := CVLedgEntryBuf."XML - Payment Method";
        CutLedgEntry."XML - Currency" := CVLedgEntryBuf."XML - Currency";
        CutLedgEntry."XML - Currency Factor" := CVLedgEntryBuf."XML - Currency Factor";
    end;

    procedure TransferGenJnlLineToCustLedgEntry(GenJnlLine: Record 81; var CustLedgEntry: Record 21)
    begin
        CustLedgEntry."XML - UUID" := GenJnlLine."XML - UUID";
        CustLedgEntry."XML - Invoice Folio" := GenJnlLine."XML - Invoice Folio";
        CustLedgEntry."XML - Certified No" := GenJnlLine."XML - Certified No";
        CustLedgEntry."XML - SAT Certified No" := GenJnlLine."XML - SAT Certified No";
        CustLedgEntry."XML - Date/Time Stamped" := GenJnlLine."XML - Date/Time Stamped";
        CustLedgEntry."XML - VAT Registration No" := GenJnlLine."XML - VAT Registration No";
        CustLedgEntry."XML - VAT Receptor" := GenJnlLine."XML - VAT Receptor";
        CustLedgEntry."XML - Total Invoice" := GenJnlLine."XML - Total Invoice";
        CustLedgEntry."XML - Payment Method" := GenJnlLine."XML - Payment Method";
        CustLedgEntry."XML - Currency" := GenJnlLine."XML - Currency";
        CustLedgEntry."XML - Currency Factor" := GenJnlLine."XML - Currency Factor";
    end;

    procedure TransferGenJnlLineToGLEntry(GenJnlLine: Record 81; var GLEntry: Record 17)
    begin
        GLEntry."XML - UUID" := GenJnlLine."XML - UUID";
        GLEntry."XML - Invoice Folio" := GenJnlLine."XML - Invoice Folio";
        GLEntry."XML - Certified No" := GenJnlLine."XML - Certified No";
        GLEntry."XML - SAT Certified No" := GenJnlLine."XML - SAT Certified No";
        GLEntry."XML - Date/Time Stamped" := GenJnlLine."XML - Date/Time Stamped";
        GLEntry."XML - VAT Registration No" := GenJnlLine."XML - VAT Registration No";
        GLEntry."XML - VAT Receptor" := GenJnlLine."XML - VAT Receptor";
        GLEntry."XML - Total Invoice" := GenJnlLine."XML - Total Invoice";
        GLEntry."XML - Payment Method" := GenJnlLine."XML - Payment Method";
        GLEntry."XML - Currency" := GenJnlLine."XML - Currency";
        GLEntry."XML - Currency Factor" := GenJnlLine."XML - Currency Factor";
        GLEntry."Pymt - Payment Method" := GenJnlLine."Pymt - Payment Method";
        GLEntry."Pymt - Bank Source Code" := GenJnlLine."Pymt - Bank Source Code";
        GLEntry."Pymt - Bank Source Account" := GenJnlLine."Pymt - Bank Source Account";
        GLEntry."Pymt - Bank Source Foreign" := GenJnlLine."Pymt - Bank Source Foreign";
        GLEntry."Pymt - Bank Target Code" := GenJnlLine."Pymt - Bank Target Code";
        GLEntry."Pymt - Bank Target Account" := GenJnlLine."Pymt - Bank Target Account";
        GLEntry."Pymt - Bank Target Foreign" := GenJnlLine."Pymt - Bank Target Foreign";
        GLEntry."Pymt - Currency Code" := GenJnlLine."Pymt - Currency Code";
        GLEntry."Pymt - Currency Factor" := GenJnlLine."Pymt - Currency Factor";
        GLEntry."Pymt - Beneficiary" := GenJnlLine."Pymt - Beneficiary";
        GLEntry."Pymt - VAT Beneficiary" := GenJnlLine."Pymt - VAT Beneficiary";
    end;

    procedure TransferGenJnlLineToVendLedgEntry(GenJnlLine: Record 81; var VendLedgEntry: Record 25)
    begin
        VendLedgEntry."XML - UUID" := GenJnlLine."XML - UUID";
        VendLedgEntry."XML - Invoice Folio" := GenJnlLine."XML - Invoice Folio";
        VendLedgEntry."XML - Certified No" := GenJnlLine."XML - Certified No";
        VendLedgEntry."XML - SAT Certified No" := GenJnlLine."XML - SAT Certified No";
        VendLedgEntry."XML - Date/Time Stamped" := GenJnlLine."XML - Date/Time Stamped";
        VendLedgEntry."XML - VAT Registration No" := GenJnlLine."XML - VAT Registration No";
        VendLedgEntry."XML - VAT Receptor" := GenJnlLine."XML - VAT Receptor";
        VendLedgEntry."XML - Total Invoice" := GenJnlLine."XML - Total Invoice";
        VendLedgEntry."XML - Payment Method" := GenJnlLine."XML - Payment Method";
        VendLedgEntry."XML - Currency" := GenJnlLine."XML - Currency";
        VendLedgEntry."XML - Currency Factor" := GenJnlLine."XML - Currency Factor";
    end;

    local procedure TransSalesInvToCustLedgEntry(SalesinvHeader: Record 112; var CustLedgEntry: Record 21)
    var
        SalesInvXMLData: Record 50036;
    begin
        IF SalesInvXMLData.GET(SalesinvHeader."No.") THEN BEGIN
            CustLedgEntry."XML - UUID" := SalesInvXMLData."XML - UUID";
            CustLedgEntry."XML - Invoice Folio" := SalesInvXMLData."XML - Invoice Folio";
            CustLedgEntry."XML - Certified No" := SalesInvXMLData."XML - Certified No";
            CustLedgEntry."XML - SAT Certified No" := SalesInvXMLData."XML - SAT Certified No";
            CustLedgEntry."XML - Date/Time Stamped" := SalesInvXMLData."XML - Date/Time Stamped";
            CustLedgEntry."XML - VAT Registration No" := SalesInvXMLData."XML - VAT Registration No";
            CustLedgEntry."XML - VAT Receptor" := SalesInvXMLData."XML - VAT Receptor";
            CustLedgEntry."XML - Total Invoice" := SalesInvXMLData."XML - Total Invoice";
            CustLedgEntry."XML - Payment Method" := SalesInvXMLData."XML - Payment Method";
            CustLedgEntry."XML - Currency" := SalesInvXMLData."XML - Currency";
            CustLedgEntry."XML - Currency Factor" := SalesInvXMLData."XML - Currency Factor";
            CustLedgEntry.MODIFY();
        END;
    end;

    local procedure TransSalesInvToDtldCustLedgEntry(SalesinvHeader: Record 112; var DtldCustLedgEntry: Record 379)
    var
        SalesInvXMLData: Record 50036;
    begin
        IF SalesInvXMLData.GET(SalesinvHeader."No.") THEN BEGIN
            DtldCustLedgEntry."XML - UUID" := SalesInvXMLData."XML - UUID";
            DtldCustLedgEntry."XML - Invoice Folio" := SalesInvXMLData."XML - Invoice Folio";
            DtldCustLedgEntry."XML - Certified No" := SalesInvXMLData."XML - Certified No";
            DtldCustLedgEntry."XML - SAT Certified No" := SalesInvXMLData."XML - SAT Certified No";
            DtldCustLedgEntry."XML - Date/Time Stamped" := SalesInvXMLData."XML - Date/Time Stamped";
            DtldCustLedgEntry."XML - VAT Registration No" := SalesInvXMLData."XML - VAT Registration No";
            DtldCustLedgEntry."XML - VAT Receptor" := SalesInvXMLData."XML - VAT Receptor";
            DtldCustLedgEntry."XML - Total Invoice" := SalesInvXMLData."XML - Total Invoice";
            DtldCustLedgEntry."XML - Payment Method" := SalesInvXMLData."XML - Payment Method";
            DtldCustLedgEntry."XML - Currency" := SalesInvXMLData."XML - Currency";
            DtldCustLedgEntry."XML - Currency Factor" := SalesInvXMLData."XML - Currency Factor";
            DtldCustLedgEntry.MODIFY();
        END;
    end;

    local procedure TransSalesInvToGLEntry(SalesInvHeader: Record 112; var GLEntry: Record 17)
    var
        SalesInvXMLData: Record 50036;
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN BEGIN
            GLEntry."XML - UUID" := SalesInvXMLData."XML - UUID";
            GLEntry."XML - Invoice Folio" := SalesInvXMLData."XML - Invoice Folio";
            GLEntry."XML - Certified No" := SalesInvXMLData."XML - Certified No";
            GLEntry."XML - SAT Certified No" := SalesInvXMLData."XML - SAT Certified No";
            GLEntry."XML - Date/Time Stamped" := SalesInvXMLData."XML - Date/Time Stamped";
            GLEntry."XML - VAT Registration No" := SalesInvXMLData."XML - VAT Registration No";
            GLEntry."XML - VAT Receptor" := SalesInvXMLData."XML - VAT Receptor";
            GLEntry."XML - Total Invoice" := SalesInvXMLData."XML - Total Invoice";
            GLEntry."XML - Payment Method" := SalesInvXMLData."XML - Payment Method";
            GLEntry."XML - Currency" := SalesInvXMLData."XML - Currency";
            GLEntry."XML - Currency Factor" := SalesInvXMLData."XML - Currency Factor";
            GLEntry.MODIFY();
        END;
    end;

    local procedure UpdateDocsRelatedToSalesInvHeader(SalesInvHeader: Record 112)
    var
        GLEntry: Record 17;
        CustLedgEntry: Record 21;
        DtldCustLedgEntry: Record 379;
    begin
        CustLedgEntry.GET(SalesInvHeader."Cust. Ledger Entry No.");
        TransSalesInvToCustLedgEntry(SalesInvHeader, CustLedgEntry);

        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETFILTER("Cust. Ledger Entry No.", '%1', CustLedgEntry."Entry No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                TransSalesInvToDtldCustLedgEntry(SalesInvHeader, DtldCustLedgEntry);
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETFILTER("Applied Cust. Ledger Entry No.", '%1', CustLedgEntry."Entry No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                TransSalesInvToDtldCustLedgEntry(SalesInvHeader, DtldCustLedgEntry);
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        GLEntry.RESET();
        GLEntry.SETFILTER("Document No.", SalesInvHeader."No.");
        //GLEntry.SETFILTER("Document Type",'%1',GLEntry."Document Type"::Sale);
        IF GLEntry.FIND('-') THEN
            REPEAT
                TransSalesInvToGLEntry(SalesInvHeader, GLEntry);
            UNTIL GLEntry.NEXT() = 0;
    end;

    local procedure TransSalesCrMToCustLedgEntry(SalesCrMHeader: Record 114; var CustLedgEntry: Record 21)
    begin
        CustLedgEntry."XML - UUID" := SalesCrMHeader."XML - UUID";
        CustLedgEntry."XML - Invoice Folio" := SalesCrMHeader."XML - Invoice Folio";
        CustLedgEntry."XML - Certified No" := SalesCrMHeader."XML - Certified No";
        CustLedgEntry."XML - SAT Certified No" := SalesCrMHeader."XML - SAT Certified No";
        CustLedgEntry."XML - Date/Time Stamped" := SalesCrMHeader."XML - Date/Time Stamped";
        CustLedgEntry."XML - VAT Registration No" := SalesCrMHeader."XML - VAT Registration No";
        CustLedgEntry."XML - VAT Receptor" := SalesCrMHeader."XML - VAT Receptor";
        CustLedgEntry."XML - Total Invoice" := SalesCrMHeader."XML - Total Invoice";
        CustLedgEntry."XML - Payment Method" := SalesCrMHeader."XML - Payment Method";
        CustLedgEntry."XML - Currency" := SalesCrMHeader."XML - Currency";
        CustLedgEntry."XML - Currency Factor" := SalesCrMHeader."XML - Currency Factor";
        CustLedgEntry.MODIFY();
    end;

    local procedure TransSalesCrMToDtldCustLedgEntry(SalesCrMHeader: Record 114; var DtldCustLedgEntry: Record 379)
    begin
        DtldCustLedgEntry."XML - UUID" := SalesCrMHeader."XML - UUID";
        DtldCustLedgEntry."XML - Invoice Folio" := SalesCrMHeader."XML - Invoice Folio";
        DtldCustLedgEntry."XML - Certified No" := SalesCrMHeader."XML - Certified No";
        DtldCustLedgEntry."XML - SAT Certified No" := SalesCrMHeader."XML - SAT Certified No";
        DtldCustLedgEntry."XML - Date/Time Stamped" := SalesCrMHeader."XML - Date/Time Stamped";
        DtldCustLedgEntry."XML - VAT Registration No" := SalesCrMHeader."XML - VAT Registration No";
        DtldCustLedgEntry."XML - VAT Receptor" := SalesCrMHeader."XML - VAT Receptor";
        DtldCustLedgEntry."XML - Total Invoice" := SalesCrMHeader."XML - Total Invoice";
        DtldCustLedgEntry."XML - Payment Method" := SalesCrMHeader."XML - Payment Method";
        DtldCustLedgEntry."XML - Currency" := SalesCrMHeader."XML - Currency";
        DtldCustLedgEntry."XML - Currency Factor" := SalesCrMHeader."XML - Currency Factor";
        DtldCustLedgEntry.MODIFY();
    end;

    local procedure TransSalesCrMToGLEntry(SalesCrMHeader: Record 114; var GLEntry: Record 17)
    begin
        GLEntry."XML - UUID" := SalesCrMHeader."XML - UUID";
        GLEntry."XML - Invoice Folio" := SalesCrMHeader."XML - Invoice Folio";
        GLEntry."XML - Certified No" := SalesCrMHeader."XML - Certified No";
        GLEntry."XML - SAT Certified No" := SalesCrMHeader."XML - SAT Certified No";
        GLEntry."XML - Date/Time Stamped" := SalesCrMHeader."XML - Date/Time Stamped";
        GLEntry."XML - VAT Registration No" := SalesCrMHeader."XML - VAT Registration No";
        GLEntry."XML - VAT Receptor" := SalesCrMHeader."XML - VAT Receptor";
        GLEntry."XML - Total Invoice" := SalesCrMHeader."XML - Total Invoice";
        GLEntry."XML - Payment Method" := SalesCrMHeader."XML - Payment Method";
        GLEntry."XML - Currency" := SalesCrMHeader."XML - Currency";
        GLEntry."XML - Currency Factor" := SalesCrMHeader."XML - Currency Factor";
        GLEntry.MODIFY();
    end;

    local procedure UpdateDocsRelatedToSalesCrMHeader(SalesCrMHeader: Record 114)
    var
        GLEntry: Record 17;
        CustLedgEntry: Record 21;
        DtldCustLedgEntry: Record 379;
    begin
        CustLedgEntry.GET(SalesCrMHeader."Cust. Ledger Entry No.");
        TransSalesCrMToCustLedgEntry(SalesCrMHeader, CustLedgEntry);

        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETFILTER("Cust. Ledger Entry No.", '%1', SalesCrMHeader."Cust. Ledger Entry No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                TransSalesCrMToDtldCustLedgEntry(SalesCrMHeader, DtldCustLedgEntry);
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETFILTER("Applied Cust. Ledger Entry No.", '%1', SalesCrMHeader."Cust. Ledger Entry No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                TransSalesCrMToDtldCustLedgEntry(SalesCrMHeader, DtldCustLedgEntry);
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        GLEntry.RESET();
        GLEntry.SETFILTER("Document No.", SalesCrMHeader."No.");
        //GLEntry.SETFILTER("Document Type",'%1',GLEntry."Document Type"::Credit Memo);
        IF GLEntry.FIND('-') THEN
            REPEAT
                TransSalesCrMToGLEntry(SalesCrMHeader, GLEntry);
            UNTIL GLEntry.NEXT() = 0;
    end;

    local procedure TransPurchInvToVendLedgEntry(PurchInvHeader: Record 122; var CustLedgEntry: Record 25)
    begin
        CustLedgEntry."XML - UUID" := PurchInvHeader."XML - UUID";
        CustLedgEntry."XML - Invoice Folio" := PurchInvHeader."XML - Invoice Folio";
        CustLedgEntry."XML - Certified No" := PurchInvHeader."XML - Certified No";
        CustLedgEntry."XML - SAT Certified No" := PurchInvHeader."XML - SAT Certified No";
        CustLedgEntry."XML - Date/Time Stamped" := PurchInvHeader."XML - Date/Time Stamped";
        CustLedgEntry."XML - VAT Registration No" := PurchInvHeader."XML - VAT Registration No";
        CustLedgEntry."XML - VAT Receptor" := PurchInvHeader."XML - VAT Receptor";
        CustLedgEntry."XML - Total Invoice" := PurchInvHeader."XML - Total Invoice";
        CustLedgEntry."XML - Payment Method" := PurchInvHeader."XML - Payment Method";
        CustLedgEntry."XML - Currency" := PurchInvHeader."XML - Currency";
        CustLedgEntry."XML - Currency Factor" := PurchInvHeader."XML - Currency Factor";
        CustLedgEntry.MODIFY();
    end;

    local procedure TransPurchInvToDtldVendLedgEntry(PurchInvHeader: Record 122; var DtldCustLedgEntry: Record 380)
    begin
        DtldCustLedgEntry."XML - UUID" := PurchInvHeader."XML - UUID";
        DtldCustLedgEntry."XML - Invoice Folio" := PurchInvHeader."XML - Invoice Folio";
        DtldCustLedgEntry."XML - Certified No" := PurchInvHeader."XML - Certified No";
        DtldCustLedgEntry."XML - SAT Certified No" := PurchInvHeader."XML - SAT Certified No";
        DtldCustLedgEntry."XML - Date/Time Stamped" := PurchInvHeader."XML - Date/Time Stamped";
        DtldCustLedgEntry."XML - VAT Registration No" := PurchInvHeader."XML - VAT Registration No";
        DtldCustLedgEntry."XML - VAT Receptor" := PurchInvHeader."XML - VAT Receptor";
        DtldCustLedgEntry."XML - Total Invoice" := PurchInvHeader."XML - Total Invoice";
        DtldCustLedgEntry."XML - Payment Method" := PurchInvHeader."XML - Payment Method";
        DtldCustLedgEntry."XML - Currency" := PurchInvHeader."XML - Currency";
        DtldCustLedgEntry."XML - Currency Factor" := PurchInvHeader."XML - Currency Factor";
        DtldCustLedgEntry.MODIFY();
    end;

    local procedure TransPurchInvToGLEntry(PurchInvHeader: Record 122; var GLEntry: Record 17)
    begin
        GLEntry."XML - UUID" := PurchInvHeader."XML - UUID";
        GLEntry."XML - Invoice Folio" := PurchInvHeader."XML - Invoice Folio";
        GLEntry."XML - Certified No" := PurchInvHeader."XML - Certified No";
        GLEntry."XML - SAT Certified No" := PurchInvHeader."XML - SAT Certified No";
        GLEntry."XML - Date/Time Stamped" := PurchInvHeader."XML - Date/Time Stamped";
        GLEntry."XML - VAT Registration No" := PurchInvHeader."XML - VAT Registration No";
        GLEntry."XML - VAT Receptor" := PurchInvHeader."XML - VAT Receptor";
        GLEntry."XML - Total Invoice" := PurchInvHeader."XML - Total Invoice";
        GLEntry."XML - Payment Method" := PurchInvHeader."XML - Payment Method";
        GLEntry."XML - Currency" := PurchInvHeader."XML - Currency";
        GLEntry."XML - Currency Factor" := PurchInvHeader."XML - Currency Factor";
        GLEntry.MODIFY();
    end;

    local procedure UpdateDocsRelatedToPurchInvHeader(PurchInvHeader: Record 122)
    var
        GLEntry: Record 17;
        VendLedgEntry: Record 25;
        VendLedgEntry2: Record 25;
        DtldVendLedgEntry: Record 380;
        DtldVendLedgEntry2: Record 380;
    begin
        IF NOT VendLedgEntry.GET(PurchInvHeader."Vendor Ledger Entry No.") THEN BEGIN
            VendLedgEntry.RESET();
            VendLedgEntry.SETFILTER(VendLedgEntry."Vendor No.", PurchInvHeader."Buy-from Vendor No.");
            VendLedgEntry.SETFILTER(VendLedgEntry."Document Type", '%1', VendLedgEntry."Document Type"::Invoice);
            VendLedgEntry.SETFILTER(VendLedgEntry."Document No.", PurchInvHeader."No.");
            IF NOT VendLedgEntry.FIND('-') THEN EXIT;
        END;
        TransPurchInvToVendLedgEntry(PurchInvHeader, VendLedgEntry);

        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETFILTER("Vendor Ledger Entry No.", '%1', VendLedgEntry."Entry No.");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                TransPurchInvToDtldVendLedgEntry(PurchInvHeader, DtldVendLedgEntry);
                IF (DtldVendLedgEntry."Applied Vend. Ledger Entry No." <> 0) AND (DtldVendLedgEntry."Applied Vend. Ledger Entry No." <> DtldVendLedgEntry."Vendor Ledger Entry No.") THEN BEGIN
                    VendLedgEntry2.GET(DtldVendLedgEntry."Applied Vend. Ledger Entry No.");
                    TransPurchInvToVendLedgEntry(PurchInvHeader, VendLedgEntry2);

                    DtldVendLedgEntry2.RESET();
                    DtldVendLedgEntry2.SETFILTER("Vendor Ledger Entry No.", '%1', VendLedgEntry2."Entry No.");
                    DtldVendLedgEntry2.SETFILTER("Document Type", '<>%1', VendLedgEntry2."Document Type"::Invoice);
                    DtldVendLedgEntry2.SETFILTER("Document Type", '<>%1', VendLedgEntry2."Document Type"::"Credit Memo");
                    IF DtldVendLedgEntry2.FIND('-') THEN
                        REPEAT
                            TransPurchInvToDtldVendLedgEntry(PurchInvHeader, DtldVendLedgEntry2);
                        UNTIL DtldVendLedgEntry2.NEXT() = 0;
                END;

            UNTIL DtldVendLedgEntry.NEXT() = 0;

        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETFILTER("Applied Vend. Ledger Entry No.", '%1', VendLedgEntry."Entry No.");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                TransPurchInvToDtldVendLedgEntry(PurchInvHeader, DtldVendLedgEntry);
            UNTIL DtldVendLedgEntry.NEXT() = 0;

        GLEntry.RESET();
        GLEntry.SETFILTER("Document No.", PurchInvHeader."No.");
        //GLEntry.SETFILTER("Document Type",'%1',GLEntry."Document Type"::Invoice);
        IF GLEntry.FIND('-') THEN
            REPEAT
                TransPurchInvToGLEntry(PurchInvHeader, GLEntry);
            UNTIL GLEntry.NEXT() = 0;
    end;

    local procedure TransPurchCrMToVendLedgEntry(PurchCrMHeader: Record "124"; var VendLedgEntry: Record "25")
    begin
        VendLedgEntry."XML - UUID" := PurchCrMHeader."XML - UUID";
        VendLedgEntry."XML - Invoice Folio" := PurchCrMHeader."XML - Invoice Folio";
        VendLedgEntry."XML - Certified No" := PurchCrMHeader."XML - Certified No";
        VendLedgEntry."XML - SAT Certified No" := PurchCrMHeader."XML - SAT Certified No";
        VendLedgEntry."XML - Date/Time Stamped" := PurchCrMHeader."XML - Date/Time Stamped";
        VendLedgEntry."XML - VAT Registration No" := PurchCrMHeader."XML - VAT Registration No";
        VendLedgEntry."XML - VAT Receptor" := PurchCrMHeader."XML - VAT Receptor";
        VendLedgEntry."XML - Total Invoice" := PurchCrMHeader."XML - Total Invoice";
        VendLedgEntry."XML - Payment Method" := PurchCrMHeader."XML - Payment Method";
        VendLedgEntry."XML - Currency" := PurchCrMHeader."XML - Currency";
        VendLedgEntry."XML - Currency Factor" := PurchCrMHeader."XML - Currency Factor";
        VendLedgEntry.MODIFY;
    end;

    local procedure TransPurchCrMToDtldVendLedgEntry(PurchCrMHeader: Record 124; var DtldVendLedgEntry: Record 380)
    begin
        DtldVendLedgEntry."XML - UUID" := PurchCrMHeader."XML - UUID";
        DtldVendLedgEntry."XML - Invoice Folio" := PurchCrMHeader."XML - Invoice Folio";
        DtldVendLedgEntry."XML - Certified No" := PurchCrMHeader."XML - Certified No";
        DtldVendLedgEntry."XML - SAT Certified No" := PurchCrMHeader."XML - SAT Certified No";
        DtldVendLedgEntry."XML - Date/Time Stamped" := PurchCrMHeader."XML - Date/Time Stamped";
        DtldVendLedgEntry."XML - VAT Registration No" := PurchCrMHeader."XML - VAT Registration No";
        DtldVendLedgEntry."XML - VAT Receptor" := PurchCrMHeader."XML - VAT Receptor";
        DtldVendLedgEntry."XML - Total Invoice" := PurchCrMHeader."XML - Total Invoice";
        DtldVendLedgEntry."XML - Payment Method" := PurchCrMHeader."XML - Payment Method";
        DtldVendLedgEntry."XML - Currency" := PurchCrMHeader."XML - Currency";
        DtldVendLedgEntry."XML - Currency Factor" := PurchCrMHeader."XML - Currency Factor";
        DtldVendLedgEntry.MODIFY();
    end;

    local procedure TransPurchCrMToGLEntry(PurchCrMHeader: Record 124; var GLEntry: Record 17)
    begin
        GLEntry."XML - UUID" := PurchCrMHeader."XML - UUID";
        GLEntry."XML - Invoice Folio" := PurchCrMHeader."XML - Invoice Folio";
        GLEntry."XML - Certified No" := PurchCrMHeader."XML - Certified No";
        GLEntry."XML - SAT Certified No" := PurchCrMHeader."XML - SAT Certified No";
        GLEntry."XML - Date/Time Stamped" := PurchCrMHeader."XML - Date/Time Stamped";
        GLEntry."XML - VAT Registration No" := PurchCrMHeader."XML - VAT Registration No";
        GLEntry."XML - VAT Receptor" := PurchCrMHeader."XML - VAT Receptor";
        GLEntry."XML - Total Invoice" := PurchCrMHeader."XML - Total Invoice";
        GLEntry."XML - Payment Method" := PurchCrMHeader."XML - Payment Method";
        GLEntry."XML - Currency" := PurchCrMHeader."XML - Currency";
        GLEntry."XML - Currency Factor" := PurchCrMHeader."XML - Currency Factor";
        GLEntry.MODIFY();
    end;

    local procedure UpdateDocRelatedToPurchCrMHeader(PurchCrMHeader: Record 124)
    var
        GLEntry: Record 17;
        VendLedgEntry: Record 25;
        DtldVendLedgEntry: Record 380;
    begin
        VendLedgEntry.GET(PurchCrMHeader."Vendor Ledger Entry No.");
        TransPurchCrMToVendLedgEntry(PurchCrMHeader, VendLedgEntry);

        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETFILTER("Vendor Ledger Entry No.", '%1', VendLedgEntry."Entry No.");
        //DtldVendLedgEntry.SETFILTER("Document Type",'%1',VendLedgEntry."Document Type");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                TransPurchCrMToDtldVendLedgEntry(PurchCrMHeader, DtldVendLedgEntry);
            UNTIL DtldVendLedgEntry.NEXT() = 0;

        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETFILTER("Applied Vend. Ledger Entry No.", '%1', VendLedgEntry."Entry No.");
        //DtldVendLedgEntry.SETFILTER("Document Type",'%1',VendLedgEntry."Document Type");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                TransPurchCrMToDtldVendLedgEntry(PurchCrMHeader, DtldVendLedgEntry);
            UNTIL DtldVendLedgEntry.NEXT() = 0;


        GLEntry.RESET();
        GLEntry.SETFILTER("Document No.", PurchCrMHeader."No.");
        //GLEntry.SETFILTER("Document Type",'%1',GLEntry."Document Type"::"Credit Memo");
        IF GLEntry.FIND('-') THEN
            REPEAT
                TransPurchCrMToGLEntry(PurchCrMHeader, GLEntry);
            UNTIL GLEntry.NEXT() = 0;
    end;

    procedure TransGenJnlLineToGenJnlLine(GenJnlLineSource: Record 81; var GenJnlLineTarget: Record 81)
    begin
        GenJnlLineTarget."XML - UUID" := GenJnlLineSource."XML - UUID";
        GenJnlLineTarget."XML - Invoice Folio" := GenJnlLineSource."XML - Invoice Folio";
        GenJnlLineTarget."XML - Certified No" := GenJnlLineSource."XML - Certified No";
        GenJnlLineTarget."XML - SAT Certified No" := GenJnlLineSource."XML - SAT Certified No";
        GenJnlLineTarget."XML - Date/Time Stamped" := GenJnlLineSource."XML - Date/Time Stamped";
        GenJnlLineTarget."XML - VAT Registration No" := GenJnlLineSource."XML - VAT Registration No";
        GenJnlLineTarget."XML - VAT Receptor" := GenJnlLineSource."XML - VAT Receptor";
        GenJnlLineTarget."XML - Total Invoice" := GenJnlLineSource."XML - Total Invoice";
        GenJnlLineTarget."XML - Payment Method" := GenJnlLineSource."XML - Payment Method";
        GenJnlLineTarget."XML - Currency" := GenJnlLineSource."XML - Currency";
        GenJnlLineTarget."XML - Currency Factor" := GenJnlLineSource."XML - Currency Factor";
        GenJnlLineTarget."Pymt - Payment Method" := GenJnlLineSource."Pymt - Payment Method";
        GenJnlLineTarget."Pymt - Bank Source Code" := GenJnlLineSource."Pymt - Bank Source Code";
        GenJnlLineTarget."Pymt - Bank Source Account" := GenJnlLineSource."Pymt - Bank Source Account";
        GenJnlLineTarget."Pymt - Bank Source Foreign" := GenJnlLineSource."Pymt - Bank Source Foreign";
        GenJnlLineTarget."Pymt - Bank Target Code" := GenJnlLineSource."Pymt - Bank Target Code";
        GenJnlLineTarget."Pymt - Bank Target Account" := GenJnlLineSource."Pymt - Bank Target Account";
        GenJnlLineTarget."Pymt - Bank Target Foreign" := GenJnlLineSource."Pymt - Bank Target Foreign";
        GenJnlLineTarget."Pymt - Currency Code" := GenJnlLineSource."Pymt - Currency Code";
        GenJnlLineTarget."Pymt - Currency Factor" := GenJnlLineSource."Pymt - Currency Factor";
        GenJnlLineTarget."Pymt - Beneficiary" := GenJnlLineSource."Pymt - Beneficiary";
        GenJnlLineTarget."Pymt - VAT Beneficiary" := GenJnlLineSource."Pymt - VAT Beneficiary";
    end;

    procedure UnApplyPayment(EntryNo: Integer)
    var
        GLEntry: Record 17;
        VendLedgEntry: Record 25;
        DtldVendLedgEntry: Record 380;
    begin
        //Firs Clear records
        VendLedgEntry.GET(EntryNo);
        VendLedgEntry."XML - UUID" := '';
        VendLedgEntry."XML - Invoice Folio" := '';
        VendLedgEntry."XML - Certified No" := '';
        VendLedgEntry."XML - SAT Certified No" := '';
        VendLedgEntry."XML - Date/Time Stamped" := '';
        VendLedgEntry."XML - VAT Registration No" := '';
        VendLedgEntry."XML - VAT Receptor" := '';
        VendLedgEntry."XML - Total Invoice" := 0.0;
        VendLedgEntry."XML - Payment Method" := '';
        VendLedgEntry."XML - Currency" := '';
        VendLedgEntry."XML - Currency Factor" := 0.0;
        VendLedgEntry.MODIFY();

        //Now Detailed Vendor Ledger Entry
        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgEntry."Entry No.");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                DtldVendLedgEntry."XML - UUID" := '';
                DtldVendLedgEntry."XML - Invoice Folio" := '';
                DtldVendLedgEntry."XML - Certified No" := '';
                DtldVendLedgEntry."XML - SAT Certified No" := '';
                DtldVendLedgEntry."XML - Date/Time Stamped" := '';
                DtldVendLedgEntry."XML - VAT Registration No" := '';
                DtldVendLedgEntry."XML - VAT Receptor" := '';
                DtldVendLedgEntry."XML - Total Invoice" := 0.0;
                DtldVendLedgEntry."XML - Payment Method" := '';
                DtldVendLedgEntry."XML - Currency" := '';
                DtldVendLedgEntry."XML - Currency Factor" := 0.0;
                DtldVendLedgEntry.MODIFY();
            UNTIL DtldVendLedgEntry.NEXT() = 0;
        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETRANGE("Applied Vend. Ledger Entry No.", VendLedgEntry."Entry No.");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                DtldVendLedgEntry."XML - UUID" := '';
                DtldVendLedgEntry."XML - Invoice Folio" := '';
                DtldVendLedgEntry."XML - Certified No" := '';
                DtldVendLedgEntry."XML - SAT Certified No" := '';
                DtldVendLedgEntry."XML - Date/Time Stamped" := '';
                DtldVendLedgEntry."XML - VAT Registration No" := '';
                DtldVendLedgEntry."XML - VAT Receptor" := '';
                DtldVendLedgEntry."XML - Total Invoice" := 0.0;
                DtldVendLedgEntry."XML - Payment Method" := '';
                DtldVendLedgEntry."XML - Currency" := '';
                DtldVendLedgEntry."XML - Currency Factor" := 0.0;
                DtldVendLedgEntry.MODIFY();
            UNTIL DtldVendLedgEntry.NEXT() = 0;
        //Finaly GL Entry
        GLEntry.RESET();
        GLEntry.SETRANGE("Document Type", VendLedgEntry."Document Type");
        GLEntry.SETRANGE(GLEntry."Document No.", VendLedgEntry."Document No.");
        IF GLEntry.FIND('-') THEN
            REPEAT
                GLEntry."XML - UUID" := '';
                GLEntry."XML - Invoice Folio" := '';
                GLEntry."XML - Certified No" := '';
                GLEntry."XML - SAT Certified No" := '';
                GLEntry."XML - Date/Time Stamped" := '';
                GLEntry."XML - VAT Registration No" := '';
                GLEntry."XML - VAT Receptor" := '';
                GLEntry."XML - Total Invoice" := 0.0;
                GLEntry."XML - Payment Method" := '';
                GLEntry."XML - Currency" := '';
                GLEntry."XML - Currency Factor" := 0.0;
                GLEntry.MODIFY();
            UNTIL GLEntry.NEXT() = 0;
    end;

    procedure UnApplyCharge(EntryNo: Integer)
    var
        GLEntry: Record 17;
        CustLedgEntry: Record 21;
        DtldCustLedgEntry: Record 379;
    begin
        CustLedgEntry.GET(EntryNo);

        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                DtldCustLedgEntry."XML - UUID" := '';
                DtldCustLedgEntry."XML - Invoice Folio" := '';
                DtldCustLedgEntry."XML - Certified No" := '';
                DtldCustLedgEntry."XML - SAT Certified No" := '';
                DtldCustLedgEntry."XML - Date/Time Stamped" := '';
                DtldCustLedgEntry."XML - VAT Registration No" := '';
                DtldCustLedgEntry."XML - VAT Receptor" := '';
                DtldCustLedgEntry."XML - Total Invoice" := 0.0;
                DtldCustLedgEntry."XML - Payment Method" := '';
                DtldCustLedgEntry."XML - Currency" := '';
                DtldCustLedgEntry."XML - Currency Factor" := 0.0;
                DtldCustLedgEntry.MODIFY();
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETRANGE("Applied Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                DtldCustLedgEntry."XML - UUID" := '';
                DtldCustLedgEntry."XML - Invoice Folio" := '';
                DtldCustLedgEntry."XML - Certified No" := '';
                DtldCustLedgEntry."XML - SAT Certified No" := '';
                DtldCustLedgEntry."XML - Date/Time Stamped" := '';
                DtldCustLedgEntry."XML - VAT Registration No" := '';
                DtldCustLedgEntry."XML - VAT Receptor" := '';
                DtldCustLedgEntry."XML - Total Invoice" := 0.0;
                DtldCustLedgEntry."XML - Payment Method" := '';
                DtldCustLedgEntry."XML - Currency" := '';
                DtldCustLedgEntry."XML - Currency Factor" := 0.0;
                DtldCustLedgEntry.MODIFY();
            UNTIL DtldCustLedgEntry.NEXT() = 0;

        GLEntry.RESET();
        GLEntry.SETRANGE(GLEntry."Document Type", CustLedgEntry."Document Type");
        GLEntry.SETRANGE("Document No.", CustLedgEntry."Document No.");
        IF GLEntry.FIND('-') THEN
            REPEAT
                GLEntry."XML - UUID" := '';
                GLEntry."XML - Invoice Folio" := '';
                GLEntry."XML - Certified No" := '';
                GLEntry."XML - SAT Certified No" := '';
                GLEntry."XML - Date/Time Stamped" := '';
                GLEntry."XML - VAT Registration No" := '';
                GLEntry."XML - VAT Receptor" := '';
                GLEntry."XML - Total Invoice" := 0.0;
                GLEntry."XML - Payment Method" := '';
                GLEntry."XML - Currency" := '';
                GLEntry."XML - Currency Factor" := 0.0;
                GLEntry.MODIFY();
            UNTIL GLEntry.NEXT() = 0;
    end;

    local procedure "----XMLs---"()
    begin
    end;

    local procedure CreateXMLHeader(var XMLDoc: XmlDocument; var RootNode: XmlNode; IDFile: Text; RootNodeName: Text; NodeNameSpace: Text; Year: Integer; Month: Integer; Version: Text)
    var
        CompanyInformation: Record 79;
        FullNameSpace: Text;
    begin
        CompanyInformation.GET();
        XMLDoc := XMLDoc;
        FullNameSpace := NamespaceTxt + NodeNameSpace;
        XMLDOMManagement.AddRootElementWithPrefix(XMLDoc, IDFile, '', FullNameSpace, RootNode);

        XMLDOMManagement.AddAttribute(RootNode, 'Version', Version);
        XMLDOMManagement.AddAttribute(RootNode, 'RFC', FORMAT(CompanyInformation."VAT Registration No."));
        XMLDOMManagement.AddAttribute(RootNode, 'Mes', FORMAT(Month, 2, '<Integer,2><Filler Character,0>'));
        XMLDOMManagement.AddAttribute(RootNode, 'Anio', FORMAT(Year));
        XMLDOMManagement.AddAttributeWithPrefix(RootNode, 'schemaLocation', 'xsi',
          NamespaceW3Txt, FullNameSpace + ' ' + 'http://' + FullNameSpace + '/' + NodeNameSpace + '_1_1.xsd');

        XMLDOMManagement.AddDeclaration(XMLDoc, '1.0', 'UTF-8', '');
    end;

    procedure ExportChartOfAccounts(Year: Integer; Month: Integer; ScheduleName: Code[10])
    var
        CompanyInformation: Record 79;
        AccScheduleLine: Record 85;
        GeneralLedgerSetup: Record 50035;
        TempBigText: BigText;
        Err_SATCode: Label 'Account %1 doesn''t have code SAT',Comment = '%1';
        Err_SATNature: Label 'Account %1 doesn''t have nature',Comment = '%1';
        Namespace: Text;
        Document: XmlDocument;
        Node: XmlNode;
        RootNode: XmlNode;
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("SAT XML Path");

        CompanyInformation.GET();
        CompanyInformation.TESTFIELD("VAT Registration No.");

        Namespace := NamespaceTxt + CatalogoNamespaceTxt;

        CreateXMLHeader(Document, RootNode, CatalogoIdText, CatalogoNodeTxt, CatalogoNamespaceTxt, Year, Month, '1.1');

        AccScheduleLine.RESET();
        AccScheduleLine.SETRANGE("Schedule Name", ScheduleName);
        AccScheduleLine.SETFILTER("Schedule Name", ScheduleName);
        AccScheduleLine.SETFILTER("Row No.", '<>%1', '');
        IF AccScheduleLine.FINDSET() THEN
            REPEAT
                IF AccScheduleLine."SAT Account Code" = '' THEN ERROR(Err_SATCode, AccScheduleLine.Totaling);
                IF AccScheduleLine."SAT Nature" = 0 THEN ERROR(Err_SATNature, AccScheduleLine.Totaling);

                XMLDOMManagement.AddElement(RootNode, 'Ctas', '', Namespace, Node);
                XMLDOMManagement.AddAttribute(Node, 'NumCta', AccScheduleLine.Totaling);
                XMLDOMManagement.AddAttribute(Node, 'CodAgrup', AccScheduleLine."SAT Account Code");
                XMLDOMManagement.AddAttribute(Node, 'Desc', AccScheduleLine.Description);
                XMLDOMManagement.AddAttribute(Node, 'Natur', FORMAT(AccScheduleLine."SAT Nature"));
                XMLDOMManagement.AddAttribute(Node, 'Nivel', FORMAT(AccScheduleLine."SAT Level"));
            UNTIL AccScheduleLine.NEXT() = 0;
        TempBigText.ADDTEXT(Document.InnerXml);
        //ExportFile(TempBigText,CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month,2,'<Integer,2><Filler Character,0>') + 'CT.xml');
        SaveXMLToClient(Document, CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month, 2, '<Integer,2><Filler Character,0>') + 'CT');
    end;

    procedure ExportBalanceSheet(Year: Integer; Month: Integer; DeliveryType: Option Normal,Complementary; UpdateDate: Date; ScheduleName: Code[10])
    var
        GLAccount: Record 15;
        CompanyInformation: Record 79;
        AccScheduleName: Record 84;
        AccScheduleLine: Record 85;
        ColumnLayout: Record 334;
        GeneralLedgerSetup: Record 50035;
        AccSchedManagement: Codeunit 8;
        BigTextTmp: BigText;
        UseAmtsInAddCurr: Boolean;
        DefaultColumnLayout: Code[10];
        EndDate: Date;
        StartDate: Date;
        Amount: Decimal;
        CellValue: array[1000, 5] of Decimal;
        x: Integer;
        y: Integer;
        FileType: Text;
        Namespace: Text;
        Totaling: Text[250];
        Document: XmlDocument;
        Node: XmlNode;
        RootNode: XmlNode;
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("SAT XML Path");
        CompanyInformation.GET();
        CompanyInformation.TESTFIELD("VAT Registration No.");

        Namespace := NamespaceTxt + BalanzaNamespaceTxt;
        CreateXMLHeader(Document, RootNode, BalanzaIdText, BalanzaNodeTxt, BalanzaNamespaceTxt, Year, Month, '1.1');

        StartDate := DMY2DATE(1, Month, Year);
        EndDate := CALCDATE('<CM>', StartDate);

        GLAccount.SETRANGE("Date Filter", StartDate, EndDate);
        //GLAccount.SETFILTER("SAT Account Code",'<>%1','');

        IF DeliveryType = DeliveryType::Normal THEN
            XMLDOMManagement.AddAttribute(RootNode, 'TipoEnvio', 'N')
        ELSE BEGIN
            XMLDOMManagement.AddAttribute(RootNode, 'TipoEnvio', 'C');
            XMLDOMManagement.AddAttribute(RootNode, 'FechaModBal', FORMAT(UpdateDate, 0, 9));
        END;

        AccScheduleLine.RESET();
        AccScheduleLine.SETRANGE("Schedule Name", ScheduleName);
        AccScheduleLine.SETFILTER("Row No.", '<>%1', '');
        AccScheduleLine.SETRANGE("Date Filter", StartDate, EndDate);
        IF AccScheduleLine.FINDSET() THEN
            REPEAT
                Totaling := AccScheduleLine.Totaling;

                AccScheduleName.RESET();
                AccScheduleName.SETRANGE(Name, ScheduleName);
                IF AccScheduleName.FINDFIRST() THEN
                    DefaultColumnLayout := AccScheduleName."Default Column Layout";

                x += 1;
                y := 0;
                ColumnLayout.RESET();
                ColumnLayout.SETRANGE("Column Layout Name", DefaultColumnLayout);
                IF ColumnLayout.FINDSET() THEN
                    REPEAT
                        Amount := AccSchedManagement.CalcCell(AccScheduleLine, ColumnLayout, UseAmtsInAddCurr);
                        y += 1;
                        CellValue[x, y] := Amount;

                        IF AccSchedManagement.GetDivisionError() THEN
                            Amount := 0;
                    UNTIL ColumnLayout.NEXT() = 0;

                XMLDOMManagement.AddElement(RootNode, 'Ctas', '', Namespace, Node);
                XMLDOMManagement.AddAttribute(Node, 'NumCta', Totaling);
                y := 1;
                XMLDOMManagement.AddAttribute(Node, 'SaldoIni', FORMAT(CellValue[x, y], 0, '<Integer><Decimals>'));
                y := 2;
                XMLDOMManagement.AddAttribute(Node, 'Debe', FORMAT(CellValue[x, y], 0, '<Integer><Decimals>'));
                y := 3;
                XMLDOMManagement.AddAttribute(Node, 'Haber', FORMAT(CellValue[x, y], 0, '<Integer><Decimals>'));
                y := 4;
                XMLDOMManagement.AddAttribute(Node, 'SaldoFin', FORMAT(CellValue[x, y], 0, '<Integer><Decimals>'));
            UNTIL AccScheduleLine.NEXT() = 0;

        IF DeliveryType = DeliveryType::Normal THEN
            FileType := 'BN'
        ELSE
            FileType := 'BC';

        //BigTextTmp.ADDTEXT(Document.InnerXml);
        SaveXMLToClient(Document, CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month, 2, '<Integer,2><Filler Character,0>') + FileType);
        ExportFile(BigTextTmp, CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month, 2, '<Integer,2><Filler Character,0>') + FileType + '.xml');
    end;

    procedure ConfirmValidateExport(StartingDate: Date; RequestType: Option AF,FC,DE,CO; ProcessNumber: Code[13]; IdProcess: Boolean)
    var
        AccountingPeriod: Record 50;
    begin
        //IdProcess = True for Poliza, False for Aux. Accounts.
        ValidateDataToProcess(StartingDate, RequestType, ProcessNumber);

        AccountingPeriod.RESET();
        AccountingPeriod.GET(StartingDate);

        IF IdProcess THEN
            ExportTransactions(DATE2DMY(AccountingPeriod."Starting Date", 3),
                                        DATE2DMY(AccountingPeriod."Starting Date", 2),
                                        RequestType, ProcessNumber)
        ELSE
            ExportAuxiliaryAccounts(DATE2DMY(AccountingPeriod."Starting Date", 3),
                                    DATE2DMY(AccountingPeriod."Starting Date", 2),
                                    RequestType, ProcessNumber);
    end;

    procedure ExportAuxiliaryAccounts(Year: Integer; Month: Integer; RequestType: Option AF,FC,DE,CO; ProcessNumber: Text[13])
    var
        GLAccount: Record 15;
        GLAccountBalanceFin: Record 15;
        GLAccountBalanceIni: Record 15;
        GLEntry: Record 17;
        CompanyInformation: Record 79;
        GeneralLedgerSetup: Record 50035;
        BigTextTmp: BigText;
        EndDate: Date;
        StartDate: Date;
        Namespace: Text;
        Document: XmlDocument;
        ChildNode: XmlNode;
        Node: XmlNode;
        RootNode: XmlNode;
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("SAT XML Path");
        CompanyInformation.GET();
        CompanyInformation.TESTFIELD("VAT Registration No.");

        StartDate := DMY2DATE(1, Month, Year);
        EndDate := CALCDATE('<CM>', StartDate);

        GLAccount.SETRANGE("Date Filter", StartDate, EndDate);
        //GLAccount.SETFILTER("SAT Account Code",'<>%1','');

        Namespace := NamespaceTxt + AuxiliaryAccountNamespaceTxt;
        CreateXMLHeader(Document, RootNode, AuxiliaryAccountNamespaceTxt, AuxiliaryAccountNodeTxt, AuxiliaryAccountNamespaceTxt, Year, Month, '1.1');
        XMLDOMManagement.AddAttribute(RootNode, 'TipoSolicitud', FORMAT(RequestType));

        IF RequestType IN [RequestType::AF, RequestType::FC] THEN
            XMLDOMManagement.AddAttribute(RootNode, 'NumOrden', ProcessNumber)
        ELSE
            XMLDOMManagement.AddAttribute(RootNode, 'NumTramite', ProcessNumber);

        IF GLAccount.FINDSET() THEN
            REPEAT
                GLEntry.SETRANGE("G/L Account No.", GLAccount."No.");
                GLEntry.SETRANGE("Posting Date", StartDate, EndDate);
                IF GLEntry.FINDSET() THEN BEGIN
                    GLAccountBalanceIni.GET(GLAccount."No.");
                    GLAccountBalanceIni.SETFILTER("Date Filter", '..%1', CLOSINGDATE(StartDate - 1));
                    GLAccountBalanceIni.CALCFIELDS("Balance at Date");

                    GLAccountBalanceFin.GET(GLAccount."No.");
                    GLAccountBalanceFin.SETFILTER("Date Filter", '..%1', EndDate);
                    GLAccountBalanceFin.CALCFIELDS("Balance at Date");

                    XMLDOMManagement.AddElement(RootNode, 'Cuenta', '', Namespace, Node);
                    XMLDOMManagement.AddAttribute(Node, 'NumCta', GLAccount."No.");
                    XMLDOMManagement.AddAttribute(Node, 'DesCta', RemoveInvalidChars(GLAccount.Name));
                    XMLDOMManagement.AddAttribute(Node, 'SaldoIni', DecimalFormat(GLAccountBalanceIni."Balance at Date"));
                    XMLDOMManagement.AddAttribute(Node, 'SaldoFin', DecimalFormat(GLAccountBalanceFin."Balance at Date"));

                    REPEAT
                        XMLDOMManagement.AddElement(Node, 'DetalleAux', '', Namespace, ChildNode);
                        XMLDOMManagement.AddAttribute(ChildNode, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
                        XMLDOMManagement.AddAttribute(ChildNode, 'NumUnIdenPol', FORMAT(GLEntry."Transaction No."));
                        IF GLEntry."Source Code" <> '' THEN
                            XMLDOMManagement.AddAttribute(ChildNode, 'Concepto', GLEntry."Source Code")
                        ELSE
                            XMLDOMManagement.AddAttribute(ChildNode, 'Concepto', 'GENJNL'); //Pasarlo a configuración UGMA
                        XMLDOMManagement.AddAttribute(ChildNode, 'Debe', DecimalFormat(GLEntry."Debit Amount"));
                        XMLDOMManagement.AddAttribute(ChildNode, 'Haber', DecimalFormat(GLEntry."Credit Amount"));
                    UNTIL GLEntry.NEXT() = 0;
                END;
            UNTIL GLAccount.NEXT() = 0;

        //BigTextTmp.ADDTEXT(Document.InnerXml);
        SaveXMLToClient(Document, CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month, 2, '<Integer,2><Filler Character,0>') + 'XC');
        ExportFile(BigTextTmp, CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month, 2, '<Integer,2><Filler Character,0>') + 'XC.xml');
    end;

    procedure ExportTransactions(Year: Integer; Month: Integer; RequestType: Option AF,FC,DE,CO; ProcessNumber: Text[13])
    var
        GLEntry: Record 17;
        CompanyInformation: Record 79;
        GeneralLedgerSetup: Record 50035;
        EndDate: Date;
        StartDate: Date;
        TransactionNoCurrent: Integer;
        Namespace: Text;
        Document: XmlDocument;
        PolizaNode: XmlNode;
        RootNode: XmlNode;
        TransactionNode: XmlNode;
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup.TESTFIELD("SAT XML Path");
        GeneralLedgerSetup.TESTFIELD("Check Element Code");
        GeneralLedgerSetup.TESTFIELD("Transfer Element Code");
        GeneralLedgerSetup.TESTFIELD("Nationals Operations Code");
        GeneralLedgerSetup.TESTFIELD("Foreign Operations Code");

        CompanyInformation.GET();
        CompanyInformation.TESTFIELD("VAT Registration No.");

        StartDate := DMY2DATE(1, Month, Year);
        EndDate := CALCDATE('<CM>', StartDate);

        Namespace := NamespaceTxt + PolizasNamespaceTxt;
        //CreateXMLHeader(Document,RootNode,BalanzaIdText,BalanzaNodeTxt,BalanzaNamespaceTxt,Year,Month,'1.1');
        CreateXMLHeader(Document, RootNode, PolizasNodeTxt, PolizasNodeTxt, PolizasNamespaceTxt, Year, Month, '1.1');

        XMLDOMManagement.AddAttribute(RootNode, 'TipoSolicitud', FORMAT(RequestType));

        IF RequestType IN [RequestType::AF, RequestType::FC] THEN
            XMLDOMManagement.AddAttribute(RootNode, 'NumOrden', ProcessNumber)
        ELSE
            XMLDOMManagement.AddAttribute(RootNode, 'NumTramite', ProcessNumber);

        GLEntry.SETCURRENTKEY("Transaction No.");
        GLEntry.SETRANGE("Posting Date", StartDate, EndDate);

        IF GLEntry.FINDSET() THEN
            REPEAT
                IF TransactionNoCurrent <> GLEntry."Transaction No." THEN BEGIN
                    TransactionNoCurrent := GLEntry."Transaction No.";
                    CreatePolizaNode(RootNode, PolizaNode, GLEntry, Namespace);
                END;
                CreateTransaccionNode(PolizaNode, TransactionNode, GLEntry, Namespace);
            UNTIL GLEntry.NEXT() = 0;

        //BigTextTmp.ADDTEXT(Document.InnerXml);
        SaveXMLToClient(Document, CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month, 2, '<Integer,2><Filler Character,0>') + 'PL');
        //ExportFile(BigTextTmp,CompanyInformation."VAT Registration No." + FORMAT(Year) + FORMAT(Month,2,'<Integer,2><Filler Character,0>') + 'PL.xml');
    end;

    local procedure ValidateDataToProcess(StartingDate: Date; RequestType: Option AF,FC,DE,CO; ProcessNumber: Code[13])
    var
        Text001: Label 'You must enter a Starting Date Period';
        Text002: Label 'The length to Order No. must be %1.',Comment = '%1';
    begin
        IF StartingDate = 0D THEN
            ERROR(Text001);

        IF RequestType IN [RequestType::AF, RequestType::FC] THEN
            IF STRLEN(ProcessNumber) <> 13 THEN
                ERROR(Text002, '13');
        IF RequestType IN [RequestType::CO, RequestType::DE] THEN
            IF STRLEN(ProcessNumber) <> 10 THEN
                ERROR(Text002, '10');
    end;

    local procedure CreatePolizaNode(var ParentNode: XmlNode; var Node: XmlNode; GLEntry: Record 17; Namespace: Text)
    begin
        XMLDOMManagement.AddElement(ParentNode, 'Poliza', '', Namespace, Node);
        XMLDOMManagement.AddAttribute(Node, 'NumUnIdenPol', FORMAT(GLEntry."Transaction No."));
        XMLDOMManagement.AddAttribute(Node, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
        XMLDOMManagement.AddAttribute(Node, 'Concepto', GLEntry."Source Code");
    end;

    local procedure CreateTransaccionNode(var ParentNode: XmlNode; var Node: XmlNode; GLEntry: Record 17; Namespace: Text)
    var
        GLAccount: Record 15;
        GeneralLedgerSetup: Record 50035;
        Created: Boolean;
        CodeForOpr: Code[10];
        CodEleCheque: Code[10];
        CodEleTransfer: Code[10];
        CodeNatOpr: Code[10];
    begin
        GeneralLedgerSetup.GET();
        CodEleCheque := GeneralLedgerSetup."Check Element Code";
        CodEleTransfer := GeneralLedgerSetup."Transfer Element Code";
        CodeNatOpr := GeneralLedgerSetup."Foreign Operations Code";
        CodeForOpr := GeneralLedgerSetup."Nationals Operations Code";

        GLAccount.GET(GLEntry."G/L Account No.");

        XMLDOMManagement.AddElement(ParentNode, 'Transaccion', '', Namespace, Node);
        XMLDOMManagement.AddAttribute(Node, 'NumCta', GLAccount."No.");
        XMLDOMManagement.AddAttribute(Node, 'DesCta', RemoveInvalidChars(GLAccount.Name));
        XMLDOMManagement.AddAttribute(Node, 'Concepto', GLEntry.Description);
        XMLDOMManagement.AddAttribute(Node, 'Debe', DecimalFormat(GLEntry."Debit Amount"));
        XMLDOMManagement.AddAttribute(Node, 'Haber', DecimalFormat(GLEntry."Credit Amount"));
        Created := FALSE;

        IF (GLEntry."Document Type" = GLEntry."Document Type"::Payment) OR (GLEntry."Document Type" = GLEntry."Document Type"::Refund) THEN
            IF GLEntry."Source Type" = GLEntry."Source Type"::Customer THEN
                CASE GLEntry."Pymt - Payment Method" OF
                    CodEleCheque:
                        BEGIN
                            CheckNode(Node, GLEntry, Namespace);
                            Created := TRUE;
                        END;
                    CodEleTransfer:
                        BEGIN
                            TransferCustomerNode(Node, GLEntry, Namespace);
                            Created := TRUE;
                        END;
                    ELSE BEGIN
                        OtherPaymentMethodCustNode(Node, GLEntry, Namespace);
                        Created := TRUE;
                    END;
                END
            ELSE
                IF GLEntry."Source Type" = GLEntry."Source Type"::Vendor THEN
                    CASE GLEntry."Pymt - Payment Method" OF
                        CodEleCheque:
                            BEGIN
                                CheckNode(Node, GLEntry, Namespace);
                                Created := TRUE;
                            END;
                        CodEleTransfer:
                            BEGIN
                                TransferVendorNode(Node, GLEntry, Namespace);
                                Created := TRUE;
                            END;
                        ELSE BEGIN
                            OtherPaymentMethodVendNode(Node, GLEntry, Namespace);
                            Created := TRUE;
                        END;
                    END;
        IF Created THEN EXIT;
        EvaluateDocument(Node, GLEntry, Namespace, CodeNatOpr, CodeForOpr);
        EvaluateDocumentPayRef(Node, GLEntry, Namespace, CodeNatOpr, CodeForOpr);
    end;

    procedure CheckNode(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text)
    var
        Customer: Record 18;
        Vendor: Record 23;
        CompanyInformation: Record 79;
        RFC: Code[13];
        Benef: Text[300];
        Node: XmlNode;
    begin
        RFC := '';
        Benef := '';
        CASE GLEntry."Document Type" OF
            GLEntry."Document Type"::Payment:
                BEGIN
                    IF GLEntry."Source Type" = GLEntry."Source Type"::Customer THEN BEGIN
                        CompanyInformation.GET();
                        RFC := CompanyInformation."VAT Registration No.";
                        Benef := CompanyInformation.Name;
                    END;
                    IF GLEntry."Source Type" = GLEntry."Source Type"::Vendor THEN
                        IF Vendor.GET(GLEntry."Source No.") THEN BEGIN
                            Benef := Vendor.Name;
                            RFC := Vendor."VAT Registration No.";
                        END;
                END;

            GLEntry."Document Type"::Refund:
                BEGIN
                    IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Bank Account")
                    AND (GLEntry."Source Type" = GLEntry."Source Type"::Customer) THEN
                        IF Customer.GET(GLEntry."Source No.") THEN BEGIN
                            Benef := Customer.Name;
                            RFC := Customer."VAT Registration No.";
                        END;
                    IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Bank Account")
                    AND (GLEntry."Source Type" = GLEntry."Source Type"::Vendor) THEN BEGIN
                        CompanyInformation.GET();
                        RFC := CompanyInformation."VAT Registration No.";
                        Benef := CompanyInformation.Name;
                    END;
                END;
        END;

        XMLDOMManagement.AddElement(ParentNode, 'Cheque', '', Namespace, Node);
        XMLDOMManagement.AddAttribute(Node, 'Num', GLEntry."Document No.");
        XMLDOMManagement.AddAttribute(Node, 'BanEmisNal', GLEntry."Pymt - Bank Source Code");
        XMLDOMManagement.AddAttribute(Node, 'CtaOri', GLEntry."Pymt - Bank Source Account");
        XMLDOMManagement.AddAttribute(Node, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
        XMLDOMManagement.AddAttribute(Node, 'Benef', Benef);
        XMLDOMManagement.AddAttribute(Node, 'RFC', RFC);
        XMLDOMManagement.AddAttribute(Node, 'Monto', DecimalFormat(GLEntry.Amount));
    end;

    local procedure SaveXMLToClient(var Document: XmlDocument; FileName: Text): Boolean
    var
        GeneralLedgerSetup: Record 50035;
        Text001: Label 'Created File %1.', Comment = '%1';
        TempXMLFile: Text;
        TestFileName: Text;
    begin
        GeneralLedgerSetup.GET();
        TestFileName := GeneralLedgerSetup."SAT XML Path" + '\' + FileName + '.xml';
        TempXMLFile := FileManagement.ServerTempFileName('xml');
        Document.Save(TempXMLFile);
        FileManagement.CopyServerFile(TempXMLFile, TestFileName, TRUE);

        MESSAGE(Text001, TestFileName);
    end;

    procedure ExportFile(Content: BigText; DefaultName: Text)
    var
        TempBlobL: codeunit "Temp Blob";
        OutStream: OutStream;
    begin
        // TempBlob.INIT;
        //TempBlob."Primary Key" := 1;
        //TempBlob.Blob.CREATEOUTSTREAM(OutStream);
        //Content.WRITE(OutStream);
        //TempBlob.INSERT;
        TempBlobL.CreateOutStream(OutStream);
        FileManagement.BLOBExport(TempBlob, DefaultName, TRUE);
    end;

    local procedure DecimalFormat(Amount: Decimal): Text
    begin
        EXIT(FORMAT(Amount, 0, '<Precision,2:2><Standard Format,9>'));
    end;

    procedure TransferCustomerNode(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text)
    var
        Customer: Record 18;
        CompanyInformation: Record 79;
        BancoDest: Code[3];
        BancoOri: Code[3];
        RFC: Code[13];
        BancoDestTag: Text[15];
        BancoOriTag: Text[15];
        CtaDest: Text[50];
        CtaOri: Text[50];
        Benef: Text[300];
        Node: XmlNode;
    begin
        CtaOri := GLEntry."Pymt - Bank Source Account";
        BancoOri := GLEntry."Pymt - Bank Source Code";

        CtaDest := GLEntry."Pymt - Bank Target Account";
        BancoDest := GLEntry."Pymt - Bank Target Code";

        IF GLEntry."Pymt - Bank Source Foreign" THEN
            BancoOriTag := 'BancoOriExt'
        ELSE
            BancoOriTag := 'BancoOriNal';

        IF GLEntry."Pymt - Bank Target Foreign" THEN
            BancoDestTag := 'BancoDestExt'
        ELSE
            BancoDestTag := 'BancoDestNal';

        Benef := '';
        RFC := '';

        CASE GLEntry."Document Type" OF
            GLEntry."Document Type"::Payment:
                BEGIN
                    CompanyInformation.GET();
                    RFC := CompanyInformation."VAT Registration No.";
                    Benef := CompanyInformation.Name;
                END;
            GLEntry."Document Type"::Refund:

                IF Customer.GET(GLEntry."Source No.") THEN BEGIN
                    Benef := Customer.Name;
                    RFC := Customer."VAT Registration No.";
                END;
        END;

        XMLDOMManagement.AddElement(ParentNode, 'Transferencia', '', Namespace, Node);
        XMLDOMManagement.AddAttribute(Node, 'CtaOri', CtaOri);
        XMLDOMManagement.AddAttribute(Node, BancoOriTag, BancoOri);
        XMLDOMManagement.AddAttribute(Node, 'CtaDest', CtaDest);
        XMLDOMManagement.AddAttribute(Node, BancoDestTag, BancoDest);
        XMLDOMManagement.AddAttribute(Node, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
        XMLDOMManagement.AddAttribute(Node, 'Benef', Benef);
        XMLDOMManagement.AddAttribute(Node, 'RFC', RFC);
        XMLDOMManagement.AddAttribute(Node, 'Monto', DecimalFormat(GLEntry.Amount));
    end;

    procedure TransferVendorNode(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text)
    var
        Vendor: Record 23;
        CompanyInformation: Record 79;
        BancoDest: Code[3];
        BancoOri: Code[3];
        RFC: Code[13];
        BancoDestTag: Text[15];
        BancoOriTag: Text[15];
        CtaDest: Text[50];
        CtaOri: Text[50];
        Benef: Text[300];
        Node: XmlNode;
    begin
        CtaOri := GLEntry."Pymt - Bank Source Account";
        BancoOri := GLEntry."Pymt - Bank Source Code";

        CtaDest := GLEntry."Pymt - Bank Target Account";
        BancoDest := GLEntry."Pymt - Bank Target Code";

        IF GLEntry."Pymt - Bank Source Foreign" THEN
            BancoOriTag := 'BancoOriExt'
        ELSE
            BancoOriTag := 'BancoOriNal';

        IF GLEntry."Pymt - Bank Target Foreign" THEN
            BancoDestTag := 'BancoDestExt'
        ELSE
            BancoDestTag := 'BancoDestNal';

        Benef := '';
        RFC := '';

        CASE GLEntry."Document Type" OF
            GLEntry."Document Type"::Payment:

                IF Vendor.GET(GLEntry."Source No.") THEN BEGIN
                    Benef := Vendor.Name;
                    RFC := Vendor."VAT Registration No.";
                END;
            GLEntry."Document Type"::Refund:
                BEGIN
                    CompanyInformation.GET();
                    RFC := CompanyInformation."VAT Registration No.";
                    Benef := CompanyInformation.Name;
                END;
        END;

        XMLDOMManagement.AddElement(ParentNode, 'Transferencia', '', Namespace, Node);
        XMLDOMManagement.AddAttribute(Node, 'CtaOri', CtaOri);
        XMLDOMManagement.AddAttribute(Node, BancoOriTag, BancoOri);
        XMLDOMManagement.AddAttribute(Node, 'CtaDest', CtaDest);
        XMLDOMManagement.AddAttribute(Node, BancoDestTag, BancoDest);
        XMLDOMManagement.AddAttribute(Node, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
        XMLDOMManagement.AddAttribute(Node, 'Benef', Benef);
        XMLDOMManagement.AddAttribute(Node, 'RFC', RFC);
        XMLDOMManagement.AddAttribute(Node, 'Monto', DecimalFormat(GLEntry.Amount));
    end;

    procedure OtherPaymentMethodCustNode(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text)
    var
        Customer: Record 18;
        CompanyInformation: Record 79;
        RFC: Code[13];
        Benef: Text[300];
        Node: XmlNode;
    begin
        CASE GLEntry."Document Type" OF
            GLEntry."Document Type"::Payment:
                BEGIN
                    CompanyInformation.GET();
                    RFC := CompanyInformation."VAT Registration No.";
                    Benef := CompanyInformation.Name;
                END;
            GLEntry."Document Type"::Refund:

                IF Customer.GET(GLEntry."Source No.") THEN BEGIN
                    RFC := Customer."VAT Registration No.";
                    Benef := Customer.Name;
                END;
        END;

        XMLDOMManagement.AddElement(ParentNode, 'OtrMetodoPago', '', Namespace, Node);
        IF GLEntry."Pymt - Payment Method" <> '' THEN
            XMLDOMManagement.AddAttribute(Node, 'MetPagoPol', GLEntry."Pymt - Payment Method")
        ELSE
            XMLDOMManagement.AddAttribute(Node, 'MetPagoPol', '01');
        XMLDOMManagement.AddAttribute(Node, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
        XMLDOMManagement.AddAttribute(Node, 'Benef', Benef);
        XMLDOMManagement.AddAttribute(Node, 'RFC', RFC);
        XMLDOMManagement.AddAttribute(Node, 'Monto', DecimalFormat(ABS(GLEntry.Amount)));
    end;

    procedure OtherPaymentMethodVendNode(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text)
    var
        Vendor: Record 23;
        CompanyInformation: Record 79;
        RFC: Code[13];
        Benef: Text[300];
        Node: XmlNode;
    begin
        CASE GLEntry."Document Type" OF
            GLEntry."Document Type"::Payment:

                IF Vendor.GET(GLEntry."Source No.") THEN BEGIN
                    Benef := Vendor.Name;
                    RFC := Vendor."VAT Registration No.";
                END;
            GLEntry."Document Type"::Refund:
                BEGIN
                    CompanyInformation.GET();
                    RFC := CompanyInformation."VAT Registration No.";
                    Benef := CompanyInformation.Name;
                END;
        END;

        XMLDOMManagement.AddElement(ParentNode, 'OtrMetodoPago', '', Namespace, Node);
        IF GLEntry."Pymt - Payment Method" <> '' THEN
            XMLDOMManagement.AddAttribute(Node, 'MetPagoPol', GLEntry."Pymt - Payment Method")
        ELSE
            XMLDOMManagement.AddAttribute(Node, 'MetPagoPol', '01');
        XMLDOMManagement.AddAttribute(Node, 'Fecha', FORMAT(GLEntry."Posting Date", 0, 9));
        XMLDOMManagement.AddAttribute(Node, 'Benef', Benef);
        XMLDOMManagement.AddAttribute(Node, 'RFC', RFC);
        XMLDOMManagement.AddAttribute(Node, 'Monto', DecimalFormat(ABS(GLEntry.Amount)));
    end;

    procedure EvaluateDocument(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text; CodeNatOpr: Code[10]; CodeForOpr: Code[10])
    var
        SourceType: Option " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        DocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin
        CASE GLEntry."Gen. Bus. Posting Group" OF
            CodeNatOpr:

                IF GLEntry."Source Type" = SourceType::Vendor THEN
                    IF (GLEntry."Document Type" = DocumentType::Invoice) OR (GLEntry."Document Type" = DocumentType::"Credit Memo") THEN
                        VendorInvoice(ParentNode, GLEntry, Namespace, FALSE);
            CodeForOpr:

                IF GLEntry."Source Type" = SourceType::Vendor THEN
                    IF (GLEntry."Document Type" = DocumentType::Invoice) OR (GLEntry."Document Type" = DocumentType::"Credit Memo") THEN
                        VendorInvoice(ParentNode, GLEntry, Namespace, TRUE);
        END;
    end;

    procedure EvaluateDocumentPayRef(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text; CodeNatOpr: Code[10]; CodeForOpr: Code[10])
    var
        SourceType: Option " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        DocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin
        IF (GLEntry."Document Type" = DocumentType::Payment) OR (GLEntry."Document Type" = DocumentType::Refund) THEN
            IF GLEntry."XML - UUID" <> '' THEN
                CASE GLEntry."Gen. Bus. Posting Group" OF
                    CodeNatOpr:

                        IF GLEntry."Source Type" = SourceType::Vendor THEN
                            VendorInvoice(ParentNode, GLEntry, Namespace, FALSE);
                    CodeForOpr:

                        IF GLEntry."Source Type" = SourceType::Vendor THEN
                            VendorInvoice(ParentNode, GLEntry, Namespace, TRUE);
                END;
    end;

    procedure VendorInvoice(var ParentNode: XmlNode; GLEntry: Record 17; Namespace: Text; NatFor: Boolean)
    var
        Vendor: Record 23;
        Node: XmlNode;
    begin
        Vendor.GET(GLEntry."Source No.");

        IF NatFor THEN BEGIN
            XMLDOMManagement.AddElement(ParentNode, 'CompNal', '', Namespace, Node);
            XMLDOMManagement.AddAttribute(Node, 'RFC', Vendor."VAT Registration No.");
            IF GLEntry."XML - UUID" <> '' THEN
                XMLDOMManagement.AddAttribute(Node, 'UUID_CFDI', GLEntry."XML - UUID")
            ELSE
                XMLDOMManagement.AddAttribute(Node, 'UUID_CFDI', 'F4113F02-DBCA-4E1B-96CE-CAE2F24E6C26')
        END ELSE BEGIN
            XMLDOMManagement.AddElement(ParentNode, 'CompExt', '', Namespace, Node);
            XMLDOMManagement.AddAttribute(Node, 'TaxID', Vendor."VAT Registration No."); //REvisar con Josue esto - UGMA
            XMLDOMManagement.AddAttribute(Node, 'NumFactExt', GLEntry."External Document No.");
        END;

        IF GLEntry."XML - Currency Factor" = 0 THEN
            XMLDOMManagement.AddAttribute(Node, 'TipCamb', DecimalFormat(1))
        ELSE
            XMLDOMManagement.AddAttribute(Node, 'TipCamb', DecimalFormat(1 / GLEntry."XML - Currency Factor"));

        XMLDOMManagement.AddAttribute(Node, 'MontoTotal', DecimalFormat(GLEntry.Amount));
    end;

    procedure RemoveInvalidChars(PassedStr: Text[1024]): Text[1024]
    begin
        PassedStr := CONVERTSTR(PassedStr, ' #%&*<>^`~|¢£¤¥¦§¨©ª¬­°±²³´µ·¹º¼½¾', '                                  ');
        PassedStr := CONVERTSTR(PassedStr, 'ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜ', 'AAAAAAEEEEIIIIOOOOOOUUUU');
        PassedStr := CONVERTSTR(PassedStr, 'àáâãäåèéêëìíîïòóôõöøùúûü', 'aaaaaaeeeeiiiioooooouuuu');
        PassedStr := CONVERTSTR(PassedStr, 'ÑÝñýÿ', 'NYnyy');
        PassedStr := RemoveExtraWhiteSpaces(PassedStr);
        EXIT(PassedStr);
    end;

    procedure RemoveExtraWhiteSpaces(StrParam: Text[1024]) StrReturn: Text[1024]
    var
        WhiteSpaceFound: Boolean;
        Cntr1: Integer;
        Cntr2: Integer;
    begin
        StrParam := DELCHR(StrParam, '<>', ' ');
        WhiteSpaceFound := FALSE;
        Cntr2 := 1;
        FOR Cntr1 := 1 TO STRLEN(StrParam) DO
            IF StrParam[Cntr1] <> ' ' THEN BEGIN
                WhiteSpaceFound := FALSE;
                StrReturn[Cntr2] := StrParam[Cntr1];
                Cntr2 += 1;
            END ELSE
                IF NOT WhiteSpaceFound THEN BEGIN
                    WhiteSpaceFound := TRUE;
                    StrReturn[Cntr2] := StrParam[Cntr1];
                    Cntr2 += 1;
                END;
    end;

    local procedure "---Tools---"()
    begin
    end;

    local procedure XMLWellFormed(ServerFileName: Text) XMLWellFormedP: Text
    var
        TempBlob: CODEUNIT "Temp Blob";
        InStream: InStream;
        Indice: Integer;
        Outstream: OutStream;
        TxtXML: Text;
    begin
        //first upload file
        // TempBlob.INIT;
        // TempBlob."Primary Key" := 1;
        // TempBlob.Blob.IMPORT(ServerFileName);
        // TempBlob.INSERT;
        // //Now pass this file to a text variable
        // TempBlob.GET(1);
        // TempBlob.CALCFIELDS(Blob);
        // TempBlob.Blob.CREATEINSTREAM(InStream);
        TempBlob.CreateOutStream(OutStream);

        // Write the text data into the Blob
        OutStream.WriteText(TxtXML);
        InStream.READTEXT(TxtXML);
        //Now analize first string
        Indice := 1;
        WHILE TxtXML[Indice] <> '<' DO Indice := Indice + 1;
        XMLWellFormed := COPYSTR(TxtXML, Indice);
        //Well paste all
        REPEAT
            InStream.READTEXT(TxtXML);
            XMLWellFormed := XMLWellFormedP + TxtXML;
        UNTIL InStream.EOS = TRUE;
        MESSAGE(COPYSTR(XMLWellFormedP, 4330, 10));
    end;
}

