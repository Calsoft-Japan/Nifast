tableextension 55767 "Warehouse Activity Line Ext" extends "Warehouse Activity Line"
{
    fields
    {
        field(50020; "Cert Required"; Boolean)
        {
            Editable = false;
        }
        field(50023; "PFC Lot No."; Code[20])
        {

        }
        field(50024; "Mfg. Lot No."; Code[20])
        {

        }
        field(50030; "Units per Parcel"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50031; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(60002; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            Editable = false;
        }
        field(60004; "Assignment Date"; Date)
        {
            Caption = 'Assignment Date';
            Editable = false;
        }
        field(60005; "Assignment Time"; Time)
        {
            Caption = 'Assignment Time';
            Editable = false;
        }
        field(14017610; "To Put-away Group Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                // >> NV - 09-09-03 MV
                IF "To Put-away Group Code" <> '' THEN
                    TESTFIELD("To Put-away Template Code", '');
                // << NV - 09-09-03 MV
            end;
        }
        field(14017611; "To Put-away Template Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Put-away Template Header";
            trigger OnValidate()
            begin
                // >> NV - 09-09-03 MV
                IF "To Put-away Template Code" <> '' THEN
                    TESTFIELD("To Put-away Group Code", '');
                // << NV - 09-09-03 MV
            end;
        }
        field(14017614; "Special Order Sales No."; Code[20])
        {
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
        field(14017630; "Pick Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017631; "Task Priority"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017640; "Skip Pick"; Boolean)
        {
            DataClassification = ToBeClassified;
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
        field(14017990; "Qty. to Handle Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(14017991; "Bin Available Capacity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14017994; "Zone Pick Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14017996; "Pick Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017998; "License Qty. to Handle"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14017999; "License Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = IF ("Action Type" = FILTER(Take)) "License Plate"."License Plate No." WHERE("Current Zone" = FIELD("Zone Code"),
            //                                                                                                                               "Current Bin" = FIELD("Bin Code"))
            // ELSE IF ("Action Type" = FILTER(Place)) "License Plate"."License Plate No.";//TODO
            trigger OnValidate()
            var
                BinContent: Record 7302;
                AvailQty: Decimal;
                IST001: Label 'ENU=There are no available quantity in the Bin Content with the filter %1.', Comment = '%1';
                IST002: Label 'ENU=They Qty. (Base) %1 that is being moved for License Plate No. %2 is out of balance. Available Qty. %3.', Comment = '%1 %2 %3';
            begin
                //      {
                //                                                 IF "License Plate No." <> '' THEN BEGIN
                //     IF ("Action Type" = "Action Type"::Take) THEN BEGIN
                //         CLEAR(BinContent);
                //         BinContent.SETRANGE("Location Code", "Location Code");
                //         BinContent.SETRANGE("Zone Code", "Zone Code");
                //         BinContent.SETRANGE("Bin Code", "Bin Code");
                //         BinContent.SETRANGE("Item No.", "Item No.");
                //         BinContent.SETRANGE("Variant Code", "Variant Code");
                //         BinContent.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                //         IF ("License Plate No." <> '') THEN
                //             BinContent.SETFILTER("License Plate No. Filter", "License Plate No.")
                //         ELSE
                //             BinContent.SETFILTER("License Plate No. Filter", '%1', '');
                //         IF NOT BinContent.ISEMPTY THEN BEGIN
                //             BinContent.FIND('-');
                //             BinContent.CALCFIELDS(Quantity, "Pick Qty.", "Neg. Adjmt. Qty.");
                //             AvailQty := (BinContent.Quantity - BinContent."Pick Qty." - BinContent."Neg. Adjmt. Qty.") +
                //               "Qty. Outstanding";
                //             IF AvailQty < 0 THEN
                //                 ERROR(IST001, BinContent.GETFILTERS);
                //         END ELSE
                //             ERROR(IST001, BinContent.GETFILTERS);
                //     END;
                //     LicensePlate.GET("License Plate No.");
                //     "Delivery Load No." := LicensePlate."Delivery Load No.";
                // END;
                //                                                 }

            end;
        }
        field(37015680; "Delivery Load No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }
    trigger OnBeforeInsert()
    begin
        //>>PFC
        GetAssignedID();
        //<<PFC
    end;

    PROCEDURE GetAssignedID();
    VAR
        WhseActHeader: Record 5766;
    BEGIN
        IF WhseActHeader.GET("Activity Type", "No.") THEN BEGIN
            "Assigned User ID" := WhseActHeader."Assigned User ID";
            "Assignment Date" := WhseActHeader."Assignment Date";
            "Assignment Time" := WhseActHeader."Assignment Time";
        END;
    END;

}
