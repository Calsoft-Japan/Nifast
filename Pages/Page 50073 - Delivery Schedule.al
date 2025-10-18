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
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Delivery Schedule Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Model Year"; Rec."Model Year")
                {
                    ToolTip = 'Specifies the value of the Model Year field.';
                }
                field("Order Reference No."; Rec."Order Reference No.")
                {
                    ToolTip = 'Specifies the value of the Order Reference No. field.';
                }
                field("Quantity CYTD"; Rec."Quantity CYTD")
                {
                    ToolTip = 'Specifies the value of the Quantity CYTD field.';
                }
                field("Release Number"; Rec."Release Number")
                {
                    ToolTip = 'Specifies the value of the Release Number field.';
                }
                field("Receiving Dock Code"; Rec."Receiving Dock Code")
                {
                    ToolTip = 'Specifies the value of the Receiving Dock Code field.';
                }
                field("Stockman Code"; Rec."Stockman Code")
                {
                    ToolTip = 'Specifies the value of the Stockman Code field.';
                }
                field("Unit of Measure CYTD"; Rec."Unit of Measure CYTD")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure CYTD field.';
                }
                field("Start Date CYTD"; Rec."Start Date CYTD")
                {
                    ToolTip = 'Specifies the value of the Start Date CYTD field.';
                }
                field("End Date CYTD"; Rec."End Date CYTD")
                {
                    ToolTip = 'Specifies the value of the End Date CYTD field.';
                }
                field("Quantity Shipped CYTD"; Rec."Quantity Shipped CYTD")
                {
                    ToolTip = 'Specifies the value of the Quantity Shipped CYTD field.';
                }
                field("Unit of Measure Shipped CYTD"; Rec."Unit of Measure Shipped CYTD")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Shipped CYTD field.';
                }
                field("Start Date Shipped CYTD"; Rec."Start Date Shipped CYTD")
                {
                    ToolTip = 'Specifies the value of the Start Date Shipped CYTD field.';
                }
                field("End Date Shipped CYTD"; Rec."End Date Shipped CYTD")
                {
                    ToolTip = 'Specifies the value of the End Date Shipped CYTD field.';
                }
            }
            part(DeliveryScheduleSubform; "Delivery Schedule Subform")
            {
                SubPageLink = "Delivery Schedule Batch No." = FIELD("Delivery Schedule Batch No."),
                              "Customer No." = FIELD("Customer No."),
                              "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

