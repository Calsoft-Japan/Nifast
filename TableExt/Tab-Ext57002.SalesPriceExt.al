tableextension 57002 "Sales Price Ext" extends "Sales Price"
{
    fields
    {
        field(50000; "Customer Cross Ref No."; Code[30])
        {
            Editable = false;
        }
        field(50001; "Customer Cross Ref. Desc."; Text[50])
        {
            Editable = false;
        }
        field(50002; "Flow Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(50003; "Flow Vendor No."; Code[10])
        {
            // cleaned
        }
        field(50005; "Revision No."; Code[10])
        {
            // cleaned
        }
        field(50010; "No. of Customer Bins"; Integer)
        {
            // cleaned
        }
        field(50011; "Default Customer Bin Code"; Code[20])
        {
            Description = 'Added on 07/30/15 by CIS.RAM';
        }

        field(50004; "Contract No."; Code[20])//NV 14017645->50004 BC Upgrade
        { }
        field(50006; "Customer Bin"; Code[20])//NV 14017662->50006 BC Upgrade
        { }
    }
}
