codeunit 50023 "Management XML Data Sales Inv."
{

    trigger OnRun()
    begin
    end;

    var
        SalesInvXMLData: Record 50036;

    procedure GetXMLUUID(SalesInvHeader: Record 112) UUID: Text
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - UUID");
        EXIT('');
    end;

    procedure GetXMLInvFolio(SalesInvHeader: Record 112) InvFolio: Text
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Invoice Folio");
        EXIT('');
    end;

    procedure GetXMLCertifiedNo(SalesInvHeader: Record 112) CertifiedNo: Text
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Certified No");
        EXIT('');
    end;

    procedure GetXMLSATCertifiedNo(SalesInvHeader: Record 112) SATCertifiedNo: Text
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - SAT Certified No");
        EXIT('');
    end;

    procedure GetXMLDateStamped(SalesInvHeader: Record 112) DateStamped: Text
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Date/Time Stamped");
        EXIT('');
    end;

    procedure GetXMLVATReceptor(SalesInvHeader: Record 112) VATReceptor: Code[13]
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - VAT Receptor");
        EXIT('');
    end;

    procedure GetXMLTotalInv(SalesInvHeader: Record 112) TotalInv: Decimal
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Total Invoice");
        EXIT(0.0);
    end;

    procedure GetXMLPaymentMethod(SalesInvHeader: Record 112) PaymentMethod: Code[50]
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Payment Method");
        EXIT('');
    end;

    procedure GetXMLCurrency(SalesInvHeader: Record 112) Currency: Code[50]
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Currency");
        EXIT('');
    end;

    procedure GetXMLCurrencyFactor(SalesInvHeader: Record 112) CurrecyFactor: Decimal
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN EXIT(SalesInvXMLData."XML - Currency Factor");
        EXIT(0.0);
    end;

    procedure IsPDFUploaded(SalesInvHeader: Record 112) Result: Boolean
    begin
        IF SalesInvXMLData.GET(SalesInvHeader."No.") THEN BEGIN
           SalesInvXMLData.CALCFIELDS(PDF);
           IF SalesInvXMLData.PDF.HASVALUE THEN EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;
}

