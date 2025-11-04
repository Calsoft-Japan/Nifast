tableextension 50225 "Post Code Ext" extends "Post Code"
{
    fields
    {
        field(70000; "NV County"; text[30])
        {
            CaptionML = ENU = 'State';
            trigger OnValidate()
            begin
                "Search County" := County;
            end;
        }
        field(70001; "Country"; code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(70002; "Search County"; code[30])
        {
            CaptionML = ENU = 'Search State';
        }
    }
}