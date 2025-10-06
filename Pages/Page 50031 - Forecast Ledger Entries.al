page 50031 "Forecast Ledger Entries"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = true;
    PageType = Document;
    SaveValues = false;
    SourceTable = Table349;
    SourceTableView = WHERE(Dimension Code=CONST(DIV));

    layout
    {
        area(content)
        {
            group()
            {
                field(Code;Code)
                {
                    AssistEdit = false;
                    Caption = 'Divsion Filter';
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                }
            }
            part(;50016)
            {
                SubPageLink = Division Code=FIELD(Code);
                SubPageView = SORTING(Entry No.,Item No.,Customer No.,Shipping Date,Forecast Quantity,Division Code);
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := FALSE;
    end;
}

