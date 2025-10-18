page 50050 "Label Fields List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Label Fields";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Test Print Value"; Rec."Test Print Value")
                {
                    ToolTip = 'Specifies the value of the Test Print Value field.';
                }
                field("Receive Line"; Rec."Receive Line")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receive Line field.';
                }
                field("Package Line"; Rec."Package Line")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Package Line field.';
                }
                field("Contract Line"; Rec."Contract Line")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Line field.';
                }
                field(Package; Rec.Package)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Package field.';
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
                    ToolTip = 'Executes the &Print action.';

                    trigger OnAction()
                    begin
                        REPORT.RUN(REPORT::"Label Field Listing", TRUE, FALSE);
                    end;
                }
                action("&Where Used")
                {
                    Caption = '&Where Used';
                    Image = "Where-Used";
                    RunObject = Page "Label Field Where-Used";
                    RunPageLink = "Field Code" = FIELD(Code);
                    ToolTip = 'Executes the &Where Used action.';
                }
            }
        }
    }
}

