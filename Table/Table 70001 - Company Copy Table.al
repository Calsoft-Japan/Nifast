table 70001 "Company Copy Table"
{
    fields
    {
        field(1;"Template Name";Code[10])
        {
            NotBlank = true;
        }
        field(2;"Table No.";Integer)
        {
            // cleaned
        }
        field(3;Name;Text[30])
        {
            Editable = false;
        }
        field(4;"Fields";Integer)
        {
            Editable = false;
        }
        field(5;"Order";Integer)
        {
            // cleaned
        }
        field(6;"Exist Action";Option)
        {
            OptionMembers = Skip,Modify;
        }
        field(7;"Validate OnModify Trigger";Boolean)
        {
            // cleaned
        }
        field(8;"Validate OnInsert Trigger";Boolean)
        {
            // cleaned
        }
        field(9;"Skip if Equal Num. of Records";Boolean)
        {
            // cleaned
        }
    }
}
