report 50041 "Package Line Label"
{
    // NF1.00:CIS.NU  09-04-15 Merged during upgrade
    // //>> NIF
    // copied from Receive Line print
    // 
    // Functions Modified:
    //   PrintPackageLabel
    // 
    // Date     Init   Proj   Desc
    // 04-26-05 RTT   #9978   code at PrintPackageLabel to handle print server
    // //<< NIF
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Package Line Label';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Package Line"; "Package Line")
        {
            RequestFilterFields = "Package No.", "Line No.";

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, Description);

                Package.GET("Package No.");

                //>>istrtt 7741 08/27/03
                IF QtyToPrint <> 0 THEN
                    "Package Line".Quantity := QtyToPrint;
                //<<
                PrintPackageLine(FALSE);
            end;

            trigger OnPostDataItem()
            begin
                IF "Package Line".GETFILTERS <> '' THEN
                    Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                //PackingStation.GetPackingStation;BC Upgrade can not do local file access

                LabelHeader.GET(LabelHeader.Code);

                IF "Package Line".GETFILTERS = '' THEN
                    CurrReport.BREAK;

                Window.OPEN(
                  'No.        #1######################\' +
                  'Description #2######################');
            end;
        }
        dataitem("Posted Package Line"; "Posted Package Line")
        {
            RequestFilterFields = "Package No.", "Line No.";

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, Description);

                //xPostedReceive.GET("Receive No.");
                //xReceive.TRANSFERFIELDS(PostedReceive);
                //x"Receive Line".TRANSFERFIELDS("Posted Receive Line");
                //xPrintReceiveLine(TRUE);

                PostedPackage.GET("Package No.");
                //>>istrtt 7741 08/27/03
                IF QtyToPrint <> 0 THEN
                    "Posted Package Line".Quantity := QtyToPrint;
                //<<
                Package.TRANSFERFIELDS(PostedPackage);
                "Package Line".TRANSFERFIELDS("Posted Package Line");
                PrintPackageLine(TRUE);
            end;

            trigger OnPostDataItem()
            begin
                //xIF "Receive Line".GETFILTERS = '' THEN
                IF "Package Line".GETFILTERS = '' THEN
                    Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                //xIF "Receive Line".GETFILTERS <> '' THEN
                IF "Package Line".GETFILTERS <> '' THEN
                    CurrReport.BREAK;

                Window.OPEN(
                  'No.        #1######################\' +
                  'Descrition #2######################');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Number of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field("Label Code"; LabelHeader.Code)
                    {
                        ApplicationArea = All;
                        Caption = 'Label Code';
                        TableRelation = "Label Header" WHERE("Label Usage" = CONST("Receive Line"));
                    }
                    field("Quantity to Print"; QtyToPrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Quantity to Print';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PackingStation: Record "Packing Station";
        ReceiveStation: Record "Receive Station";
        LabelHeader: Record "Label Header";
        LabelLine: Record "Label Line";
        Package: Record Package;
        PostedPackage: Record "Posted Package";
        /* BC Upgrade can not do local file access
        LabelMgt: Codeunit "14000841";
        FieldValue: Codeunit "14000843"; */
        Window: Dialog;
        NoOfCopies: Integer;
        "<<IST 7741>>": Integer;
        QtyToPrint: Decimal;
    /* BC Upgrade can not do local file access
    LabelMgtNIF: Codeunit "50017";
    DotNETAutomationMgt: Codeunit "37031001"; */

    procedure PrintPackageLine(Posted: Boolean)
    var
        Item: Record Item;
        OutputFile: File;
        ReturnCode: Integer;
        Value: Text[250];
        CompanyInformation: Record "Company Information";
        "<<NIF_LV>>": Integer;
        OutputFileFTP: File;
    begin
        /* BC Upgrade can not do local file access
        CLEAR(FieldValue);
        //>> NIF
        //FieldValue.Receive_14000601(Receive,0);
        //FieldValue.ReceiveLine_14000602("Receive Line",0);
        FieldValue.Package_14000701(Package, 0);
        FieldValue.PackageLine_14000702("Package Line", 0);
        //<< NIF


        CLEAR(Item);
        //>> NIF
        //IF ("Receive Line".Type = "Receive Line".Type::Item) AND ("Receive Line"."No." <> '') THEN
        //  IF NOT Item.GET("Receive Line"."No.") THEN
        IF ("Package Line".Type = "Package Line".Type::Item) AND ("Package Line"."No." <> '') THEN
            IF NOT Item.GET("Package Line"."No.") THEN
              //<< NIF
              ;
        FieldValue.Item_27(Item, 0);
        // Additional tables can be loaded here.
        CompanyInformation.GET;
        FieldValue.CompanyInformation_79(CompanyInformation, 0);
        ;


        //>> 05-09-05
        //>> NIF
        //ReceiveStation.TESTFIELD("Label Buffer File");
        //PackingStation.TESTFIELD("Label Buffer File");
        //<< NIF

        //OutputFile.TEXTMODE(TRUE);
        //>> NIF
        //OutputFile.CREATE(ReceiveStation."Label Buffer File");
        //OutputFile.CREATE(PackingStation."Label Buffer File");
        //<< NIF

        FieldValue.LabelHeader_14000841(LabelHeader, 0);

        LabelMgtNIF.PrintPackageLineLabel(Package, "Package Line", LabelHeader.Code, QtyToPrint, NoOfCopies);
        EXIT;
        //<< 05-09-05

        LabelMgt.LabelFileTop(LabelHeader, OutputFile);

        LabelLine.RESET;
        LabelLine.SETRANGE("Label Code", LabelHeader.Code);
        IF LabelLine.FIND('-') THEN
            REPEAT
                FieldValue.LabelLine_14000842(LabelLine, 0);
                Value := FieldValue.SubstituteLine(LabelLine);

                LabelMgt.LabelFileLine(LabelHeader, LabelLine, Value, OutputFile);
            UNTIL LabelLine.NEXT = 0;

        LabelMgt.LabelFileBottom(LabelHeader, OutputFile, NoOfCopies);

        OutputFile.CLOSE;

        PackingStation.TESTFIELD("Std. Pack. Label Printer Port");


        //>> NIF 9978 RTT 04-26-05
        IF (NOT PackingStation."No Label Printer") AND (PackingStation."Print Server") THEN BEGIN
            PackingStation.TESTFIELD("FTP Command File");
            PackingStation.TESTFIELD("Printer Server IP");
            OutputFileFTP.TEXTMODE(TRUE);
            OutputFileFTP.CREATE(PackingStation."FTP Command File");
            OutputFileFTP.WRITE('put ' + PackingStation."Label Buffer File");
            OutputFileFTP.WRITE('quit');
            OutputFileFTP.CLOSE;
            //>> NF1.00:CIS.NU 09-04-15
            //ReturnCode :=
            //SHELL(
            //ENVIRON('COMSPEC') + ' /c ftp -n -s:' + PackingStation."FTP Command File" + ' ' +PackingStation."Printer Server IP");

            DotNETAutomationMgt.PrintLabel(PackingStation."Label Buffer File", PackingStation."Std. Pack. Label Printer Port");
            //<< NF1.00:CIS.NU 09-04-15
        END
        ELSE
            //<< NIF 9978 RTT 04-26-05
            IF NOT PackingStation."No Label Printer" THEN
                //>> NF1.00:CIS.NU 09-04-15
                //ReturnCode :=
                //SHELL(
                //ENVIRON('COMSPEC') + ' /c type ' + PackingStation."Label Buffer File" + ' > ' +
                //PackingStation."Std. Pack. Label Printer Port");

                DotNETAutomationMgt.PrintLabel(PackingStation."Label Buffer File", PackingStation."Std. Pack. Label Printer Port");
        //<< NF1.00:CIS.NU 09-04-15
        IF Posted THEN
            PostedPackage.InsertLabelFile(
              PackingStation."Label Buffer File",
              STRSUBSTNO('%1 %2 Label', "Package Line".Type, "Package Line"."No."), 2,
              PackingStation."Std. Pack. Label Printer Port", PackingStation.Code,
              NOT PackingStation."No Label Printer", PackingStation."Do Not Import Label File")
        ELSE
            Package.InsertLabelFile(
              PackingStation."Label Buffer File",
              STRSUBSTNO('%1 %2 Label', "Package Line".Type, "Package Line"."No."), 2,
              PackingStation."Std. Pack. Label Printer Port", PackingStation.Code,
              NOT PackingStation."No Label Printer", PackingStation."Do Not Import Label File"); */
    end;

    procedure LabelFormattingHelp()
    begin
        //>> NIF
        //MESSAGE('Item (27) Receive (14000601) and Receive Line (14000602) are available.');
        MESSAGE('Item (27) Company Information (79) Package (14000701) and Package Line (14000702) are available.');
        //<< NIF
    end;

    procedure GetTableFilter(): Text[250]
    begin
        //>> NIF
        //EXIT('27|14000601|14000602|14000841|14000842');
        EXIT('27|14000701|14000702|14000841|14000842|79');
        //<< NIF
    end;

    procedure GetRecordNoStrMenu(CurrentTableNo: Integer): Text[250]
    begin
        CASE CurrentTableNo OF
            ELSE
                EXIT('');
        END;
    end;

    procedure InitializeRequest(NewLabelCode: Code[10]; NewNoOfCopies: Decimal)
    begin
        LabelHeader.Code := NewLabelCode;
        NoOfCopies := ROUND(NewNoOfCopies, 1);
    end;

    procedure "<<ist 7743>>"()
    begin
    end;

    procedure InitializeRequest2(NewQtyToPrint: Decimal)
    begin
        QtyToPrint := NewQtyToPrint;
    end;
}

