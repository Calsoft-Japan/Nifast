page 50033 "4X Contract List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "4X Contract";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "4X Contract";
    SourceTableView = SORTING("No.")
                      WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Contract Note No."; Rec."Contract Note No.")
                {
                    ToolTip = 'Specifies the value of the Contract Note No. field.';
                }
                field(Total; Rec.Total)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total field.';
                }
                field("Division Code"; Rec."Division Code")
                {
                    ToolTip = 'Specifies the value of the Division Code field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Line)
            {
                Caption = 'Line';
                action("Contract Card")
                {
                    Caption = 'Contract Card';
                    Image = FileContract;
                    RunObject = Page "4X Contract";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'Executes the Contract Card action.';
                }
            }
        }
    }
}

