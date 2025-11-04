page 50079 "Bin Management"
{
    PageType = Card;
    SourceTable = Location;
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            field(Code; Rec.Code)
            {
                AssistEdit = false;
                Caption = 'Location';
                DrillDown = false;
                Editable = false;
                Lookup = false;
                ToolTip = 'Specifies the value of the Location field.';
            }
            part(Bin; Bins)
            {
                SubPageLink = "Location Code" = FIELD(Code);
                SubPageView = SORTING("Location Code", Code)
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
    }
}

