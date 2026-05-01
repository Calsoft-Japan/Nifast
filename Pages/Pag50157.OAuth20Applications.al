page 50157 "OAuth 2.0 Applications"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'OAuth 2.0 Applications';
    CardPageID = "OAuth 2.0 Application";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "OAuth 2.0 Application";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}
