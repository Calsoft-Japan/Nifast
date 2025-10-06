page 50007 "Sales Shpt. Line Spec. Fields"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    Permissions = TableData 111=rm;
    SourceTable = Table111;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(;'')
                {
                    CaptionClass = FORMAT ('Posted Shipment ' + "Document No.");
                    Editable = false;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("No.";"No.")
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Box Weight";"Box Weight")
                {
                }
                field("Certificate No.";"Certificate No.")
                {
                }
                field("Container No.";"Container No.")
                {
                }
                field("External Document No.";"External Document No.")
                {
                    Caption = 'Customer P.O. No.';
                }
                field("Dock Code";"Dock Code")
                {
                }
                field("Deliver To";"Deliver To")
                {
                }
                field("Delivery Order No.";"Delivery Order No.")
                {
                }
                field("Eng. Change No.";"Eng. Change No.")
                {
                }
                field("FRS No.";"FRS No.")
                {
                }
                field("Group Code";"Group Code")
                {
                }
                field("Kanban No.";"Kanban No.")
                {
                }
                field("Line Side Address";"Line Side Address")
                {
                }
                field("Line Supply Location";"Line Supply Location")
                {
                }
                field("Location Code";"Location Code")
                {
                    Editable = false;
                }
                field(Quantity;Quantity)
                {
                    Editable = false;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Editable = false;
                }
                field("Main Route";"Main Route")
                {
                }
                field("Man No.";"Man No.")
                {
                }
                field("Mfg. Date";"Mfg. Date")
                {
                }
                field("Model Year";"Model Year")
                {
                }
                field("Plant Code";"Plant Code")
                {
                }
                field("Ran No.";"Ran No.")
                {
                }
                field("Receiving Area";"Receiving Area")
                {
                }
                field("Release No.";"Release No.")
                {
                }
                field("Res. Mfg.";"Res. Mfg.")
                {
                }
                field("Revision No. (Label Only)";"Revision No. (Label Only)")
                {
                }
                field("Special Markings";"Special Markings")
                {
                }
                field("Storage Location";"Storage Location")
                {
                }
                field("Store Address";"Store Address")
                {
                }
                field("Sub Route Number";"Sub Route Number")
                {
                }
            }
        }
    }

    actions
    {
    }
}

