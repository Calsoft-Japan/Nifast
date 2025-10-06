page 50050 "Label Fields List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50005;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code;Code)
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                }
                field("Test Print Value";"Test Print Value")
                {
                }
                field("Receive Line";"Receive Line")
                {
                    Editable = false;
                }
                field("Package Line";"Package Line")
                {
                    Editable = false;
                }
                field("Contract Line";"Contract Line")
                {
                    Editable = false;
                }
                field(Package;Package)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Label Fields")
            {
                Caption = '&Label Fields';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        REPORT.RUN(REPORT::"Label Field Listing",TRUE,FALSE);
                    end;
                }
                action("&Where Used")
                {
                    Caption = '&Where Used';
                    RunObject = Page 50054;
                    RunPageLink = Field Code=FIELD(Code);
                }
            }
        }
    }
}

