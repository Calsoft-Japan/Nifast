xmlport 50028 "Import PPS File1"
{
    // NF1.00:CIS.NG  11/03/15 Comment code (Yield function is not available in NAV 2015)
    // 
    // WC>>
    // 122210 JWW Changed to use new SID instead of ASN and changed lengths in header
    // 012511 JWW Changed to ignore "ASN No." coming in - T36-OnInsert() will auto-increment "EDI Control No."
    // <<WC
    // 
    // //>> WC 122210 JWW
    // Was:
    //          1         2         3         4         5         6         7
    // 123456789012345678901234567890123456789012345678901234567890123456789012
    // ASN: 1A0A14AU1 RACK: NIFAST - TRIM 1              Run Date: 10/14/2010
    // Text1  1- 5  5
    // Text2  6-15 10
    // Text3 16-30 15
    // Text4 31-50 20
    // Text5 51-70 20
    // 
    // Now:
    //          1         2         3         4         5         6         7
    // 123456789012345678901234567890123456789012345678901234567890123456789012
    // SID: 1AU1-20101217N RACK: TEST NIFAST - TRIM 1     Run Date: 12/16/2010 : Test
    // SID: 2AU1-20101222A RACK: NIFAST - TRIM 2         Run Date: 12/22/2010  : Live
    // Text1  1- 5  5 / Same
    // Text2  6-20 15 / Same
    // Text3 21-40 20 / 21-35 15
    // Text4 41-51 11 / 36-50 15
    // Text5 52-71 20 / 51-70 20
    // //<< WC 122210 JWW / WC 122310 RM
    // 
    // QtyText  1- 8  8
    // PartNo   9-28 20
    // StdPack 29-43 15
    // Desc    44-70 27

    Caption = 'Import PPS File';
    Direction = Import;
    Format = FixedText;
    FormatEvaluate = Legacy;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            MinOccurs = Once;
            tableelement("<integerh>";Table2000000026)
            {
                AutoSave = false;
                XmlName = 'HeaderLoop';
                SourceTableView = SORTING(Field1)
                                  WHERE(Field1=FILTER(1));
                UseTemporary = false;
                textelement(Text1)
                {
                    Width = 5;
                }
                textelement(Text2)
                {
                    Width = 15;
                }
                textelement(Text3)
                {
                    Width = 15;
                }
                textelement(Text4)
                {
                    Width = 15;
                }
                textelement(Text5)
                {
                    Width = 20;
                }

                trigger OnAfterInitRecord()
                begin

                    LineCount := 0;
                    CLEAR(ZoneCode);
                end;

                trigger OnAfterInsertRecord()
                begin

                    d.UPDATE(1,currXMLport.FILENAME);
                    d.UPDATE(2,LineCount);

                    LineCount := LineCount + 1;

                    //second line contains the ship-to
                    IF LineCount<>2 THEN
                      currXMLport.SKIP;

                    //>> WC 122210 JWW
                    //IF COPYSTR(Text1,1,3)='ASN' THEN BEGIN
                    //  "ASN No." := Text2;
                    //  ZoneCode := Text4;
                    //  OldVersion := FALSE;
                    //END ELSE BEGIN
                    //  Text2 := DELCHR(Text2,'<',' ');
                    //  ZoneCode := COPYSTR(Text2 + Text3,1,20);
                    //  "ASN No." := '';
                    //  OldVersion := TRUE;
                    //END;
                    IF COPYSTR(Text1,1,3)='SID' THEN BEGIN
                    //>> WC 012511 JWW - Don't want the "ASN No." (want to auto-populate)
                    //  "ASN No." := Text2;
                      "ASN No." := '';
                    //<< WC 012511 JWW - Don't want the "ASN No." (want to auto-populate)
                      ZoneCode := Text4;
                      OldVersion := FALSE;
                    END ELSE BEGIN
                      Text2 := DELCHR(Text2,'<',' ');
                      ZoneCode := COPYSTR(Text2 + Text3,1,20);
                      "ASN No." := '';
                      OldVersion := TRUE;
                    END;

                    //<< WC 122210 JWW

                    //Get Ship-to Code
                    CLEAR(ErrorFlag);
                    CLEAR(ErrorMessage);
                    PPSShipTo.SETRANGE(Code,ZoneCode);
                    IF NOT PPSShipTo.FIND('-') THEN BEGIN
                      ErrorFlag := TRUE;
                      ErrorMessage := STRSUBSTNO('No Ship-to Code found in Ship-to PPS file for Zone %1.',ZoneCode);
                      PPSBuffer.INIT;
                      PPSBuffer."File Name" := UseFileName;
                      PPSBuffer."File Name 2" := UseFileName2;
                      PPSBuffer."Document No." := UseDocNo;
                      PPSBuffer."Line No." :=  0;
                      PPSBuffer."EDI Control No." := "ASN No.";
                      PPSBuffer."Error Found" := ErrorFlag;
                      PPSBuffer."Error Message" := ErrorMessage;
                      PPSBuffer.INSERT;
                      MESSAGE('Error in File %1:\'+
                              '%2',UseFileName2,ErrorMessage);
                    END;
                end;

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000005";
                begin
                end;
            }
            tableelement("<integerd>";Table2000000026)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'DetailLoop';
                SourceTableView = SORTING(Field1)
                                  WHERE(Field1=FILTER(1));
                UseTemporary = false;
                textelement(QtyText)
                {
                    Width = 8;
                }
                textelement(PartNo)
                {
                    Width = 20;
                }
                textelement(StdPack)
                {
                    Width = 15;
                }
                textelement(Desc)
                {
                    Width = 27;
                }

                trigger OnAfterInitRecord()
                begin
                    //CLEAR(ObjectTypeImport);
                end;

                trigger OnAfterInsertRecord()
                begin

                    CLEAR(ErrorFlag);
                    CLEAR(ErrorMessage);
                    CLEAR(Item);
                    CLEAR(ItemCrossRef);

                    LineCount := LineCount + 1;
                    d.UPDATE(2,LineCount);

                    //first line is the header
                    IF LineCount=1 THEN
                      currXMLport.SKIP;

                    IF NOT EVALUATE(Qty,QtyText) THEN
                      Qty := 0;

                    IF OldVersion THEN
                      Desc := COPYSTR(StdPack+Desc,1,50);

                    //ERROR CHECKING
                    //I - FIND ITEM
                    //find cross reference
                    ItemCrossRef.RESET;
                    ItemCrossRef.SETCURRENTKEY("Cross-Reference No.","Cross-Reference Type","Cross-Reference Type No.");
                    ItemCrossRef.SETRANGE("Cross-Reference No.",PartNo);
                    ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::Customer);
                    ItemCrossRef.SETFILTER("Cross-Reference Type No.",'%1|%2','1','CAMI');
                    IF NOT ItemCrossRef.FIND('-') THEN BEGIN
                      CrossRefFound := FALSE;
                      ErrorFlag := TRUE;
                      ErrorMessage := STRSUBSTNO('No Cross Reference found for Part Number %1.',PartNo);
                      MESSAGE('Error in File %1:\'+
                              '%2',UseFileName2,ErrorMessage);
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
                        SETRANGE("Sales Code",'1');
                        IF FIND('-') THEN
                          UseCustNo := SalesPrice."Sales Code";

                        //2 - if no match try JPY customer
                        IF UseCustNo='' THEN BEGIN
                          SETRANGE("Sales Code",'CAMI');
                           IF FIND('-') THEN
                             UseCustNo := 'CAMI'
                        END;

                        //3 - if still no match, revert back to USD with warning
                        IF UseCustNo='' THEN BEGIN
                           ErrorFlag := TRUE;
                           ErrorMessage := STRSUBSTNO('No Price Contract found for Item %1, Cross Ref No. %2.',ItemCrossRef."Item No.",PartNo);
                           MESSAGE('Error in File %1:\'+
                                    '%2',UseFileName2,ErrorMessage);
                        END; //end IF UseCustNo=''
                      END; //end WITH SalesPrice DO
                    END; //end IF CrossRefFound



                    //III - verify info from Item record
                    IF CrossRefFound THEN BEGIN
                      Item.GET(ItemCrossRef."Item No.");
                      //SNP
                      IF Item."Units per Parcel"=0 THEN BEGIN
                        ErrorFlag := TRUE;
                        ErrorMessage := STRSUBSTNO('No SNP found for Item %1, Cross Ref No. %2.',Item."No.",PartNo);
                        MESSAGE('Error in File %1:\'+
                              '%2',UseFileName2,ErrorMessage);
                      END;
                      //Tax Group Code
                      IF Item."Tax Group Code"='' THEN BEGIN
                        ErrorFlag := TRUE;
                        ErrorMessage := STRSUBSTNO('Tax Group Code for Item %1 is blank.',Item."No.");
                        MESSAGE('Error in File %1:\'+
                              '%2',UseFileName2,ErrorMessage);
                      END;
                    END;


                    //IV - verify Ship-to for specific Customer
                    IF (UseCustNo<>'') AND (PPSShipTo."Ship-to Code"<>'') AND (NOT ShipToErrorShown) THEN
                      IF NOT ShipTo.GET(UseCustNo,PPSShipTo."Ship-to Code") THEN BEGIN
                        ErrorFlag := TRUE;
                        ShipToErrorShown := TRUE;
                        ErrorMessage := STRSUBSTNO('Ship-to %1 for Customer %2 is not on file.',PPSShipTo."Ship-to Code",UseCustNo);
                        MESSAGE('Error in File %1:\'+
                                    '%2',UseFileName2,ErrorMessage);
                      END;


                    //WRITE TO BufferTable
                    PPSBuffer.SETRANGE("Document No.",UseDocNo);
                    PPSBuffer.SETRANGE("Customer No.",UseCustNo);
                    PPSBuffer.SETRANGE("Ship-to Code",PPSShipTo."Ship-to Code");
                    PPSBuffer.SETRANGE("Item No.",Item."No.");
                    IF (PPSBuffer.FIND('-')) AND (NOT ErrorFlag) THEN BEGIN
                      PPSBuffer.Quantity := PPSBuffer.Quantity + (Qty * Item."Units per Parcel");
                      PPSBuffer.MODIFY;
                    END ELSE BEGIN
                      PPSBuffer.INIT;
                      PPSBuffer."Document No." := UseDocNo;
                      PPSBuffer."Line No." := LineCount;
                      PPSBuffer."Customer No." := UseCustNo;
                      PPSBuffer."Ship-to Code" := PPSShipTo."Ship-to Code";
                      PPSBuffer."Item No." := Item."No.";
                      PPSBuffer."Cross-Reference No." := PartNo;
                      PPSBuffer.Description := Desc;
                      PPSBuffer.Quantity := Qty * Item."Units per Parcel";
                      PPSBuffer."EDI Control No." := "ASN No.";
                      PPSBuffer."File Name" := UseFileName;
                      PPSBuffer."File Name 2" := UseFileName2;
                      PPSBuffer."Error Found" := ErrorFlag;
                      PPSBuffer."Error Message" := ErrorMessage;
                      PPSBuffer.INSERT;
                    END;
                end;

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000005";
                begin
                    //Counter_gInt += 1;
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

    trigger OnPostXmlPort()
    begin

        d.CLOSE;

        //the following was put in to make sure file is closed
        //this was causing problems when later trying to move the file
        //CurrFileName.CLOSE;
        //YIELD;   //NF1.00:CIS.NG  11/03/15
    end;

    trigger OnPreXmlPort()
    begin

        d.OPEN('Processing #1#############################\'+
               'Line #2##');

        //LineCount := 0;
        //CLEAR(ZoneCode);
    end;

    var
        Text000_gTxt: Label 'Current  #1##############';
        "<<inbound hdr fields>>": Integer;
        "<<inbound dtl fields>>": Integer;
        "<<data>>": Integer;
        ZoneCode: Code[20];
        Qty: Decimal;
        "ASN No.": Code[20];
        "<<supporting vars>>": Integer;
        LineCount: Integer;
        ItemCrossRef: Record "5717";
        SalesPrice: Record "7002";
        UseCustNo: Code[20];
        Item: Record "27";
        PPSBuffer: Record "50025";
        d: Dialog;
        UseDocNo: Code[30];
        UseFileName: Text[250];
        UseFileName2: Text[100];
        PPSShipTo: Record "50024";
        ErrorFlag: Boolean;
        ErrorMessage: Text[250];
        CrossRefFound: Boolean;
        ShipTo: Record "222";
        ShipToErrorShown: Boolean;
        OldVersion: Boolean;

    procedure SetBufferFields(NewUseDocNo: Code[30];NewUseFileName: Text[250];NewUseFileName2: Text[100])
    begin

        UseDocNo := NewUseDocNo;
        UseFileName  := NewUseFileName;
        UseFileName2 := NewUseFileName2;
    end;
}

