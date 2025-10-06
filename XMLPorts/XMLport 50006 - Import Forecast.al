xmlport 50006 "Import Forecast"
{
    // NF1.00:CIS.NG    12/08/15 To Prevent white space in item code update xmlport port property - PreserveWhiteSpace = Yes

    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    TextEncoding = MS-DOS;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Table50027;Table50027)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'ForecastLE';
                UseTemporary = false;
                fieldelement(ItemNo;"Forecast Ledger Entry"."Item No.")
                {
                }
                fieldelement(ForecastQty;"Forecast Ledger Entry"."Forecast Quantity")
                {
                }
                fieldelement(CustNo;"Forecast Ledger Entry"."Customer No.")
                {
                }
                fieldelement(ShippingDate;"Forecast Ledger Entry"."Shipping Date")
                {
                }
                fieldelement(DivCode;"Forecast Ledger Entry"."Division Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EnterDate;"Forecast Ledger Entry"."Enter Date")
                {
                }
                fieldelement(Remark;"Forecast Ledger Entry".Remark)
                {
                }
                fieldelement(NifForecast;"Forecast Ledger Entry"."Nifast Forecast")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000005";
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

    local procedure EvaluateDate(parDateText: Text[10]): Date
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
          IF EVALUATE(locYear,COPYSTR(parDateText,7,4)) AND
           EVALUATE(locMonth,COPYSTR(parDateText,1,2)) AND
           EVALUATE(locDay,COPYSTR(parDateText,4,2))
          THEN
            EXIT(DMY2DATE(locDay,locMonth,locYear))
        END ELSE BEGIN
          Slashpos := STRPOS(parDateText,'/');
          Txtlen := STRLEN(parDateText);
          TmpStr := COPYSTR(parDateText,Slashpos+1,Txtlen-Slashpos);
          IF Slashpos = 3 THEN BEGIN
            EVALUATE(locMonth,COPYSTR(parDateText,1,2))
          END ELSE
            EVALUATE(locMonth,COPYSTR(parDateText,1,1));
           Slashpos := STRPOS(TmpStr,'/');
           Txtlen := STRLEN(TmpStr);
           IF Slashpos = 3 THEN BEGIN
             EVALUATE(locDay,COPYSTR(TmpStr,1,2))
           END ELSE
             EVALUATE(locDay,COPYSTR(TmpStr,1,1));
          EVALUATE(locYear,COPYSTR(TmpStr,Slashpos+1,4));
          IF (locDay+locMonth+locYear) >0 THEN
            EXIT(DMY2DATE(locDay,locMonth,locYear))
          ELSE
            EXIT(0D);
        END
    end;
}

