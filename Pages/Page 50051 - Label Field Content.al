page 50051 "Label Field Content"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // CIF.RAM 06/29/22 Added field <No. Series> to the page

    DataCaptionFields = "Label Code";
    PageType = List;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Field Code";"Field Code")
                {
                }
                field(Description;Description)
                {
                }
                field("Test Print Value";"Test Print Value")
                {
                }
                field("No. Series";"No. Series")
                {
                }
                field("Print Value";"Print Value")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Label Field")
            {
                Caption = '&Label Field';
                action("&Properties")
                {
                    Caption = '&Properties';
                    RunObject = Page 50055;
                    RunPageLink = Label Code=FIELD(Label Code),
                                  Field Code=FIELD(Field Code);
                }
            }
        }
    }
}

