xmlport 50018 "Purchase Line Maker"
{
    //    recomp

    DefaultFieldsValidation = false;
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Purchase Line"; "Purchase Line")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'PurchLine';
                UseTemporary = false;
                fieldelement(DocType; "Purchase Line"."Document Type")
                {
                }
                fieldelement(DocNo; "Purchase Line"."Document No.")
                {
                }
                fieldelement(LineNo; "Purchase Line"."Line No.")
                {
                }
                fieldelement(Type; "Purchase Line".Type)
                {

                    trigger OnAfterAssignField()
                    begin
                        // if Type = '' then
                        //"Purchase Line".Type   CurrXMPport.skip;
                        IF "Purchase Line".Type = "Purchase Line".Type::Resource THEN
                            currXMLport.SKIP();
                        IF "Purchase Line".Type = 0 THEN
                            currXMLport.SKIP();
                    end;
                }
                fieldelement(Numb; "Purchase Line"."No.")
                {
                }
                //TODO
                /* fieldelement(AltQty; "Purchase Line"."Alt. Quantity")
                {
                }
                fieldelement(AltQtyUOM; "Purchase Line"."Alt. Qty. UOM")
                {
                } */
                //TODO
                fieldelement(AltPrice; "Purchase Line"."Alt. Price")
                {
                }
                //TODO
                /* fieldelement(AltPrcUOM; "Purchase Line"."Alt. Qty. UOM")
                {
                } */
                //TODO
                fieldelement(PlannedRecptDt; "Purchase Line"."Planned Receipt Date")
                {
                }
                fieldelement(OrdDt; "Purchase Line"."Order Date")
                {
                }
                fieldelement(AllowItemChgAssign; "Purchase Line"."Allow Item Charge Assignment")
                {
                }
                //TODO
                /* fieldelement(OutstGrossWt; "Purchase Line"."Outstanding Gross Weight")
                {
                }
                fieldelement(OutstNetWt; "Purchase Line"."Outstanding Net Weight")
                {
                }
                fieldelement(LineGrossWt; "Purchase Line"."Line Gross Weight")
                {
                }
                fieldelement(LineNetWt; "Purchase Line"."Line Net Weight")
                {
                } */
                //TODO
                fieldelement(BuyFmVenNo; "Purchase Line"."Buy-from Vendor No.")
                {
                }
                fieldelement(PostGrp; "Purchase Line"."Posting Group")
                {
                }
                fieldelement(ExptdRcptDt; "Purchase Line"."Expected Receipt Date")
                {
                }
                fieldelement(Desc; "Purchase Line".Description)
                {
                }
                fieldelement(UOM; "Purchase Line"."Unit of Measure")
                {
                }
                fieldelement(Qty; "Purchase Line".Quantity)
                {
                }
                fieldelement(OutstandQty; "Purchase Line"."Outstanding Quantity")
                {
                }
                fieldelement(QtyToInv; "Purchase Line"."Qty. to Invoice")
                {
                }
                fieldelement(QtyToRecv; "Purchase Line"."Qty. to Receive")
                {
                }
                fieldelement(DirectUnitCost; "Purchase Line"."Direct Unit Cost")
                {
                }
                fieldelement(UnitCostLCY; "Purchase Line"."Unit Cost (LCY)")
                {
                }
                fieldelement(QtyPerUOM; "Purchase Line"."Qty. per Unit of Measure")
                {
                }
                fieldelement(UOMCode; "Purchase Line"."Unit of Measure Code")
                {
                }
                fieldelement(GrossWt; "Purchase Line"."Gross Weight")
                {
                }
                fieldelement(NetWt; "Purchase Line"."Net Weight")
                {
                }
                fieldelement(UnitsPerParcel; "Purchase Line"."Units per Parcel")
                {
                }
                fieldelement(QtyBase; "Purchase Line"."Quantity (Base)")
                {
                }
                fieldelement(OutstQtyBase; "Purchase Line"."Outstanding Qty. (Base)")
                {
                }
                fieldelement(QtyToInvBase; "Purchase Line"."Qty. to Invoice (Base)")
                {
                }
                fieldelement(QtyToRecvBase; "Purchase Line"."Qty. to Receive (Base)")
                {
                }
                fieldelement(OutstAmt; "Purchase Line"."Outstanding Amount")
                {
                }
                fieldelement(PayToVenNo; "Purchase Line"."Pay-to Vendor No.")
                {
                }
                fieldelement(GPPG; "Purchase Line"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(VatCalcType; "Purchase Line"."VAT Calculation Type")
                {
                }
                fieldelement(ItemCatgCode; "Purchase Line"."Item Category Code")
                {
                }
                //TODO
                /* fieldelement(ProdGrpCd; "Purchase Line"."Product Group Code")
                {
                }
                fieldelement(LineAmtToRecv; "Purchase Line"."Line Amount to Receive")
                {
                }
                fieldelement(LineAmtToInv; "Purchase Line"."Line Amount to Invoice")
                {
                } */
                //TODO
                fieldelement(TaxGrpCode; "Purchase Line"."Tax Group Code")
                {
                }
                fieldelement(CurrCode; "Purchase Line"."Currency Code")
                {
                }
                fieldelement(OutstAmtLCY; "Purchase Line"."Outstanding Amount (LCY)")
                {
                }
                fieldelement(UnitCost; "Purchase Line"."Unit Cost")
                {
                }
                fieldelement(LineAmt; "Purchase Line"."Line Amount")
                {
                }
                fieldelement(SafetyLeadTime; "Purchase Line"."Safety Lead Time")
                {
                }
                fieldelement(ReqRecptDt; "Purchase Line"."Requested Receipt Date")
                {
                }
                fieldelement(PromRecptDt; "Purchase Line"."Promised Receipt Date")
                {
                }
                fieldelement(RespCentre; "Purchase Line"."Responsibility Center")
                {
                }
                fieldelement(SCDim1; "Purchase Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(BinCode; "Purchase Line"."Bin Code")
                {
                }
                fieldelement(LocCode; "Purchase Line"."Location Code")
                {
                }
                fieldelement(Desc2; "Purchase Line"."Description 2")
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                var
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
}

