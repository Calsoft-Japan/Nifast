page 50032 "Part List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // SM.001 - 09-21-16 ADDED PPAP Approved
    // SM.001 - 10-25-16 ADDED REVISION NO.

    PageType = List;
    SourceTable = Table50029;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Customer No.";"Customer No.")
                {
                }
                field("Customer Name";"Customer Name")
                {
                }
                field("Div Code";"Div Code")
                {
                    Caption = 'Div Code';
                }
                field("Item No.";"Item No.")
                {
                }
                field("Cross Reference No.";"Cross Reference No.")
                {
                }
                field("EC Level";"EC Level")
                {
                }
                field("Applicable Std";"Applicable Std")
                {
                }
                field(EMU;EMU)
                {
                    DecimalPlaces = 0:0;
                }
                field(OEM;OEM)
                {
                }
                field(Model;Model)
                {
                }
                field("Final Customer";"Final Customer")
                {
                }
                field("Pieces Per Vehicle";"Pieces Per Vehicle")
                {
                    DecimalPlaces = 2:2;
                }
                field(Per;Per)
                {
                }
                field(SOP;SOP)
                {
                }
                field(EOP;EOP)
                {
                }
                field(Remarks;Remarks)
                {
                }
                field(Active;Active)
                {
                    Caption = 'Inactive';
                }
                field(SNP;SNP)
                {
                    DecimalPlaces = 0:0;
                }
                field(Selling;Selling)
                {
                    DecimalPlaces = 4:4;
                }
                field(Buying;Buying)
                {
                    DecimalPlaces = 4:4;
                }
                field("Vendor No.";"Vendor No.")
                {
                }
                field("Vendor Name";"Vendor Name")
                {
                }
                field(Manufacturer;Manufacturer)
                {
                }
                field("Flow Item";"Flow Item")
                {
                }
                field("Remark-2";"Remark-2")
                {
                }
                field("PPAP Approved";"PPAP Approved")
                {
                }
                field("Revision No.";"Revision No.")
                {
                }
                field("PPAP Approved Date";"PPAP Approved Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

