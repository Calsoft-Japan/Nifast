tableextension 57319 "Posted Whse. Receipt Line Ext" extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(70000; "To Put-away Group Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70001; "To Put-away Template Code"; code[10])
        {
            TableRelation = "Put-away Template Header";
        }
        field(70002; "Special Order Sales No."; code[20])
        {
        }
        field(70003; "Special Order Sales Line No."; Integer)
        {
        }
        field(70004; "External Document No."; code[20])
        {
        }
        field(70005; "Prod. Kit Order No."; code[20])
        {
            Editable = false;
        }
        field(70006; "Prod. Kit Order Line No."; Integer)
        {
            Editable = false;
        }
        field(70007; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70008; "Transfer License Plate No."; Code[20])
        {
            Editable = false;
        }
        field(70009; "QC Hold"; Boolean)
        {
        }
    }
}