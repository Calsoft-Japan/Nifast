page 50079 "Bin Management"
{
    PageType = Card;
    SourceTable = Table14;

    layout
    {
        area(content)
        {
            field(Code;Code)
            {
                AssistEdit = false;
                Caption = 'Location';
                DrillDown = false;
                Editable = false;
                Lookup = false;
            }
            part(;7302)
            {
                SubPageLink = Location Code=FIELD(Code);
                SubPageView = SORTING(Location Code,Code)
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
    }
}

