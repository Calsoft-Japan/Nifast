tableextension 50047 "Warehouse Setup Ext" extends "Warehouse Setup"
{
    //Version NAVW18.00,NV4.35;
    fields
    {
        field(70000; "Bin/Package Setup Mandatory"; Boolean)
        {
            Description = 'NV';
        }

        field(70001; "Pick Task Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(70002; "RF Count Adj. Template"; Code[10])
        {
            TableRelation = "Warehouse Journal Template".Name WHERE(Type = CONST(Item));
        }

        field(70003; "RF Count Adj. Batch"; Code[10])
        {
            TableRelation = "Warehouse Journal Batch".Name WHERE("Journal Template Name" = FIELD("RF Count Adj. Template"));
        }

        field(70004; "RF Cycle Count Template"; Code[10])
        {
            TableRelation = "Warehouse Journal Template".Name WHERE(Type = CONST("Physical Inventory"));
        }

        field(70005; "RF Cycle Count Batch"; Code[10])
        {
            TableRelation = "Warehouse Journal Batch".Name WHERE("Journal Template Name" = FIELD("RF Cycle Count Template"));
        }

        field(70006; "License Plate Nos."; Code[10])
        {
            TableRelation = "No. Series";
            CaptionML = ENU = 'License Plate Nos.';
            Description = 'NV';
        }

        field(70007; "Extended Distribution"; Boolean)
        {
            Description = 'NV';
        }

        field(70008; "License Plate Tracking"; Boolean)
        {
        }

        field(70009; "Delivery Load Nos."; Code[10])
        {
            TableRelation = "No. Series";
            CaptionML = ENU = 'Delivery Load Nos.';
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}
