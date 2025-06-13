tableextension 50013 "Salesperson/Purchaser Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000;"Navision User ID";Code[50])
        {
            Caption = 'Navision User ID';
            DataClassification = ToBeClassified;
            Description = 'NIF - created during merge (20 --> 50 NF1.00:CIS.NG  10-10-15)';
            //This property is currently not supported
            //TestTableRelation = false;
            
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
