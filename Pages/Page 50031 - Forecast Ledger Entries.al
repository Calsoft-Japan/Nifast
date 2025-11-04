page 50031 "Forecast Ledger Entries"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = true;
    PageType = Document;
    SaveValues = false;
    UsageCategory = Lists;
    SourceTable = "Dimension Value";
    SourceTableView = WHERE("Dimension Code" = CONST('DIV'));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    AssistEdit = false;
                    Caption = 'Divsion Filter';
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                    ToolTip = 'Specifies the value of the Divsion Filter field.';
                }
            }
            part(AvailabilityProjection; "[[P] Availability Projection]")
            {
                SubPageLink = "Division Code" = FIELD(Code);
                SubPageView = SORTING("Entry No.", "Item No.", "Customer No.", "Shipping Date", "Forecast Quantity", "Division Code");
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

