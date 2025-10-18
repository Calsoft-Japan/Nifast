page 50149 "FB Processed Order List"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // 12-14-05 Added "Import Time"

    CardPageID = "FB Processed Order";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FB Header";
    SourceTableView = WHERE(Status = CONST(Processed));

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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Ship-To Code"; Rec."Ship-To Code")
                {
                    ToolTip = 'Specifies the value of the Ship-To Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Import Date"; Rec."Import Date")
                {
                    ToolTip = 'Specifies the value of the Import Date field.';
                }
                field("Import Time"; Rec."Import Time")
                {
                    ToolTip = 'Specifies the value of the Import Time field.';
                }
                field("Import File Name"; Rec."Import File Name")
                {
                    ToolTip = 'Specifies the value of the Import File Name field.';
                }
                field("FB Order Type"; Rec."FB Order Type")
                {
                    ToolTip = 'Specifies the value of the FB Order Type field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Inside Salesperson Code"; Rec."Inside Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Inside Salesperson Code field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

