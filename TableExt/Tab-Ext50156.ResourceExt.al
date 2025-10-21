tableextension 50156 "Resource Ext" extends "Resource"
{
    fields
    {
        field(60000; "COL Code"; Text[10])
        {
            // cleaned
        }
        field(60005; "MPD Code"; Text[10])
        {
            // cleaned
        }
        field(60010; "LEN Code"; Text[10])
        {
            // cleaned
        }
        field(60015; "SAL Code"; Text[10])
        {
            // cleaned
        }
        field(60020; "TN Code"; Text[10])
        {
            // cleaned
        }
        field(60025; "MICH Code"; Text[10])
        {
            // cleaned
        }
        field(60030; "IBN Code"; Text[10])
        {
            // cleaned
        }
        field(14017610; "Customer Filter"; Code[20])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowFilter;
            TableRelation = customer."No.";
        }
        field(14017761; "Default Purchasing Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Purchasing;
        }
        field(14017905; "Reallocate Cost"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
