table 50013 "Delivery Schedule Line"
{
    // //>> NIF
    // Fields Added:
    //   50000 Item No.
    //   50001 Model Year
    // Fields Modified:
    //   12 Forecast Quantity (Type=Decimal)
    // Keys Added:
    //   Delivery Schedule Batch No.,Expected Delivery Date,Item No.,Model Year
    // 
    // Date    Init    Proj   Description
    // 111505  RTT   #10477   new fields 50000..50001,change Forecase Quantity from Integer to Decimal
    // 111505  RTT   #10477   new key w/SumIndexField
    // //<< NIF

    fields
    {
        field(1; "Delivery Schedule Batch No."; Code[20])
        {
            // cleaned
        }
        field(2; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            // cleaned
        }
        field(4; "Line No."; Integer)
        {
            // cleaned
        }
        field(10; Type; Option)
        {
            OptionMembers = " ",Firm,"Commitment for Manufacturing","Commitment for Material",Planning;
        }
        field(11; Frequency; Option)
        {
            OptionMembers = " ",Weekly,Flexible;
        }
        field(12; "Forecast Quantity"; Decimal)
        {
            // cleaned
        }
        field(13; "Expected Delivery Date"; Date)
        {
            // cleaned
        }
        field(14; "Start Date"; Date)
        {
            // cleaned
        }
        field(15; "End Date"; Date)
        {
            // cleaned
        }
        field(1010; "Type Code"; Integer)
        {
            trigger OnValidate()
            begin
                CASE "Type Code" OF
                    1:
                        Type := Type::Firm;
                    4:
                        Type := Type::Planning;
                END;
            end;
        }
        field(1011; "Frequency Code"; Text[10])
        {
            trigger OnValidate()
            begin
                CASE "Frequency Code" OF
                    'W':
                        Frequency := Frequency::Weekly;
                    'F':
                        Frequency := Frequency::Flexible;
                END;
            end;
        }
        field(1012; "Forecast Unit of Measure"; Text[10])
        {
            // cleaned
        }
        field(50000; "Item No."; Code[20])
        {
            // cleaned
        }
        field(50001; "Model Year"; Code[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Delivery Schedule Batch No.", "Customer No.", "Document No.", "Line No.")
        {
        }
        key(Key2; "Delivery Schedule Batch No.", "Expected Delivery Date", "Item No.", "Model Year")
        {
            SumIndexFields = "Forecast Quantity";
        }
    }

    fieldgroups
    {
    }

}
