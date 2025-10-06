xmlport 50019 "Standard Sales Order Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table37;Table37)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'SalesLine';
                UseTemporary = false;
                fieldelement(DocType;"Sales Line"."Document Type")
                {
                }
                fieldelement(SellToCustNo;"Sales Line"."Sell-to Customer No.")
                {
                }
                fieldelement(DocNo;"Sales Line"."Document No.")
                {
                }
                fieldelement(LineNo;"Sales Line"."Line No.")
                {
                }
                fieldelement(Type;"Sales Line".Type)
                {

                    trigger OnAfterAssignField()
                    begin
                        // if Type = '' then
                        //"Purchase Line".Type   CurrXMPport.skip;
                        //IF "Sales Line".Type = "Sales Line".Type::Resource THEN
                        //   currXMLport.SKIP;
                    end;
                }
                fieldelement(Numb;"Sales Line"."No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        //Items.SETRANGE("No.","Sales Line"."No.");

                        //IF Items.FINDSET THEN BEGIN
                        //    REPEAT
                            //"Sales Line".Description:=Items.Description;
                        //      "Sales Line".VALIDATE(Description,Items.Description);
                        //      MESSAGE(Items.Description);
                             // "Sales Line".MODIFY(TRUE);
                        //    UNTIL Items.NEXT = 0;
                        //END;
                    end;
                }
                fieldelement(UOM;"Sales Line"."Unit of Measure")
                {
                }
                fieldelement(Qty;"Sales Line".Quantity)
                {
                }
                fieldelement(UnitPrice;"Sales Line"."Unit Price")
                {
                }
                fieldelement(UOMCode;"Sales Line"."Unit of Measure Code")
                {
                }
                fieldelement(ExtDocNo;"Sales Line"."External Document No.")
                {
                }
                fieldelement(Desc;"Sales Line".Description)
                {
                }
                fieldelement(LocCode;"Sales Line"."Location Code")
                {
                }
                fieldelement(ShpntDate;"Sales Line"."Shipment Date")
                {
                }
                fieldelement(OutstQty;"Sales Line"."Outstanding Quantity")
                {
                }
                fieldelement(QtyToInv;"Sales Line"."Qty. to Invoice")
                {
                }
                fieldelement(QtyToShip;"Sales Line"."Qty. to Ship")
                {
                }
                fieldelement(AllowInvDisc;"Sales Line"."Allow Invoice Disc.")
                {
                }
                fieldelement(SCDim1;"Sales Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(BillToCust;"Sales Line"."Bill-to Customer No.")
                {
                }
                fieldelement(GPPG;"Sales Line"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(VATCalcType;"Sales Line"."VAT Calculation Type")
                {
                }
                fieldelement(CurrCode;"Sales Line"."Currency Code")
                {
                }
                fieldelement(QtyPerUOM;"Sales Line"."Qty. per Unit of Measure")
                {
                }
                fieldelement(QtyBase;"Sales Line"."Quantity (Base)")
                {
                }
                fieldelement(OQtyBase;"Sales Line"."Outstanding Qty. (Base)")
                {
                }
                fieldelement(QtyToInvBase;"Sales Line"."Qty. to Invoice (Base)")
                {
                }
                fieldelement(QtyToShipBase;"Sales Line"."Qty. to Ship (Base)")
                {
                }
                fieldelement(RespCenter;"Sales Line"."Responsibility Center")
                {
                }
                fieldelement(PlannedDelDt;"Sales Line"."Planned Delivery Date")
                {
                }
                fieldelement(PlannedShpmntDt;"Sales Line"."Planned Shipment Date")
                {
                }
                fieldelement(ShippingAgntCd;"Sales Line"."Shipping Agent Code")
                {
                }
                fieldelement(OrdDt;"Sales Line"."Order Date")
                {
                }
                fieldelement(SlsPerCode;"Sales Line"."Salesperson Code")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    Items.SETRANGE("No.","Sales Line"."No.");

                    IF Items.FINDSET THEN BEGIN
                        REPEAT
                          "Sales Line".VALIDATE(Description,Items.Description);
                          "Sales Line".VALIDATE("Gen. Prod. Posting Group",Items."Gen. Prod. Posting Group");
                          "Sales Line".MODIFY(TRUE);
                        UNTIL Items.NEXT = 0;
                    END;

                    Customers.SETRANGE("No.","Sales Line"."Sell-to Customer No.");

                    IF Customers.FINDSET THEN BEGIN
                        REPEAT

                          "Sales Line".VALIDATE("Currency Code",Customers."Currency Code");
                          "Sales Line".MODIFY(TRUE);
                        UNTIL Customers.NEXT = 0;
                    END;


                    SalesHeader.SETRANGE("No.","Sales Line"."Document No.");

                    IF SalesHeader.FINDSET THEN BEGIN
                        REPEAT
                          "Sales Line".VALIDATE("Salesperson Code",SalesHeader."Salesperson Code");
                          "Sales Line".VALIDATE("Shipping Agent Code",SalesHeader."Shipping Agent Code");
                          "Sales Line".MODIFY(TRUE);
                        UNTIL SalesHeader.NEXT = 0;
                    END;


                    "Sales Line".VALIDATE("Total Parcels","Sales Line".Quantity/"Sales Line"."Units per Parcel");
                           "Sales Line".MODIFY(TRUE);
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

    trigger OnPostXmlPort()
    begin
         MESSAGE('Import Completed');
    end;

    var
        Items: Record "27";
        Customers: Record "18";
        SalesHeader: Record "36";
}

