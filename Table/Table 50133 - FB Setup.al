table 50133 "FB Setup"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            // cleaned
        }
        field(20; "Order Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(30; "Tag Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(40; "Import Data Log Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50; "Req. Worksheet Template"; Code[10])
        {
            // cleaned
            TableRelation = "Req. Wksh. Template".Name WHERE(Type = CONST("Req."));
        }
        field(51; "Req. Worksheet Name"; Code[10])
        {
            // cleaned
            TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Req. Worksheet Template"));
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}
