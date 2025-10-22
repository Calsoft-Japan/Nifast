tableextension 55766 "Warehouse Activity Header Ext" extends "Warehouse Activity Header"
{
    fields
    {
        field(50000; "Blanket Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const("Blanket Order"));
        }
        field(14017610; "Priority Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017630; "Pick Task No. Series"; Code[10])
        {
        }
        field(14017631; "Pick Task No."; Code[20])
        {
            trigger OnValidate()
            begin
                UpdateWhseActLines(FIELDCAPTION("Pick Task No."));
            end;
        }
        field(14017650; "Task Priority"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            begin
                UpdateWhseActLines(FIELDCAPTION("Task Priority"));
            end;
        }
        field(14017660; "License Plate No."; Code[20])
        {
        }
        field(14017990; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. to Handle" WHERE("Activity Type" = FIELD(Type), "No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14017991; "Placed In Whse. Queue"; Boolean)
        {
        }
        field(14017992; "Movement Type"; Option)
        {
            OptionCaptionML = ENU = ', Put-Away, Pick, Replinishment';
            OptionMembers = ,"Put-Away",Pick,Replinishment;
        }
    }
}
