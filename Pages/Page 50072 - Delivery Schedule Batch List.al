page 50072 "Delivery Schedule Batch List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // //>> NIF
    // Fields Added:
    //   Model Year
    // 
    // Date   Init   Proj   Desc
    // 111505 RTT  #10477   new field "Model Year"
    // //<< NIF

    CardPageID = "Delivery Schedule Batch";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Delivery Schedule Batch";

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
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Release No."; Rec."Release No.")
                {
                    ToolTip = 'Specifies the value of the Release No. field.';
                }
                field("Document Function"; Rec."Document Function")
                {
                    ToolTip = 'Specifies the value of the Document Function field.';
                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Expected Delivery Date field.';
                }
                field("Model Year"; Rec."Model Year")
                {
                    ToolTip = 'Specifies the value of the Model Year field.';
                }
            }
        }
    }

    actions
    {
    }
}

