xmlport 50004 "FB Import Nifast FB File"
{
    // 09/29/15 - JRR Dataport 50000 conversion
    // NF1.00:CIS.NG    09/30/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // NF1.00:CIS.NG    10/26/15 Fill-Bill Functionality (Merge some missing code in xmlport from old dataport)

    Caption = 'Import/Export Permissions';
    Direction = Import;
    Format = FixedText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("<integer>";Table2000000026)
            {
                AutoSave = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Field1)
                                  WHERE(Field1=FILTER(1));
                UseTemporary = false;
                textelement("<reserved1>")
                {
                    XmlName = 'Reserved1';
                    Width = 2;
                }
                textelement(CustNo)
                {
                    Width = 20;
                }
                textelement(ShipTo)
                {
                    Width = 10;
                }
                textelement(Initials)
                {
                    Width = 3;
                }
                textelement(LocationCode)
                {
                    Width = 10;
                }
                textelement(TagID)
                {
                    Width = 20;
                }
                textelement(ItemNo)
                {
                    Width = 20;
                }
                textelement(Qty)
                {
                    Width = 13;
                }
                textelement(CustBin)
                {
                    Width = 12;
                }
                textelement(DateOrdered)
                {
                    Width = 6;
                }
                textelement(TimeOrdered)
                {
                    Width = 6;
                }
                textelement(Reserved2)
                {
                    Width = 1;
                }

                trigger OnAfterInitRecord()
                begin

                    //LineCount := 0;
                    //CLEAR(ZoneCode);
                end;

                trigger OnAfterInsertRecord()
                begin

                    CLEAR(FBImportDataLog);
                    IF GUIALLOWED THEN
                      Window.UPDATE(1,currXMLport.FILENAME);

                    WITH FBImportDataLog DO BEGIN
                      INIT;
                      "No." := ImportDataLogNo;
                      "Line No." := LineNo;
                      LineNo := LineNo + 1;
                      "Import File Name" := currXMLport.FILENAME;
                      "Import Date" := TODAY;
                      "Import Time" := TIME;

                      IF GUIALLOWED THEN
                        Window.UPDATE(2,"Line No.");

                      "Customer No." := CustNo;
                      IF NOT NVV.ValidateCustomer(CustNo) THEN
                        FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                                                  'Customer No. '+CustNo+' Not Valid');

                      //>> NIF 12-02-05
                      //ShipTo=Contract
                      CLEAR(Contract);
                      Contract.SETRANGE("No.",ShipTo);
                      Contract.SETRANGE("Customer No.",CustNo);
                      IF Contract.FIND('-') THEN
                        ShipTo := Contract."Ship-to Code"
                      ELSE BEGIN
                        FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                                                    'Contract No. '+ShipTo+' Not Valid');
                        ShipTo := '';
                      END;
                      //<< NIF 12-02-05


                      IF ShipTo <> '' THEN BEGIN
                        "Ship-to Code" := ShipTo;
                        IF NOT NVV.ValidateShipTo(CustNo,ShipTo) THEN
                          FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                            'Ship-to Code '+ShipTo+' Not Valid');
                      END;

                      IF LocationCode <> '' THEN BEGIN
                        "Location Code" := LocationCode;
                        IF NOT NVV.ValidateLocation(LocationCode) THEN
                          FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                            'Location Code '+LocationCode+' Not Valid');
                      END;

                      IF TagID <> '' THEN BEGIN
                        "Tag No." := TagID;
                        IF NOT NVV.ValidateFBTag(TagID) THEN
                          FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                            'Tag No. '+TagID+' Not Valid');
                      END;

                      IF ItemNo <> '' THEN BEGIN
                        ItemNo2 := '';
                        VarNo2 := '';
                        IF NVV.ValidateItem(ItemNo) THEN
                          "Item No." := ItemNo
                        ELSE BEGIN
                          IF NVV.FindCustItemCrossRef(CustNo,ItemNo,ItemNo2,VarNo2,UOM2) THEN BEGIN
                            "Item No." := ItemNo2;
                            "Cross-Reference No." := ItemNo;
                            "Unit of Measure Code" := UOM2
                    //>> NIF 12-21-05 RTT
                          //END ELSE BEGIN
                          //  IF NVV.FindLotNo(ItemNo2,VarNo2,ItemNo) THEN BEGIN
                          //    "Item No." := ItemNo2;
                          //    "Lot No." := ItemNo;
                          //  END;
                    //<< NIF 12-21-05 RTT
                          END;
                        END;

                      IF NOT NVV.ValidateItem("Item No.") THEN
                        FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                          'Item No. '+ItemNo+' Not Valid');
                      END;

                      IF ("Lot No." <> '') AND ("Item No." <> '') AND (NOT NVV.ValidateLotNo("Item No.","Variant Code","Lot No.")) THEN
                        FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                          'Lot No. '+"Lot No."+' Not Valid');

                      IF ("Cross-Reference No." <> '') AND (NOT NVV.ValidateCustItemCrossRef(CustNo,"Cross-Reference No.")) THEN
                        FBManagement.WriteMessage("Import File Name",'','',"No.","Line No.",'IMPORT',1,
                          'Cross-Ref. No. '+"Cross-Reference No."+' Not Valid');

                     //jrr Quantity := format(Qty);
                      IF EVALUATE(Quantity, Qty) THEN ; //jrr

                      IF ("Item No." <> '') AND Item.GET("Item No.") THEN
                        "Unit of Measure Code" := Item."Sales Unit of Measure";

                      IF DateOrdered <> '' THEN
                        EVALUATE("Order Date",COPYSTR(DateOrdered,3,2)+COPYSTR(DateOrdered,5,2)+COPYSTR(DateOrdered,1,2));
                      IF TimeOrdered <> '' THEN
                        EVALUATE("Order Time",TimeOrdered);

                      "Customer Bin" := CustBin;
                    //>> NIF 12-02-05
                      "Contract No." := Contract."No.";
                    //<< NIF 12-02-05

                      INSERT;
                    END;
                end;

                trigger OnBeforeInsertRecord()
                var
                    PermissionSet_lRec: Record "2000000005";
                begin
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

    trigger OnInitXmlPort()
    begin

        FBImportDataport.SETCURRENTKEY("User ID");
        FBImportDataport.SETRANGE("User ID",USERID);
        IF FBImportDataport.FIND('-') THEN
          currXMLport.FILENAME := FBImportDataport.TempFileName;
    end;

    trigger OnPostXmlPort()
    begin

        IF GUIALLOWED THEN
          Window.CLOSE;


        //the following was put in to make sure file is closed
        //this was causing problems when later trying to move the file
        //CurrFileName.CLOSE;
        //YIELD;
    end;

    trigger OnPreXmlPort()
    begin

        IF GUIALLOWED THEN
          Window.OPEN('File Name #1########################### \'+
                      'Line No.  #2###########################');
        LineNo := 1;

        FBSetup.GET;
        FBSetup.TESTFIELD("Import Data Log Nos.");
        NoSeriesMgt.InitSeries(FBSetup."Import Data Log Nos.",OldNoSeries,WORKDATE,ImportDataLogNo,NewNoSeries);
    end;

    var
        Text000_gTxt: Label 'Current  #1##############';
        Reserved1: Code[2];
        Window: Dialog;
        CurrFBOrderNo: Code[20];
        LineNo: Integer;
        FilePathName: Text[200];
        FBManagement: Codeunit "50133";
        NoSeriesMgt: Codeunit "396";
        NVV: Codeunit "50132";
        FBImportDataLog: Record "50138";
        FBImportDataport: Record "50139";
        Item: Record "27";
        FBSetup: Record "50133";
        Contract: Record "50110";
        ImportDataLogNo: Code[20];
        OldNoSeries: Code[10];
        NewNoSeries: Code[10];
        ItemNo2: Code[20];
        VarNo2: Code[10];
        UOM2: Code[10];
}

