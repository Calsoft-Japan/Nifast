report 50082 "Export Payee Match"
{
    // NF1.00:CIS.NG    06/18/16 Create New Report to Export Payee Match File to Shared Directory and Upload to FTP

    Caption = 'Export Payee Match';
    Permissions = TableData 270=rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem5439;Table272)
        {
            DataItemTableView = SORTING(Document No.,Posting Date)
                                WHERE(Entry Status=FILTER(Posted|Financially Voided));
            RequestFilterFields = "Check Date","Bank Account No.";

            trigger OnAfterGetRecord()
            var
                ChrLength_lInt: Integer;
                Vendor_lRec: Record "23";
                Customer_lRec: Record "18";
            begin
                RecNo_gInt := RecNo_gInt + 1;

                IF GUIALLOWED THEN
                  Window_gDlg.UPDATE(2,ROUND(RecNo_gInt / TotalRec_gInt * 10000,1));

                IF RecNo_gInt = 1 THEN BEGIN
                  //3.1
                  Export_31_gFnc;

                  //3.2
                  Export_32_gFnc;
                END;

                //3.3
                Export_33_gFnc;
            end;

            trigger OnPostDataItem()
            begin
                //3.5 & 3.6
                IF RecNo_gInt > 0 THEN BEGIN
                  Export_35_gFnc;
                  Export_36_gFnc;
                END;

                TextFile_gFil.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                IF GETFILTER("Bank Account No.") = '' THEN
                  ERROR(Text001_gCtx,FIELDCAPTION("Bank Account No."));

                IF GETFILTER("Check Date") = '' THEN
                  ERROR('Please apply Check Date Filter');

                TotalRec_gInt := COUNT;
                RecNo_gInt := 0;

                TextFile_gFil.CREATE(FileName_gTxt);
                TextFile_gFil.CREATEOUTSTREAM(OutStreamObj_gOsm);

                IF GUIALLOWED THEN BEGIN
                  Window_gDlg.OPEN(
                    '#1##################################\\' +
                    '@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\');

                  Window_gDlg.UPDATE(1,Text002_gCtx);
                END;

                //3.0
                Export_30_gFnc;
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
                group(Option)
                {
                    Caption = 'Option';
                    field("For Testing";ForTesting_gBln)
                    {
                        Caption = 'For Testing';
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

    trigger OnPostReport()
    begin
        IF GUIALLOWED THEN
          Window_gDlg.CLOSE;

        ExportFTPFiles_lFnc(FileName_gTxt);

        IF RecNo_gInt = 0 THEN BEGIN
          IF EXISTS(FileName_gTxt) THEN
            ERASE(FileName_gTxt);

          ERROR(Text004_gCtx);
        END ELSE
          MESSAGE(Text005_gCtx,FileName_gTxt);
    end;

    trigger OnPreReport()
    begin
        GLSetup_gRec.GET;
        IF GLSetup_gRec."Upload File To FTP" THEN BEGIN
          GLSetup_gRec.TESTFIELD("FTP Server Name with Directory");  //  ftp://ftp.haldengroup.com/ECommerceDemo/WebOrder/
          GLSetup_gRec.TESTFIELD("FTP User ID");
          GLSetup_gRec.TESTFIELD("FTP Password");
        END;

        GLSetup_gRec.TESTFIELD("Payee Match Export Shared Dir");
        UpdatePath_gFnc(GLSetup_gRec."Payee Match Export Shared Dir");

        FileName_gTxt := GLSetup_gRec."Payee Match Export Shared Dir" + 'PayeeMatch' + '_' + FORMAT(TODAY,0,'<Day,2><Month,2><Year4>') + '_' + FORMAT(TIME,0,'<Hours24,2><Minutes,2><Seconds,2>') + '.txt';
    end;

    var
        BankAcc_gRec: Record "270";
        GLSetup_gRec: Record "98";
        TextFile_gFil: File;
        OutStreamObj_gOsm: OutStream;
        Window_gDlg: Dialog;
        BankAccountNo_gCod: Code[20];
        FileName_gTxt: Text;
        VoidChr_gTxt: Text[1];
        PayeeLine1_gTxt: Text[40];
        PayeeLine2_gTxt: Text[40];
        FilterText_gTxt: Text[25];
        TotalRec_gInt: Integer;
        RecNo_gInt: Integer;
        Text001_gCtx: Label 'Please selecte %1';
        Text002_gCtx: Label 'Export Posted Payment File...';
        Text003_gCtx: Label 'Please enter the file name to export Positive Pay.';
        Text004_gCtx: Label 'There is nothing to export.';
        Text005_gCtx: Label 'Posted payment file exported successfully at location: %1';
        Text008_gCtx: Label 'Text Files (*.txt)|*.txt';
        Text500000: Label 'The string %1 contains no number and cannot be incremented.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Payment_FileCaptionLbl: Label 'Posted Payment File';
        PaidDate_gTxtCaptionLbl: Label 'Posting Date';
        Amount_gTxtCaptionLbl: Label 'Amount';
        CheckNo_gTxtCaptionLbl: Label 'Check No.';
        AccountNo_gTxtCaptionLbl: Label 'Account Number';
        VoidChr_gTxtCaptionLbl: Label 'Void Character';
        AdditionalData_gTxtCaptionLbl: Label 'Addition Data';
        PayeeLine1_gTxtCaptionLbl: Label 'Payee Line 1';
        PayeeLine2_gTxtCaptionLbl: Label 'Payee Line 2';
        FilterText_gTxtCaptionLbl: Label 'Filter Text';
        ForTesting_gBln: Boolean;
        RecordCount3_1_gCod: Code[7];
        BatchSequenceNumber_gTxt: Text[4];
        TotalAmount_gDec: Decimal;

    procedure Export_30_gFnc()
    var
        ASCIIFiles_lTxt: Text[20];
    begin
        IF ForTesting_gBln THEN
          ASCIIFiles_lTxt := '$$LW00PMFF[ATEST$$'
        ELSE
          ASCIIFiles_lTxt := '$$LW00PMFF$$';

        OutStreamObj_gOsm.WRITETEXT(ASCIIFiles_lTxt);
        OutStreamObj_gOsm.WRITETEXT();
    end;

    procedure Export_31_gFnc()
    var
        RecordIdentifier_lTxt: Text[1];
        FileNumber_lTxt: Text[4];
        ClientNumber_lTxt: Text[9];
        FileCreationDate_lTxt: Text[8];
        FILLER_lTxt: Text[665];
        FileCreationDate_lDte: Date;
    begin
        //Record Identifier
        RecordIdentifier_lTxt := 'A';

        //Record Count
        RecordCount3_1_gCod := '0000001';

        //File Number
        BankAcc_gRec.GET("Check Ledger Entry"."Bank Account No.");
        BankAcc_gRec.TESTFIELD("File Number Payee Match");

        IF INCSTR(BankAcc_gRec."File Number Payee Match") = '' THEN
          ERROR(Text500000,BankAcc_gRec."File Number Payee Match");

        IF STRLEN(BankAcc_gRec."File Number Payee Match") <> 4 THEN
          BankAcc_gRec.FIELDERROR("File Number Payee Match",'should be contain 4 digit');

        FileNumber_lTxt := INCSTR(BankAcc_gRec."File Number Payee Match");
        BankAcc_gRec."File Number Payee Match" := FileNumber_lTxt;
        BankAcc_gRec.MODIFY;

        //Client Number
        BankAcc_gRec.TESTFIELD("Client Number Payee Match");
        IF STRLEN(BankAcc_gRec."Client Number Payee Match") <> 9 THEN
          BankAcc_gRec.FIELDERROR("Client Number Payee Match",'should be contain 9 chacter');

        ClientNumber_lTxt := BankAcc_gRec."Client Number Payee Match";

        //File Creation Date
        FileCreationDate_lTxt := FORMAT(TODAY,8,'<Year4><Month,2><Day,2>');

        //FILLER
        LeftFillCharacter_lFnc(FILLER_lTxt,665,' ');

        OutStreamObj_gOsm.WRITETEXT(RecordIdentifier_lTxt);
        OutStreamObj_gOsm.WRITETEXT(RecordCount3_1_gCod);
        OutStreamObj_gOsm.WRITETEXT(FileNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ClientNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FileCreationDate_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FILLER_lTxt);
        OutStreamObj_gOsm.WRITETEXT();
    end;

    procedure Export_32_gFnc()
    var
        RecordIdentifier_lTxt: Text[1];
        TransitBranchNumber_lTxt: Text[5];
        ReservedForAccount_lTxt: Text[5];
        BankAccountNumber_lTxt: Text[7];
        Currency_lTxt: Text[3];
        SRFNumber_lTxt: Text[9];
        FILLER_lTxt: Text[52];
        FinanicialInstituionNumber_lTxt: Text[5];
        ServiceTypeIndicator_lTxt: Text[4];
        FILLER2_lTxt: Text[592];
        GLSetup_lRec: Record "98";
    begin
        //Record Identifier
        RecordIdentifier_lTxt := 'B';

        //Record Count
        RecordCount3_1_gCod := INCSTR(RecordCount3_1_gCod);

        //Batch Sequence Number
        BatchSequenceNumber_gTxt := '0001';

        //Transit/Branch Number
        BankAcc_gRec.TESTFIELD("Transit/Branch Number");
        IF STRLEN(BankAcc_gRec."Transit/Branch Number") <> 5 THEN
          BankAcc_gRec.FIELDERROR("Transit/Branch Number",'should be length of 5 digit');

        TransitBranchNumber_lTxt := BankAcc_gRec."Transit/Branch Number";

        //Reserved for account Numbers
        LeftFillCharacter_lFnc(ReservedForAccount_lTxt,5,' ');

        //Bank Account Number
        BankAcc_gRec.TESTFIELD("Bank Account No.");
        BankAccountNumber_lTxt := DELCHR(BankAcc_gRec."Bank Account No.",'=','-');

        //Currency
        GLSetup_lRec.GET;
        Currency_lTxt := GLSetup_lRec."LCY Code";

        //SRF Number
        BankAcc_gRec.TESTFIELD("SRF Number");
        IF STRLEN(BankAcc_gRec."SRF Number") <> 9 THEN
          BankAcc_gRec.FIELDERROR("SRF Number",'must have 9 character');

        SRFNumber_lTxt := BankAcc_gRec."SRF Number";

        //FILLER
        LeftFillCharacter_lFnc(FILLER_lTxt,52,' ');

        //Financial Year Institution Number
        FinanicialInstituionNumber_lTxt := '00003';  //Default as per file Format

        //Service Type Indicator
        ServiceTypeIndicator_lTxt := '0002';  //0002 = Payee Match only

        //FILLER
        LeftFillCharacter_lFnc(FILLER2_lTxt,592,' ');

        OutStreamObj_gOsm.WRITETEXT(RecordIdentifier_lTxt);
        OutStreamObj_gOsm.WRITETEXT(RecordCount3_1_gCod);
        OutStreamObj_gOsm.WRITETEXT(BatchSequenceNumber_gTxt);
        OutStreamObj_gOsm.WRITETEXT(TransitBranchNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ReservedForAccount_lTxt);
        OutStreamObj_gOsm.WRITETEXT(BankAccountNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(Currency_lTxt);
        OutStreamObj_gOsm.WRITETEXT(SRFNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FILLER_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FinanicialInstituionNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ServiceTypeIndicator_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FILLER2_lTxt);
        OutStreamObj_gOsm.WRITETEXT();
    end;

    procedure Export_33_gFnc()
    var
        VLE_lRec: Record "25";
        RecordIdentifier_lTxt: Text[1];
        TransactionCode_lTxt: Text[3];
        TransitBranchNumber_lTxt: Text[5];
        ReservedForAccountgt7_lTxt: Text[5];
        BankAccountNumber_lTxt: Text[7];
        ChequeNumber_lTxt: Text[12];
        ChequeAmount_lTxt: Text[10];
        ClientReference_lTxt: Text[19];
        TraceNumber_lTxt: Text[8];
        IssueDate_lTxt: Text[8];
        VendorNumber_lTxt: Text[14];
        CountryCode_lTxt: Text[1];
        DistributionCode_lTxt: Text[3];
        PayeeName1_lTxt: Text[60];
        PayeeName2_lTxt: Text[60];
        PayeeName3_lTxt: Text[60];
        AddressLine1_lTxt: Text[60];
        AddressLine2_lTxt: Text[60];
        AddressLine3_lTxt: Text[60];
        AddressLine4_lTxt: Text[60];
        AddressLine5_lTxt: Text[60];
        AddressLine6_lTxt: Text[60];
        AddressLine7_lTxt: Text[51];
        Diff_lInt: Integer;
        Var_ltxt: Text;
        BankAcc_lRec: Record "270";
    begin
        BankAcc_lRec.GET("Check Ledger Entry"."Bank Account No.");
        //Record Identifier
        RecordIdentifier_lTxt := 'C';

        //Record Count
        RecordCount3_1_gCod := INCSTR(RecordCount3_1_gCod);

        //Transaction Code
        CASE "Check Ledger Entry"."Entry Status" OF
          "Check Ledger Entry"."Entry Status"::Posted:
            TransactionCode_lTxt := '300';
          "Check Ledger Entry"."Entry Status"::"Financially Voided":
            TransactionCode_lTxt := '490';
          ELSE
            ERROR('Check Entry Status case is not defined');
        END;

        //Transit/Branch Number
        TransitBranchNumber_lTxt := BankAcc_gRec."Transit/Branch Number";

        //Reserved for account Numbers
        LeftFillCharacter_lFnc(ReservedForAccountgt7_lTxt,5,' ');

        //Bank Account Number
        BankAcc_gRec.TESTFIELD("Bank Account No.");
        BankAccountNumber_lTxt := DELCHR(BankAcc_gRec."Bank Account No.",'=','-');

        //Reserved for cheque # greater than 8 & //Cheque Number
        "Check Ledger Entry".TESTFIELD("Check No.");
        ChequeNumber_lTxt := "Check Ledger Entry"."Check No.";
        LeftFillCharacter_lFnc(ChequeNumber_lTxt,12-STRLEN(ChequeNumber_lTxt),'0');

        //Cheque Amount
        TotalAmount_gDec += ROUND("Check Ledger Entry".Amount,0.01);
        ChequeAmount_lTxt := GetAmtText_gFnc("Check Ledger Entry".Amount);
        LeftFillCharacter_lFnc(ChequeAmount_lTxt,10-STRLEN(ChequeAmount_lTxt),'0');

        //Client Reference
        LeftFillCharacter_lFnc(ClientReference_lTxt,19,' ');

        //Trace Number
        LeftFillCharacter_lFnc(TraceNumber_lTxt,8,' ');

        //Issue Date
        IssueDate_lTxt := FORMAT("Check Ledger Entry"."Check Date",8,'<Year4><Month,2><Day,2>');

        //Vendor Number
        VendorNumber_lTxt := '';
        VLE_lRec.RESET;
        VLE_lRec.SETRANGE("Document No.","Check Ledger Entry"."Check No.");
        VLE_lRec.SETRANGE("Posting Date","Check Ledger Entry"."Posting Date");
        IF VLE_lRec.FINDFIRST THEN
          VendorNumber_lTxt := VLE_lRec."Vendor No.";

        RightFillCharacter_lFnc(VendorNumber_lTxt,14-STRLEN(VendorNumber_lTxt),' ');


        //Country Code
        CountryCode_lTxt := '1';  //Value: "1" = Canada "2" = USA "3" = International (Cheque Issuance Only)

        //Distribution Code
        DistributionCode_lTxt := '000';  //Value: "000" = Mail; "999" = Return to Sender (Cheque Issuance Only)

        //Payee Name 1
        PayeeName1_lTxt := COPYSTR("Check Ledger Entry".Description,1,35);
        RightFillCharacter_lFnc(PayeeName1_lTxt,60-STRLEN(PayeeName1_lTxt),' ');

        //Payee Name 2
        RightFillCharacter_lFnc(PayeeName2_lTxt,60,' ');

        //Payee Name 3
        RightFillCharacter_lFnc(PayeeName3_lTxt,60,' ');

        //Address Line 1
        RightFillCharacter_lFnc(AddressLine1_lTxt,60,' ');

        //Address Line 2
        RightFillCharacter_lFnc(AddressLine2_lTxt,60,' ');

        //Address Line 3
        RightFillCharacter_lFnc(AddressLine3_lTxt,60,' ');

        //Address Line 4
        RightFillCharacter_lFnc(AddressLine4_lTxt,60,' ');

        //Address Line 5
        RightFillCharacter_lFnc(AddressLine5_lTxt,60,' ');

        //Address Line 6
        RightFillCharacter_lFnc(AddressLine6_lTxt,60,' ');

        //Address Line 7
        RightFillCharacter_lFnc(AddressLine7_lTxt,51,' ');

        OutStreamObj_gOsm.WRITETEXT(RecordIdentifier_lTxt);
        OutStreamObj_gOsm.WRITETEXT(RecordCount3_1_gCod);
        OutStreamObj_gOsm.WRITETEXT(TransactionCode_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TransitBranchNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ReservedForAccountgt7_lTxt);
        OutStreamObj_gOsm.WRITETEXT(BankAccountNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ChequeNumber_lTxt);  //Reserved Char + Check Number
        OutStreamObj_gOsm.WRITETEXT(ChequeAmount_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ClientReference_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TraceNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(IssueDate_lTxt);
        OutStreamObj_gOsm.WRITETEXT(VendorNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(CountryCode_lTxt);
        OutStreamObj_gOsm.WRITETEXT(DistributionCode_lTxt);
        OutStreamObj_gOsm.WRITETEXT(PayeeName1_lTxt);
        OutStreamObj_gOsm.WRITETEXT(PayeeName2_lTxt);
        OutStreamObj_gOsm.WRITETEXT(PayeeName3_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine1_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine2_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine3_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine4_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine5_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine6_lTxt);
        OutStreamObj_gOsm.WRITETEXT(AddressLine7_lTxt);
        OutStreamObj_gOsm.WRITETEXT();
    end;

    procedure Export_35_gFnc()
    var
        RecordIdentifier_lTxt: Text[1];
        RecordCount_lTxt: Text[7];
        BatchSequenceNumber_lTxt: Text[4];
        TransitBranchNumber_lTxt: Text[5];
        ReservedForAccount_lTxt: Text[5];
        BankAccountNumber_lTxt: Text[7];
        TotalNumberTransactionRecords_lTxt: Text[8];
        TotalDollarAmtTransactionRecords_lTxt: Text[13];
        TotalNumberRemittanceDataRecords_lTxt: Text[8];
        TotalDollarAmtRemittanceDataRecords_lTxt: Text[13];
        FILLER_lTxt: Text[623];
    begin
        //Record Identifier
        RecordIdentifier_lTxt := 'T';

        //Record Count
        RecordCount3_1_gCod := INCSTR(RecordCount3_1_gCod);

        //Batch Sequence Number
        BatchSequenceNumber_lTxt := '0001';

        //Transit/Branch Number
        TransitBranchNumber_lTxt := BankAcc_gRec."Transit/Branch Number";

        //Reserved for account Numbers
        LeftFillCharacter_lFnc(ReservedForAccount_lTxt,5,' ');

        //Bank Account
        BankAcc_gRec.TESTFIELD("Bank Account No.");
        BankAccountNumber_lTxt := DELCHR(BankAcc_gRec."Bank Account No.",'=','-');

        //Total Number Transaction Records
        TotalNumberTransactionRecords_lTxt := '00000001';   //1 Transcation in file

        //Total Dollar Amt. Transaction Record
        TotalDollarAmtTransactionRecords_lTxt := GetAmtText_gFnc(TotalAmount_gDec);   //Implied two decimals - 2 Decimal Include in amount
        LeftFillCharacter_lFnc(TotalDollarAmtTransactionRecords_lTxt,13-STRLEN(TotalDollarAmtTransactionRecords_lTxt),'0');

        //Total Number Remittance Data Records
        LeftFillCharacter_lFnc(TotalNumberRemittanceDataRecords_lTxt,8,'0');

        //Total Dollar Amt. Remittance Data Records
        LeftFillCharacter_lFnc(TotalDollarAmtRemittanceDataRecords_lTxt,13,'0');

        //FILLER
        LeftFillCharacter_lFnc(FILLER_lTxt,623,' ');

        OutStreamObj_gOsm.WRITETEXT(RecordIdentifier_lTxt);
        OutStreamObj_gOsm.WRITETEXT(RecordCount3_1_gCod);
        OutStreamObj_gOsm.WRITETEXT(BatchSequenceNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TransitBranchNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(ReservedForAccount_lTxt);
        OutStreamObj_gOsm.WRITETEXT(BankAccountNumber_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TotalNumberTransactionRecords_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TotalDollarAmtTransactionRecords_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TotalNumberRemittanceDataRecords_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TotalDollarAmtRemittanceDataRecords_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FILLER_lTxt);
        OutStreamObj_gOsm.WRITETEXT();
    end;

    procedure Export_36_gFnc()
    var
        RecordIdentifier_lTxt: Text[1];
        TotalBatch_lTxt: Text[8];
        TotalDollarAmtTransactionRecords_lTxt: Text[13];
        FILLER_lTxt: Text[665];
        FileCreationDate_lDte: Date;
    begin
        //Record Identifier
        RecordIdentifier_lTxt := 'Z';

        //Record Count
        RecordCount3_1_gCod := INCSTR(RecordCount3_1_gCod);

        //Total Batch
        TotalBatch_lTxt := '00000001';

        //Total Dollar Amt. Transaction Record
        TotalDollarAmtTransactionRecords_lTxt := GetAmtText_gFnc(TotalAmount_gDec);   //Implied two decimals - 2 Decimal Include in amount
        LeftFillCharacter_lFnc(TotalDollarAmtTransactionRecords_lTxt,13-STRLEN(TotalDollarAmtTransactionRecords_lTxt),'0');

        //FILLER
        LeftFillCharacter_lFnc(FILLER_lTxt,665,' ');

        OutStreamObj_gOsm.WRITETEXT(RecordIdentifier_lTxt);
        OutStreamObj_gOsm.WRITETEXT(RecordCount3_1_gCod);
        OutStreamObj_gOsm.WRITETEXT(TotalBatch_lTxt);
        OutStreamObj_gOsm.WRITETEXT(TotalDollarAmtTransactionRecords_lTxt);
        OutStreamObj_gOsm.WRITETEXT(FILLER_lTxt);
    end;

    procedure "---- Other ---------"()
    begin
    end;

    local procedure LeftFillCharacter_lFnc(var FillString_vTxt: Text[100];FillCount_iInt: Integer;FillCharacter_iTxt: Text[1])
    var
        i: Integer;
    begin
        IF FillCount_iInt <=0 THEN
          EXIT;
        FOR i:=1 TO FillCount_iInt DO
          FillString_vTxt := FillCharacter_iTxt + FillString_vTxt;
    end;

    local procedure RightFillCharacter_lFnc(var FillString_vTxt: Text[100];FillCount_iInt: Integer;FillCharacter_iTxt: Text[1])
    var
        i: Integer;
    begin
        IF FillCount_iInt <=0 THEN
          EXIT;
        FOR i:=1 TO FillCount_iInt DO
          FillString_vTxt += FillCharacter_iTxt;
    end;

    procedure UpdatePath_gFnc(var Path_vTxt: Text[250])
    begin
        IF COPYSTR(Path_vTxt,STRLEN(Path_vTxt),1) <> '\' THEN
          Path_vTxt := Path_vTxt + '\';
    end;

    local procedure GetAmtText_gFnc(Amount_iDec: Decimal): Text[15]
    var
        ChequeAmount_lTxt: Text[15];
    begin
        Amount_iDec := ROUND(Amount_iDec,0.01);
        ChequeAmount_lTxt := FORMAT(Amount_iDec,0,'<Integer>') + DELCHR(FORMAT(Amount_iDec,0,'<Decimals,3>'),'=','.');   //Implied two decimals - 2 Decimal Include in amount
        EXIT(ChequeAmount_lTxt)
    end;

    local procedure "----FTP Upload ---------"()
    begin
    end;

    local procedure ExportFTPFiles_lFnc(FileNameWithDir_iTxt: Text)
    var
        FTPDotNet_gDnt: DotNet FTPFileUploadDownload;
        ErrorMessage_lTxt: Text[250];
        FileName_lTxt: Text[250];
        FileNameWithDir_lTxt: Text;
        ExportFileCount_lInt: Integer;
        i_Int: Integer;
        HasError_lBln: Boolean;
    begin
        IF NOT GLSetup_gRec."Upload File To FTP" THEN
          EXIT;

        IF GUIALLOWED THEN
          Window_gDlg.OPEN('Uploading File To FTP.....');

        FileNameWithDir_lTxt := FileNameWithDir_iTxt;

        CLEAR(FTPDotNet_gDnt);
        //FTPDotNet_gDnt := FTPDotNet_gDnt.FTPFileUploadDownload;  FTPHelper.FTPFileUploadDownload
        FTPDotNet_gDnt := FTPDotNet_gDnt.FTPFileUploadDownload;     //jrr

        FTPDotNet_gDnt.UploadFileToFTP_gFnc(        //chg to new fn
        //FTPDotNet_gDnt.UploadFileToFTPSecure(       //C9-m
        //FTPDotNet_gDnt.UploadFileToFTPS(            //C9-m
          GLSetup_gRec."FTP Server Name with Directory",
          GLSetup_gRec."FTP User ID",
          GLSetup_gRec."FTP Password",
          GLSetup_gRec."FTP Use SSL",
          FileNameWithDir_lTxt,
          HasError_lBln,
          ErrorMessage_lTxt);

        IF GUIALLOWED THEN
          Window_gDlg.CLOSE;

        IF HasError_lBln THEN
          ERROR(ErrorMessage_lTxt);
    end;
}

