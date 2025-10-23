xmlport 50003 "Import IoT Trans. Rcpt. Data"
{
    // CIS.IoT 07/22/22 RAM Created new Object

    Direction = Import;
    Format = VariableText;
    PreserveWhiteSpace = true;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement("IoT Data Staging"; "IoT Data Staging")
            {
                XmlName = 'IoTData';
                SourceTableView = SORTING("Entry No.");
                fieldelement(DocNo; "IoT Data Staging"."Document No.")
                {

                    trigger OnAfterAssignField()
                    var
                        i: Integer;
                        CleanString: Text[20];
                    begin
                        CleanString := '';
                        FOR i := 1 TO STRLEN("IoT Data Staging"."Document No.") DO
                            CleanString += JunkCleanUp(COPYSTR("IoT Data Staging"."Document No.", i, 1));
                        //MESSAGE('%1\%2\%3',CleanString,STRLEN("IoT Data Staging"."Document No."),"IoT Data Staging"."Document No.");

                        "IoT Data Staging"."Document No." := CleanString;
                    end;
                }
                fieldelement(DocLineNo; "IoT Data Staging"."Line No.")
                {
                }
                fieldelement(ItemNo; "IoT Data Staging"."Item No.")
                {
                }
                fieldelement(LotNo; "IoT Data Staging"."Lot No.")
                {
                }
                fieldelement(Qty; "IoT Data Staging".Quantity)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    "IoT Data Staging"."Document Type" := "IoT Data Staging"."Document Type"::"Trans. Rcpt.";
                    "IoT Data Staging"."Record Status" := "IoT Data Staging"."Record Status"::Processed;
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

    var
        MyFile: Text[250];

    local procedure JunkCleanUp(Input: Code[1]): Code[1]
    begin
        //MESSAGE('%1',Input);
        IF Input = 'Ù' THEN
            Input := '';

        IF Input IN ['A' .. 'Z', '0' .. '9'] THEN
            EXIT(Input)
        ELSE
            EXIT('');
    end;

    procedure SetFileName(FileName: Text[250])
    begin
        MyFile := '';
        MyFile := FileName;
    end;
}

