page 50151 "SAT Payment Method Code"
{
    Caption = 'SAT Payment Method Codes';
    PageType = List;
    SourceTable = Table50033;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                }
                field(Description;Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

