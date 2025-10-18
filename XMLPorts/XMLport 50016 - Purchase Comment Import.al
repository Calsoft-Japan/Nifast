xmlport 50016 "Purchase Comment Import"
{
    Direction = Import;
    Format = VariableText;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(Root)
        {
            tableelement("Purch. Comment Line"; "Purch. Comment Line")
            {
                XmlName = 'PurchCommentImport';
                fieldelement(DocType; "Purch. Comment Line"."Document Type")
                {
                }
                fieldelement(No; "Purch. Comment Line"."No.")
                {
                }
                fieldelement(DocLineNo; "Purch. Comment Line"."Document Line No.")
                {
                }
                fieldelement(LineNo; "Purch. Comment Line"."Line No.")
                {
                }
                fieldelement(Date; "Purch. Comment Line".Date)
                {
                }
                fieldelement(Comment; "Purch. Comment Line".Comment)
                {
                }
                //TODO
                /*   fieldelement(PrintOnQuote; "Purch. Comment Line"."Print On Quote")
                  {
                  }
                  fieldelement(PrintOnPutAway; "Purch. Comment Line"."Print On Put Away")
                  {
                  }
                  fieldelement(PrintOnOrder; "Purch. Comment Line"."Print On Order")
                  {
                  }
                  fieldelement(PrintOnReceipt; "Purch. Comment Line"."Print On Receipt")
                  {
                  }
                  fieldelement(PrintOnInvoice; "Purch. Comment Line"."Print On Invoice")
                  {
                  }
                  fieldelement(PrintOnCredtiMemo; "Purch. Comment Line"."Print On Credit Memo")
                  {
                  } */
                //TODO
                fieldelement(PrintOnBlanket; "Purch. Comment Line"."Print On Blanket")
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

