xmlport 50078 "Gan. Journal List Import"
{
    // 
    // 9/13/16 - SM.001 - added Div COde and Dept Code (Shortcut dim 1 and 2)

    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoSave = true;
                AutoUpdate = false;
                XmlName = 'GenJnlLn';
                UseTemporary = false;
                fieldelement(JnlTNm; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(LnNo; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(ActTyp; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(ActNo; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(PostDt; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(DocNo; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(Desc; "Gen. Journal Line".Description)
                {
                }
                fieldelement(Amt; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(DrAmt; "Gen. Journal Line"."Debit Amount")
                {
                }
                fieldelement(CrAmt; "Gen. Journal Line"."Credit Amount")
                {
                }
                fieldelement(AmtLCY; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(BalLCY; "Gen. Journal Line"."Balance (LCY)")
                {
                }
                fieldelement(SCDim1; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(SrcCd; "Gen. Journal Line"."Source Code")
                {
                }
                textelement(VATAmt)
                {
                }
                fieldelement(JnlBNm; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                textelement(BalVAmt)
                {
                }
                fieldelement(DocDt; "Gen. Journal Line"."Document Date")
                {
                }
                textelement(VATAmtLCY)
                {
                }
                textelement(BalAmtLCY)
                {
                }
                fieldelement(AllowAppl; "Gen. Journal Line"."Allow Application")
                {
                }
                fieldelement(DivCode; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(DepCode; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
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

    trigger OnPreXmlPort()
    begin
        "Gen. Journal Line"."Journal Batch Name" := 'PAYROLL';
        //"Allow VAT Difference"  := True;
    end;
}

