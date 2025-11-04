tableextension 57311 "Warehoue Journarl line EXT" extends "Warehouse Journal Line"
{
    fields
    {
        field(14017614; "Special Order Sales No."; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(14017615; "Special Order Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017620; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14017621; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017635; "Applies-to Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                WhseEntry: Record 7312;
            begin
                IF "Applies-to Entry No." <> 0 THEN BEGIN
                    WhseEntry.GET("Applies-to Entry No.");
                    WhseEntry.TESTFIELD(Open, TRUE);
                    IF "Qty. (Base)" <> 0 THEN
                        CASE "Entry Type" OF
                            "Entry Type"::"Positive Adjmt.":
                                WhseEntry.TESTFIELD(Positive, NOT ("Qty. (Base)" > 0));
                            "Entry Type"::"Negative Adjmt.", "Entry Type"::Movement:
                                WhseEntry.TESTFIELD(Positive, "Qty. (Base)" > 0);
                        END;
                    WhseEntry.TESTFIELD("Location Code", "Location Code");
                    IF WhseEntry."Item No." <> "Item No." THEN
                        VALIDATE("Item No.", WhseEntry."Item No.");
                    IF WhseEntry."Variant Code" <> "Variant Code" THEN
                        VALIDATE("Variant Code", WhseEntry."Variant Code");
                    IF WhseEntry."Unit of Measure Code" <> "Unit of Measure Code" THEN
                        VALIDATE("Unit of Measure Code", WhseEntry."Unit of Measure Code");
                    IF WhseEntry."Zone Code" <> "Zone Code" THEN
                        VALIDATE("Zone Code", WhseEntry."Zone Code");
                    IF WhseEntry."Bin Code" <> "Bin Code" THEN
                        VALIDATE("Bin Code", WhseEntry."Bin Code");
                    IF WhseEntry."Lot No." <> "Lot No." THEN
                        VALIDATE("Lot No.", WhseEntry."Lot No.");
                    IF WhseEntry."Serial No." <> "Serial No." THEN
                        VALIDATE("Serial No.", WhseEntry."Serial No.");
                    IF WhseEntry."Expiration Date" <> "Expiration Date" THEN
                        VALIDATE("Expiration Date", WhseEntry."Expiration Date");
                    IF "Qty. (Base)" = 0 THEN BEGIN
                        CASE "Entry Type" OF
                            "Entry Type"::"Positive Adjmt.":
                                IF WhseEntry."Qty. (Base)" <> -"Qty. (Base)" THEN
                                    VALIDATE("Qty. (Base)", -WhseEntry."Qty. (Base)");
                            "Entry Type"::"Negative Adjmt.", "Entry Type"::Movement:
                                IF WhseEntry."Qty. (Base)" <> "Qty. (Base)" THEN
                                    VALIDATE("Qty. (Base)", WhseEntry."Qty. (Base)");
                        END;
                    END;
                END;
                // << NV - 09/11/03 MV
            end;
        }
        field(14017761; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017762; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017999; "From License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14018000; "To License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14018001; "License Plate Operation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU =' ,Create,Movement,Reassign,License Plate Movement';
            OptionMembers = ,Create,Movement,Reassign,"License Plate Movement";
        }
        field(14018003; "To License Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14018004; "From License Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14018005; "License Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
}
