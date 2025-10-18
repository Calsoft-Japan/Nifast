page 50098 "License Permission"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "License Permission";
    SourceTableView = SORTING("Object Type", "Object Number")
                      WHERE("Read Permission" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    Caption = 'Object Type';
                }
                field("Object Number"; Rec."Object Number")
                {
                    ToolTip = 'Specifies the value of the Object Number field.';
                    Caption = 'Object Number';
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ToolTip = 'Specifies the value of the Read Permission field.';
                    Caption = 'Read Permission';
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ToolTip = 'Specifies the value of the Insert Permission field.';
                    Caption = 'Insert Permission';
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ToolTip = 'Specifies the value of the Modify Permission field.';
                    Caption = 'Modify Permission';
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ToolTip = 'Specifies the value of the Delete Permission field.';
                    Caption = 'Delete Permission';
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ToolTip = 'Specifies the value of the Execute Permission field.';
                    Caption = 'Execute Permission';
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
                {
                    ToolTip = 'Specifies the value of the Limited Usage Permission field.';
                    Caption = 'Limited Usage Permission';
                }
            }
        }
    }

    actions
    {
    }
}

