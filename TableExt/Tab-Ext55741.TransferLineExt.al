tableextension 55741 "Transfer Line Ext" extends "Transfer Line"
{
    fields
    {
        field(50000; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(51000; "Source PO No."; Code[20])
        {
            Editable = true;
        }
        field(51010; "Contract Note No."; Code[20])
        {
            Editable = true;
        }
        field(51011; "IoT Lot No."; Code[20])
        {
            Description = 'CIS.IoT';
        }
        field(70000; "Whse. Pick Outst. Qty (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70001; "Whse. Pick Outstanding Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70005; "Whse. Ship. Qty (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70006; "Whse. Shipment Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70010; "Invt. Pick Outst. Qty (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70011; "Invt. Pick Outstanding Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(50001; "FB Order No."; Code[20])//NV-FB 37015330->50001 BC Upgrade
        { }
    }
}
