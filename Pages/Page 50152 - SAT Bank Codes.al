page 50152 "SAT Bank Codes"
{
    Caption = 'SAT Bank Codes';
    PageType = List;
    SourceTable = Table50034;

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
                field("Bank Name";"Bank Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

