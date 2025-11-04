tableextension 50048 "Warehouse Entry Ext" extends "Warehouse Entry"
{
    //Version NAVW18.00,NV4.35,NIF.N15.C9IN.001;
    fields
    {
        field(70000; "Special Order Sales No."; Code[20])
        {
        }

        field(70001; "Special Order Sales Line No."; Integer)
        {
        }

        field(70002; "Posting Date"; Date)
        {
            Description = 'NV-Lot';
        }

        field(70003; "External Document No."; Code[20])
        {
        }

        field(70004; "Remaining Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(70005; "Open"; Boolean)
        {
            Description = 'NV-Lot';
        }

        field(70006; "Positive"; Boolean)
        {
            Description = 'NV-Lot';
        }

        field(70007; "Applies-to Entry No."; Integer)
        {
        }

        field(70008; "Applies-to ID <Not enabled>"; Code[10])
        {
            Description = 'Non enabled -- application for costing method "Specific" not implemented';
        }

        field(70009; "Closed by Entry No."; Integer)
        {
        }

        field(70010; "Closed at Date"; Date)
        {
        }

        field(70011; "Closed by Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(70012; "Prod. Kit Order No."; Code[20])
        {
            Editable = false;
        }

        field(70013; "Prod. Kit Order Line No."; Integer)
        {
            Editable = false;
        }

        field(70014; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
        }

        field(70015; "License Bin"; Boolean)
        {
        }

    }

}