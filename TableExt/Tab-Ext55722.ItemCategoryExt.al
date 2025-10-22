tableextension 55722 "Item Category Ext" extends "Item Category"
{
    fields
    {
        field(14017634; "Def. Purchasing Code"; Code[10])
        {
            TableRelation = Purchasing.Code;
        }
    }
}