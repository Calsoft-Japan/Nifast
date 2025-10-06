codeunit 50015 "Nifast Mgmt"
{
    // NF1.00:CIS.NG  11-04-15 Fix the Compilation Issue
    // RTT 09-08-05 ImportPPS #10279
    // NF1.00:CIS.NG  02-02-16 Fix the Automation Compile Issue
    // NF1.00:CIS.NG  06-04-16 Update code to solve error in load XML File -When code in reun from Remote App- Dwn file in local directory before load
    // 22-sep-16: JRR: Added "C0238" to logic
    // 23-oct-16:JRR : Added "C0237" to logic
    // 
    // SM Addition 031523 for new PPS


    trigger OnRun()
    begin
        ImportPPS;
    end;

    var
        PlantCode: Code[10];
        DockCOde: Code[10];

    procedure ImportPPS()
    var
        DriveRec: Record "2000000020";
        InboundFile: Record "2000000022";
        FileRec: File;
        PathIn: Text[250];
        PathOut: Text[250];
        FileName: Text[250];
        UseFileName: Code[50];
        PPSBuffer: Record "50025";
        SalesSetup: Record "311";
        UserSetup: Record "91";
        Location: Record "14";
        SalesHeader: Record "36";
        SalesLine: Record "37";
        TempPPSBuffer: Record "50025" temporary;
        TempPPSBufferFiles: Record "50025" temporary;
        SalesShptHdr: Record "110";
        TempSalesHeader: Record "36" temporary;
        Counter: Integer;
        OrderCounter: Integer;
        FileCounter: Integer;
        ErrorCounter: Integer;
        FileErrorCounter: Integer;
        SalesOrderReport: Report "10075";
        UserMgt: Codeunit "5700";
        BeginOrdNo: Code[20];
        EndOrdNo: Code[20];
        d: Dialog;
        ErrorFound: Boolean;
        ModelYearText: Code[10];
        ImportData: XMLport "50005";
        NewPath: Text[250];
    begin
        //check and set paths
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Inbound PPS Directory");
        SalesSetup.TESTFIELD("Archive PPS Directory");
        
        PathIn := SalesSetup."Inbound PPS Directory";     // '\\nifnavprapp\FileImport\Inbound PPS'
        PathOut := SalesSetup."Archive PPS Directory";    // '\\nifnavprapp\FileImport\Archive PPS';
        /*
        PathIn :='\\nifastnavedi.file.core.windows.net\datamasons\Inbound PPS\';
        PathOut :='\\nifastnavedi.file.core.windows.net\datamasons\Archive PPS\';
        PathIn :='V:\Inbound PPS\';
        PathOut :='V:\Archive PPS\';
        
        NewPath:=CONVERTSTR(PathIn,'?','.');     //added to bypass dots in path during setup
        PathIn := NewPath;
        NewPath:=CONVERTSTR(PathOut,'?','.');
        PathOut := NewPath;
        */
        
        //check and set location from user default
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Default Location Code");
        Location.GET(UserSetup."Default Location Code");
        
        
        //clear buffer table
        PPSBuffer.LOCKTABLE;
        PPSBuffer.DELETEALL;
        
        Counter := 0;
        
        //set filter on text files and read
        CLEAR(InboundFile);
        InboundFile.SETFILTER(Path,PathIn);
        IF SalesSetup."Use PPS XML format" THEN
          InboundFile.SETFILTER(Name,'*.xml')
        ELSE
          InboundFile.SETFILTER(Name,'*.dat|*.txt');
        InboundFile.SETRANGE("Is a file",TRUE);
        IF NOT InboundFile.FIND('-') THEN
          ERROR('No files found in %1',PathIn);
        
        REPEAT
          //set file name
          FileName := InboundFile.Name;
        
          //>> 11-16-05
          /*
          //set UseFileName, used as an identifier
          IF STRPOS(UPPERCASE(FileName),'.TXT')<>0 THEN BEGIN
            UseFileName := COPYSTR(DELCHR(FileName,'>','.txt'),STRLEN(FileName)-20,20);
            UseFileName := COPYSTR(UseFileName,1,20);
            UseFileName := DELCHR(UseFileName,'<',' ');
          END ELSE BEGIN
            UseFileName := COPYSTR(DELCHR(UPPERCASE(FileName),'>','.DAT'),STRLEN(FileName)-20,20);
            UseFileName := COPYSTR(UseFileName,1,20);
            UseFileName := DELCHR(UseFileName,'<',' ');
          END;
          */
          UseFileName := DELCHR(FileName,'>','.txt');
          UseFileName := DELCHR(UseFileName,'>','.dat');
        
          IF STRLEN(UseFileName) > 30 THEN
            UseFileName := COPYSTR(UseFileName,STRLEN(UseFileName)-29,30)
          ELSE
            UseFileName := COPYSTR(UseFileName,1,30);
          //<< 11-16-05
        
          IF SalesSetup."Use PPS XML format" THEN BEGIN
            ProcessXML(PathIn+FileName,InboundFile.Name);
          END ELSE BEGIN
        
            //run dataport
            ImportData.SetBufferFields(UseFileName,FileName,InboundFile.Name);   //pass file and docno to use to dp
            ImportData.FILENAME(PathIn+FileName);
            ImportData.RUN;
            CLEAR(ImportData);
        
          END;
        
          //determine if error was found
          PPSBuffer.SETRANGE("File Name",InboundFile.Name);
          PPSBuffer.SETRANGE("Error Found",TRUE);
          ErrorFound := PPSBuffer.FIND('-');
        
          //insert file names
          FileCounter := FileCounter + 1;
          IF ErrorFound THEN
            FileErrorCounter := FileErrorCounter + 1;
        
          TempPPSBufferFiles.INIT;
          TempPPSBufferFiles."Line No." := FileCounter;
          TempPPSBufferFiles."File Name" := InboundFile.Name;
          TempPPSBufferFiles."Error Found" := ErrorFound;
          TempPPSBufferFiles.INSERT;
        
          //read into a temp table to get file/customer combos
          //use counter to keep unique if split customers
          PPSBuffer.SETRANGE("Error Found");
          PPSBuffer.FIND('-');
          REPEAT
            Counter := Counter + 1;
            TempPPSBuffer.SETRANGE("Document No.",PPSBuffer."Document No.");
            TempPPSBuffer.SETRANGE("Customer No.",PPSBuffer."Customer No.");
            TempPPSBuffer.SETRANGE("File Name",PPSBuffer."File Name");
            IF NOT TempPPSBuffer.FIND('-') THEN BEGIN
              TempPPSBuffer.INIT;
              TempPPSBuffer.TRANSFERFIELDS(PPSBuffer);
              IF NOT SalesSetup."Use PPS XML format" THEN BEGIN
                TempPPSBuffer."Error Found" := ErrorFound;
                TempPPSBuffer."Line No." := Counter;
              END;
              TempPPSBuffer.INSERT;
            END;
          UNTIL PPSBuffer.NEXT=0;
        UNTIL InboundFile.NEXT=0;
        
        
        //check sales header and shipments for dupl
        TempPPSBuffer.SETRANGE("Document No.");
        TempPPSBuffer.SETRANGE("Customer No.");
        TempPPSBuffer.SETRANGE("File Name");
        TempPPSBuffer.FIND('-');
        REPEAT
          SalesHeader.SETRANGE("PPS File Name",TempPPSBuffer."File Name 2");
          SalesHeader.SETRANGE("Sell-to Customer No.",TempPPSBuffer."Customer No.");
          IF SalesHeader.FIND('-') THEN
            IF NOT CONFIRM(
              STRSUBSTNO('%1 %2 already exists for File %3. Do you want to continue?',
                           SalesHeader."Document Type",SalesHeader."No.",TempPPSBuffer."File Name 2")) THEN
                ERROR('Operation Canceled.');
        
          SalesShptHdr.SETRANGE("PPS File Name",TempPPSBuffer."File Name 2");
          SalesShptHdr.SETRANGE("Sell-to Customer No.",TempPPSBuffer."Customer No.");
          IF SalesShptHdr.FIND('-') THEN
            IF NOT CONFIRM(
              STRSUBSTNO('Posted Shipment %1 already exists for File %2. Do you want to continue?',
                           SalesShptHdr."No.",TempPPSBuffer."File Name 2")) THEN
                ERROR('Operation Canceled.');
        UNTIL TempPPSBuffer.NEXT=0;
        
        
        d.OPEN('Creating Order #1######## Item #2#############\'+
               'File Name #3##################################\'+
               'Progress @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        
        //sales order creation
        SalesHeader.RESET;
        PPSBuffer.RESET;
        TempPPSBuffer.SETRANGE("Error Found",FALSE);
        IF TempPPSBuffer.FIND('-') THEN
         REPEAT
          //create header
          SalesHeader.INIT;
          SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
          SalesHeader."No." := '';
          SalesHeader.INSERT(TRUE);
          SalesHeader.VALIDATE("Sell-to Customer No.",TempPPSBuffer."Customer No.");
          SalesHeader.VALIDATE("Ship-to Code",TempPPSBuffer."Ship-to Code");
          SalesHeader."PPS Order" := TRUE;
          SalesHeader."PPS File Name" := TempPPSBuffer."File Name 2";
          IF TempPPSBuffer."EDI Control No."<>'' THEN
            SalesHeader."EDI Control No." := TempPPSBuffer."EDI Control No.";
          IF SalesHeader."Responsibility Center"='' THEN
            SalesHeader.VALIDATE("Responsibility Center",UserMgt.GetSalesFilter());
          IF SalesHeader."Location Code"='' THEN
            SalesHeader.VALIDATE("Location Code",Location.Code);
        //>>NIF 062207 RTT
          IF TempPPSBuffer."EDI Control No."<>'' THEN BEGIN
            ModelYearText := COPYSTR(TempPPSBuffer."EDI Control No.",STRLEN(TempPPSBuffer."EDI Control No."),1);
            CASE ModelYearText OF
              '7' : ModelYearText := '07';
              '8' : ModelYearText := '08';
              '9' : ModelYearText := '09';
              '0' : ModelYearText := '10';
              '1' : ModelYearText := '11';
              '2' : ModelYearText := '12';
              '3' : ModelYearText := '13';
              '4' : ModelYearText := '14';
              '5' : ModelYearText := '15';
              '6' : ModelYearText := '16';
              ELSE ModelYearText := '';
            END;
          END;
        
          IF ModelYearText<>'' THEN
            SalesHeader."Model Year" := ModelYearText;
        //<<NIF 062207 RTT
          SalesHeader.MODIFY;
        
          //create lines;
          PPSBuffer.SETRANGE("Document No.",TempPPSBuffer."Document No.");
          PPSBuffer.SETRANGE("Customer No.",TempPPSBuffer."Customer No.");
          PPSBuffer.SETRANGE("File Name",TempPPSBuffer."File Name");
          PPSBuffer.FIND('-');
          REPEAT
            SalesLine.INIT;
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := PPSBuffer."Line No." * 10000;
            SalesLine.Type := SalesLine.Type::Item;
            SalesLine.VALIDATE("No.",PPSBuffer."Item No.");
            SalesLine.VALIDATE("Location Code",Location.Code);
            SalesLine.VALIDATE(Quantity,PPSBuffer.Quantity);
            SalesLine."Cross-Reference No." := PPSBuffer."Cross-Reference No.";
            //SM Addition 031523 for new PPS========================================
            SalesLine."Plant Code" := PPSBuffer."Plant Code";
            SalesLine."Dock Code" := PPSBuffer."Dock Code";
            //SM Addition 031523 for new PPS========================================
        
            //SalesLine.Description := PPSBuffer.Description;  //comment out 10-27-05
            SalesLine.INSERT(TRUE);
        
            d.UPDATE(1,SalesHeader."No.");
            d.UPDATE(2,SalesLine."No.");
            d.UPDATE(3,TempPPSBuffer."File Name");
            d.UPDATE(4,ROUND(OrderCounter / FileCounter * 10000,1));
        
          UNTIL PPSBuffer.NEXT=0;
        
          //write to temp sales header for later printing and results display
          OrderCounter := OrderCounter + 1;
          TempSalesHeader.INIT;
          TempSalesHeader.TRANSFERFIELDS(SalesHeader);
          TempSalesHeader.INSERT;
        
        
         UNTIL TempPPSBuffer.NEXT=0;
        d.CLOSE;
        
        
        //now that orders have been created, move the files
        IF TempPPSBuffer.FIND('-') THEN
          REPEAT
            IF EXISTS(PathIn+TempPPSBuffer."File Name") THEN BEGIN
              COPY(PathIn+TempPPSBuffer."File Name",PathOut+TempPPSBuffer."File Name");
              ERASE(PathIn+TempPPSBuffer."File Name");
              TempPPSBuffer.DELETE;
            END;
          UNTIL TempPPSBuffer.NEXT=0;
        
        //error counts
        PPSBuffer.RESET;
        PPSBuffer.SETRANGE("Error Found",TRUE);
        ErrorCounter := PPSBuffer.COUNT;
        
        
        //prompt for print
        IF NOT TempSalesHeader.FIND('+') THEN
          EXIT;
        EndOrdNo := TempSalesHeader."No.";
        TempSalesHeader.FIND('-');
        BeginOrdNo := TempSalesHeader."No.";
        
        
        IF CONFIRM(
           STRSUBSTNO('Files Read:         %1\'+
                      'Files Successful:   %2\'+
                      'Files with Errors:  %3\'+
                      'Number of Errors:   %4\\'+
                      'Orders Created:     %5\'+
                      'Starting Order No.: %6\'+
                      'Ending Order No.:   %7\\'+
                      'Do you want to print Orders?',
                      FileCounter,FileCounter-FileErrorCounter,FileErrorCounter,ErrorCounter,OrderCounter,BeginOrdNo,EndOrdNo) ) THEN
          BEGIN
            TempSalesHeader.FIND('-');
            COMMIT;
            REPEAT
              SalesHeader.RESET;
              SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
              SalesHeader.SETRANGE("No.",TempSalesHeader."No.");
              //SalesOrderReport.USEREQUESTFORM(FALSE);
              //SalesOrderReport.USEREQUESTFORM(TRUE);  //NF1.00:CIS.NG  11-04-15
              SalesOrderReport.SETTABLEVIEW(SalesHeader);
              SalesOrderReport.RUN;
            UNTIL TempSalesHeader.NEXT=0;
          END;
        
        IF ErrorCounter<>0 THEN
          IF CONFIRM('Do you want to print the errors found?') THEN
            REPORT.RUN(REPORT::"PPS Error Report",TRUE,FALSE,PPSBuffer);
        
        //******** DELETE PPS BUFFER HERE*****

    end;

    procedure ProcessXML(Filename: Text[240];Filename2: Text[240])
    var
        PPSBuffer: Record "50025";
        XmlDoc: Automation ;
        XmlNodelist: Automation ;
        XmlNodelist2: Automation ;
        XmlNode: Automation ;
        i: Integer;
        ItemCrossRef: Record "5717";
        SalesPrice: Record "7002";
        PPSShipTo: Record "50024";
        ListTime: Text[100];
        ListCode: Text[100];
        ErrorFlag: Boolean;
        ErrorMessage: Text[250];
        CrossRefFound: Boolean;
        UseCustNo: Code[20];
        Item: Record "27";
        ShipTo: Record "222";
        Qty: Decimal;
        DeliveryCode: Code[20];
        FileMgt: Codeunit "419";
        LocalTmpFile: Text;
    begin
        //>> NF1.00:CIS.NG  02-02-16
        //CREATE(XmlDoc);
        //XmlDoc.load(Filename);  //NF1.00:CIS.NG  06-04-16
        CREATE(XmlDoc,TRUE,TRUE);
        //>> NF1.00:CIS.NG  06-04-16
        LocalTmpFile := FileMgt.DownloadTempFile(Filename);
        XmlDoc.load(LocalTmpFile);
        //<< NF1.00:CIS.NG  06-04-16
        //<< NF1.00:CIS.NG  02-02-16

        XmlNodelist := XmlDoc.selectNodes('//DocumentElement/DeliveryListDataTable');
        FOR i := 1 TO XmlNodelist.length DO BEGIN
          ErrorFlag := FALSE;

          XmlNode := XmlNodelist.item(i-1).selectSingleNode('OffsiteListTime');
          ListTime := '';
          IF NOT ISCLEAR(XmlNode) THEN BEGIN
            ListTime := DELCHR(XmlNode.text,'=',':-');
          END;

          XmlNode := XmlNodelist.item(i-1).selectSingleNode('Delivery');
          CLEAR(PPSShipTo);
          DeliveryCode := '';
          ListTime := ListTime + '-' + '24188079';
          ListCode := XmlNode.text;
          IF NOT ISCLEAR(XmlNode) THEN BEGIN
            // Find PPS ship to
            DeliveryCode := XmlNode.text;
            IF STRPOS(XmlNode.text,'NIFAST - ') <> 0 THEN
              DeliveryCode := COPYSTR(XmlNode.text,9);
            IF NOT PPSShipTo.GET(DeliveryCode) THEN BEGIN
              ErrorFlag := TRUE;
              ErrorMessage := STRSUBSTNO('No Ship-to Code found in Ship-to PPS file for Zone %1.',XmlNode.text);
              PPSBuffer.INIT;
              PPSBuffer."Document No." := ListCode;
              PPSBuffer."File Name" := Filename2;
              PPSBuffer."File Name 2" := ListTime;
              PPSBuffer."Line No." :=  i;
              PPSBuffer."EDI Control No." := '';
              PPSBuffer."Error Found" := ErrorFlag;
              PPSBuffer."Error Message" := ErrorMessage;
              PPSBuffer.INSERT;

              MESSAGE('Error in File %1:\%2',ListTime,ErrorMessage);

            END;
          END;

          IF NOT ErrorFlag THEN BEGIN
          XmlNode := XmlNodelist.item(i-1).selectSingleNode('Quantity');
          Qty := 0;
          IF NOT ISCLEAR(XmlNode) THEN BEGIN
            EVALUATE(Qty,XmlNode.text);
          END;

        //SM
          XmlNode := XmlNodelist.item(i-1).selectSingleNode('PlantCode');
          PlantCode:=XmlNode.text;
          XmlNode := XmlNodelist.item(i-1).selectSingleNode('DockCode');
          DockCOde:=XmlNode.text;

        //SM


          XmlNode := XmlNodelist.item(i-1).selectSingleNode('PartNumber');

          IF NOT ISCLEAR(XmlNode) THEN BEGIN
            // check xref
            ItemCrossRef.RESET;
            ItemCrossRef.SETCURRENTKEY("Cross-Reference No.","Cross-Reference Type","Cross-Reference Type No.");
            ItemCrossRef.SETRANGE("Cross-Reference No.",XmlNode.text);
            ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::Customer);
            ItemCrossRef.SETFILTER("Cross-Reference Type No.",'%1|%2|%3','C0346','C0347','C0349');     //jrr
            IF NOT ItemCrossRef.FIND('-') THEN BEGIN
              ErrorFlag := TRUE;
              ErrorMessage := STRSUBSTNO('No Cross Reference found for Part Number %1.',XmlNode.text);
              CrossRefFound := FALSE;
              MESSAGE('Error in File %1:\'+
                      '%2','',ErrorMessage);
            END ELSE
              CrossRefFound := TRUE;

            //II - FIND CUSTOMER
            //look in sales price to find the customer
            IF CrossRefFound THEN BEGIN
              SalesPrice.RESET;
              CLEAR(UseCustNo);

              WITH SalesPrice DO BEGIN
                SETRANGE("Item No.",ItemCrossRef."Item No.");
                SETFILTER("Ending Date",'%1|>=%2',0D,TODAY);
                SETRANGE("Sales Type","Sales Type"::Customer);
                SETFILTER("Contract No.",'<>%1','');

                //1- first try USD customer
                SETRANGE("Sales Code",'C0346');
                IF FIND('-') THEN
                  UseCustNo := SalesPrice."Sales Code";

                //2 - if no match try JPY customer
                IF UseCustNo='' THEN BEGIN
                  SETRANGE("Sales Code",'C0347');
                   IF FIND('-') THEN
                     UseCustNo := 'C0347'
                END;
               //3 - if no match try new customer C0238   //jrr
                IF UseCustNo='' THEN BEGIN
                  SETRANGE("Sales Code",'C0349');
                   IF FIND('-') THEN
                     UseCustNo := 'C0349'
                END;
               //4 - if no match try new customer C0238   //jrr
               // IF UseCustNo='' THEN BEGIN
               //   SETRANGE("Sales Code",'C0237');
               //    IF FIND('-') THEN
               //      UseCustNo := 'C0237'
               // END;

                //5 - if still no match, revert back to USD with warning
                IF UseCustNo='' THEN BEGIN
                  ErrorFlag := TRUE;
                  ErrorMessage := STRSUBSTNO('No Price Contract found for Item %1, Cross Ref No. %2.',ItemCrossRef."Item No.",XmlNode.text);
                  MESSAGE('Error in File %1:\'+
                        '%2','',ErrorMessage);
                END; //end IF UseCustNo=''
              END; //end WITH SalesPrice DO
            END; //end IF CrossRefFound



            //III - verify info from Item record
            IF CrossRefFound THEN BEGIN
              Item.GET(ItemCrossRef."Item No.");
              //SNP
              IF Item."Units per Parcel"=0 THEN BEGIN
                ErrorFlag := TRUE;
                ErrorMessage := STRSUBSTNO('No SNP found for Item %1, Cross Ref No. %2.',Item."No.",XmlNode.text);
                MESSAGE('Error in File %1:\'+
                      '%2','',ErrorMessage);
              END;
              //Tax Group Code
              IF Item."Tax Group Code"='' THEN BEGIN
                ErrorFlag := TRUE;
                ErrorMessage := STRSUBSTNO('Tax Group Code for Item %1 is blank.',Item."No.");
                MESSAGE('Error in File %1:\'+
                      '%2','',ErrorMessage);
              END;
            END;


            //IV - verify Ship-to for specific Customer
            IF (UseCustNo<>'') AND (PPSShipTo."Ship-to Code"<>'') THEN
              IF NOT ShipTo.GET(UseCustNo,PPSShipTo."Ship-to Code") THEN BEGIN
                ErrorFlag := TRUE;
                ErrorMessage := STRSUBSTNO('Ship-to %1 for Customer %2 is not on file.',PPSShipTo."Ship-to Code",UseCustNo);
                MESSAGE('Error in File %1:\'+
                        '%2','',ErrorMessage);
              END;


            //WRITE TO BufferTable
            PPSBuffer.SETRANGE("Document No.",ListCode);
            PPSBuffer.SETRANGE("Customer No.",UseCustNo);
            PPSBuffer.SETRANGE("Ship-to Code",PPSShipTo."Ship-to Code");
            PPSBuffer.SETRANGE("Item No.",Item."No.");
            IF (PPSBuffer.FIND('-')) AND (NOT ErrorFlag) THEN BEGIN
              PPSBuffer.Quantity := PPSBuffer.Quantity + (Qty * Item."Units per Parcel");
              PPSBuffer.MODIFY;
            END ELSE BEGIN
              PPSBuffer.INIT;
              PPSBuffer."Document No." := ListCode;
              PPSBuffer."Line No." := i;
              PPSBuffer."Customer No." := UseCustNo;
              PPSBuffer."Ship-to Code" := PPSShipTo."Ship-to Code";
              PPSBuffer."Item No." := Item."No.";
              PPSBuffer."Cross-Reference No." := XmlNode.text;
              PPSBuffer.Description := '';
              PPSBuffer.Quantity := Qty * Item."Units per Parcel";
              PPSBuffer."EDI Control No." := '';
              PPSBuffer."File Name" := Filename2;
              PPSBuffer."File Name 2" := ListTime;
              PPSBuffer."Error Found" := ErrorFlag;
              PPSBuffer."Error Message" := ErrorMessage;
        //SM new PPS 032323==================================================
              PPSBuffer."Plant Code" := PlantCode;
              PPSBuffer."Dock Code" := DockCOde;
        //SM new PPS 032323==================================================

              PPSBuffer.INSERT;
            END;


          END;

          XmlNode := XmlNodelist.item(i-1).selectSingleNode('StandardPack');
          IF NOT ISCLEAR(XmlNode) THEN BEGIN
          END;

          XmlNode := XmlNodelist.item(i-1).selectSingleNode('Description');
          IF NOT ISCLEAR(XmlNode) THEN BEGIN
          END;

          XmlNode := XmlNodelist.item(i-1).selectSingleNode('LocationCSV');
          IF NOT ISCLEAR(XmlNode) THEN BEGIN
          END;


          END;
        END;

        //>> NF1.00:CIS.NG  06-04-16
        IF EXISTS(LocalTmpFile) THEN
          ERASE(LocalTmpFile);
        //<< NF1.00:CIS.NG  06-04-16
    end;
}

