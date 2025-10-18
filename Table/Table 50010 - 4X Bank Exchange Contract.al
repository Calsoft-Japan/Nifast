table 50010 "4X Bank Exchange Contract"
{
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)
    // >> IST
    // Date     Init  SCR    Description
    // 04-11-05 DPC   #9806  New Table to hold "Bank Exchange Contracts"
    // << IST

    LookupPageID = 50029;
    fields
    {
        field(1; "No."; Code[10])
        {
            trigger OnValidate()
            begin

                IF "No." <> xRec."No." THEN BEGIN
                    GLSetup.GET();
                    NoSeriesMgt.TestManual(GLSetup."Bank Exchange Contract Nos.");
                    "No. Series" := '';
                END;

                "Date Created" := TODAY;
            end;

        }
        field(2; BankName; Text[30])
        {
            // cleaned
        }
        field(3; Bank; Code[10])
        {
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                BankAccount.GET(Bank);
                BankName := BankAccount.Name;
            end;
        }
        field(4; "Amount $"; Decimal)
        {
            // cleaned
        }
        field(5; ExchangeRate; Decimal)
        {
            DecimalPlaces = 1 : 10;
            trigger OnValidate()
            begin
                IF ExchangeRate <> 0 THEN
                    "Amount $" := AmountYen / ExchangeRate
                ELSE
                    "Amount $" := 0;
            end;
        }
        field(6; AmountYen; Decimal)
        {
            trigger OnValidate()
            begin
                IF ExchangeRate <> 0 THEN
                    "Amount $" := AmountYen / ExchangeRate
                ELSE
                    "Amount $" := 0;
            end;
        }
        field(7; "Date Created"; Date)
        {
            // cleaned
        }
        field(8; PeriodStart; Date)
        {
            trigger OnValidate()
            begin
                IF PeriodEnd <> 0D THEN
                    IF PeriodStart > PeriodEnd THEN
                        FIELDERROR(PeriodStart, ' - "Window From" MUST BE Before "Window To"');
            end;
        }
        field(9; PeriodEnd; Date)
        {
            trigger OnValidate()
            begin
                IF PeriodEnd <> 0D THEN
                    IF PeriodStart > PeriodEnd THEN
                        FIELDERROR(PeriodEnd, ' - "Window From" MUST BE Before "Window To"');
            end;
        }
        field(10; Approved; Code[50])
        {
            Description = '10-->50 NF1.00:CIS.NG  10-10-15';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestPermission();
                TESTFIELD("Bank Contract No.");
                TESTFIELD(PeriodStart);
                TESTFIELD(PeriodEnd);
            end;
        }
        field(11; RemainingAmount; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            begin
                CALCFIELDS(JournalAmount);
                RemainingAmount := AmountYen - "Posted Amount";
                VALIDATE("Sell Back Rate");
            end;
        }
        field(12; "Sell Back Rate"; Decimal)
        {
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            begin
                IF "Sell Back Rate" <> 0 THEN
                    "Sell Back Amount" := RemainingAmount / "Sell Back Rate";
            end;
        }
        field(14; "Bank Contract No."; Code[30])
        {
            // cleaned
        }
        field(15; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(16; "Contract Complete"; Boolean)
        {
            // cleaned
        }
        field(17; Expired; Boolean)
        {
            Editable = true;
        }
        field(18; JournalAmount; Decimal)
        {
            // cleaned
            CalcFormula = Sum("Gen. Journal Line".Amount WHERE("Exchange Contract No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(19; "Current Assigned Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("4X Purchase Header"."Ext. Cost" WHERE("Exchange Contract No." = FIELD("No.")));
            Editable = false;
        }
        field(20; "Sell Back Amount"; Decimal)
        {
            // cleaned
        }
        field(21; "Posted Amount"; Decimal)
        {
            // cleaned
            CalcFormula = Sum("G/L Entry"."4X Amount JPY" WHERE("Exchange Contract No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record 98;
        BankAccount: Record 270;
        NoSeriesMgt: Codeunit "No. Series";
        TEXT001: Label 'You do not have permissions to change this value';



    trigger OnInsert()
    begin
        GLSetup.GET();
        IF "No." = '' THEN
            NoSeriesMgt.AreRelated(GLSetup."Bank Exchange Contract Nos.", xRec."No. Series");
        VALIDATE(RemainingAmount);
        "Date Created" := TODAY;
    end;

    trigger OnModify()
    begin
        VALIDATE(RemainingAmount);
    end;



    procedure TestPermission()
    var
        UserSetup: Record 91;
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Approve BankContract" THEN
            ERROR(TEXT001);
    end;

    procedure CheckExpiration()
    var
        Rec_: Record 50010;
    begin
        IF 0D IN [PeriodStart, PeriodEnd] THEN
            EXIT
        ELSE BEGIN
            Rec_.COPY(Rec);
            SETFILTER("No.", '<>SPOT');
            IF FIND('-') THEN
                REPEAT
                    IF WORKDATE() > PeriodEnd THEN BEGIN
                        Expired := TRUE;
                        MODIFY();
                    END ELSE BEGIN
                        Expired := FALSE;
                        MODIFY();
                    END;
                UNTIL NEXT() = 0;
            Rec.COPY(Rec_);
        END;
    end;

    procedure CheckClosed()
    begin
        IF FIND('-') THEN
            REPEAT
                CALCFIELDS("Posted Amount");
                IF AmountYen = "Posted Amount" THEN BEGIN
                    "Contract Complete" := TRUE;
                    MODIFY();
                END;
            UNTIL NEXT() = 0;
    end;

    procedure CloseContract(var ContractToClose: Record 50010)
    var
        LText50000: Label 'You have not specified a Sell Back Rate\Close the contract anyway ?';
    begin
        VALIDATE(RemainingAmount);
        IF RemainingAmount <> 0 THEN
            IF "Sell Back Rate" = 0 THEN
                IF NOT CONFIRM(LText50000, FALSE) THEN
                    EXIT;

        "Contract Complete" := TRUE;
        MODIFY();
    end;

    procedure AssistEdit(OldMaster: Record 50010): Boolean
    begin
        GLSetup.GET();
        IF NoSeriesMgt.LookupRelatedNoSeries(GLSetup."Bank Exchange Contract Nos.", OldMaster."No. Series", "No. Series") THEN BEGIN
            GLSetup.GET();
            NoSeriesMgt.GetNextNo("No.");
            EXIT(TRUE);
        END;
    end;
}
