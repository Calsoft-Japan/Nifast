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
    SourceTable = Table50020;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("Release No.";"Release No.")
                {
                }
                field("Document Function";"Document Function")
                {
                }
                field("Expected Delivery Date";"Expected Delivery Date")
                {
                }
                field("Model Year";"Model Year")
                {
                }
            }
        }
    }

    actions
    {
    }
}

