page 50139 "FB Tag Journal Batches"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FB Tag Journal Batch";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
            }
        }
    }

    actions
    {
    }
}

