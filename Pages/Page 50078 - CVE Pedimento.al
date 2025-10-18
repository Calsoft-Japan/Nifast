page 50078 "CVE Pedimento"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CVE Pedimento";

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
                field("Include on Virtual Invoice"; Rec."Include on Virtual Invoice")
                {
                    ToolTip = 'Specifies the value of the Include on Virtual Invoice field.';
                }
            }
        }
    }

    actions
    {
    }
}

