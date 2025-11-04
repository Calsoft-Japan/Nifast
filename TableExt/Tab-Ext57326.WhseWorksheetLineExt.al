tableextension 57326 "Whse. Worksheet Line Ext" extends "Whse. Worksheet Line"
{
    fields
    {
        field(70000; "To Put-away Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            begin
                // >> NV - 09-09-03 MV
                IF "To Put-away Group Code" <> '' THEN
                    TESTFIELD("To Put-away Template Code", '');
                // << NV - 09-09-03 MV
            end;
        }
        field(70001; "To Put-away Template Code"; Code[10])
        {
            TableRelation = "Put-away Template Header";
            trigger OnValidate()
            begin
                // >> NV - 09-09-03 MV
                IF "To Put-away Template Code" <> '' THEN
                    TESTFIELD("To Put-away Group Code", '');
                // << NV - 09-09-03 MV
            end;
        }
        field(70002; "Movement Type"; Option)
        {
            OptionCaptionML = ENU = ', Put-Away, Pick, Replinishment';
            OptionMembers = ,"Put-Away",Pick,Replinishment;
        }
        field(70003; "License Plate No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(70004; "QC Hold"; Boolean)
        {
        }
    }
}