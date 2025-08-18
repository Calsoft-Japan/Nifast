tableextension 57320 "Warehouse Shipment Header Ext" extends "Warehouse Shipment Header"
{
    //Version NAVW18.00,NV4.35,NIF.N15.C9IN.001;
    fields
    {
        modify("Assigned User ID")
        {
            trigger OnAfterValidate()
            begin
                //>>PFC
                UpdateWhseShipLines(FIELDCAPTION("Assigned User ID"));
                //<<PFC
            end;
        }
        //TODO
        /* field(37015680; "Delivery Load No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';

            trigger OnValidate();
            var
                WhseShipLine: Record 7321;
                WhseActLine: Record 5767;
                WhseEntry: Record 7312;
                RegWhseActLine: Record 5773;
            begin
                WhseShipLine.LOCKTABLE;
                WhseShipLine.SETRANGE("No.", "No.");
                WhseShipLine.MODIFYALL("Delivery Load No.", "Delivery Load No.");
                WhseActLine.LOCKTABLE;
                WhseActLine.SETRANGE("Activity Type", WhseActLine."Activity Type"::Pick);
                WhseActLine.SETRANGE("Whse. Document Type", WhseActLine."Whse. Document Type"::Shipment);
                WhseActLine.SETRANGE("Whse. Document No.", "No.");
                WhseActLine.MODIFYALL("Delivery Load No.", "Delivery Load No.");
                RegWhseActLine.LOCKTABLE;
                RegWhseActLine.SETRANGE("Activity Type", RegWhseActLine."Activity Type"::Pick);
                RegWhseActLine.SETRANGE("Whse. Document Type", RegWhseActLine."Whse. Document Type"::Shipment);
                RegWhseActLine.SETRANGE("Whse. Document No.", "No.");
                RegWhseActLine.MODIFYALL("Delivery Load No.", "Delivery Load No.");
                WhseEntry.SETRANGE("Whse. Document No.", "No.");
                WhseEntry.SETRANGE("Whse. Document Type", WhseEntry."Whse. Document Type"::Shipment);
                WhseEntry.SETRANGE(Open, TRUE);
                IF NOT WhseEntry.ISEMPTY THEN BEGIN
                    WhseEntry.FIND('-');
                    REPEAT
                    //>> NF1.00:CIS.CM 09-29-15
                    //IF LPN.GET(WhseEntry."License Plate No.") THEN BEGIN
                    //    LPN."Delivery Load No." := "Delivery Load No.";
                    //    LPN."Delivery Load Seq." := "Delivery Load Seq.";
                    //    LPN.MODIFY;
                    //END;
                    //<< NF1.00:CIS.CM 09-29-15
                    UNTIL WhseEntry.NEXT = 0;
                END;
            end;
        } */
        //TODO
    }
    procedure UpdateWhseShipLines(ChangedFieldName: Text[100]);
    var
        WhseShipLine: Record 7321;
    // LinesExist: Boolean;
    begin
        //PFC
        WhseShipLine.Reset();
        WhseShipLine.SETRANGE("No.", "No.");
        IF WhseShipLine.FIND('-') THEN
            REPEAT
                CASE ChangedFieldName OF
                    FIELDCAPTION("Assigned User ID"):
                        begin
                            WhseShipLine."Assigned User ID" := "Assigned User ID";
                            WhseShipLine."Assignment Date" := "Assignment Date";
                            WhseShipLine."Assignment Time" := "Assignment Time";
                        end;
                END;
                WhseShipLine.Modify();
            UNTIL WhseShipLine.Next() = 0;
    end;
}