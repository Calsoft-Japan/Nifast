page 50073 "Delivery Schedule"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // //>> NIF
    // Controls Modified:
    //   Subform (HorzGlue=Both,VertGlue=Both)
    // 
    // Date    Init   Proj   Desc
    // 111505  RTT  #10477   modified Subform controls
    // //<< NIF

    InsertAllowed = false;
    PageType = Document;
    SourceTable = Table50012;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Delivery Schedule Batch No.";"Delivery Schedule Batch No.")
                {
                }
                field("Customer No.";"Customer No.")
                {
                }
                field("No.";"No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Model Year";"Model Year")
                {
                }
                field("Order Reference No.";"Order Reference No.")
                {
                }
                field("Quantity CYTD";"Quantity CYTD")
                {
                }
                field("Release Number";"Release Number")
                {
                }
                field("Receiving Dock Code";"Receiving Dock Code")
                {
                }
                field("Stockman Code";"Stockman Code")
                {
                }
                field("Unit of Measure CYTD";"Unit of Measure CYTD")
                {
                }
                field("Start Date CYTD";"Start Date CYTD")
                {
                }
                field("End Date CYTD";"End Date CYTD")
                {
                }
                field("Quantity Shipped CYTD";"Quantity Shipped CYTD")
                {
                }
                field("Unit of Measure Shipped CYTD";"Unit of Measure Shipped CYTD")
                {
                }
                field("Start Date Shipped CYTD";"Start Date Shipped CYTD")
                {
                }
                field("End Date Shipped CYTD";"End Date Shipped CYTD")
                {
                }
            }
            part(;50075)
            {
                SubPageLink = Delivery Schedule Batch No.=FIELD(Delivery Schedule Batch No.),
                              Customer No.=FIELD(Customer No.),
                              Document No.=FIELD(No.);
            }
        }
    }

    actions
    {
    }
}

