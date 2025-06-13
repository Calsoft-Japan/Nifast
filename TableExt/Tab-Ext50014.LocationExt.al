tableextension 50014 "Location Ext" extends "Location"
{
    fields
    {
        field(50000;"Print Labels Upon Receipt";Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60000;"COL Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60005;"MPD Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60010;"LEN Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60015;"SAL Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60020;"TN Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60025;"MICH Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60030;"IBN Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
    }
}
