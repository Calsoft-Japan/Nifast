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
        field(70000; "Priority Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70001; "Pick Task No. Series"; Code[10])
        {
        }
        field(70002; "Pick Task No."; Code[20])
        {
            trigger OnValidate()
            begin
                UpdateWhseActLines(FIELDCAPTION("Pick Task No."));
            end;
        }
        field(70003; "Task Priority"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            begin
                UpdateWhseActLines(FIELDCAPTION("Task Priority"));
            end;
        }
        field(70004; "License Plate No."; Code[20])
        {
        }
        field(70005; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. to Handle" WHERE("Activity Type" = FIELD(Type), "No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70006; "Placed In Whse. Queue"; Boolean)
        {
        }
        field(70007; "Movement Type"; Option)
        {
            OptionCaptionML = ENU = ', Put-Away, Pick, Replinishment';
            OptionMembers = ,"Put-Away",Pick,Replinishment;
        }
    }
    PROCEDURE UpdateWhseActLines(ChangedFieldName: Text[100]);
    VAR
        WhseActLine: Record "Warehouse Activity Line";
    BEGIN
        //PFC
        WhseActLine.RESET();
        WhseActLine.SETRANGE("No.", "No.");

        IF WhseActLine.FIND('-') THEN
            REPEAT
                CASE ChangedFieldName OF
                    FIELDCAPTION("Assigned User ID"):
                        BEGIN
                            WhseActLine."Assigned User ID" := "Assigned User ID";
                            WhseActLine."Assignment Date" := "Assignment Date";
                            WhseActLine."Assignment Time" := "Assignment Time";
                        END;
                    FIELDCAPTION("Pick Task No."):
                        WhseActLine."Pick Task No." := "Pick Task No.";
                    FIELDCAPTION("Task Priority"):
                        WhseActLine."Task Priority" := "Task Priority";
                END;
                WhseActLine.MODIFY();
            UNTIL WhseActLine.NEXT() = 0;
    END;
}
