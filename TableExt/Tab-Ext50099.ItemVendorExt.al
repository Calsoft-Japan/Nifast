tableextension 50099 ItemVendorExt extends "Item Vendor"
{
    fields
    {
        field(14017610; "Minimum Order Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14017611; "Minimum Order Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(14017612; "Minimum Order Net Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14017635; "Vendor Name"; text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            Editable = false;
        }
        field(14017636; "Note"; text[50])
        {
        }
        field(14018070; "Waive QC Hold"; Boolean)
        {
            trigger onvalidate()
            var
                UserSetup: Record "User Setup";
            begin
                //>> NV
                //also check user setup
                IF NOT UserSetup.GET(USERID) THEN
                    ERROR('You are not set up to edit this field.');

                IF (("Waive QC Hold") AND (NOT UserSetup."Edit QC Hold - On")) OR
                   ((NOT "Waive QC Hold") AND (NOT UserSetup."Edit QC Hold - Off")) THEN
                    ERROR('You are not authorized to change the value of this field.');

                //>> NF1.00:CIS.CM 09-29-15
                //QCMgmt.UpdateQCWaiverFromItemVend(Rec,"Waive QC Hold",FALSE);
                UpdateQCWaiverFromItemVend(Rec, "Waive QC Hold", FALSE);
                //<< NF1.00:CIS.CM 09-29-15
                //<< NV
            end;
        }
    }
    keys
    {
        key(Key50000; "Item No.", "Vendor No.")
        {
        }
    }
}
