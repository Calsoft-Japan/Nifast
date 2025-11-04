codeunit 50164 CU6620Subscriber
{
    //Version List=NAVW18.00,NAVNA8.00,NIF1.069,AKK1606.01;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopySalesDocLineOnBeforeCheckLocationOnWMS, '', false, false)]
    local procedure OnCopySalesDocLineOnBeforeCheckLocationOnWMS(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line"; var IsHandled: Boolean; IncludeHeader: Boolean; RecalculateLines: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopySalesDocLineOnBeforeCopyThisLine, '', false, false)]
    local procedure OnCopySalesDocLineOnBeforeCopyThisLine(ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line"; FromSalesDocType: Enum "Sales Document Type From"; var RecalculateLines: Boolean; var CopyThisLine: Boolean; var LinesNotCopied: Integer; var Result: Boolean; var IsHandled: Boolean; var NextLineNo: Integer; DocLineNo: Integer; MoveNegLines: Boolean)
    begin
        //>> NIF #10088 RTT 06-08-05
        if ToSalesLine.CheckIfLineComments() then
            ToSalesLine.InsertLineComments();
        //<< NIF #10088 RTT 06-08-05
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnUpdateSalesLineBeforeRecalculateAmount, '', false, false)]
    local procedure OnUpdateSalesLineBeforeRecalculateAmount(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line");
    begin
        //-AKK1606.01--
        ToSalesLine."Exit Point" := FromSalesLine."Exit Point";
        ToSalesLine."Entry/Exit No." := FromSalesLine."Entry/Exit No.";
        ToSalesLine."Entry/Exit Date" := FromSalesLine."Entry/Exit Date";
        ToSalesLine.National := FromSalesLine.National;
        //+AKK1606.01++
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopyPurchDocLineOnBeforeCheckLocationOnWMS, '', false, false)]
    local procedure OnCopyPurchDocLineOnBeforeCheckLocationOnWMS(var ToPurchHeader: Record "Purchase Header"; var ToPurchLine: Record "Purchase Line"; var FromPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopyPurchDocLineOnBeforeCopyThisLine, '', false, false)]
    local procedure OnCopyPurchDocLineOnBeforeCopyThisLine(var ToPurchLine: Record "Purchase Line"; var FromPurchLine: Record "Purchase Line"; MoveNegLines: Boolean; FromPurchDocType: Enum "Purchase Document Type From"; var LinesNotCopied: Integer; var CopyThisLine: Boolean; var Result: Boolean; var IsHandled: Boolean; ToPurchaseHeader: Record "Purchase Header"; var RecalculateLines: Boolean; var NextLineNo: Integer)
    begin
        //>> NIF #10088 RTT 06-08-05
        IF ToPurchLine.CheckIfLineComments() THEN
            ToPurchLine.InsertLineComments();
        //<< NIF #10088 RTT 06-08-05
    end;

}