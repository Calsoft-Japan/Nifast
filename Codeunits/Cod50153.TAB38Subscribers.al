codeunit 50153 TAB38Subscribers
{
    var
        SalesRelease: Codeunit "Release Sales Document";
        FlagRelease: Boolean;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterOnInsert, '', false, false)]
    local procedure "Sales Header_OnAfterOnInsert"(var SalesHeader: Record "Sales Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        //>>NIF
        if SalesHeader."EDI Control No." = '' then begin
            SalesSetup.GET();
            SalesSetup.TestField("EDI Control Nos.");
            SalesHeader."EDI No. Series" := SalesSetup."EDI Control Nos.";
            SalesHeader."EDI Control No." := NoSeries.GetNextNo(SalesHeader."EDI No. Series", SalesHeader."Posting Date");
        end;
        //<<NIF
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterCopySellToCustomerAddressFieldsFromCustomer, '', false, false)]
    local procedure "Sales Header_OnAfterCopySellToCustomerAddressFieldsFromCustomer"(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean; var SkipSellToContact: Boolean)
    begin

        //SM 001 - 6/12/17
        SalesHeader."Plant Code" := SellToCustomer."CISCO Code";
        //SM 001 - 6/12/17

        //SM 001 - 9/29/17
        SalesHeader."SCAC Code" := SellToCustomer."SCAC Code";
        SalesHeader."Mode of Transport" := SellToCustomer."Mode of Transport";
        //SM 001 - 9/29/17 
        //>> NIF 07-14-05 RTT
        SellToCustomer.CALCFIELDS("Default Model Year");
        SalesHeader."Model Year" := SellToCustomer."Default Model Year";
        //<< NIF 07-14-05 RTT        
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnUpdateSalesLineByChangedFieldName, '', false, false)]
    local procedure "Sales Header_OnUpdateSalesLineByChangedFieldName"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer; xSalesHeader: Record "Sales Header")
    begin
        //>> NIF 07-12-05 RTT
        //if released, then reopen
        if (ChangedFieldName = SalesHeader.FIELDCAPTION("Currency Factor")) and (SalesHeader.Status = SalesHeader.Status::Released) then begin
            FlagRelease := true;
            SalesRelease.Reopen(SalesHeader);
        end;
        //<< NIF 07-12-05 RTT
        case ChangedFieldNo of
            //-AKK1606.01--
            SalesHeader.FieldNo("Entry/Exit No."):
                if (SalesLine."No." <> '') and (SalesLine.Type = SalesLine.Type::Item) and
                not (SalesLine.National) then
                    SalesLine.VALIDATE("Entry/Exit No.", SalesHeader."Entry/Exit No.");
            SalesHeader.FieldNo("Entry/Exit Date"):
                if (SalesLine."No." <> '') and (SalesLine.Type = SalesLine.Type::Item) and
                not (SalesLine.National) then
                    SalesLine.VALIDATE("Entry/Exit Date", SalesHeader."Entry/Exit Date");
            //+AK1606.01++
            //>> NIF #10076 07-06-05 RTT
            SalesHeader.FieldNo("Model Year"):
                SalesLine.VALIDATE("Model Year", SalesHeader."Model Year");
        //<< NIF #10076 07-06-05 RTT
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterUpdateSalesLinesByFieldNo, '', false, false)]
    local procedure "Sales Header_OnAfterUpdateSalesLinesByFieldNo"(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ChangedFieldNo: Integer)
    begin
        //>> NIF 07-13-05 RTT
        //if released, then reopen
        if FlagRelease then
            SalesRelease.RUN(SalesHeader);
        //<< NIF 07-13-05 RTT
    end;


}
