page 50071 "Delivery Schedule Batch"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table50020;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Horizon Start Date";"Horizon Start Date")
                {
                }
                field("Horizon End Date";"Horizon End Date")
                {
                }
            }
            group("Material Issuer")
            {
                Caption = 'Material Issuer';
                field("Material Issuer No.";"Material Issuer No.")
                {
                }
                field("Material Issuer Name";"Material Issuer Name")
                {
                }
                field("Material Issuer Name 2";"Material Issuer Name 2")
                {
                }
                field("Material Issuer Address";"Material Issuer Address")
                {
                }
                field("Material Issuer Address 2";"Material Issuer Address 2")
                {
                }
                field("Material Issuer City";"Material Issuer City")
                {
                }
                field("Material Issuer State";"Material Issuer State")
                {
                    Caption = 'Material Issuer State / Sip Code';
                }
                field("Material Issuer Postal Code";"Material Issuer Postal Code")
                {
                }
                field("Material Issuer Country Code";"Material Issuer Country Code")
                {
                }
            }
            group(Supplier)
            {
                Caption = 'Supplier';
                field("Supplier No.";"Supplier No.")
                {
                }
                field("Supplier Name";"Supplier Name")
                {
                }
                field("Supplier Name 2";"Supplier Name 2")
                {
                }
                field("Supplier Address";"Supplier Address")
                {
                }
                field("Supplier Address 2";"Supplier Address 2")
                {
                }
                field("Supplier City";"Supplier City")
                {
                }
                field("Supplier State";"Supplier State")
                {
                    Caption = 'Supplier State / ZIP Code';
                }
                field("Supplier Postal Code";"Supplier Postal Code")
                {
                }
                field("Supplier Country Code";"Supplier Country Code")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Schedule Batch")
            {
                Caption = 'Schedule Batch';
                separator()
                {
                }
                action("Delivery Schedules")
                {
                    Caption = 'Delivery Schedules';
                    RunObject = Page 50073;
                    RunPageLink = Delivery Schedule Batch No.=FIELD(No.),
                                  Customer No.=FIELD(Customer No.);
                }
            }
        }
    }
}

