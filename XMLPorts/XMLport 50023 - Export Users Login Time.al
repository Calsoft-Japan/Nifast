xmlport 50023 "Export Users Login Time"
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
            tableelement("User Time Register"; "User Time Register")
            {
                XmlName = 'UserTime';
                fieldattribute(UserName; "User Time Register"."User ID")
                {
                }
                fieldattribute(DateLogin; "User Time Register".Date)
                {

                    trigger OnBeforePassField()
                    begin
                        IF "User Time Register".Date <> tOdATE THEN
                            currXMLport.SKIP();
                    end;
                }
                fieldattribute(TimeLogged; "User Time Register".Minutes)
                {
                }
                textelement(CoName)
                {
                }

                trigger OnPreXmlItem()
                begin
                    "User Time Register".SETRANGE(Date, tOdATE);
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
        InputDate: Date;
        datestr: Text[10];
    begin
        InitializeGlobals();
        InputDate := TODAY;
        datestr := FORMAT(DATE2DMY(InputDate, 2)) + FORMAT(DATE2DMY(InputDate, 1)) + FORMAT(DATE2DMY(InputDate, 3)); //mdy
        currXMLport.FILENAME := 'c:\temp\userstimelog' + datestr + '.csv';
        //"User Time Register".SETFILTER(Date, '>=%1',010116D);
        CoName := COMPANYNAME;
        tOdATE := TODAY;
    end;

    var
        QuitLoop: Boolean;
        tOdATE: Date;
        LastLineNo: Integer;
        PrevColumnNo: Integer;
        ErrorText: Text;

    local procedure InitializeGlobals()
    begin
        //PostExchEntryNo := "Posting Exch. Field".GETRANGEMIN("Posting Exch. No.");
        LastLineNo := 1;
        PrevColumnNo := 0;
        QuitLoop := FALSE;
    end;
}

