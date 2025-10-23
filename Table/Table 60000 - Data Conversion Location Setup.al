table 60000 "Data Conversion Location Setup"
{
    fields
    {
        field(10; "Location Code"; Code[20])
        {
            // cleaned
            TableRelation = Location;
        }
        field(11; "Cust. No. Series"; Code[20])
        {
            // cleaned
        }
        field(12; "Location Name"; Text[50])
        {
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cust . No. Series Name"; Text[30])
        {
            // cleaned
            CalcFormula = Lookup("No. Series".Description WHERE(Code = FIELD("Cust. No. Series")));
            FieldClass = FlowField;
        }
        field(14; "Freight Resource"; Code[20])
        {
            // cleaned
            TableRelation = Resource;
        }
        field(20; Prefix; Code[10])
        {
            // cleaned
        }
        field(30; "AR Order No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(31; "AR Posted Invoice No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(32; "AR Posted Shipment No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(36; "AR Cr.Memo No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(37; "AR Posted Cr.Memo No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(60; "PO Order No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(61; "PO Posted Invoice No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(62; "PO Posted Receipt No. Series"; Code[20])
        {
            // cleaned
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Location Code")
        {
        }
    }

    fieldgroups
    {
    }
}
