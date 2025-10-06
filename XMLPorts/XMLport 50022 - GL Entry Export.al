xmlport 50022 "G/L Entry Export"
{
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table17; Table17)
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'GLEntry';
                UseTemporary = false;
                fieldelement(EntryNo; "G/L Entry"."Entry No.")
                {
                }
                fieldelement(GLAcNo; "G/L Entry"."G/L Account No.")
                {
                }
                fieldelement(TrnNo; "G/L Entry"."Transaction No.")
                {
                }
                fieldelement(POstingDt; "G/L Entry"."Posting Date")
                {
                }
                fieldelement(DocNo; "G/L Entry"."Document No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        // if Type = '' then
                        //"Purchase Line".Type   CurrXMPport.skip;
                        //IF "Sales Line".Type = "Sales Line".Type::Resource THEN
                        //   currXMLport.SKIP;
                    end;
                }
                fieldelement(Desc; "G/L Entry".Description)
                {
                }
                fieldelement(Amt; "G/L Entry".Amount)
                {
                }
                fieldelement(GlobalDim1; "G/L Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(UserId; "G/L Entry"."User ID")
                {
                }
                fieldelement(SrcCd; "G/L Entry"."Source Code")
                {
                }
                fieldelement(SysCrtEnt; "G/L Entry"."System-Created Entry")
                {
                }
                fieldelement(DrAmt; "G/L Entry"."Debit Amount")
                {
                }
                fieldelement(CrAmt; "G/L Entry"."Credit Amount")
                {
                }
                fieldelement(DocType; "G/L Entry"."Document Type")
                {
                }
                fieldelement(BalAcNo; "G/L Entry"."Bal. Account No.")
                {
                }
                fieldelement(FlobalDim2; "G/L Entry"."Global Dimension 2 Code")
                {
                }
                fieldelement(PriorYrEnt; "G/L Entry"."Prior-Year Entry")
                {
                }
                fieldelement(JobNo; "G/L Entry"."Job No.")
                {
                }
                fieldelement(Qty; "G/L Entry".Quantity)
                {
                }
                fieldelement(VatAmt; "G/L Entry"."VAT Amount")
                {
                }
                fieldelement(BusUnitCd; "G/L Entry"."Business Unit Code")
                {
                }
                fieldelement(JnlBatchName; "G/L Entry"."Journal Batch Name")
                {
                }
                fieldelement(ReasonCd; "G/L Entry"."Reason Code")
                {
                }
                fieldelement(GenPostTyp; "G/L Entry"."Gen. Posting Type")
                {
                }
                fieldelement(GBPG; "G/L Entry"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GPPG; "G/L Entry"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(BalAcTyp; "G/L Entry"."Bal. Account Type")
                {
                }
                fieldelement(DocDt; "G/L Entry"."Document Date")
                {
                }
                fieldelement(ExtDocNo; "G/L Entry"."External Document No.")
                {
                }
                fieldelement(SrcType; "G/L Entry"."Source Type")
                {
                }
                fieldelement(SrcNo; "G/L Entry"."Source No.")
                {
                }
                fieldelement(NoSeries; "G/L Entry"."No. Series")
                {
                }
                fieldelement(TaxAreaCd; "G/L Entry"."Tax Area Code")
                {
                }
                fieldelement(TaxLiable; "G/L Entry"."Tax Liable")
                {
                }
                fieldelement(TaxGrpCd; "G/L Entry"."Tax Group Code")
                {
                }
                fieldelement(UseTax; "G/L Entry"."Use Tax")
                {
                }
                fieldelement(VBPG; "G/L Entry"."VAT Bus. Posting Group")
                {
                }
                fieldelement(VPPG; "G/L Entry"."VAT Prod. Posting Group")
                {
                }
                fieldelement(AddlCurAmt; "G/L Entry"."Additional-Currency Amount")
                {
                }
                fieldelement(AddlCurDrAmt; "G/L Entry"."Add.-Currency Debit Amount")
                {
                }
                fieldelement(AdlCurCrAmt; "G/L Entry"."Add.-Currency Credit Amount")
                {
                }
                fieldelement(CloseIncSDim; "G/L Entry"."Close Income Statement Dim. ID")
                {
                }
                fieldelement(ProdOrdNo; "G/L Entry"."Prod. Order No.")
                {
                }
                fieldelement(FAEntType; "G/L Entry"."FA Entry Type")
                {
                }
                fieldelement(FAEntNo; "G/L Entry"."FA Entry No.")
                {
                }
                textelement(ValEntNo)
                {
                }
                fieldelement(ContNoteNo; "G/L Entry"."Contract Note No.")
                {
                }
                fieldelement(ExchgContNo; "G/L Entry"."Exchange Contract No.")
                {
                }
                fieldelement(FXCurRate; "G/L Entry"."4X Currency Rate")
                {
                }
                fieldelement(FXAmtJPY; "G/L Entry"."4X Amount JPY")
                {
                }

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
}

