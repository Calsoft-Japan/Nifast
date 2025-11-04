pageextension 50121 "G/L Budget Ext" extends "G/L Budget Names"
{
    actions
    {
        addafter(EditBudget)
        {
            action("RunCustomerExport")
            {
                ApplicationArea = All;
                Caption = 'Import From Excel';
                Image = Export;
                ToolTip = '';

                trigger OnAction()
                begin
                    XmlPort.Run(50031, true, false);
                end;
            }
        }
    }
}
