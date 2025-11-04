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
        field(70000; "Default by Zone Pickingr"; Boolean)
        {
            Description = 'NV';
        }
        field(70001; "Rework Location Code"; Code[10])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false));
            Description = 'NV';
        }
        field(70002; "Rework In-Transit Code"; Code[10])
        {
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
            Description = 'NV';
        }
        field(70003; "Staging Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(70004; "Break Pick when Qty. on Hand"; Option)
        {
            OptionMembers = ,">= Min. Qty. (no split pick)","= Max. Qty. (allow split pick)";
            Description = 'NV';
        }
        field(70005; "Inbound QC Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code), "QC Bin" = FILTER(true));
            Description = 'NV';
        }
        field(70006; "Outbound QC Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(70007; "QC RTV Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(70008; "QC Rework Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code), "QC Bin" = FILTER(true));
            Description = 'NV';
        }
        field(70009; "QC First Article Bin Code"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
            Description = 'NV';
        }
        field(70010; "QC Receipt Bin Code"; Code[20])
        {
            CaptionML = ENU = 'QC Receipt Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code), "QC Bin" = CONST(true));
            Description = 'NV';
        }
        field(70011; "Transfer Inbound Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Header" WHERE("Transfer-to Code" = FIELD(Code),
                                                                                              "In-Transit Lines" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70012; "Transfer Inbound Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Line"."In-Transit Gross Weight" WHERE("Transfer-to Code" = FIELD(Code)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(70013; "Transfer Inbound Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Line" WHERE("Transfer-to Code" = FIELD(Code),
                                                                                            "Qty. in Transit (Base)" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70014; "Transfer Outbound Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Header" WHERE("Transfer-from Code" = FIELD(Code),
                                                                                        Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(70015; "Transfer Outbound Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Line"."Outstanding Gross Weight" WHERE("Transfer-from Code" = FIELD(Code),
                                                                                                                Status = CONST(Released)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(70016; "Transfer Outbound Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Line" WHERE("Transfer-from Code" = FIELD(Code),
                                                                                            Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(70017; "Sale Orders Open Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                                                           "Location Code" = FIELD(Code),
                                                                                           Status = CONST(Open)));
            Description = 'NV';
            Editable = false;
        }
        field(70018; "Sale Orders Open Weight"; Decimal)
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
        field(70019; "Sale Orders Open Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Line" WHERE("Document Type" = CONST(Order),
                                                                                         "Location Code" = FIELD(Code),
                                                                                         Status = CONST(Open),
                                                                                         "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70020; "Sale Orders Released Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                                                           "Location Code" = FIELD(Code),
                                                                                           Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(70021; "Sale Orders Released Weight"; Decimal)
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
        field(70022; "Sale Orders Released Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Line" WHERE("Document Type" = CONST(Order),
                                                                                         "Location Code" = FIELD(Code),
                                                                                         Status = CONST(Released),
                                                                                         "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70023; "Purch. Orders Released Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order),
                                                                                              "Location Code" = FIELD(Code),
                                                                                              Status = CONST(Released)));
            Description = 'NV';
            Editable = false;
        }
        field(70024; "Purch. Orders Released Weight"; Decimal)
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
        field(70025; "Purch. Orders Released Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Line" WHERE("Document Type" = CONST(Order),
                                                                                            "Location Code" = FIELD(Code),
                                                                                            Status = CONST(Released),
                                                                                            "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70026; "Receipt"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Receipt Header" WHERE("Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(70027; "Receipt Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Receipt Line"."Qty. to Receive Weight" WHERE("Location Code" = FIELD(Code),
                                                                                                                           "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(70028; "Receipt Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Receipt Line" WHERE("Location Code" = FIELD(Code),
                                                                                                     "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70029; "Put-Away"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE("Location Code" = FIELD(Code),
                                                                                                        Type = CONST("Put-away")));
            Description = 'NV';
            Editable = false;
        }
        field(70030; "Put-Away Weight"; Decimal)
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
        field(70031; "Put-Away Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Line" WHERE("Activity Type" = CONST("Put-away"),
                                                                                                      "Location Code" = FIELD(Code),
                                                                                                      "Action Type" = CONST(Take),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70032; "Pick"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST(Pick),
                                                                                                        "Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(70033; "Pick Weight"; Decimal)
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
        field(70034; "Pick Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Line" WHERE("Activity Type" = CONST(Pick),
                                                                                                      "Location Code" = FIELD(Code),
                                                                                                      "Action Type" = CONST(Place),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70035; "Shipment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Shipment Header" WHERE("Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(70036; "Shipment Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship Weight" WHERE("Location Code" = FIELD(Code),
                                                                                                                          "Qty. Outstanding" = FILTER(<> 0)));
            DecimalPlaces = 0 : 0;
            Description = 'NV';
            Editable = false;
        }
        field(70037; "Shipment Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Shipment Line" WHERE("Location Code" = FIELD(Code),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70038; "Replinshment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST(Movement),
                                                                                                        "Location Code" = FIELD(Code)));
            Description = 'NV';
            Editable = false;
        }
        field(70039; "Replinshment Weight"; Decimal)
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
        field(70040; "Replinshment Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Line" WHERE("Activity Type" = CONST(Movement),
                                                                                                      "Location Code" = FIELD(Code),
                                                                                                      "Action Type" = CONST(Place),
                                                                                                      "Qty. Outstanding" = FILTER(<> 0)));
            Description = 'NV';
            Editable = false;
        }
        field(70041; "License Plate Enabled"; Boolean)
        {
            Description = 'NV';
        }
        field(70042; "Rework Location OLD"; Boolean)
        {
            Description = 'NV';
        }
        field(70043; "Rework Location"; Boolean)
        {
            Description = 'NV';
        }

    }
}

