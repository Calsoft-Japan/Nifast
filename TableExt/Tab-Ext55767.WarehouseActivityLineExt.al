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
            // cleaned
        }
        field(50024; "Mfg. Lot No."; Code[20])
        {
            // cleaned
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

    }
    trigger OnBeforeInsert()
    begin
        //>>PFC
        GetAssignedID;
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
