xmlport 50024 "Export Session Event"
{
    Caption = 'Export Users Login Time';
    Direction = Export;
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Session Event"; "Session Event")
            {
                XmlName = 'SessionEvnt';
                fieldattribute(SId; "Session Event"."Session ID")
                {
                }
                fieldattribute(EvntTyp; "Session Event"."Event Type")
                {

                    trigger OnBeforePassField()
                    begin
                        /*
                        IF "Session Event"."Event Datetime" < (ToDtTime -40) THEN
                           currXMLport.SKIP;
                        */

                    end;
                }
                fieldattribute(EvntDtTime; "Session Event"."Event Datetime")
                {
                }
                fieldattribute(ClntType; "Session Event"."Client Type")
                {
                }
                fieldattribute(UsrId; "Session Event"."User ID")
                {
                }
                fieldattribute(ClntCompNm; "Session Event"."Client Computer Name")
                {
                }
                textelement(coname)
                {
                    XmlName = 'CoName';
                }

                trigger OnPreXmlItem()
                begin
                    //"Session Event".SETRANGE("Event Datetime",ToDtTime,ToDtTime+1);
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

    trigger OnInitXmlPort()
    begin
        //jrr Window.OPEN(ProgressMsg);
    end;

    trigger OnPostXmlPort()
    begin
        IF ErrorText <> '' THEN
            ERROR(ErrorText);

        //jrrWindow.CLOSE;

        //    currXMLport.FILENAME := PostingExchDef.Name + '.csv';
    end;

    trigger OnPreXmlPort()
    var
        datestr: Text[10];
        InputDate: Date;
    begin
        InitializeGlobals();
        InputDate := TODAY;
        datestr := FORMAT(DATE2DMY(InputDate, 2)) + FORMAT(DATE2DMY(InputDate, 1)) + FORMAT(DATE2DMY(InputDate, 3)); //mdy
        currXMLport.FILENAME := 'c:\temp\userstimelog' + datestr + '.csv';
        //"User Time Register".SETFILTER(Date, '>=%1',010116D);
        CoName := COMPANYNAME;
        tOdATE := TODAY - 40;
        ToDtTime := CURRENTDATETIME;
    end;

    var
        ErrorText: Text;
        LastLineNo: Integer;
        PrevColumnNo: Integer;
        QuitLoop: Boolean;
        tOdATE: Date;
        ToDtTime: DateTime;

    local procedure InitializeGlobals()
    begin
        //PostExchEntryNo := "Posting Exch. Field".GETRANGEMIN("Posting Exch. No.");
        LastLineNo := 1;
        PrevColumnNo := 0;
        QuitLoop := FALSE;
    end;
}

