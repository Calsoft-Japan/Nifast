page 50041 "Posted Package Line Label Req."
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // WC>>
    // 0201011 JWW Added Total Quantity field at bottom of screen - Changed QtyToPrint and NoOfCopies per requested change
    //             Added GV: TotQtyToPrint, Item, Warn
    //             Code at: Form - OnAfterGetCurrRecord()
    // <<WC

    PageType = Document;
    SourceTable = 14000705;

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
            }
            field(QtyToPrint;QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0:2;
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
                    PostedPackage: Record "14000704";
                    Package2: Record "14000701";
                begin
                    PostedPackage.GET("Package No.");
                    Package2.TRANSFERFIELDS(PostedPackage);
                    IF (PackingRule.GetPackingRule(Package2."Ship-to Type",Package2."Ship-to No.",Package2."Ship-to Code")) AND
                          (PackingRule."Std. Package Label Code" <> '') THEN
                      BEGIN
                        COMMIT;
                        LabelMgtNIF.PrintPackageLabel(Package2,PackingRule."Std. Package Label Code",NoOfCopies,TRUE,"Line No.",QtyToPrint)
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

    var
        QtyToPrint: Decimal;
        NoOfCopies: Integer;
        PackingRule: Record "14000715";
        PackageLineLabel: Report "50041";
        PackageLine: Record "14000705";
        Package: Record "14000704";
        "WC>": Integer;
        TotQtyToPrint: Decimal;
        Item: Record "27";
        Warn: Decimal;
        StyleTxt: Text;

    local procedure OnAfterGetCurrRecord()
    begin
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
    end;

    local procedure TotQtyToPrintOnFormat(): Text
    begin
        IF Warn = 0 THEN
          EXIT('')
        ELSE
          EXIT('Unfavorable');
    end;
}

