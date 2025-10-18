xmlport 50034 "Import Payment Journal"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'GenJnlLine';
                fieldelement(PostingDate; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(JnlTemplateName; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(JnlBatchName; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(AppliedToDocNo; "Gen. Journal Line"."Applies-to Doc. No.")
                {
                }
                fieldelement(LineNo; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(DocumentType; "Gen. Journal Line"."Document Type")
                {
                }
                fieldelement(AccountType; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(BalAccType; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(BalAccNo; "Gen. Journal Line"."Bal. Account No.")
                {
                }
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
}

