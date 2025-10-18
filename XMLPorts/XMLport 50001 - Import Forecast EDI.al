xmlport 50001 "Import Forecast EDI"
{
    // NF1.00:CIS.NG    12/08/15 To Prevent white space in item code update xmlport port property - PreserveWhiteSpace = Yes
    // NF1.00:CIS.RAM   10/04/24 Added Description field to the XML port

    Direction = Import;
    Format = Xml;
    FormatEvaluate = Xml;
    PreserveWhiteSpace = true;
    //TextEncoding = UTF8;
    Encoding = UTF8;

    schema
    {
        textelement(NAVXML)
        {
            textelement(Forecast_Table)
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
                    textelement(ShippingDate)
                    {

                        trigger OnAfterAssignVariable()
                        begin
                            "Forecast Ledger Entry"."Shipping Date" := EvaluateDate(ShippingDate);
                        end;
                    }
                    fieldelement(DivCode; "Forecast Ledger Entry"."Division Code")
                    {
                    }
                    textelement(EnterDate)
                    {

                        trigger OnAfterAssignVariable()
                        begin
                            "Forecast Ledger Entry"."Enter Date" := EvaluateDate(EnterDate);
                        end;
                    }

                    trigger OnBeforeInsertRecord()
                    begin
                    end;
                }
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

    local procedure EvaluateDate(parDateText: Text[8]): Date
    var
        locYear: Integer;
        locMonth: Integer;
        locDay: Integer;
    begin
        IF EVALUATE(locYear, COPYSTR(parDateText, 1, 4)) AND
           EVALUATE(locMonth, COPYSTR(parDateText, 5, 2)) AND
           EVALUATE(locDay, COPYSTR(parDateText, 7, 2))
        THEN
            EXIT(DMY2DATE(locDay, locMonth, locYear))
        ELSE
            EXIT(0D);
    end;
}

