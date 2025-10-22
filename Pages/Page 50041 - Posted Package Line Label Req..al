page 50041 "Posted Package Line Label Req."
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // WC>>
    // 0201011 JWW Added Total Quantity field at bottom of screen - Changed QtyToPrint and NoOfCopies per requested change
    //             Added GV: TotQtyToPrint, Item, Warn
    //             Code at: Form - OnAfterGetCurrRecord()
    // <<WC
    ApplicationArea = All;
    UsageCategory = None;
    PageType = Document;
    SourceTable = "LAX Posted Package Line";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.';
                    Caption = 'Package No.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    Caption = 'Lot No.';
                }
                field("Mfg. Lot No."; Rec."Mfg. Lot No.")
                {
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                    Caption = 'Mfg. Lot No.';
                }
            }
            part(CrossReferenceSubform; "Cross Reference Subform")
            {
                Editable = false;
                SubPageLink = "Item No." = FIELD("No.");
            }
            field(TotQtyToPrint; TotQtyToPrint)
            {
                Caption = 'Total Quantity';
                DecimalPlaces = 0 : 2;
                Editable = false;
                StyleExpr = StyleTxt;
                ToolTip = 'Specifies the value of the Total Quantity field.';
            }
            field(NoOfCopies; NoOfCopies)
            {
                Caption = 'No. of Copies';
                ToolTip = 'Specifies the value of the No. of Copies field.';
            }
            field(QtyToPrint; QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0 : 2;
                ToolTip = 'Specifies the value of the Quantity To Print field.';
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
                    Image = Shipment;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date")
                                  WHERE("Entry Type" = FILTER(Sale),
                                        Quantity = FILTER(<> 0));
                    ToolTip = 'Executes the Shipment History action.';
                }
                action("Sales Order Lines")
                {
                    Caption = 'Sales Order Lines';
                    Image = Sales;
                    RunObject = Page "Sales Lines";
                    RunPageLink = Type = FILTER(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Document No.", Type, "No.", "Variant Code", "Drop Shipment", Pack)
                                  WHERE("Document Type" = FILTER(Order));
                    ToolTip = 'Executes the Sales Order Lines action.';
                }
            }
        }
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Image = "1099Form";
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the OK action.';

                trigger OnAction()
                begin
                    Package.GET(Rec."Package No.");

                    PackingRule.GetPackingRule(
                      Package."Ship-to Type", Package."Ship-to No.", Package."Ship-to Code");

                    IF PackingRule."Package Line Label Code" <> '' THEN BEGIN
                        CLEAR(PackageLineLabel);
                        PackageLine.COPYFILTERS(Rec);
                        //XPackageLine.SETRECFILTER;
                        PackageLineLabel.SETTABLEVIEW(PackageLine);
                        PackageLineLabel.InitializeRequest(PackingRule."Package Line Label Code", NoOfCopies);
                        PackageLineLabel.InitializeRequest2(QtyToPrint);
                        //PackageLineLabel.USEREQUESTFORM(TRUE);
                        PackageLineLabel.USEREQUESTPAGE(FALSE);
                        PackageLineLabel.RUNMODAL();
                        CLEAR(PackageLineLabel);
                    END;
                end;
            }
            action("&Master Label")
            {
                Caption = '&Master Label';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Master Label action.';

                trigger OnAction()
                var
                    Package2: Record "LAX Package";
                    PostedPackage: Record "LAX Posted Package";
                    LabelMgtNIF: Codeunit "Label Mgmt NIF";
                begin
                    PostedPackage.GET(Rec."Package No.");
                    Package2.TRANSFERFIELDS(PostedPackage);
                    IF (PackingRule.GetPackingRule(Package2."Ship-to Type", Package2."Ship-to No.", Package2."Ship-to Code")) AND
                          (PackingRule."Std. Package Label Code" <> '') THEN BEGIN
                        COMMIT();
                        LabelMgtNIF.PrintPackageLabel(Package2, PackingRule."Std. Package Label Code", NoOfCopies, TRUE, Rec."Line No.", QtyToPrint)
                    END
                    ELSE
                        MESSAGE('No Master Label is defined for this customer.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
        StyleTxt := TotQtyToPrintOnFormat();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        Item: Record Item;
        PackingRule: Record "LAX Packing Rule";
        Package: Record "LAX Posted Package";
        PackageLine: Record "LAX Posted Package Line";
        PackageLineLabel: Report "Package Line Label";
        QtyToPrint: Decimal;
        TotQtyToPrint: Decimal;
        Warn: Decimal;
        NoOfCopies: Integer;
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

        TotQtyToPrint := Rec.Quantity;

        IF Rec.Type = Rec.Type::Item THEN BEGIN
            Item.GET(Rec."No.");
            QtyToPrint := Item."Units per Parcel";
        END ELSE
            QtyToPrint := Rec.Quantity;

        Warn := 0;
        IF QtyToPrint = 0 THEN
            NoOfCopies := 0
        ELSE BEGIN
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

