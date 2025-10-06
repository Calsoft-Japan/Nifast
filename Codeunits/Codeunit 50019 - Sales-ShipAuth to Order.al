codeunit 50019 "Sales-ShipAuth to Order"
{
    TableNo = 50015;

    trigger OnRun()
    var
        Cust: Record "18";
    begin

        Cust.GET("Sell-to Customer No.");
        NextLineNo := 0;
        PurchOrderNo := '';

        SalesOrderHeader.INIT();
        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::Order;
        //>>
        SalesOrderHeader.VALIDATE("Posting Date",TODAY);
        //>>
        SalesOrderHeader.VALIDATE("Sell-to Customer No.","Sell-to Customer No.");
        SalesOrderHeader.INSERT(TRUE);

        ShipAuthorizationLine.SETRANGE("Sell-to Customer No.","Sell-to Customer No.");
        ShipAuthorizationLine.SETRANGE("Document No.","No.");
        ShipAuthorizationLine.SETFILTER("Item No.",'<>%1','');
        IF ShipAuthorizationLine.FIND('-') THEN
          REPEAT
            IF ShipAuthorizationLine.Quantity > 0 THEN BEGIN
              NextLineNo := NextLineNo + 10000;
              SalesLine."Line No." := NextLineNo;
              SalesLine."Document Type" := SalesOrderHeader."Document Type";
              SalesLine."Document No." := SalesOrderHeader."No.";
              SalesLine."Sell-to Customer No." := SalesOrderHeader."Sell-to Customer No.";
              SalesLine.Type := SalesLine.Type::Item;
              SalesLine."Cross-Reference Type" := SalesLine."Cross-Reference Type"::Customer;
              SalesLine.VALIDATE("Cross-Reference Type No.",ShipAuthorizationLine."Cross-Reference Type No.");
              SalesLine.VALIDATE("No.",ShipAuthorizationLine."Item No.");
              SalesLine.VALIDATE(Quantity,ShipAuthorizationLine.Quantity);
              IF PurchOrderNo = '' THEN
                PurchOrderNo := ShipAuthorizationLine."Purchase Order Number";
              SalesLine.INSERT(TRUE);
            END;
          UNTIL ShipAuthorizationLine.NEXT = 0;

        SalesOrderHeader."EDI Order" := TRUE;
        SalesOrderHeader."EDI Internal Doc. No." := "EDI Internal Doc. No.";
        SalesOrderHeader."EDI Trade Partner" := "EDI Trade Partner";
        SalesOrderHeader."Ship Authorization No." := "No.";
        SalesOrderHeader."External Document No." := PurchOrderNo;
        SalesOrderHeader."No. Printed" := 0;
        SalesOrderHeader.Status := SalesOrderHeader.Status::Open;
        SalesOrderHeader."Date Sent" := 0D;
        SalesOrderHeader."Time Sent" := 0T;
        SalesOrderHeader.MODIFY;

        "Sales Order No." := SalesOrderHeader."No.";
        Archive := TRUE;
        MODIFY();
    end;

    var
        Text000: Label 'An Open Opportunity is linked to this quote.\';
        Text001: Label 'It has to be closed before an Order can be made.\';
        Text002: Label 'Do you wish to close this Opportunity now?';
        Text003: Label 'Wizard Aborted';
        ShipAuthorizationLine: Record "50016";
        SalesLine: Record "37";
        SalesOrderHeader: Record "36";
        HideValidationDialog: Boolean;
        Text004: Label 'The Opportunity has not been closed. The program has aborted making the Order.';
        NextLineNo: Integer;
        PurchOrderNo: Code[20];

    procedure GetSalesOrderHeader(var SalesHeader2: Record "36")
    begin
        SalesHeader2 := SalesOrderHeader;
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;
}

