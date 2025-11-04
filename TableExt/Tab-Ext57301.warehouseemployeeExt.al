tableextension 57301 "warehouse employee Ext" extends "Warehouse Employee"
{
    fields
    {
        field(70000; "MC PIN"; Code[10])
        {
            Caption = '';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                WhseEmployee: Record 7301;
                LTEXT000: Label 'ENU=MC Bin code has already been used.';
            begin
                IF "MC PIN" <> '' THEN BEGIN
                    WhseEmployee.SETRANGE("MC PIN", "MC PIN");
                    WhseEmployee.SETFILTER("User ID", '<>%1', "User ID");
                    IF WhseEmployee.FIND('-') THEN
                        ERROR(LTEXT000);
                END;
            end;
        }
        field(70001; "Current Pick Zone"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zone.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(70002; Receipts; Integer)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Receipt Header" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                       "Assigned User ID" = FIELD("User ID")));
        }
        field(70003; "Put-Aways"; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST("Put-away"),
                                                                                                        "Location Code" = FIELD("Location Code"),
                                                                                                        "Assigned User ID" = FIELD("User ID")));
            Editable = false;
        }
        field(70004; Shipments; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Shipment Header" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                        "Assigned User ID" = FIELD("User ID")));
            Editable = false;
        }
        field(70005; Picks; Integer)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST(Pick),
                                                                                                        "Location Code" = FIELD("Location Code"),
                                                                                                        "Assigned User ID" = FIELD("User ID")));
            Editable = false;
        }
        field(70006; Movements; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = CONST(Movement),
                                                                                                        "Location Code" = FIELD("Location Code"),
                                                                                                        "Assigned User ID" = FIELD("User ID")));
            Editable = false;
        }
    }
}

