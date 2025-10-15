codeunit 70001 "Temp JRR"
{
    Permissions = TableData 21=rimd,
                  TableData 379=rimd,
                  TableData 7312=rimd;

    trigger OnRun()
    var
        sp: Record 7002;
        cntint: Integer;
        OutputFileName: Text[250];
        SourceFile: File;
        DestinationFile: File;
        CurrentLine: Text[1000];
        InputFileName: Text[250];
        TestFile: File;
        MyOutstream: OutStream;
        SIH: Record 112;
        WHE: Record 7312;
    begin
         IF WHE.GET(147349) THEN  BEGIN     //-1000
            WHE.Quantity :=0;
           WHE."Qty. (Base)"  :=0;
           WHE.MODIFY;
         END;
         IF WHE.GET(147350) THEN  BEGIN     //-6k
            WHE.Quantity :=0;
           WHE."Qty. (Base)"  :=0;
           WHE.MODIFY;
         END;
         IF WHE.GET(147351) THEN  BEGIN   //-2k
            WHE.Quantity :=0;
           WHE."Qty. (Base)"  :=0;
           WHE.MODIFY;
         END;
         IF WHE.GET(147352) THEN  BEGIN    //-2k
            WHE.Quantity :=0;
           WHE."Qty. (Base)"  :=0;
           WHE.MODIFY;
         END;
        EXIT;
        
        /*
        cntint:=SIH.COUNT;
        MESSAGE('SIH ' + FORMAT(cntint));
        
        cntint:=DCLE.COUNT;
        MESSAGE('DCLE ' + FORMAT(cntint));
        
        cntint:=CLE.COUNT;
        MESSAGE('CLE ' + FORMAT(cntint));
        
        cntint:=VLE.COUNT;
        MESSAGE('VLE ' + FORMAT(cntint));
        
        cntint:=ILE.COUNT;
        MESSAGE('ILE ' + FORMAT(cntint));
        
        cntint:=GLE.COUNT;
        MESSAGE('GLE ' + FORMAT(cntint));
        EXIT;
        
        //1
        DestinationFile.CREATE('c:\temp\MyWriteText.txt');
        DestinationFile.CREATEOUTSTREAM(MyOutstream);
        cntint := MyOutstream.WRITETEXT('Hello World!');
        MESSAGE('%1 characters were written to the file.', cntint);
        //1
        
        
        
        
        //2
        
        InputFileName := 'c:\temp\Input.txt';      //reads file
        SourceFile.OPEN(InputFileName);
        SourceFile.TEXTMODE := TRUE;
        
        IF SkipHeader THEN
           REPEAT
            SourceFile.READ(CurrentLine)
           UNTIL (CurrentLine = '</tr>');
        
        
        OutputFileName := 'c:\temp\Output.txt';
        //DestinationFile.CREATE(OutputFileName);
        //DestinationFile.CLOSE;
        DestinationFile.WRITEMODE(TRUE);
        DestinationFile.TEXTMODE(TRUE);
        DestinationFile.OPEN(OutputFileName);
        DestinationFile.SEEK(DestinationFile.LEN);   //for writing to end of file
        
        //reads input file / writes to output file
           WHILE (CurrentLine <> '</table>') AND (SourceFile.POS <> SourceFile.LEN) DO BEGIN
                SourceFile.READ(CurrentLine);
                IF CurrentLine <> '</table>' THEN
                  DestinationFile.WRITE(CurrentLine);
              END;
        
        SourceFile.CLOSE;
        DestinationFile.CLOSE;
        EXIT;
        
        
        OutputFileName := 'C:\Temp\TestFile.txt';
        TestFile.CREATE(OutputFileName);
        TestFile.CLOSE;
        IF EXISTS(OutputFileName) THEN BEGIN
          TestFile.WRITEMODE(TRUE);
          TestFile.OPEN(OutputFileName);
          TestFile.WRITE('Hello World');
          TestFile.WRITE('Hello World');
          TestFile.WRITE('Hello World');
          TestFile.WRITE('Hello World');
          TestFile.WRITE('Hello World');
        
          TestFile.CLOSE;
        END
        ELSE
          MESSAGE('%1 does not exit.', OutputFileName);
        
        EXIT;
        //2 end
        
        //ftp cmds
        
        Report: 50090
        CREATE(wshShell);
        EDISetup.CHANGECOMPANY('INCOMM 3PL');
        EDISetup.GET('MC_FTP');
        
        UserName := 'Synergex';
        FTPPassword := 'A4014118';
        FTPDir := 'FSS_Serial_Update';
        UploadDir := '\';
        ftpFileName := dtpFile;
        
        getFileName := COPYSTR(ftpFileName, 1, STRPOS(ftpFileName, '.')) + 'ftp';
        
        SrcFileName := EDISetup."Send Directory" + 'put.scr';
        UploadFileName := EDISetup."Send Directory" + 'upload.cmd';
        
        startPOS := STRLEN(ftpFileName) - 3;
        
        
        
        
        BOL.GET(BOL."No.", 'PK194377');
        BOL.Posted := TRUE;
        BOL.MODIFY;
        
        //PSH.SETFILTER("No.",'PSH209984');
        //IF PSH.FINDFIRST THEN   BEGIN
        IF DCLE.GET(110409) THEN BEGIN
          DCLE.DELETE;
        END;
        IF CLE.GET(151562) THEN BEGIN
          CLE.DELETE;
        END;
        
        DCLE.SETRANGE("Entry No.",110514,110517);
        DCLE.DELETEALL;
        
        IF CLE.GET(151772) THEN
          CLE.DELETE;
        IF CLE.GET(151774) THEN
          CLE.DELETE;
        IF CLE.GET(151776) THEN
          CLE.DELETE;
        IF CLE.GET(151778) THEN
          CLE.DELETE;
        
         cntint := sp.COUNT;
         MESSAGE(FORMAT(cntint));
         */

    end;

    var
        DCLE: Record 379;
        CLE: Record 21;
        GLE: Record 17;
        ILE: Record 32;
        VLE: Record 25;
}

