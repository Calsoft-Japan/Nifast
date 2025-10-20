tableextension 50047 "Warehouse Setup Ext" extends "Warehouse Setup"
{
    //Version NAVW18.00,NV4.35;
    fields
    {
        field(14017610; "Bin/Package Setup Mandatory"; Boolean)
        {
            Description = 'NV';
        }

        field(14017620; "Pick Task Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(14017680; "RF Count Adj. Template"; Code[10])
        {
            TableRelation = "Warehouse Journal Template".Name WHERE(Type = CONST(Item));
        }

        field(14017681; "RF Count Adj. Batch"; Code[10])
        {
            TableRelation = "Warehouse Journal Batch".Name WHERE("Journal Template Name" = FIELD("RF Count Adj. Template"));
        }

        field(14017686; "RF Cycle Count Template"; Code[10])
        {
            TableRelation = "Warehouse Journal Template".Name WHERE(Type = CONST("Physical Inventory"));
        }

        field(14017687; "RF Cycle Count Batch"; Code[10])
        {
            TableRelation = "Warehouse Journal Batch".Name WHERE("Journal Template Name" = FIELD("RF Cycle Count Template"));
        }

        field(14017999; "License Plate Nos."; Code[10])
        {
            TableRelation = "No. Series";
            CaptionML = ENU = 'License Plate Nos.';
            Description = 'NV';
        }

        field(14018000; "Extended Distribution"; Boolean)
        {
            Description = 'NV';
        }

        field(14018001; "License Plate Tracking"; Boolean)
        {
        }

        field(37015680; "Delivery Load Nos."; Code[10])
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
