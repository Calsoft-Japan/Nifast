tableextension 50291 "Shipping Agent Ext" extends "Shipping Agent"
{
    fields
    {
        field(50002;"Mode of Transport";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60000;"COL Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60005;"MPD Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60010;"LEN Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60015;"SAL Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60020;"TN Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60025;"MICH Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60030;"IBN Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}
