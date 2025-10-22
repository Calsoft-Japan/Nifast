tableextension 57319 "Posted Whse. Receipt Line Ext" extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(14017610; "To Put-away Group Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017611; "To Put-away Template Code"; code[10])
        {
            TableRelation = "Put-away Template Header";
        }
        field(14017614; "Special Order Sales No."; code[20])
        {
        }
        field(14017615; "Special Order Sales Line No."; Integer)
        {
        }
        field(14017621; "External Document No."; code[20])
        {
        }
        field(14017761; "Prod. Kit Order No."; code[20])
        {
            Editable = false;
        }
        field(14017762; "Prod. Kit Order Line No."; Integer)
        {
            Editable = false;
        }
        field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14018000; "Transfer License Plate No."; Code[20])
        {
            Editable = false;
        }
        field(14018070; "QC Hold"; Boolean)
        {
        }
    }
}