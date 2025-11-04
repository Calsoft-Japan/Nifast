tableextension 50014 "Location Ext" extends "Location"
{
    fields
    {
        field(50000; "Print Labels Upon Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60000; "COL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60005; "MPD Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60010; "LEN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60015; "SAL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60020; "TN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60025; "MICH Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60030; "IBN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(14017610; "Default by Zone Pickingr"; Boolean)
        {
            Description = 'NV';
        }
        field(14017931; "Rework Location Code"; Code[10])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false));
            Description = 'NV';
        }
        field(14017932; "Rework In-Transit Code"; Code[10])
        {
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
            Description = 'NV';
        }
        field(14017990; "Staging Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(14017996; "Break Pick when Qty. on Hand"; Option)
        {
            OptionMembers = ,">= Min. Qty. (no split pick)","= Max. Qty. (allow split pick)";
            Description = 'NV';
        }
        field(14018070; "Inbound QC Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code), "QC Bin" = FILTER(true));
            Description = 'NV';
        }
        field(14018071; "Outbound QC Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(14018072; "QC RTV Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(14018073; "QC Rework Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code), "QC Bin" = FILTER(true));
            Description = 'NV';
        }
        field(14018074; "QC First Article Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(14018075; "QC Receipt Bin Code"; Code[20])
        {
            CaptionML = ENU = 'QC Receipt Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code), "QC Bin" = CONST(true));
            Description = 'NV';
        }
        field(37015590; "Transfer Inbound Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Header" WHERE("Transfer-to Code" = FIELD(Code),
                                                                                              "In-Transit Lines" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015591; "Transfer Inbound Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Line"."In-Transit Gross Weight" WHERE("Transfer-to Code" = FIELD(Code)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015592; "Transfer Inbound Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Line" WHERE("Transfer-to Code" = FIELD(Code),
                                                                                            "Qty. in Transit (Base)" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015593; "Transfer Outbound Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Header" WHERE("Transfer-from Code" = FIELD(Code),
                                                                                        Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(37015594; "Transfer Outbound Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Line"."Outstanding Gross Weight" WHERE("Transfer-from Code" = FIELD(Code),
                                                                                                                Status = CONST(Released)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015595; "Transfer Outbound Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Line" WHERE("Transfer-from Code" = FIELD(Code),
                                                                                            Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(37015596; "Sale Orders Open Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                                                           "Location Code" = FIELD(Code),
                                                                                           Status = CONST(Open)));
            Description = 'NV';
            Editable = false;
        }
        field(37015597; "Sale Orders Open Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Gross Weight" WHERE("Document Type" = CONST(Order),
                                                                                                                  "Location Code" = FIELD(Code),
                                                                                                                  Status = CONST(Open),
                                                                                                                  "Outstanding Quantity" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015598; "Sale Orders Open Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Line" WHERE("Document Type" = CONST(Order),
                                                                                         "Location Code" = FIELD(Code),
                                                                                         Status = CONST(Open),
                                                                                         "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015599; "Sale Orders Released Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                                                           "Location Code" = FIELD(Code),
                                                                                           Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(37015600; "Sale Orders Released Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Gross Weight" WHERE("Document Type" = CONST(Order),
                                                                                                                  "Location Code" = FIELD(Code),
                                                                                                                  Status = CONST(Released),
                                                                                                                  "Outstanding Quantity" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015601; "Sale Orders Released Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Line" WHERE("Document Type" = CONST(Order),
                                                                                         "Location Code" = FIELD(Code),
                                                                                         Status = CONST(Released),
                                                                                         "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015602; "Purch. Orders Released Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order),
                                                                                              "Location Code" = FIELD(Code),
                                                                                              Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(37015603; "Purch. Orders Released Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Gross Weight" WHERE("Document Type" = CONST(Order),
                                                                                                                     "Location Code" = FIELD(Code),
                                                                                                                     Status = CONST(Released),
                                                                                                                     "Outstanding Quantity" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015604; "Purch. Orders Released Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Line" WHERE("Document Type" = CONST(Order),
                                                                                            "Location Code" = FIELD(Code),
                                                                                            Status = CONST(Released),
                                                                                            "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015605; "Receipt"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Receipt Header" WHERE("Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(37015606; "Receipt Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Receipt Line"."Qty. to Receive Weight" WHERE("Location Code" = FIELD(Code),
                                                                                                                           "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015607; "Receipt Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Receipt Line" WHERE("Location Code" = FIELD(Code),
                                                                                                     "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015608; "Put-Away"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE("Location Code" = FIELD(Code),
                                                                                                        Type = CONST("Put-away")));
            Description = 'NV';
            Editable = false;
        }
        field(37015609; "Put-Away Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. to Handle Weight" WHERE("Activity Type" = CONST("Put-away"),
                                                                                                                            "Location Code" = FIELD(Code),
                                                                                                                            "Action Type" = CONST(Take),
                                                                                                                            "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015610; "Put-Away Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Line" WHERE("Activity Type" = CONST("Put-away"),
                                                                                                      "Location Code" = FIELD(Code),
                                                                                                      "Action Type" = CONST(Take),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015611; "Pick"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST(Pick),
                                                                                                        "Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(37015612; "Pick Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. to Handle Weight" WHERE("Activity Type" = CONST(Pick),
                                                                                                                            "Location Code" = FIELD(Code),
                                                                                                                            "Action Type" = CONST(Place),
                                                                                                                            "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015613; "Pick Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Line" WHERE("Activity Type" = CONST(Pick),
                                                                                                      "Location Code" = FIELD(Code),
                                                                                                      "Action Type" = CONST(Place),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015614; "Shipment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Shipment Header" WHERE("Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(37015615; "Shipment Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship Weight" WHERE("Location Code" = FIELD(Code),
                                                                                                                          "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015616; "Shipment Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Shipment Line" WHERE("Location Code" = FIELD(Code),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015617; "Replinshment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST(Movement),
                                                                                                        "Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(37015618; "Replinshment Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. to Handle Weight" WHERE("Activity Type" = CONST(Movement),
                                                                                                                            "Location Code" = FIELD(Code),
                                                                                                                            "Action Type" = CONST(Place),
                                                                                                                            "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(37015619; "Replinshment Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Line" WHERE("Activity Type" = CONST(Movement),
                                                                                                      "Location Code" = FIELD(Code),
                                                                                                      "Action Type" = CONST(Place),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(37015620; "License Plate Enabled"; Boolean)
        {
            Description = 'NV';
        }
        field(37015621; "Rework Location OLD"; Boolean)
        {
            Description = 'NV';
        }
        field(37018300; "Rework Location"; Boolean)
        {
            Description = 'NV';
        }
        field(7327; "Outbound BOM Bin Code"; code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            CaptionML = ENU = 'Outbound BOM Bin Code';
        }
        field(7328; "Inbound BOM Bin Code"; code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            CaptionML = ENU = 'Inbound BOM Bin Code';
        }
    }
}

