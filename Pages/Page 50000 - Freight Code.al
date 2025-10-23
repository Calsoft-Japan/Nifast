page 50000 "Freight Code"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Freight Code";
    ApplicationArea = All;

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
                field("COL Code"; Rec."COL Code")
                {
                    ToolTip = 'Specifies the value of the COL Code field.';
                }
                field("MPD Code"; Rec."MPD Code")
                {
                    ToolTip = 'Specifies the value of the MPD Code field.';
                }
                field("LEN Code"; Rec."LEN Code")
                {
                    ToolTip = 'Specifies the value of the LEN Code field.';
                }
                field("SAL Code"; Rec."SAL Code")
                {
                    ToolTip = 'Specifies the value of the SAL Code field.';
                }
                field("TN Code"; Rec."TN Code")
                {
                    ToolTip = 'Specifies the value of the TN Code field.';
                }
                field("MICH Code"; Rec."MICH Code")
                {
                    ToolTip = 'Specifies the value of the MICH Code field.';
                }
                field("IBN Code"; Rec."IBN Code")
                {
                    ToolTip = 'Specifies the value of the IBN Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

