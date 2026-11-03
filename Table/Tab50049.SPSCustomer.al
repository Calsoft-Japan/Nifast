table 50049 "SPS Customer"
{
    Caption = 'SPS Customer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(2; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            fieldClass = flowfield;
            CalcFormula = Lookup("Customer".Name WHERE("No." = FIELD("Customer No.")));
        }
    }
    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }
}
