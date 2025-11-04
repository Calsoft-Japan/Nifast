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
        field(14017620; "Purchase Limit"; Decimal)
        {
        }
        field(14017645; "Order Address Code"; code[10])
        {
            TableRelation = "Order Address".Code WHERE("Vendor No." = FIELD("No."));
        }
        field(14017650; "Broker/Agent Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14018070; "QC Contact"; text[30])
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
        field(14018071; "QC Phone No."; text[30])
        {
        }
        field(14018072; "QC Fax No."; text[20])
        {
        }
        field(14018073; "QC E-Mail"; text[80])
        {
        }
    }
    var
        RMSetup: Record "Marketing Setup";
        UpdateContFromVend: Codeunit "VendCont-Update";
}



