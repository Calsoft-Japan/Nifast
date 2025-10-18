xmlport 50035 "Import IoT Sales Shpt. Data"
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
                fieldelement(RFID; "IoT Data Staging"."RFID Gate No.")
                {

                    trigger OnAfterAssignField()
                    var
                        i: Integer;
                        CleanString: Text[20];
                    begin
                        CleanString := '';
                        FOR i := 1 TO STRLEN("IoT Data Staging"."RFID Gate No.") DO
                            CleanString += JunkCleanUp(COPYSTR("IoT Data Staging"."RFID Gate No.", i, 1));
                        //MESSAGE('%1\%2\%3',CleanString,STRLEN("IoT Data Staging"."Document No."),"IoT Data Staging"."Document No.");

                        "IoT Data Staging"."RFID Gate No." := CleanString;
                    end;
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
                    "IoT Data Staging"."Document Type" := "IoT Data Staging"."Document Type"::"Sales Ship";
                    "IoT Data Staging"."File Name" := MyFile;
                    "IoT Data Staging"."Date Imported" := TODAY;
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

