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
        field(70000; "Carrier Trailer ID"; Code[20])
        {
        }

        field(70001; "Destination Code"; Code[10])
        {
            CaptionML = ENU = 'Destination Code';
            Editable = false;
            FieldClass = FlowField;
            // CalcFormula = Lookup("Warehouse Shipment Line".Field3427764 WHERE("No." = FIELD("No.")));//TODO
            TableRelation = IF ("Destination Type" = FILTER(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Destination No."))
            ELSE IF ("Destination Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Destination No."));
            trigger OnValidate()
            VAR
            // SellToCustTemplate: Record 5105;
            BEGIN
            END;

        }

        field(70002; "Total Ship Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship" WHERE("No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(70003; "Placed In Whse. Queue"; Boolean)
        {
        }

        field(70004; "Destination Name"; Text[50])
        {
            Editable = false;
        }

        field(70005; "Destination Type"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Shipment Line"."Destination Type" WHERE("No." = FIELD("No.")));
            CaptionML = ENU = 'Destination Type';
            OptionCaptionML = ENU = ' ,Customer,Vendor,Location';
            OptionMembers = " ",Customer,Vendor,Location;
            Editable = false;
        }

        field(70006; "Destination No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Shipment Line"."Destination No." WHERE("No." = FIELD("No.")));
            CaptionML = ENU = 'Destination No.';
            Editable = false;
        }

        field(70007; "Delivery Load No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            VAR
                WhseShipLine: Record 7321;
                WhseActLine: Record 5767;
                WhseEntry: Record 7312;
                RegWhseActLine: Record 5773;
            BEGIN
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
                    // LPN processing commented
                    UNTIL WhseEntry.NEXT = 0;
                END;
            END;

        }

        field(70008; "Delivery Load Seq."; Code[20])
        {
        }

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