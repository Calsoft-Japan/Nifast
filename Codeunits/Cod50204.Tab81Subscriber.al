codeunit 50204 Tab81Subscriber
{
    Var
        //TODO
        // NVM: Codeunit 50021;
        //TODO
        //SoftBlockError: Text[80];
        EmplLedgEntry: Record "Employee Ledger Entry";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";



    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnValidateAccountNoOnBeforeAssignValue, '', false, false)]
    local procedure OnValidateAccountNoOnBeforeAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    begin
        //TODO
        /*  case GenJournalLine."Account Type" of
             GenJournalLine."Account Type"::Customer:
                 //>>NV
                 IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment THEN
                     IF NVM.CheckSoftBlock(0, GenJournalLine."Account No.", '', '', 8, SoftBlockError) THEN
                         ERROR(SoftBlockError);
             //<<NV
             GenJournalLine."Account Type"::Vendor:
                 //>>NV
                 IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment THEN
                     IF NVM.CheckSoftBlock(1, GenJournalLine."Account No.", '', '', 8, SoftBlockError) THEN
                         ERROR(SoftBlockError);
         //<<NV
         End; */
        //TODO
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnBeforeValidateAppliesToDocNo, '', false, false)]
    local procedure OnBeforeValidateAppliesToDocNo(var GenJnlLine: Record "Gen. Journal Line"; xGenJnlLine: Record "Gen. Journal Line"; CurrentFieldNo: Integer; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        TempGenJnlLine: Record "Gen. Journal Line" temporary;
    begin
        IsHandled := true;

        if SuppressCommit then
            PaymentToleranceMgt.SetSuppressCommit(true);

        if (GenJnlLine."Applies-to Doc. No." = '') and (xGenJnlLine."Applies-to Doc. No." <> '') then begin
            PaymentToleranceMgt.DelPmtTolApllnDocNo(GenJnlLine, xGenJnlLine."Applies-to Doc. No.");

            TempGenJnlLine := GenJnlLine;
            if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) or
               (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor) or
               (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Employee)
            then
                CODEUNIT.Run(CODEUNIT::"Exchange Acc. G/L Journal Line", TempGenJnlLine);

            case TempGenJnlLine."Account Type" of
                TempGenJnlLine."Account Type"::Customer:
                    begin
                        CustLedgEntry.SetCurrentKey("Document No.");
                        CustLedgEntry.SetRange("Document No.", xGenJnlLine."Applies-to Doc. No.");
                        if not (xGenJnlLine."Applies-to Doc. Type" = GenJnlLine."Document Type"::" ") then
                            CustLedgEntry.SetRange("Document Type", xGenJnlLine."Applies-to Doc. Type");
                        CustLedgEntry.SetRange("Customer No.", TempGenJnlLine."Account No.");
                        CustLedgEntry.SetRange(Open, true);
                        if CustLedgEntry.FindFirst() then begin
                            if CustLedgEntry."Amount to Apply" <> 0 then begin
                                CustLedgEntry."Amount to Apply" := 0;
                                CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry);
                            end;
                            GenJnlLine."Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                            GenJnlLine."Applies-to Ext. Doc. No." := '';
                        end;
                    end;
                TempGenJnlLine."Account Type"::Vendor:
                    begin
                        VendLedgEntry.SetCurrentKey("Document No.");
                        VendLedgEntry.SetRange("Document No.", xGenJnlLine."Applies-to Doc. No.");
                        if not (xGenJnlLine."Applies-to Doc. Type" = GenJnlLine."Document Type"::" ") then
                            VendLedgEntry.SetRange("Document Type", xGenJnlLine."Applies-to Doc. Type");
                        VendLedgEntry.SetRange("Vendor No.", TempGenJnlLine."Account No.");
                        VendLedgEntry.SetRange(Open, true);
                        if VendLedgEntry.FindFirst() then begin
                            if VendLedgEntry."Amount to Apply" <> 0 then begin
                                VendLedgEntry."Amount to Apply" := 0;
                                CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
                            end;
                            GenJnlLine."Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                        end;
                        GenJnlLine."Applies-to Ext. Doc. No." := '';
                    end;
                TempGenJnlLine."Account Type"::Employee:
                    begin
                        EmplLedgEntry.SetCurrentKey("Document No.");
                        EmplLedgEntry.SetRange("Document No.", xGenJnlLine."Applies-to Doc. No.");
                        if not (xGenJnlLine."Applies-to Doc. Type" = GenJnlLine."Document Type"::" ") then
                            EmplLedgEntry.SetRange("Document Type", xGenJnlLine."Applies-to Doc. Type");
                        EmplLedgEntry.SetRange("Employee No.", TempGenJnlLine."Account No.");
                        EmplLedgEntry.SetRange(Open, true);
                        if EmplLedgEntry.FindFirst() then begin
                            if EmplLedgEntry."Amount to Apply" <> 0 then begin
                                EmplLedgEntry."Amount to Apply" := 0;
                                CODEUNIT.Run(CODEUNIT::"Empl. Entry-Edit", EmplLedgEntry);
                            end;
                            GenJnlLine."Exported to Payment File" := EmplLedgEntry."Exported to Payment File";
                        end;
                    end;
            end;
        end;

        if (GenJnlLine."Applies-to Doc. No." <> xGenJnlLine."Applies-to Doc. No.") and (GenJnlLine.Amount <> 0) then begin
            if xGenJnlLine."Applies-to Doc. No." <> '' then
                PaymentToleranceMgt.DelPmtTolApllnDocNo(GenJnlLine, xGenJnlLine."Applies-to Doc. No.");
            GenJnlLine.SetApplyToAmount();
            PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine);
            xGenJnlLine.ClearAppliedGenJnlLine();
        end;

        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::Customer:
                GenJnlLine.GetCustLedgerEntry();
            GenJnlLine."Account Type"::Vendor:
                GenJnlLine.GetVendLedgerEntry();
            GenJnlLine."Account Type"::Employee:
                GenJnlLine.GetEmplLedgerEntry();
        end;

        GenJnlLine.ValidateApplyRequirements(GenJnlLine);
        GenJnlLine.SetJournalLineFieldsFromApplication();

        if GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::Invoice then
            GenJnlLine.UpdateAppliesToInvoiceID();
    end;
}