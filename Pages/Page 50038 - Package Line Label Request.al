page 50038 "Package Line Label Request"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  07-12-16 Added Code to Show Error Message When user click on system "OK" button
    // WC>>
    // 0201011 JWW Added Total Quantity field at bottom of screen - Changed QtyToPrint and NoOfCopies per requested change
    //             Added GV: TotQtyToPrint, Item, Warn
    //             Code at: Form - OnAfterGetCurrRecord()
    // <<WC

    PageType = Document;
    SourceTable = Table14000702;

    layout
    {
        area(content)
        {
            group()
            {
                Editable = false;
                field("Package No.";"Package No.")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field(Description;Description)
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Mfg. Lot No.";"Mfg. Lot No.")
                {
                }
            }
            part(;50008)
            {
                Editable = false;
                SubPageLink = Item No.=FIELD(No.);
            }
            field(TotQtyToPrint;TotQtyToPrint)
            {
                Caption = 'Total Quantity';
                DecimalPlaces = 0:2;
                Editable = false;
                StyleExpr = StyleTxt;
            }
            field(NoOfCopies;NoOfCopies)
            {
                Caption = 'No. of Copies';

                trigger OnValidate()
                begin
                    QtyUpdated_gBln := TRUE;  //NG-N
                end;
            }
            field(QtyToPrint;QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0:2;

                trigger OnValidate()
                begin
                    QtyUpdated_gBln := TRUE;  //NG-N
                end;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                action("Shipment History")
                {
                    Caption = 'Shipment History';
                    RunObject = Page 38;
                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Entry Type,Item No.,Variant Code,Source Type,Source No.,Posting Date)
                                  WHERE(Entry Type=FILTER(Sale),
                                        Quantity=FILTER(<>0));
                }
                action("Sales Order Lines")
                {
                    Caption = 'Sales Order Lines';
                    RunObject = Page 516;
                    RunPageLink = Type=FILTER(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Document No.,Type,No.,Variant Code,Drop Shipment,Pack)
                                  WHERE(Document Type=FILTER(Order));
                }
            }
        }
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Package.GET("Package No.");

                    PackingRule.GetPackingRule(
                      Package."Ship-to Type",Package."Ship-to No.",Package."Ship-to Code");

                    IF PackingRule."Package Line Label Code" <> '' THEN BEGIN
                      CLEAR(PackageLineLabel);
                      PackageLine.COPYFILTERS(Rec);
                      //XPackageLine.SETRECFILTER;
                      PackageLineLabel.SETTABLEVIEW(PackageLine);
                      PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code",NoOfCopies);
                      PackageLineLabel.InitializeRequest2(QtyToPrint);
                      //PackageLineLabel.USEREQUESTFORM(TRUE);
                      PackageLineLabel.USEREQUESTPAGE(FALSE);
                      PackageLineLabel.RUNMODAL;
                      CLEAR(PackageLineLabel);
                    END;
                end;
            }
            action("&Master Label")
            {
                Caption = '&Master Label';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LabelMgtNIF: Codeunit "50017";
                    Package: Record "14000701";
                begin
                    Package.GET("Package No.");
                    IF (PackingRule.GetPackingRule(Package."Ship-to Type",Package."Ship-to No.",Package."Ship-to Code")) AND
                    //>> 12-08-05
                          //(PackingRule."Std. Package Label Code" <> '') THEN
                          (PackingRule."Std. Package Label Code" <> '') OR (PackingRule."Std. Package Label Code 2" <> '') THEN
                    //<< 12-08-05
                      BEGIN
                        COMMIT;
                    //>> 12-08-05
                        //LabelMgtNIF.PrintPackageLabel(Package,PackingRule."Std. Package Label Code",1,FALSE,"Line No.");
                        IF PackingRule."Std. Package Label Code"<>'' THEN
                          LabelMgtNIF.PrintPackageLabel(Package,PackingRule."Std. Package Label Code",NoOfCopies,FALSE,"Line No.",QtyToPrint);

                        IF PackingRule."Std. Package Label Code 2"<>'' THEN
                          LabelMgtNIF.PrintPackageLabel(Package,PackingRule."Std. Package Label Code 2",1,FALSE,"Line No.",QtyToPrint);
                    //<< 12-08-05
                      END
                    ELSE
                      MESSAGE('No Master Label is defined for this customer.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
        StyleTxt := TotQtyToPrintOnFormat;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        QtyUpdated_gBln := FALSE;  //NG-N
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //>> NF1.00:CIS.NG  07-12-16
        IF CloseAction IN [ACTION::LookupOK,ACTION::OK] THEN BEGIN
          IF NOT CONFIRM('Please click on OK button from action bar to print Label.\Do you want to close page?',FALSE) THEN
            ERROR('');
        END;
        //<< NF1.00:CIS.NG  07-12-16
    end;

    var
        QtyToPrint: Decimal;
        NoOfCopies: Integer;
        PackingRule: Record "14000715";
        PackageLineLabel: Report "50041";
        PackageLine: Record "14000702";
        Package: Record "14000701";
        LabelMgmt: Codeunit "14000841";
        "WC>": Integer;
        TotQtyToPrint: Decimal;
        Item: Record "27";
        Warn: Decimal;
        StyleTxt: Text;
        QtyUpdated_gBln: Boolean;

    local procedure OnAfterGetCurrRecord()
    begin
        IF NOT QtyUpdated_gBln THEN BEGIN  //NG-N
          xRec := Rec;
          //>> WC 020111 JWW
          //IF QtyToPrint=0 THEN
          //  QtyToPrint := Quantity;
          //
          //IF NoOfCopies=0 THEN
          //  NoOfCopies := 1;

          TotQtyToPrint := Quantity;

          IF Type = Type:: Item THEN BEGIN
            Item.GET("No.");
            QtyToPrint := Item."Units per Parcel";
          END ELSE BEGIN
            QtyToPrint := Quantity;
          END;

          Warn := 0;
          IF QtyToPrint = 0 THEN BEGIN
            NoOfCopies := 0;
          END ELSE BEGIN
            Warn := TotQtyToPrint MOD QtyToPrint;
            NoOfCopies := (TotQtyToPrint - Warn) / QtyToPrint;
          END;
          //<< WC 020111 JWW
        END;  //NG-N
    end;

    local procedure TotQtyToPrintOnFormat(): Text
    begin
        IF Warn = 0 THEN
          EXIT('')
        ELSE
          EXIT('Unfavorable')
    end;
}

