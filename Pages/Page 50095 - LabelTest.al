page 50095 LabelTest
{
    ApplicationArea = All;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field(CompanyInformation; DATABASE::"Company Information")
            {
                ToolTip = 'Specifies the value of the DATABASE::Company Information field.';
                Caption = 'DATABASE::Company Information';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(RUn)
            {
                ToolTip = 'Executes the RUn action.';
                Image = Process;
                trigger OnAction()
                begin
                    MESSAGE('%1', FORMAT(1) + '-' + 'DONE' + '-' + DELCHR(FORMAT(CURRENTDATETIME), '=', '/\:') + '.txt');
                end;
            }
        }
    }
}

