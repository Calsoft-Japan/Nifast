codeunit 70000 "RdWrite File"
{

    trigger OnRun()
    var
        DetStr: Text[3];
        pName: Text[100];
        pPath: Text[100];
    begin
        pPath := '\\nifnavprapp\FileImport\Export SICrMemo\';
        pName := 'SALINVSI2957.txt';
        CommonInpFile.TEXTMODE(TRUE);
        CommonInpFile.OPEN(pPath + pName);

        CommonOutFile.TEXTMODE(TRUE);
        CommonOutFile.WRITEMODE(TRUE);
        CommonOutFile.CREATE(pPath + 'Copy' + pName);
        WHILE CommonInpFile.READ(tmpSTR) <> 0 DO BEGIN    //read str & write a fixed chgd length string
            DetStr := COPYSTR(tmpSTR, 1, 3);
            // IF DetStr = 'D01' THEN
            //     tmpSTR := COPYSTR(tmpSTR, 1, 277)
            // ELSE IF DetStr = 'D02' THEN
            //     tmpSTR := COPYSTR(tmpSTR, 1, 86)
            // ELSE IF DetStr = 'DA6' THEN
            //     tmpSTR := COPYSTR(tmpSTR, 1, 37);
            // CommonOutFile.WRITE(tmpSTR);
            CASE DetStr OF
                'D01':
                    tmpSTR := COPYSTR(tmpSTR, 1, 277);
                'D02':
                    tmpSTR := COPYSTR(tmpSTR, 1, 86);
                'DA6':
                    tmpSTR := COPYSTR(tmpSTR, 1, 37);
            END;

            CommonOutFile.WRITE(tmpSTR);

        END;

        CommonOutFile.CLOSE;
        CommonInpFile.CLOSE;

        SLEEP(3000);   //3secs
        COPY((pPath + pName), (pPath + 'oldinvs\BC' + pName));   //copy org file to befchg folder
        ERASE(pPath + pName);    //erase org file

        RENAME((pPath + 'copy' + pName), (pPath + pName));
    end;

    var
        CommonInpFile: File;
        CommonOutFile: File;
        tmpSTR: Text[800];
}

