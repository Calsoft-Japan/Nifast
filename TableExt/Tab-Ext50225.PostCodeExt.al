tableextension 50225 "Post Code Ext" extends "Post Code"
{
    fields
    {
        field(14017626; "NV County"; text[30])
        {
            CaptionML = ENU = 'State';
            trigger OnValidate()
            begin
                "Search County" := County;
            end;
        }
        field(14017627; "Country"; code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(14017628; "Search County"; code[30])
        {
            CaptionML = ENU = 'Search State';
        }
    }
}