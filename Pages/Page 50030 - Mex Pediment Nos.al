page 50030 "Mex Pediment Nos"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Mex Export Pediment";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Pedimento Virtual No."; Rec."Pedimento Virtual No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Pedimento Virtual No. field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create New")
            {
                Caption = 'Create New';
                Promoted = true;
                Image = Create;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "Mex Pediment Card";
                ToolTip = 'Executes the Create New action.';
            }
            action("Calsonic|K-MEX")
            {
                Caption = 'Calsonic|K-MEX';
                Promoted = true;
                Image = Invoice;
                PromotedCategory = Process;
                RunObject = Page "Commercial Invoice Mex Form";
                ToolTip = 'Executes the Calsonic|K-MEX action.';
            }
        }
    }
}

