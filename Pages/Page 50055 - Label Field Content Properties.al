page 50055 "Label Field Content Properties"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            group()
            {
                Editable = false;
                field("Label Code";"Label Code")
                {
                }
                field("Field Code";"Field Code")
                {
                }
                field(Description;Description)
                {
                }
            }
            field("No. Series";"No. Series")
            {
            }
        }
    }

    actions
    {
    }
}

