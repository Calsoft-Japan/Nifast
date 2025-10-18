page 50064 "HS Tariff Codes"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HS Tariff Code";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

