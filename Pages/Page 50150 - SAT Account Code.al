page 50150 "SAT Account Code"
{
    Caption = 'SAT Account Codes';
    PageType = List;
    SourceTable = Table50032;

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
                field(Level;Level)
                {
                }
            }
        }
    }

    actions
    {
    }
}

