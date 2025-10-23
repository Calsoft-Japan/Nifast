codeunit 70002 "Misc JRR"
{
    Permissions = TableData 27 = rimd,
                  TableData 32 = rimd,
                  TableData 39 = rimd,
                  TableData 112 = rimd,
                  TableData 339 = rimd,
                  TableData 5802 = rimd,
                  TableData 5804 = rimd,
                  TableData 7312 = rimd,
                  TableData 14000705 = rimd;

    trigger OnRun()
    begin
        WE.RESET();
        IF WE.GET(1760447) THEN BEGIN
            WE.Quantity := 0;

            WE."Remaining Qty. (Base)" := 0;
            WE.Open := FALSE;
            WE.MODIFY();
        END;

        WE.RESET();
        IF WE.GET(1760425) THEN BEGIN
            WE.Quantity := 0;
            //TODO
            // WE."Remaining Qty. (Base)" := 0;
            //WE.Open := FALSE;
            WE.MODIFY();
        END;
        WE.RESET();
        IF WE.GET(1760443) THEN BEGIN
            WE.Quantity := 0;
            //TODO
            // WE."Remaining Qty. (Base)" := 0;
            //WE.Open := FALSE;
            WE.MODIFY();
        END;
        WE.RESET();
        IF WE.GET(1760429) THEN BEGIN
            WE.Quantity := 0;
            //TODO
            // WE."Remaining Qty. (Base)" := 0;
            //WE.Open := FALSE;
            WE.MODIFY();
        END;

        ILE.RESET();
        IF ILE.GET(222758) THEN BEGIN
            ILE.Quantity := 0;
            ILE."Remaining Quantity" := 0;
            ILE."Invoiced Quantity" := 0;
            ILE.MODIFY();
        END;
        EXIT;

        /*
            pPath := '\\nifnavprapp\FileImport\Export SICrMemo\';
            pName:= 'SALINVSI2957.txt';
              CommonInpFile.TEXTMODE(TRUE);
              CommonInpFile.OPEN(pPath + pName);
        
              CommonOutFile.TEXTMODE(TRUE);
              CommonOutFile.WRITEMODE(TRUE);
              CommonOutFile.CREATE(pPath + 'Copy' + pName);
              WHILE CommonInpFile.READ(tmpSTR) <> 0 DO BEGIN    //read str & write a fixed chgd length string
               DetStr := COPYSTR(tmpSTR,1,3);
               IF DetStr = 'D01' THEN
                  tmpSTR := COPYSTR(tmpSTR,1,277)
               ELSE IF  DetStr = 'D02' THEN
                   tmpSTR := COPYSTR(tmpSTR,1,86)
               ELSE IF  DetStr = 'DA6' THEN
                   tmpSTR := COPYSTR(tmpSTR,1,37);
                CommonOutFile.WRITE(tmpSTR);
              END;
        
              CommonOutFile.CLOSE;
              CommonInpFile.CLOSE;
        
              SLEEP (3000);   //3secs
              COPY((pPath + pName),(pPath + 'oldinvs\BC' + pName));   //copy org file to befchg folder
              ERASE(pPath + pName);    //erase org file
        
              RENAME((pPath + 'copy' + pName), (pPath + pName));
        
         EXIT;
        
        IF PurRLn.GET('PREC80617',10000) THEN  BEGIN
         //MESSAGE('code' + PurLn."Unit of Measure Code");
          PurRLn."Unit of Measure Code" := 'EA';
          PurRLn."Unit of Measure" := '1';
          PurRLn.MODIFY(FALSE);
        END;
        
        
        PurLn.SETRANGE("Document No.",'PO61270');
        PurLn.SETRANGE("Line No.",10000);
        IF PurLn.FINDFIRST THEN BEGIN   //GET('PREC80617',10000) THEN  BEGIN
         //MESSAGE('code' + PurLn."Unit of Measure Code");
          PurLn."Unit of Measure Code" := 'EA';
          PurLn."Qty. per Unit of Measure" := 1;
          PurLn.MODIFY(FALSE);
        END;
        
        
        //PIL.SETFILTER("Posting Date",'');
        //PIL.SETFILTER("NV Posting Date",'<>%1',0D);
        //PIL.INIT;
        //reccnt :=PIL.COUNT;
        //MESSAGE(FORMAT(reccnt));
        IF SIH.GET('SI2868') THEN BEGIN
          SIH."Exclude from Virtual Inv." := TRUE;
          SIH.MODIFY();
        END;
        IF SIH.GET('SI2856') THEN BEGIN
          SIH."Exclude from Virtual Inv." := TRUE;
          SIH.MODIFY();
        END;
        EXIT;
        
        IF IAE.GET(1469) THEN
           IAE.DELETE;
        IF IAE.GET(1470) THEN
           IAE.DELETE;
        IF IAE.GET(1441943) THEN
           IAE.DELETE;
        IF IAE.GET(1441942) THEN
           IAE.DELETE;
        ACE.SETRANGE("Item No.",'106NC08A2TP2');
        ACE.DELETEALL(FALSE);
        EXIT;
        
        
        ILE.RESET;
        ILE.SETRANGE(ILE."Item No.",'106NC08A2TP2');
        IF ILE.FINDSET(TRUE,FALSE) THEN BEGIN
          REPEAT
            VE.RESET;
            VE.SETRANGE("Item Ledger Entry No.",ILE."Entry No.");
            VE.DELETEALL;
        
            ILE.DELETE;
          UNTIL ILE.NEXT = 0;
        END;
        //Delete Warehouse Entry
        WE.RESET;
        //WE.SETCURRENTKEY(WE."Item No.",'106NC08A2TP2');
        WE.SETRANGE("Item No.",'106NC08A2TP2');
        WE.DELETEALL(FALSE);
        IF Item.GET('106NC08A2TP2') THEN
          Item.DELETE;
        */

    end;

    var
        ILE: Record 32;
        WE: Record 7312;
}

