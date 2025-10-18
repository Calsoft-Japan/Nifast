xmlport 50026 "SP  Import - JRR"
{
    // 09/29/15 - JRR Dataport 50000 conversion
    // Copy of Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    Caption = 'Import/Export Permissions';
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Price"; "Sales Price")
            {
                AutoSave = false;
                XmlName = 'SlsPrc';
                UseTemporary = false;
                fieldattribute(iNo; "Sales Price"."Item No.")
                {
                    Width = 20;
                }
                fieldattribute(iCrossref; "Sales Price"."Customer Cross Ref No.")
                {
                    Width = 30;
                }
                fieldattribute(iSalesCode; "Sales Price"."Sales Code")
                {
                    Width = 20;
                }
                fieldattribute(iCurrCode; "Sales Price"."Currency Code")
                {
                    Width = 10;
                }
                fieldattribute(iStartDate; "Sales Price"."Starting Date")
                {
                    Width = 20;
                }
                fieldattribute(iUnitPrice; "Sales Price"."Unit Price")
                {
                    Width = 20;
                }
                fieldattribute(iAllowInvDisc; "Sales Price"."Allow Invoice Disc.")
                {
                    Width = 5;
                }
                fieldattribute(iSalesType; "Sales Price"."Sales Type")
                {
                    Width = 5;
                }
                fieldattribute(iMinQty; "Sales Price"."Minimum Quantity")
                {
                    Width = 20;
                }
                fieldattribute(iEndDate; "Sales Price"."Ending Date")
                {
                    Width = 20;
                }
                fieldattribute(iUOM; "Sales Price"."Unit of Measure Code")
                {
                    Width = 20;
                }
                fieldattribute(iVariant; "Sales Price"."Variant Code")
                {
                    Width = 20;
                }
                fieldattribute(iAllowLineDisc; "Sales Price"."Allow Line Disc.")
                {
                    Width = 20;
                }
                //TODO
                /*  fieldattribute(CiscoCd; "Sales Price"."Contract Ship-to Code")
                 {
                     Width = 20;
                 } */
                //TODO
                textelement(iContno)
                {
                    Width = 20;
                }
                //TODO
                /*   fieldelement(icontslc; "Sales Price"."Contract Ship-to Code")
                  {
                      Width = 10;
                  }
                  fieldelement(icontlc; "Sales Price"."Contract Location Code")
                  {
                      Width = 10;
                  }
                  fieldelement(iContcn; "Sales Price"."Contract Customer No.")
                  {
                      Width = 20;
                  }
                  fieldelement(icontedn; "Sales Price"."External Document No.")
                  {
                      Width = 20;
                  } */
                //TODO
                trigger OnAfterInsertRecord()
                begin

                    d.UPDATE(1, FORMAT(RecNo));
                    //d.UPDATE(2,iNo);
                    RecNo := RecNo + 1;
                    /*
                    IF SalesPrice."Contract No." <> '' THEN BEGIN
                       IF NOT PrcCont.GET(SalesPrice."Contract No.") THEN BEGIN
                         PrcCont."No." := SalesPrice."Contract No.";
                         PrcCont."Customer No." := SalesPrice."Sales Code";
                         PrcCont."External Document No." :=
                         PrcCont."No. Series" := 'S-PCT';
                         PrcCont.INSERT;
                       END;
                     END;
                    */

                    IF iContno <> '' THEN
                        IF NOT PrcCont.GET(iContno) THEN BEGIN
                            PrcCont."No." := iContno;
                            PrcCont."Customer No." := "Sales Price"."Sales Code";
                            PrcCont."Starting Date" := "Sales Price"."Starting Date";
                            PrcCont."Ending Date" := "Sales Price"."Ending Date";
                            //TODO
                            /* PrcCont."External Document No." := "Sales Price"."External Document No."; */
                            //TODO
                            PrcCont."No. Series" := 'S-PCT';
                            //TODO
                            /*   PrcCont."Location Code" := "Sales Price"."Contract Location Code";
                              PrcCont."Shipping Location Code" := "Sales Price"."Contract Ship Location Code"; */
                            //TODO
                            PrcCont."E-Mail" := 'test@test.com';
                            PrcCont.INSERT();
                        END ELSE BEGIN
                            PrcCont."Customer No." := "Sales Price"."Sales Code";
                            PrcCont."Starting Date" := "Sales Price"."Starting Date";
                            PrcCont."Ending Date" := "Sales Price"."Ending Date";
                            //TODO
                            /* PrcCont."External Document No." := "Sales Price"."External Document No."; */
                            //TODO
                            PrcCont."No. Series" := 'S-PCT';
                            //TODO
                            /*   PrcCont."Location Code" := "Sales Price"."Contract Location Code";
                              PrcCont."Shipping Location Code" := "Sales Price"."Contract Ship Location Code"; */
                            //TODO
                            PrcCont."E-Mail" := 'test@test.com';
                            PrcCont.MODIFY();
                        END;

                    SalesPrice."Contract No." := iContno;




                    /*
                    RecReplace := SalesPrice.GET(iNo,iSalesType,iSalesCode,iStartDate,iCurrCode,iVariant,iUOM,iMinQty);
                    
                    IF NOT RecReplace THEN
                     SalesPrice.INIT;
                    //jrr
                    EVALUATE(StartDt,
                                         COPYSTR(iStartDate, 1, 2) +         //6
                                         COPYSTR(iStartDate, 4, 2) +         //9
                                         COPYSTR(iStartDate, 7, 2));         //3
                    EVALUATE(EndDt,
                                         COPYSTR(iEndDate, 1, 2) +
                                         COPYSTR(iEndDate, 4, 2) +
                                         COPYSTR(iEndDate, 7, 2));
                    
                    
                    //Startdt := DMY2DATE(Day, Month, Year);
                    SalesPrice.VALIDATE("Item No.",iNo);
                    SalesPrice."Customer Cross Ref No." := iCrossref;
                    SalesPrice.VALIDATE("Sales Code",iSalesCode);
                    SalesPrice.VALIDATE("Currency Code",iCurrCode);
                    SalesPrice.VALIDATE("Starting Date",StartDt);
                    EVALUATE(SalesPrice."Unit Price",iUnitPrice);
                    EVALUATE(InvDisc,iAllowInvDisc);
                    SalesPrice."Allow Invoice Disc." := InvDisc;
                    EVALUATE(SlsType,iSalesType);
                    SalesPrice.VALIDATE("Sales Type",SlsType);
                    EVALUATE(SalesPrice."Minimum Quantity",iMinQty);
                    SalesPrice."Ending Date" := EndDt;
                    SalesPrice.VALIDATE("Unit of Measure Code",iUOM);
                    SalesPrice.VALIDATE("Variant Code",iVariant);
                    EVALUATE(SalesPrice."Allow Line Disc.",iAllowLineDisc);      //boolean
                    SalesPrice."Contract Ship-to Code" := CiscoCd;
                    SalesPrice."Contract No." :=iContno;
                    SalesPrice."Contract Ship Location Code" :=icontslc;
                    //SalesPrice."Contract Location Code" := icontlc;
                    SalesPrice."Contract Customer No."   := iContcn;
                    SalesPrice."External Document No." :=  icontedn;
                    IF NOT RecReplace THEN
                     SalesPrice.INSERT
                    ELSE SalesPrice.MODIFY;
                    */

                end;

                trigger OnBeforeInsertRecord()
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

        /*
        FBImportDataport.SETCURRENTKEY("User ID");
        FBImportDataport.SETRANGE("User ID",USERID);
        IF FBImportDataport.FIND('-') THEN
          currXMLport.FILENAME := FBImportDataport.TempFileName;
        */

    end;

    trigger OnPostXmlPort()
    begin

        IF GUIALLOWED THEN
            d.CLOSE();
    end;

    trigger OnPreXmlPort()
    begin

        IF GUIALLOWED THEN
            d.OPEN('Record      #1############## \' +
                 'Sales Price #2##############');
        RecNo := 1;
    end;

    var
        PrcCont: Record "Price Contract";
        SalesPrice: Record "Sales Price";
        d: Dialog;
        RecNo: Integer;
}

