tableextension 70018 LAXManifestLine_NF extends "LAX Manifest Line"
{
    fields
    {
        field(50000; "Bill of Lading No."; Code[20])
        {
            Editable = false;
            TableRelation = "LAX Bill of Lading";

            trigger OnLookup()
            var
                BillofLading: Record 14000822;
            begin
                IF BillOfLading.GET("Bill of Lading No.") THEN BEGIN
                    IF BillOfLading.Posted THEN
                        PAGE.RUNMODAL(PAGE::"LAX Posted Bill of Lading", BillOfLading)
                    ELSE
                        PAGE.RUNMODAL(PAGE::"LAX Bill of Lading", BillOfLading);
                END;
            end;
        }
        field(50003; "ASN Order"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("LAX Bill of Lading"."EDI ASN" WHERE("No." = FIELD("Bill of Lading No.")));
            Editable = false;

        }
        field(50004; "ASN Generated"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("LAX Bill of Lading"."EDI ASN Generated" WHERE("No." = FIELD("Bill of Lading No.")));
            Editable = false;

        }
        field(50010; Cartons; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }

    }
}
