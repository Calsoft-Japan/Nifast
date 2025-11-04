tableextension 50023 "Vendor Ext" extends "Vendor"
{
    fields
    {
        field(50000; "Vessel Info Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50001; "3 Way Currency Adjmt."; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Forex';
        }
        field(70000; "Minimum Order Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(70001; "Minimum Order Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(70002; "Minimum Order Net Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(70003; "Purchase Limit"; Decimal)
        {
        }
        field(70004; "Order Address Code"; code[10])
        {
            TableRelation = "Order Address".Code WHERE("Vendor No." = FIELD("No."));
        }
        field(70005; "Broker/Agent Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70006; "QC Contact"; text[30])
        {
            trigger OnValidate()
            begin
                IF RMSetup.GET THEN
                    IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN
                        IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                            MODIFY;
                            UpdateContFromVend.OnModify(Rec);
                            UpdateContFromVend.InsertNewContactPerson(Rec, FALSE);
                            MODIFY(TRUE);
                        END
            end;
        }
        field(70007; "QC Phone No."; text[30])
        {
        }
        field(70008; "QC Fax No."; text[20])
        {
        }
        field(70009; "QC E-Mail"; text[80])
        {
        }
    }
    var
        RMSetup: Record "Marketing Setup";
        UpdateContFromVend: Codeunit "VendCont-Update";
}



