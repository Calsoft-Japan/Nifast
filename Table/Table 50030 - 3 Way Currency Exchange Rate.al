table 50030 "3 Way Currency Exchange Rate"
{
    // NF1.00:CIS.RAM 09/07/15 Forex Change
    //  # Created
    //  # Added new function ExchangeAmtFCYtoUSD

    Caption = 'Currency Exchange Rate';
    DataCaptionFields = "Currency Code";
    DrillDownPageID = 483;
    LookupPageID = 483;
    fields
    {
        field(1; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            NotBlank = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                IF "Currency Code" = "Relational Currency Code" THEN
                    ERROR(
                      Text000, FIELDCAPTION("Currency Code"), FIELDCAPTION("Relational Currency Code"));
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(3; "Exchange Rate Amount"; Decimal)
        {
            Caption = 'Exchange Rate Amount';
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TESTFIELD("Exchange Rate Amount");
            end;
        }
        field(4; "Adjustment Exch. Rate Amount"; Decimal)
        {
            AccessByPermission = TableData 4 = R;
            Caption = 'Adjustment Exch. Rate Amount';
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TESTFIELD("Adjustment Exch. Rate Amount");
            end;
        }
        field(5; "Relational Currency Code"; Code[10])
        {
            Caption = 'Relational Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                IF "Currency Code" = "Relational Currency Code" THEN
                    ERROR(
                      Text000, FIELDCAPTION("Currency Code"), FIELDCAPTION("Relational Currency Code"));
            end;
        }
        field(6; "Relational Exch. Rate Amount"; Decimal)
        {
            AccessByPermission = TableData 4 = R;
            Caption = 'Relational Exch. Rate Amount';
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TESTFIELD("Relational Exch. Rate Amount");
            end;
        }
        field(7; "Fix Exchange Rate Amount"; Option)
        {
            Caption = 'Fix Exchange Rate Amount';
            OptionCaption = 'Currency,Relational Currency,Both';
            OptionMembers = Currency,"Relational Currency",Both;
        }
        field(8; "Relational Adjmt Exch Rate Amt"; Decimal)
        {
            AccessByPermission = TableData 4 = R;
            Caption = 'Relational Adjmt Exch Rate Amt';
            DecimalPlaces = 1 : 6;
            MinValue = 0;
            trigger OnValidate()
            begin
                TESTFIELD("Relational Adjmt Exch Rate Amt");
            end;
        }
    }

    keys
    {
        key(Key1; "Currency Code", "Relational Currency Code", "Starting Date")
        {
        }
    }

    fieldgroups
    {
    }

    var

        CurrencyExchRate2: array[2] of Record 50030;
        CurrencyExchRate3: array[3] of Record 50030;
        RelExchangeRateAmt: Decimal;
        ExchangeRateAmt: Decimal;
        RelCurrencyCode: Code[10];
        FixExchangeRateAmt: Option;
        CurrencyFactor: Decimal;
        UseAdjmtAmounts: Boolean;
        CurrencyCode2: array[2] of Code[10];
        Date2: array[2] of Date;
        Text000: Label 'The currency code in the %1 field and the %2 field cannot be the same.',
          Comment = '%1 = From Currency Code field, %2 = To Currency Code field.';

    procedure ExchangeAmtLCYToFCY(Date: Date; CurrencyCode: Code[10]; Amount: Decimal; Factor: Decimal): Decimal
    begin
        IF CurrencyCode = '' THEN
            EXIT(Amount);
        FindCurrency(Date, CurrencyCode, 1);
        TESTFIELD("Exchange Rate Amount");
        TESTFIELD("Relational Exch. Rate Amount");
        IF "Relational Currency Code" = '' THEN
            IF "Fix Exchange Rate Amount" = "Fix Exchange Rate Amount"::Both THEN
                Amount := (Amount / "Relational Exch. Rate Amount") * "Exchange Rate Amount"
            ELSE
                Amount := Amount * Factor
        ELSE BEGIN
            RelExchangeRateAmt := "Relational Exch. Rate Amount";
            ExchangeRateAmt := "Exchange Rate Amount";
            RelCurrencyCode := "Relational Currency Code";
            FixExchangeRateAmt := "Fix Exchange Rate Amount";
            FindCurrency(Date, RelCurrencyCode, 2);
            TESTFIELD("Exchange Rate Amount");
            TESTFIELD("Relational Exch. Rate Amount");
            CASE FixExchangeRateAmt OF
                "Fix Exchange Rate Amount"::"Relational Currency":
                    ExchangeRateAmt :=
                      (Factor * RelExchangeRateAmt * "Relational Exch. Rate Amount") /
                      "Exchange Rate Amount";
                "Fix Exchange Rate Amount"::Currency:
                    RelExchangeRateAmt :=
                      (ExchangeRateAmt * "Exchange Rate Amount") /
                      (Factor * "Relational Exch. Rate Amount");
                "Fix Exchange Rate Amount"::Both:
                    CASE "Fix Exchange Rate Amount" OF
                        "Fix Exchange Rate Amount"::"Relational Currency":
                            "Exchange Rate Amount" :=
                              (Factor * RelExchangeRateAmt * "Relational Exch. Rate Amount") /
                              ExchangeRateAmt;
                        "Fix Exchange Rate Amount"::Currency:
                            "Relational Exch. Rate Amount" :=
                              (ExchangeRateAmt * "Exchange Rate Amount") /
                              (Factor * RelExchangeRateAmt);
                    END;
            END;
            Amount := (Amount / RelExchangeRateAmt) * ExchangeRateAmt;
            Amount := (Amount / "Relational Exch. Rate Amount") * "Exchange Rate Amount";
        END;
        EXIT(Amount);
    end;

    procedure ExchangeAmtFCYToLCY(Date: Date; CurrencyCode: Code[10]; Amount: Decimal; Factor: Decimal): Decimal
    begin
        IF CurrencyCode = '' THEN
            EXIT(Amount);
        FindCurrency(Date, CurrencyCode, 1);
        IF NOT UseAdjmtAmounts THEN BEGIN
            TESTFIELD("Exchange Rate Amount");
            TESTFIELD("Relational Exch. Rate Amount");
        END ELSE BEGIN
            TESTFIELD("Adjustment Exch. Rate Amount");
            TESTFIELD("Relational Adjmt Exch Rate Amt");
            "Exchange Rate Amount" := "Adjustment Exch. Rate Amount";
            "Relational Exch. Rate Amount" := "Relational Adjmt Exch Rate Amt";
        END;
        IF "Relational Currency Code" = '' THEN
            IF "Fix Exchange Rate Amount" = "Fix Exchange Rate Amount"::Both THEN
                Amount := (Amount / "Exchange Rate Amount") * "Relational Exch. Rate Amount"
            ELSE
                Amount := Amount / Factor
        ELSE BEGIN
            RelExchangeRateAmt := "Relational Exch. Rate Amount";
            ExchangeRateAmt := "Exchange Rate Amount";
            RelCurrencyCode := "Relational Currency Code";
            FixExchangeRateAmt := "Fix Exchange Rate Amount";
            FindCurrency(Date, RelCurrencyCode, 2);
            IF NOT UseAdjmtAmounts THEN BEGIN
                TESTFIELD("Exchange Rate Amount");
                TESTFIELD("Relational Exch. Rate Amount");
            END ELSE BEGIN
                TESTFIELD("Adjustment Exch. Rate Amount");
                TESTFIELD("Relational Adjmt Exch Rate Amt");
                "Exchange Rate Amount" := "Adjustment Exch. Rate Amount";
                "Relational Exch. Rate Amount" := "Relational Adjmt Exch Rate Amt";
            END;
            CASE FixExchangeRateAmt OF
                "Fix Exchange Rate Amount"::"Relational Currency":
                    ExchangeRateAmt :=
                      (RelExchangeRateAmt * "Relational Exch. Rate Amount") /
                      ("Exchange Rate Amount" * Factor);
                "Fix Exchange Rate Amount"::Currency:
                    RelExchangeRateAmt :=
                      ((Factor * ExchangeRateAmt * "Exchange Rate Amount") /
                       "Relational Exch. Rate Amount");
                "Fix Exchange Rate Amount"::Both:
                    CASE "Fix Exchange Rate Amount" OF
                        "Fix Exchange Rate Amount"::"Relational Currency":
                            "Exchange Rate Amount" :=
                              (RelExchangeRateAmt * "Relational Exch. Rate Amount") /
                              (ExchangeRateAmt * Factor);
                        "Fix Exchange Rate Amount"::Currency:
                            "Relational Exch. Rate Amount" :=
                              ((Factor * ExchangeRateAmt * "Exchange Rate Amount") /
                               RelExchangeRateAmt);
                        "Fix Exchange Rate Amount"::Both:
                            BEGIN
                                Amount := (Amount / ExchangeRateAmt) * RelExchangeRateAmt;
                                Amount := (Amount / "Exchange Rate Amount") * "Relational Exch. Rate Amount";
                                EXIT(Amount);
                            END;
                    END;
            END;
            Amount := (Amount / RelExchangeRateAmt) * ExchangeRateAmt;
            Amount := (Amount / "Relational Exch. Rate Amount") * "Exchange Rate Amount";
        END;
        EXIT(Amount);
    end;

    procedure ExchangeRate(Date: Date; CurrencyCode: Code[10]): Decimal
    begin
        IF CurrencyCode = '' THEN
            EXIT(1);
        FindCurrency(Date, CurrencyCode, 1);
        IF NOT UseAdjmtAmounts THEN BEGIN
            TESTFIELD("Exchange Rate Amount");
            TESTFIELD("Relational Exch. Rate Amount");
        END ELSE BEGIN
            TESTFIELD("Adjustment Exch. Rate Amount");
            TESTFIELD("Relational Adjmt Exch Rate Amt");
            "Exchange Rate Amount" := "Adjustment Exch. Rate Amount";
            "Relational Exch. Rate Amount" := "Relational Adjmt Exch Rate Amt";
        END;
        RelExchangeRateAmt := "Relational Exch. Rate Amount";
        ExchangeRateAmt := "Exchange Rate Amount";
        RelCurrencyCode := "Relational Currency Code";
        IF "Relational Currency Code" = '' THEN
            CurrencyFactor := "Exchange Rate Amount" / "Relational Exch. Rate Amount"
        ELSE BEGIN
            FindCurrency(Date, RelCurrencyCode, 2);
            IF NOT UseAdjmtAmounts THEN BEGIN
                TESTFIELD("Exchange Rate Amount");
                TESTFIELD("Relational Exch. Rate Amount");
            END ELSE BEGIN
                TESTFIELD("Adjustment Exch. Rate Amount");
                TESTFIELD("Relational Adjmt Exch Rate Amt");
                "Exchange Rate Amount" := "Adjustment Exch. Rate Amount";
                "Relational Exch. Rate Amount" := "Relational Adjmt Exch Rate Amt";
            END;
            CurrencyFactor := (ExchangeRateAmt * "Exchange Rate Amount") / (RelExchangeRateAmt * "Relational Exch. Rate Amount");
        END;
        EXIT(CurrencyFactor);
    end;

    procedure ExchangeAmtLCYToFCYOnlyFactor(Amount: Decimal; Factor: Decimal): Decimal
    begin
        Amount := Factor * Amount;
        EXIT(Amount);
    end;

    procedure ExchangeAmtFCYToLCYAdjmt(Date: Date; CurrencyCode: Code[10]; Amount: Decimal; Factor: Decimal): Decimal
    begin
        UseAdjmtAmounts := TRUE;
        EXIT(ExchangeAmtFCYToLCY(Date, CurrencyCode, Amount, Factor));
    end;

    procedure ExchangeRateAdjmt(Date: Date; CurrencyCode: Code[10]): Decimal
    begin
        UseAdjmtAmounts := TRUE;
        EXIT(ExchangeRate(Date, CurrencyCode));
    end;

    procedure ExchangeAmount(Amount: Decimal; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; UsePostingDate: Date): Decimal
    var
        ToCurrency: Record 4;
    begin
        IF (FromCurrencyCode = ToCurrencyCode) OR (Amount = 0) THEN
            EXIT(Amount);

        Amount :=
          ExchangeAmtFCYToFCY(
            UsePostingDate, FromCurrencyCode, ToCurrencyCode, Amount);

        IF ToCurrencyCode <> '' THEN BEGIN
            ToCurrency.GET(ToCurrencyCode);
            Amount := ROUND(Amount, ToCurrency."Amount Rounding Precision");
        END ELSE
            Amount := ROUND(Amount);

        EXIT(Amount);
    end;

    procedure FindCurrency(Date: Date; CurrencyCode: Code[10]; CacheNo: Integer)
    begin
        IF (CurrencyCode2[CacheNo] = CurrencyCode) AND (Date2[CacheNo] = Date) THEN
            Rec := CurrencyExchRate2[CacheNo]
        ELSE BEGIN
            IF Date = 0D THEN
                Date := WORKDATE();
            CurrencyExchRate2[CacheNo].SETRANGE("Currency Code", CurrencyCode);
            CurrencyExchRate2[CacheNo].SETRANGE("Starting Date", 0D, Date);
            CurrencyExchRate2[CacheNo].FINDLAST();
            Rec := CurrencyExchRate2[CacheNo];
            CurrencyCode2[CacheNo] := CurrencyCode;
            Date2[CacheNo] := Date;
        END;
    end;

    procedure ExchangeAmtFCYToFCY(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal): Decimal
    begin
        IF FromCurrencyCode = ToCurrencyCode THEN
            EXIT(Amount);
        IF ToCurrencyCode = '' THEN BEGIN
            FindCurrency2(Date, FromCurrencyCode, 1);
            IF CurrencyExchRate3[1]."Relational Currency Code" = '' THEN
                EXIT(
                  (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
                  CurrencyExchRate3[1]."Relational Exch. Rate Amount");

            FindCurrency2(Date, CurrencyExchRate3[1]."Relational Currency Code", 3);
            Amount :=
              ((Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
               CurrencyExchRate3[1]."Relational Exch. Rate Amount");
            EXIT(
              (Amount / CurrencyExchRate3[3]."Exchange Rate Amount") *
              CurrencyExchRate3[3]."Relational Exch. Rate Amount");
        END;
        IF FromCurrencyCode = '' THEN BEGIN
            FindCurrency2(Date, ToCurrencyCode, 2);
            IF CurrencyExchRate3[2]."Relational Currency Code" = '' THEN
                EXIT(
                  (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
                  CurrencyExchRate3[2]."Exchange Rate Amount");

            FindCurrency2(Date, CurrencyExchRate3[2]."Relational Currency Code", 3);
            Amount :=
              ((Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
               CurrencyExchRate3[2]."Exchange Rate Amount");
            EXIT(
              (Amount / CurrencyExchRate3[3]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[3]."Exchange Rate Amount");
        END;
        FindCurrency2(Date, FromCurrencyCode, 1);
        FindCurrency2(Date, ToCurrencyCode, 2);
        IF CurrencyExchRate3[1]."Currency Code" = CurrencyExchRate3[2]."Relational Currency Code" THEN
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        IF CurrencyExchRate3[1]."Relational Currency Code" = CurrencyExchRate3[2]."Currency Code" THEN
            EXIT(
              (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
              CurrencyExchRate3[1]."Relational Exch. Rate Amount");

        IF CurrencyExchRate3[1]."Relational Currency Code" = CurrencyExchRate3[2]."Relational Currency Code" THEN BEGIN
            Amount :=
              ((Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
               CurrencyExchRate3[1]."Relational Exch. Rate Amount");
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        END;
        IF (CurrencyExchRate3[1]."Relational Currency Code" = '') AND
           (CurrencyExchRate3[2]."Relational Currency Code" <> '')
        THEN BEGIN
            FindCurrency2(Date, CurrencyExchRate3[2]."Relational Currency Code", 3);
            Amount :=
              (Amount * CurrencyExchRate3[1]."Relational Exch. Rate Amount") /
              CurrencyExchRate3[1]."Exchange Rate Amount";
            Amount :=
              (Amount / CurrencyExchRate3[3]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[3]."Exchange Rate Amount";
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        END;
        IF (CurrencyExchRate3[1]."Relational Currency Code" <> '') AND
           (CurrencyExchRate3[2]."Relational Currency Code" = '')
        THEN BEGIN
            FindCurrency2(Date, CurrencyExchRate3[1]."Relational Currency Code", 3);
            Amount :=
              (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
              CurrencyExchRate3[1]."Relational Exch. Rate Amount";
            Amount :=
              (Amount / CurrencyExchRate3[3]."Exchange Rate Amount") *
              CurrencyExchRate3[3]."Relational Exch. Rate Amount";
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        END;
    end;

    procedure FindCurrency2(Date: Date; CurrencyCode: Code[10]; Number: Integer)
    begin
        IF Date = 0D THEN
            Date := WORKDATE();
        CurrencyExchRate3[Number].SETRANGE("Currency Code", CurrencyCode);
        CurrencyExchRate3[Number].SETRANGE("Starting Date", 0D, Date);
        CurrencyExchRate3[Number].FINDLAST();
        CurrencyExchRate3[Number].TESTFIELD("Exchange Rate Amount");
        CurrencyExchRate3[Number].TESTFIELD("Relational Exch. Rate Amount");
    end;

    procedure ApplnExchangeAmtFCYToFCY(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal; var ExchRateFound: Boolean): Decimal
    begin
        IF FromCurrencyCode = ToCurrencyCode THEN
            EXIT(Amount);
        IF ToCurrencyCode = '' THEN BEGIN
            ExchRateFound := FindApplnCurrency(Date, FromCurrencyCode, 1);
            IF NOT ExchRateFound THEN
                EXIT(0);

            IF CurrencyExchRate3[1]."Relational Currency Code" = '' THEN
                EXIT(
                  (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
                  CurrencyExchRate3[1]."Relational Exch. Rate Amount");

            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[1]."Relational Currency Code", 3);
            IF NOT ExchRateFound THEN
                EXIT(0);

            Amount :=
              (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
              CurrencyExchRate3[1]."Relational Exch. Rate Amount";
            EXIT(
              (Amount / CurrencyExchRate3[3]."Exchange Rate Amount") *
              CurrencyExchRate3[3]."Relational Exch. Rate Amount");
        END;
        IF FromCurrencyCode = '' THEN BEGIN
            ExchRateFound := FindApplnCurrency(Date, ToCurrencyCode, 2);
            IF NOT ExchRateFound THEN
                EXIT(0);

            IF CurrencyExchRate3[2]."Relational Currency Code" = '' THEN
                EXIT(
                  (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
                  CurrencyExchRate3[2]."Exchange Rate Amount");

            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[2]."Relational Currency Code", 3);
            IF NOT ExchRateFound THEN
                EXIT(0);

            Amount :=
              ((Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
               CurrencyExchRate3[2]."Exchange Rate Amount");
            EXIT(
              (Amount / CurrencyExchRate3[3]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[3]."Exchange Rate Amount");
        END;
        ExchRateFound := FindApplnCurrency(Date, FromCurrencyCode, 1);
        IF NOT ExchRateFound THEN
            EXIT(0);

        ExchRateFound := FindApplnCurrency(Date, ToCurrencyCode, 2);
        IF NOT ExchRateFound THEN
            EXIT(0);

        IF CurrencyExchRate3[1]."Currency Code" = CurrencyExchRate3[2]."Relational Currency Code" THEN
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        IF CurrencyExchRate3[1]."Relational Currency Code" = CurrencyExchRate3[2]."Currency Code" THEN
            EXIT(
              (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
              CurrencyExchRate3[1]."Relational Exch. Rate Amount");

        IF CurrencyExchRate3[1]."Relational Currency Code" = CurrencyExchRate3[2]."Relational Currency Code" THEN BEGIN
            Amount :=
              ((Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
               CurrencyExchRate3[1]."Relational Exch. Rate Amount");
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        END;
        IF (CurrencyExchRate3[1]."Relational Currency Code" = '') AND
           (CurrencyExchRate3[2]."Relational Currency Code" <> '')
        THEN BEGIN
            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[2]."Relational Currency Code", 3);
            IF NOT ExchRateFound THEN
                EXIT(0);

            Amount :=
              (Amount * CurrencyExchRate3[1]."Relational Exch. Rate Amount") /
              CurrencyExchRate3[1]."Exchange Rate Amount";
            Amount :=
              (Amount / CurrencyExchRate3[3]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[3]."Exchange Rate Amount";
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        END;
        IF (CurrencyExchRate3[1]."Relational Currency Code" <> '') AND
           (CurrencyExchRate3[2]."Relational Currency Code" = '')
        THEN BEGIN
            ExchRateFound := FindApplnCurrency(Date, CurrencyExchRate3[1]."Relational Currency Code", 3);
            IF NOT ExchRateFound THEN
                EXIT(0);

            Amount :=
              (Amount / CurrencyExchRate3[1]."Exchange Rate Amount") *
              CurrencyExchRate3[1]."Relational Exch. Rate Amount";
            Amount :=
              (Amount / CurrencyExchRate3[3]."Exchange Rate Amount") *
              CurrencyExchRate3[3]."Relational Exch. Rate Amount";
            EXIT(
              (Amount / CurrencyExchRate3[2]."Relational Exch. Rate Amount") *
              CurrencyExchRate3[2]."Exchange Rate Amount");
        END;
    end;

    local procedure FindApplnCurrency(Date: Date; CurrencyCode: Code[10]; Number: Integer): Boolean
    begin
        CurrencyExchRate3[Number].SETRANGE("Currency Code", CurrencyCode);
        CurrencyExchRate3[Number].SETRANGE("Starting Date", 0D, Date);
        IF NOT CurrencyExchRate3[Number].FINDLAST() THEN
            EXIT(FALSE);

        CurrencyExchRate3[Number].TESTFIELD("Exchange Rate Amount");
        CurrencyExchRate3[Number].TESTFIELD("Relational Exch. Rate Amount");
        EXIT(TRUE);
    end;

    procedure GetCurrentCurrencyFactor(CurrencyCode: Code[10]): Decimal
    begin
        SETRANGE("Currency Code", CurrencyCode);
        IF FINDLAST() THEN
            IF "Relational Exch. Rate Amount" <> 0 THEN
                EXIT("Exchange Rate Amount" / "Relational Exch. Rate Amount")
    end;

    procedure SetCurrentCurrencyFactor(CurrencyCode: Code[10]; CurrencyFactor_: Decimal)
    var
        RateForTodayExists: Boolean;
    begin
        "Currency Code" := CurrencyCode;
        TESTFIELD("Currency Code");
        RateForTodayExists := GET(CurrencyCode, TODAY);
        "Exchange Rate Amount" := 1;
        "Relational Exch. Rate Amount" := 1 / CurrencyFactor_;
        "Adjustment Exch. Rate Amount" := "Exchange Rate Amount";
        "Relational Adjmt Exch Rate Amt" := "Relational Exch. Rate Amount";
        IF RateForTodayExists THEN BEGIN
            "Relational Currency Code" := '';
            MODIFY();
        END ELSE BEGIN
            "Starting Date" := TODAY;
            INSERT();
        END;
    end;

    procedure ExchangeAmtFCYToUSD(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal): Decimal
    var
        CurrencyExchRate: Record 50030;
    begin
        //>>NF1.00:CIS.RAM
        IF FromCurrencyCode = ToCurrencyCode THEN
            EXIT(Amount);

        IF FromCurrencyCode = '' THEN
            ERROR('From currency code cannot be blank');

        IF ToCurrencyCode = '' THEN
            ERROR('To currency code cannot be blank');

        IF Date = 0D THEN
            Date := WORKDATE();

        CurrencyExchRate.RESET();
        CurrencyExchRate.SETRANGE("Currency Code", FromCurrencyCode);
        CurrencyExchRate.SETRANGE("Relational Currency Code", ToCurrencyCode);
        CurrencyExchRate.SETRANGE("Starting Date", 0D, Date);
        CurrencyExchRate.FINDLAST();
        CurrencyExchRate.TESTFIELD("Exchange Rate Amount");
        CurrencyExchRate.TESTFIELD("Relational Exch. Rate Amount");
        Amount :=
            (Amount * CurrencyExchRate."Relational Exch. Rate Amount") /
            CurrencyExchRate."Exchange Rate Amount";
        EXIT(Amount);
        //<<NF1.00:CIS.RAM
    end;
}
