xmlport 50002 "Import IoT Invt. Pick Data"
{
    // CIS.IoT 07/22/22 RAM Created new Object
    // CIS.RAM 04/18/23 RAM Modified to update Invt. Pick files status to processed

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
                textelement(Dummy)
                {
                }
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
                fieldelement(LineNo; "IoT Data Staging"."Line No.")
                {
                }
                fieldelement(TableID; "IoT Data Staging"."Table No.")
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
                fieldelement(FromLocation; "IoT Data Staging"."Location From")
                {
                }
                fieldelement(ToLocation; "IoT Data Staging"."Location To")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    "IoT Data Staging"."Document Type" := "IoT Data Staging"."Document Type"::"Invt. Pick";

                    //>>CIS.RAM 04/18/23
                    IF WarehouseActivityHeader.GET(WarehouseActivityHeader.Type::"Invt. Pick", "IoT Data Staging"."Document No.") THEN
                        "IoT Data Staging"."Record Status" := "IoT Data Staging"."Record Status"::Processed;
                    //<<CIS.RAM 04/18/23
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
        WarehouseActivityHeader: Record "Warehouse Activity Header";
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

