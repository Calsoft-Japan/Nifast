codeunit 50024 "Withholding Calcs"
{

    trigger OnRun()
    begin
    end;

    var
        GLAcc: Record 15;
        PurchLine: Record 39;
        WithHoldSetup: Record 50037;
        IncTaxAcc: Code[10];
        IncTaxGrp: Code[10];
        VatTaxAcc: Code[10];
        VatTaxGrp: Code[10];
        IncTaxPerc: Decimal;
        VatTaxPerc: Decimal;
        CountAppl: Integer;
        Counter: Integer;

    procedure CheckWithHold(PurchInvNo: Code[20])
    var
        Counter01: Integer;
    begin
        Counter := 0;
        CountAppl := 0;
        Counter01 := 0;
        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Invoice);
        PurchLine.SETRANGE(Type, PurchLine.Type::"G/L Account");
        PurchLine.SETRANGE("Document No.", PurchInvNo);
        IF PurchLine.FIND('-') THEN BEGIN
            CountAppl := PurchLine.COUNT;
            REPEAT
                Counter01 := Counter01 + 1;
                GetGLAccInfo(PurchLine."No.");
                // CountAppl := PurchLine."Line No.";
                IF HasIncTax(PurchLine."No.") THEN
                    InsertNewLineInc(PurchInvNo, IncTaxPerc, CountAppl);
                // InsertNewLineVAT(PurchInvNo,VatTaxPerc,CountAppl+2);
                //CountAppl := PurchLine."Line No.";
                IF HasVATTax(PurchLine."No.") THEN
                    InsertNewLineVAT(PurchInvNo, VatTaxPerc, CountAppl + 3);
            UNTIL (PurchLine.NEXT() = 0) OR (CountAppl = Counter01);
        END;
    end;

    local procedure GetGLAccInfo(AccNo: Code[20])
    begin
        GLAcc.GET(AccNo);
        IncTaxGrp := GLAcc."Income Tax Withholding Group";
        VatTaxGrp := GLAcc."VAT Tax Withholding Group";
        CalcISR(IncTaxGrp);
        CalcVAT(VatTaxGrp);
    end;

    local procedure CalcISR(LocCalcISR: Code[10])
    begin
        WithHoldSetup.RESET();
        WithHoldSetup.SETRANGE(WithHoldSetup."Income Tax", TRUE);
        WithHoldSetup.SETRANGE(WithHoldSetup."Withholding Group", LocCalcISR);
        IF WithHoldSetup.FINDSET() THEN
            IncTaxPerc := WithHoldSetup."Withholding Percentage" / 100;
        IncTaxAcc := WithHoldSetup."Purch Withholding Account";
        IF IncTaxPerc <> 0 THEN
            Counter := 1;
    end;

    local procedure CalcVAT(LocCalcVAT: Code[10])
    begin
        WithHoldSetup.RESET();
        WithHoldSetup.SETRANGE(WithHoldSetup."VAT Tax", TRUE);
        WithHoldSetup.SETRANGE(WithHoldSetup."Withholding Group", LocCalcVAT);
        IF WithHoldSetup.FINDSET() THEN
            VatTaxPerc := WithHoldSetup."Withholding Percentage" / 100;
        VatTaxAcc := WithHoldSetup."Purch Withholding Account";
        IF VatTaxPerc <> 0 THEN
            Counter += 1;
    end;

    local procedure InsertNewLineInc(LDocNo: Code[20]; LIncTaxPerc: Decimal; LocCount: Integer)
    var
        PurchLine3: Record 39;
    begin
        Clear(LIncTaxPerc);
        Clear(LocCount);
        PurchLine3.RESET();
        PurchLine3.INIT();
        PurchLine3."Document Type" := PurchLine3."Document Type"::Invoice;
        PurchLine3."Document No." := LDocNo;
        PurchLine3.VALIDATE("Buy-from Vendor No.", PurchLine."Buy-from Vendor No.");
        PurchLine3."Line No." := GetLineNo(PurchLine);//TempPurchLine."Line No."+LocCount;
        PurchLine3.Type := PurchLine3.Type::"G/L Account";
        PurchLine3.VALIDATE("No.", IncTaxAcc);
        PurchLine3."Expected Receipt Date" := PurchLine."Expected Receipt Date";
        PurchLine3.VALIDATE(Quantity, -1);
        PurchLine3.VALIDATE("Direct Unit Cost", PurchLine.Amount * IncTaxPerc);
        PurchLine3."Is retention Line" := TRUE;
        PurchLine3.INSERT();
        COMMIT();
    end;

    local procedure InsertNewLineVAT(LDocNo: Code[20]; LIncTaxPerc: Decimal; LocCount: Integer)
    var
        PurchLine3: Record 39;
    begin

        PurchLine3.RESET();
        PurchLine3.INIT();
        PurchLine3."Document Type" := PurchLine3."Document Type"::Invoice;
        PurchLine3."Document No." := LDocNo;
        PurchLine3.VALIDATE("Buy-from Vendor No.", PurchLine."Buy-from Vendor No.");
        PurchLine3."Line No." := GetLineNo(PurchLine);//TempPurchLine."Line No."+LocCount;
        PurchLine3.Type := PurchLine3.Type::"G/L Account";
        PurchLine3.VALIDATE("No.", VatTaxAcc);
        PurchLine3."Expected Receipt Date" := PurchLine."Expected Receipt Date";
        PurchLine3.VALIDATE(Quantity, -1);
        PurchLine3.VALIDATE("Direct Unit Cost", PurchLine.Amount * VatTaxPerc);
        PurchLine3."Is retention Line" := TRUE;
        PurchLine3.INSERT();
        COMMIT();
        Clear(LIncTaxPerc);
        Clear(LocCount);
    end;

    local procedure GetLineNo(PLine: Record 39): Integer
    var
        PLines: Record 39;
    begin
        PLines.RESET();
        PLines.SETRANGE("Document Type", PLine."Document Type");
        PLines.SETRANGE("Document No.", PLine."Document No.");
        IF NOT PLines.IsEmpty THEN EXIT(PLines."Line No." + 10000);
        EXIT(10000);
    end;

    local procedure HasIncTax(AccNo: Code[20]): Boolean
    var
        GLAccount: Record 15;
    begin
        IF GLAccount.GET(AccNo) THEN
            IF STRLEN(GLAccount."Income Tax Withholding Group") > 0 THEN EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure HasVATTax(AccNo: Code[20]): Boolean
    var
        GLAccount: Record 15;
    begin
        IF GLAccount.GET(AccNo) THEN
            IF STRLEN(GLAccount."VAT Tax Withholding Group") > 0 THEN EXIT(TRUE);
        EXIT(FALSE);
    end;
}

