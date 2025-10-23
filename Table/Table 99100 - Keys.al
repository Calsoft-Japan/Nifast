table 99100 "Keys"
{
    fields
    {
        field(1; "Table No."; Integer)
        {
            // cleaned
        }
        field(2; "Key No."; Integer)
        {
            // cleaned
        }
        field(3; Enabled; Boolean)
        {
            // cleaned
        }
        field(10; "Key Fields"; Text[250])
        {
            // cleaned
        }
        field(11; "Key Fields 2"; Text[250])
        {
            // cleaned
        }
        field(20; "Sum Index Fields"; Text[250])
        {
            // cleaned
        }
        field(30; "Maintain SIFT Levels"; Boolean)
        {
            // cleaned
            CalcFormula = Exist("SIFT Levels" WHERE("Table No."=FIELD("Table No."),
                                                     "Key No."=FIELD("Key No.")));
            FieldClass = FlowField;
        }
        field(40;"Maintain SQL Index";Boolean)
        {
            // cleaned
        }
        field(41;"SIFT Levels Enabled";Integer)
        {
            // cleaned
            FieldClass = Normal;
        }
    }
     keys
    {
        key(Key1;"Table No.","Key No.",Enabled)
        {
        }
    }

    fieldgroups
    {
    }
}
