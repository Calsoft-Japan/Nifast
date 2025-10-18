page 50074 "Delivery Schedule List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Delivery Schedule";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Delivery Schedule Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Delivery Schedule Batch No."; Rec."Delivery Schedule Batch No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Schedule Batch No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
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

