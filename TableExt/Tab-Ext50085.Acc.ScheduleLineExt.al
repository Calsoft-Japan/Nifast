tableextension 50085 "Acc. Schedule Line Ext" extends "Acc. Schedule Line"
{
    fields
    {
        field(50000; "SAT Account Code"; Code[10])
        {
            Description = 'CE 1.2';
            TableRelation = "SAT Account Codes";
            trigger OnValidate()
            begin
                //>> CE 1.2
                IF SATAccCode.GET("SAT Account Code") THEN
                    "SAT Level" := SATAccCode.Level
                ELSE
                    "SAT Level" := 0;
                //<< CE 1.2
            end;


        }
        field(50001; "SAT Level"; Integer)
        {
            Caption = 'Level';
            Description = 'CE 1.2';
        }
        field(50002; "SAT Nature"; Option)
        {
            Caption = 'Nature';
            Description = 'CE  1.2';
            OptionCaption = ' ,D,A';
            OptionMembers = " ",D,A;
        }
    }
    var
        "//>>CE 1.2": Integer;
        SATAccCode: Record 50032;

}
