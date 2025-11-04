tableextension 50048 "Warehouse Entry Ext" extends "Warehouse Entry"
{
    //Version NAVW18.00,NV4.35,NIF.N15.C9IN.001;
    fields
    {
        field(14017614; "Special Order Sales No."; Code[20])
        {
        }

        field(14017615; "Special Order Sales Line No."; Integer)
        {
        }

        field(14017620; "Posting Date"; Date)
        {
            Description = 'NV-Lot';
        }

        field(14017621; "External Document No."; Code[20])
        {
        }

        field(14017631; "Remaining Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017632; "Open"; Boolean)
        {
            Description = 'NV-Lot';
        }

        field(14017633; "Positive"; Boolean)
        {
            Description = 'NV-Lot';
        }

        field(14017635; "Applies-to Entry No."; Integer)
        {
        }

        field(14017636; "Applies-to ID <Not enabled>"; Code[10])
        {
            Description = 'Non enabled -- application for costing method "Specific" not implemented';
        }

        field(14017640; "Closed by Entry No."; Integer)
        {
        }

        field(14017641; "Closed at Date"; Date)
        {
        }

        field(14017643; "Closed by Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017761; "Prod. Kit Order No."; Code[20])
        {
            Editable = false;
        }

        field(14017762; "Prod. Kit Order Line No."; Integer)
        {
            Editable = false;
        }

        field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
        }

        field(14018002; "License Bin"; Boolean)
        {
        }

    }

}