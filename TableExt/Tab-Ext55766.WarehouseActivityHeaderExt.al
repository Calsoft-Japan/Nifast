tableextension 55766 "Warehouse Activity Header Ext" extends "Warehouse Activity Header"
{
    fields
    {
        field(50000; "Blanket Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const("Blanket Order"));
        }
    }
}
