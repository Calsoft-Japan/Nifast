page 50009 "Customer Model Year"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SaveValues = true;
    SourceTable = "Customer Model Year";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.';
                }
            }
        }
    }

    actions
    {
    }
}

