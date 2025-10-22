tableextension 57326 "Whse. Worksheet Line Ext" extends "Whse. Worksheet Line"
{
    fields
    {
        field(14017610; "To Put-away Group Code"; Code[10])
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
        field(14017611; "To Put-away Template Code"; Code[10])
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
        field(14017992; "Movement Type"; Option)
        {
            OptionCaptionML = ENU = ', Put-Away, Pick, Replinishment';
            OptionMembers = ,"Put-Away",Pick,Replinishment;
        }
        field(14017999; "License Plate No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(14018070; "QC Hold"; Boolean)
        {
        }
    }
}