page 50054 "Label Field Where-Used"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = false;
    PageType = List;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            repeater()
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Label")
            {
                Caption = '&Label';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 50053;
                    RunPageLink = Code=FIELD(Label Code);
                }
            }
        }
    }
}

