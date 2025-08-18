tableextension 50081 "Gen. Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        modify("Account No.")
        {
            trigger OnBeforeValidate()
            begin
                //SM 3/11/21-DEPT CODE auto enter
                IF "Account No." = '877' THEN
                    "Shortcut Dimension 2 Code" := 'USUAL';
                //SM 3/11/21-DEPT CODE aut enter
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                Vendor: Record 23;
            begin
                //>>FOREX
                IF ("Account Type" = "Account Type"::Vendor) AND
                   ("Account No." <> '')
                THEN BEGIN
                    Vendor.RESET();
                    Vendor.GET("Account No.");
                    IF Vendor."3 Way Currency Adjmt." THEN
                        VALIDATE(Amount);
                END;
                //<<FOREX
            end;
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            Description = '4x';
            TableRelation = "4X Bank Exchange Contract"."No." WHERE(Expired = CONST(false),
                                                                   "Contract Complete" = CONST(false),
                                                                   Approved = FILTER(<> ''));

            trigger OnValidate();
            var
                Bank4XContract: Record 50010;
                Vend: Record Vendor;
            begin
                //>>IST 052005 DPC #9806
                IF "Exchange Contract No." <> 'SPOT' THEN BEGIN
                    IF Bank4XContract.GET("Exchange Contract No.") THEN BEGIN
                        Bank4XContract.TESTFIELD(Approved); //make sure the contract is approved!
                        Vend.GET("Bill-to/Pay-to No.");
                        "Currency Code" := Vend."Currency Code";
                        Check4XContract();
                        VALIDATE("Currency Factor", Bank4XContract.ExchangeRate);
                    END;
                END
                ELSE BEGIN
                    "Currency Code" := 'USD';
                    VALIDATE("Currency Factor", 1);
                END;
                //<<IST 052005 DPC #9806
            end;
        }
        field(50002; "USD Value"; Decimal)
        {
            Description = 'Forex';
        }
        field(50003; "3-Way Applied"; Boolean)
        {
            Description = 'Forex';
        }
        field(50004; "3-Way Line applied to"; Integer)
        {
            Description = 'Forex';
        }
        field(50010; "EDI Control No."; Code[20])
        {
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            Description = 'NiMex';
        }
        field(55000; "XML - UUID"; Code[36])
        {
            CaptionML = ENU = 'UUID',
                        ESP = 'UUID';
            Description = 'CE 1.2';
        }
        field(55010; "XML - Invoice Folio"; Code[50])
        {
            CaptionML = ENU = 'Invoice Folio',
                        ESP = 'Folio Factura';
            Description = 'CE 1.2';
        }
        field(55020; "XML - Certified No"; Text[20])
        {
            CaptionML = ENU = 'Certified No',
                        ESP = 'Núm. Certificado';
            Description = 'CE 1.2';
        }
        field(55030; "XML - SAT Certified No"; Text[20])
        {
            CaptionML = ENU = 'SAT Certified No',
                        ESP = 'Núm Certificado SAT';
            Description = 'CE 1.2';
        }
        field(55040; "XML - Date/Time Stamped"; Text[50])
        {
            CaptionML = ENU = 'Date/Time Stamped',
                        ESP = 'Fecha/Hora Timbrado';
            Description = 'CE 1.2';
        }
        field(55050; "XML - VAT Registration No"; Code[13])
        {
            CaptionML = ENU = 'VAT Registration No',
                        ESP = 'RFC';
            Description = 'CE 1.2';
        }
        field(55051; "XML - VAT Receptor"; Code[13])
        {
            Description = 'CE 1.2';
        }
        field(55060; "XML - Total Invoice"; Decimal)
        {
            CaptionML = ENU = 'Total Invoice',
                        ESP = 'Total Factura';
            Description = 'CE 1.2';
        }
        field(55070; "XML - Payment Method"; Code[50])
        {
            CaptionML = ENU = 'Payment Method',
                        ESP = 'Método de Pago';
            Description = 'CE 1.2';
        }
        field(55080; "XML - Currency"; Code[50])
        {
            CaptionML = ENU = 'Currency',
                        ESP = 'Moneda';
            Description = 'CE 1.2';
        }
        field(55090; "XML - Currency Factor"; Decimal)
        {
            Caption = 'Tipo de Cambio';
            Description = 'CE 1.2';
        }
        field(55100; "Pymt - Payment Method"; Code[10])
        {
            CaptionML = ENU = 'SAT - Payment Method',
                        ESP = 'SAT - Método Pago';
            Description = 'CE 1.2';
        }
        field(55105; "Pymt - Bank Source Code"; Code[20])
        {
            CaptionML = ENU = 'SAT - Bank Source',
                        ESP = 'SAT - Banco Origen';
            Description = 'CE 1.2';
        }
        field(55110; "Pymt - Bank Source Account"; Code[30])
        {
            CaptionML = ENU = 'SAT - Bank Account Source',
                        ESP = 'SAT - Cuenta Banco Origen';
            Description = 'CE 1.2';
        }
        field(55115; "Pymt - Bank Source Foreign"; Boolean)
        {
            CaptionML = ENU = 'SAT - Source Is Foreign',
                        ESP = 'SAT - Origen Es Extranjero';
            Description = 'CE 1.2';
        }
        field(55120; "Pymt - Bank Target Code"; Code[10])
        {
            CaptionML = ENU = 'SAT - Bank Target',
                        ESP = 'SAT - Banco Destino';
            Description = 'CE 1.2';
        }
        field(55125; "Pymt - Bank Target Account"; Code[30])
        {
            CaptionML = ENU = 'SAT- Bank Target Account ',
                        ESP = 'SAT - Cuenta Banco Destino';
            Description = 'CE 1.2';
        }
        field(55130; "Pymt - Bank Target Foreign"; Boolean)
        {
            CaptionML = ENU = 'SAT - Target Is Foreign',
                        ESP = 'SAT - Destino Es Extranjero';
            Description = 'CE 1.2';
        }
        field(55135; "Pymt - Currency Code"; Code[10])
        {
            CaptionML = ENU = 'SAT - Currency',
                        ESP = 'SAT - Moneda';
            Description = 'CE 1.2';
        }
        field(55140; "Pymt - Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'SAT - Currency Factor',
                        ESP = 'SAT - Tipo Cambio';
            Description = 'CE 1.2';
        }
        field(55145; "Pymt - Beneficiary"; Text[150])
        {
            CaptionML = ENU = 'SAT - Beneficiary',
                        ESP = 'SAT - Beneficiario';
            Description = 'CE 1.2';
        }
        field(55150; "Pymt - VAT Beneficiary"; Code[13])
        {
            CaptionML = ENU = 'SAT - VAT Benecifiary',
                        ESP = 'SAT - RFC Beneficiario';
            Description = 'CE 1.2';
        }
        field(70001; "Original Entry No."; Integer)
        {
            Description = 'Consolidation';
        }
        field(70002; "Original Transaction No."; Integer)
        {
            Description = 'Consolidation';
        }
    }
    Var
    /*         CustLedgEntry: Record 21;
            VendLedgEntry: Record 25;
            //NVM: Codeunit 50021;
            SoftBlockError: Text[80];
            ">>IST": Integer;
            SpotRate: Decimal; */

    trigger OnAfterDelete()
    var
        "3WayGenJnlLine": Record 81;
    begin
        //>>FOREX
        IF "3-Way Applied" THEN
            IF CONFIRM('If you delete 3-way adjustment entry, all corresponding entries will be deleted') THEN BEGIN
                "3WayGenJnlLine".RESET();
                "3WayGenJnlLine".SETRANGE("Journal Template Name", "Journal Template Name");
                "3WayGenJnlLine".SETRANGE("Journal Batch Name", "Journal Batch Name");
                "3WayGenJnlLine".SETRANGE("3-Way Line applied to", "Line No.");
                IF "3WayGenJnlLine".FINDSET() THEN
                    REPEAT
                        "3WayGenJnlLine".DELETE();
                    UNTIL "3WayGenJnlLine".NEXT() = 0;
            END ELSE
                ERROR('User terminated delete of record');

        IF "3-Way Line applied to" <> 0 THEN
            IF CONFIRM('If you delete 3-way adjustment entry, all corresponding entries will be deleted') THEN BEGIN
                "3WayGenJnlLine".RESET();
                "3WayGenJnlLine".SETRANGE("Journal Template Name", "Journal Template Name");
                "3WayGenJnlLine".SETRANGE("Journal Batch Name", "Journal Batch Name");
                "3WayGenJnlLine".SETRANGE("3-Way Line applied to", "3-Way Line applied to");
                IF "3WayGenJnlLine".FINDSET() THEN
                    REPEAT
                        IF "3WayGenJnlLine"."Line No." <> "Line No." THEN
                            "3WayGenJnlLine".DELETE();
                    UNTIL "3WayGenJnlLine".NEXT() = 0;

                "3WayGenJnlLine".RESET();
                "3WayGenJnlLine".SETRANGE("Journal Template Name", "Journal Template Name");
                "3WayGenJnlLine".SETRANGE("Journal Batch Name", "Journal Batch Name");
                "3WayGenJnlLine".SETRANGE("Line No.", "3-Way Line applied to");
                IF "3WayGenJnlLine".FINDSET() THEN BEGIN
                    "3WayGenJnlLine"."3-Way Applied" := FALSE;
                    "3WayGenJnlLine".MODIFY();
                END;
            END ELSE
                ERROR('User terminated delete of record');
        //<<FOREX
    end;

    PROCEDURE ">>>IST"();
    BEGIN
    END;

    PROCEDURE Check4XContract();
    VAR
    /*  Bank4XContract: Record 50010;
     LText50000: Label 'There is not enough remaining to cover this line\Do you want to split this line ?';
     LText50001: Label 'Select another Contract or use SPOT';
     LText50002: Label 'The Amount avaliable on Exchange Contract No. %1 has already been used in this journal', Comment = '%1=Bank4XContract."No."'; */
    BEGIN
        //TODO
        /*   IF Bank4XContract.GET("Exchange Contract No.") THEN BEGIN
              Bank4XContract.CALCFIELDS(JournalAmount);
              IF Bank4XContract.JournalAmount = Bank4XContract.AmountYen THEN
                  ERROR(LText50002, Bank4XContract."No.");

              IF (Bank4XContract.JournalAmount + Amount) > Bank4XContract.AmountYen THEN BEGIN
                  IF NOT CONFIRM(LText50000, FALSE) THEN
                      ERROR(LText50001);

                  SplitLine(Bank4XContract);
              END;
          END; */
        //TODO
    END;

    PROCEDURE SplitLine(VAR Bank4XContract: Record 50010);
    VAR
        GenJnlLine: Record 81;
        _Amount: Decimal;
    BEGIN
        //Modify line to split

        LOCKTABLE();
        GenJnlLine.COPY(Rec);
        _Amount := Amount;
        Amount := Bank4XContract.RemainingAmount;
        /////////////MODIFY;

        //Insert new line after split
        GenJnlLine.Amount := _Amount - Amount;
        GenJnlLine."Line No." := "Line No." + 5111;    ///10000;
        GenJnlLine."Exchange Contract No." := 'SPOT';
        GenJnlLine.INSERT();

        /*  //MAK NOTES from 060805
         { There was an error when inserting lines in this function.The first error stemmed
           from the "Modify" command above.It was giving an error message because the line
           to be "modified" had not actually been inserted / committed yet.Hence, I commented
           that line out.

           The next issue that I saw was the line number.Somewhere in this table the line number
         is being assigned as lines are added.I think this is happening in codeunit 12, but I'm
           not going to spend the time to look for it.Anyway, I thought that assigning the line number
           of the(unmodified) line + 10,000 would conflict with the next line to be inserted.
          Therefore, I decided to assign the line number an odd increment to assure its uniqueness.  This
           did not effect the subsequent line numbers - they are still being incremented by 10,000 based
           on the original "seed" line number.
         } */
    END;
}
