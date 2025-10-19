codeunit 50027 CU87Subscriber
{
    //Version NAVW18.00,SE0.28.33,NV4.32,NIF1.000,NIF.N15.C9IN.001;
    var
        SalesSetup: Record "Sales & Receivables Setup";
    /*   EMailListEntry: Record 14000908;
      EMailMgt : Codeunit 14000903; */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnBeforeSalesOrderHeaderModify, '', false, false)]
    local procedure OnBeforeSalesOrderHeaderModify(var SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        //>>NIF MAK 061405
        SalesOrderHeader."Blanket Order No." := BlanketOrderSalesHeader."No.";
        //<<NIF
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnAfterInsertSalesOrderLine, '', false, false)]
    local procedure OnAfterInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesLine: Record "Sales Line"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        //>>NV
        //>> NF1.00:CIS.CM 09-29-15
        //      CopyLineCommentLines(
        //       BlanketOrderSalesLine."Document Type",
        //       SalesLineCommentLine."Document Type"::"1",
        //       BlanketOrderSalesLine."Document No.",
        //       SalesOrderLine."Document No.",
        //       BlanketOrderSalesLine."Line No.",
        //       SalesOrderLine."Line No.");
        //<< NF1.00:CIS.CM 09-29-15
        //<<NV
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnBeforeReserveItemsManuallyLoop, '', false, false)]
    local procedure OnBeforeReserveItemsManuallyLoop(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary; var SuppressCommit: Boolean)
    var
        EMailMgt: Codeunit 14000903;
    begin
        SalesSetup.get();
        // >> Shipping
        IF SalesSetup."LAX Enable E-Mail" THEN
            EMailMgt.MoveEMailListSalesHeader(SalesHeader, SalesOrderHeader);
        // << Shipping
    end;

    PROCEDURE CopyLineCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromLine: Integer; ToLine: Integer);
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //SalesLineCommentLine.SETRANGE("Document Type",FromDocumentType);
        //SalesLineCommentLine.SETRANGE("No.",FromNumber);
        //SalesLineCommentLine.SETRANGE("Doc. Line No.",FromLine);
        //IF SalesLineCommentLine.FIND('-') THEN
        //  REPEAT
        //    SalesLineCommentLine2 := SalesLineCommentLine;
        //    SalesLineCommentLine2."Document Type" := ToDocumentType;
        //    SalesLineCommentLine2."No." := ToNumber;
        //    SalesLineCommentLine2."Doc. Line No." := ToLine;
        //    SalesLineCommentLine2.INSERT;
        //  UNTIL SalesLineCommentLine.NEXT = 0;
        //<< NF1.00:CIS.CM 09-29-15
    END;
}