xmlport 50021 "Toyo SO Surcharge Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Line"; "Sales Line")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'SalesLine';
                UseTemporary = false;
                fieldelement(DocType; "Sales Line"."Document Type")
                {
                }
                fieldelement(SellToCustNo; "Sales Line"."Sell-to Customer No.")
                {
                }
                fieldelement(DocNo; "Sales Line"."Document No.")
                {
                }
                fieldelement(LineNo; "Sales Line"."Line No.")
                {
                }
                fieldelement(Type; "Sales Line".Type)
                {

                    trigger OnAfterAssignField()
                    begin
                        // if Type = '' then
                        //"Purchase Line".Type   CurrXMPport.skip;
                        //IF "Sales Line".Type = "Sales Line".Type::Resource THEN
                        //   currXMLport.SKIP;
                    end;
                }
                fieldelement(Numb; "Sales Line"."No.")
                {
                }
                fieldelement(UOM; "Sales Line"."Unit of Measure")
                {
                }
                fieldelement(Qty; "Sales Line".Quantity)
                {
                }
                fieldelement(UnitPrc; "Sales Line"."Unit Price")
                {

                    trigger OnAfterAssignField()
                    begin
                        UPrc := "Sales Line"."Unit Price";
                        "Sales Line".VALIDATE("Unit Price", UPrc);
                    end;
                }
                fieldelement(UOMCode; "Sales Line"."Unit of Measure Code")
                {
                }
                //TODO
                /*  fieldelement(ExtDocNo; "Sales Line"."External Document No.")
                 {
                 } */
                //TODO
                fieldelement(Desc; "Sales Line".Description)
                {
                }
                fieldelement(LocCode; "Sales Line"."Location Code")
                {
                }
                fieldelement(ShpntDate; "Sales Line"."Shipment Date")
                {
                }
                fieldelement(OutstQty; "Sales Line"."Outstanding Quantity")
                {
                }
                fieldelement(QtyToInv; "Sales Line"."Qty. to Invoice")
                {
                }
                fieldelement(QtyToShip; "Sales Line"."Qty. to Ship")
                {
                }
                fieldelement(AllowInvDisc; "Sales Line"."Allow Invoice Disc.")
                {
                }
                fieldelement(SCDim1; "Sales Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(BillToCust; "Sales Line"."Bill-to Customer No.")
                {
                }
                fieldelement(GPPG; "Sales Line"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(VATCalcType; "Sales Line"."VAT Calculation Type")
                {
                }
                fieldelement(CurrCode; "Sales Line"."Currency Code")
                {
                }
                fieldelement(QtyPerUOM; "Sales Line"."Qty. per Unit of Measure")
                {
                }
                fieldelement(QtyBase; "Sales Line"."Quantity (Base)")
                {
                }
                fieldelement(OQtyBase; "Sales Line"."Outstanding Qty. (Base)")
                {
                }
                fieldelement(QtyToInvBase; "Sales Line"."Qty. to Invoice (Base)")
                {
                }
                fieldelement(QtyToShipBase; "Sales Line"."Qty. to Ship (Base)")
                {
                }
                fieldelement(RespCenter; "Sales Line"."Responsibility Center")
                {
                }
                fieldelement(PlannedDelDt; "Sales Line"."Planned Delivery Date")
                {
                }
                fieldelement(PlannedShpmntDt; "Sales Line"."Planned Shipment Date")
                {
                }
                fieldelement(ShippingAgntCd; "Sales Line"."Shipping Agent Code")
                {
                }
                //TODO
                /*   fieldelement(SlsPerCode; "Sales Line"."Salesperson Code")
                  {
                  }
                  fieldelement(OrdDt; "Sales Line"."Order Date")
                  {
                  } */
                //TODO
                fieldelement(Amt; "Sales Line".Amount)
                {
                }
                fieldelement(AmtIncVat; "Sales Line"."Amount Including VAT")
                {
                }
                fieldelement(OutstAmt; "Sales Line"."Outstanding Amount")
                {
                }
                fieldelement(OutstAmtLCY; "Sales Line"."Outstanding Amount (LCY)")
                {
                }
                fieldelement(VATBaseAmt; "Sales Line"."VAT Base Amount")
                {
                }
                fieldelement(LineAmt; "Sales Line"."Line Amount")
                {
                }
                //TODO
                /* fieldelement(NetUPrc; "Sales Line"."Net Unit Price")
                {
                } */
                //TODO
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

    trigger OnPostXmlPort()
    begin
        MESSAGE('Import Completed');
    end;

    var
        UPrc: Decimal;
}

