xmlport 50008 "Import Forecast w Description"
{
    // NF1.00:CIS.NG    12/08/15 To Prevent white space in item code update xmlport port property - PreserveWhiteSpace = Yes

    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    //TextEncoding = MS-DOS;
    TextEncoding = MSDOS;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Forecast Ledger Entry"; "Forecast Ledger Entry")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'ForecastLE';
                UseTemporary = false;
                fieldelement(ItemNo; "Forecast Ledger Entry"."Item No.")
                {
                }
                fieldelement(ForecastQty; "Forecast Ledger Entry"."Forecast Quantity")
                {
                }
                fieldelement(CustNo; "Forecast Ledger Entry"."Customer No.")
                {
                }
                fieldelement(ShippingDate; "Forecast Ledger Entry"."Shipping Date")
                {
                }
                fieldelement(DivCode; "Forecast Ledger Entry"."Division Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EnterDate; "Forecast Ledger Entry"."Enter Date")
                {
                }
                fieldelement(Description; "Forecast Ledger Entry".Description)
                {
                }
                fieldelement(NifastForecast; "Forecast Ledger Entry"."Nifast Forecast")
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                var
                begin
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    /* local procedure EvaluateDate(parDateText: Text[10]): Date
    var
        locYear: Integer;
        locMonth: Integer;
        locDay: Integer;
        Txtlen: Integer;
        TmpStr: Text[10];
        Slashpos: Integer;
    begin
        locYear := 0;
        locMonth := 0;
        locDay := 0;

        IF STRLEN(parDateText) = 10 THEN BEGIN      //mm/dd/yyyy
            IF EVALUATE(locYear, COPYSTR(parDateText, 7, 4)) AND
             EVALUATE(locMonth, COPYSTR(parDateText, 1, 2)) AND
             EVALUATE(locDay, COPYSTR(parDateText, 4, 2))
            THEN
                EXIT(DMY2DATE(locDay, locMonth, locYear))
        END ELSE BEGIN
            Slashpos := STRPOS(parDateText, '/');
            Txtlen := STRLEN(parDateText);
            TmpStr := COPYSTR(parDateText, Slashpos + 1, Txtlen - Slashpos);
            IF Slashpos = 3 THEN
                EVALUATE(locMonth, COPYSTR(parDateText, 1, 2))
            ELSE
                EVALUATE(locMonth, COPYSTR(parDateText, 1, 1));
            Slashpos := STRPOS(TmpStr, '/');
            Txtlen := STRLEN(TmpStr);
            IF Slashpos = 3 THEN
                EVALUATE(locDay, COPYSTR(TmpStr, 1, 2))
            ELSE
                EVALUATE(locDay, COPYSTR(TmpStr, 1, 1));
            EVALUATE(locYear, COPYSTR(TmpStr, Slashpos + 1, 4));
            IF (locDay + locMonth + locYear) > 0 THEN
                EXIT(DMY2DATE(locDay, locMonth, locYear))
            ELSE
                EXIT(0D);
        END
    end; */
}

