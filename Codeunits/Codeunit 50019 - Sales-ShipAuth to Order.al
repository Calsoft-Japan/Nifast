codeunit 50019 "Sales-ShipAuth to Order"
{
    TableNo = 50015;

    trigger OnRun()
    var
        Cust: Record 18;
    begin

        Cust.GET(Rec."Sell-to Customer No.");
        NextLineNo := 0;
        PurchOrderNo := '';

        SalesOrderHeader.INIT();
        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::Order;
        //>>
        SalesOrderHeader.VALIDATE("Posting Date", TODAY);
        //>>
        SalesOrderHeader.VALIDATE("Sell-to Customer No.", Rec."Sell-to Customer No.");
        SalesOrderHeader.INSERT(TRUE);

        ShipAuthorizationLine.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
        ShipAuthorizationLine.SETRANGE("Document No.", Rec."No.");
        ShipAuthorizationLine.SETFILTER("Item No.", '<>%1', '');
        IF ShipAuthorizationLine.FIND('-') THEN
            REPEAT
                IF ShipAuthorizationLine.Quantity > 0 THEN BEGIN
                    NextLineNo := NextLineNo + 10000;
                    SalesLine."Line No." := NextLineNo;
                    SalesLine."Document Type" := SalesOrderHeader."Document Type";
                    SalesLine."Document No." := SalesOrderHeader."No.";
                    SalesLine."Sell-to Customer No." := SalesOrderHeader."Sell-to Customer No.";
                    SalesLine.Type := SalesLine.Type::Item;
                    //TODO
                    // SalesLine."Cross-Reference Type" := SalesLine."Cross-Reference Type"::Customer;
                    // SalesLine.VALIDATE("Cross-Reference Type No.", ShipAuthorizationLine."Cross-Reference Type No.");
                    SalesLine.VALIDATE("No.", ShipAuthorizationLine."Item No.");
                    SalesLine.VALIDATE(Quantity, ShipAuthorizationLine.Quantity);
                    IF PurchOrderNo = '' THEN
                        PurchOrderNo := ShipAuthorizationLine."Purchase Order Number";
                    SalesLine.INSERT(TRUE);
                END;
            UNTIL ShipAuthorizationLine.NEXT() = 0;
        //TODO
        // SalesOrderHeader."EDI Order" := TRUE;
        // SalesOrderHeader."EDI Internal Doc. No." := Rec."EDI Internal Doc. No.";
        // SalesOrderHeader."EDI Trade Partner" := Rec."EDI Trade Partner";
        SalesOrderHeader."Ship Authorization No." := Rec."No.";
        SalesOrderHeader."External Document No." := PurchOrderNo;
        SalesOrderHeader."No. Printed" := 0;
        SalesOrderHeader.Status := SalesOrderHeader.Status::Open;
        SalesOrderHeader."Date Sent" := 0D;
        SalesOrderHeader."Time Sent" := 0T;
        SalesOrderHeader.MODIFY();

        Rec."Sales Order No." := SalesOrderHeader."No.";
        Rec.Archive := TRUE;
        Rec.MODIFY();
    end;

    var
        SalesOrderHeader: Record 36;
        SalesLine: Record 37;
        ShipAuthorizationLine: Record 50016;
        PurchOrderNo: Code[20];
        NextLineNo: Integer;

    procedure GetSalesOrderHeader(var SalesHeader2: Record 36)
    begin
        SalesHeader2 := SalesOrderHeader;
    end;

    // procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    // begin
    //     HideValidationDialog := NewHideValidationDialog;
    // end;
}

