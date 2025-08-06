tableextension 55741 "Transfer Line Ext" extends "Transfer Line"
{
    // version NAVW18.00,SE0.55.08,NV4.35,NIF1.058,NIF.N15.C9IN.001,CIS.IoT
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                GetPostedAssOrder;  //NF1.00:CIS.NG  10/06/15
            end;
        }
        field(50000; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(51000; "Source PO No."; Code[20])
        {
            Editable = true;
        }
        field(51010; "Contract Note No."; Code[20])
        {
            Editable = true;
        }
        field(51011; "IoT Lot No."; Code[20])
        {
            Description = 'CIS.IoT';
        }
        field(70000; "Whse. Pick Outst. Qty (Base)"; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Activity Type" = FILTER(Pick),
                                                                                         "Source Type" = CONST(5741),
                                                                                        "Source Subtype" = CONST(0),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No."),
                                                                                         "Action Type" = FILTER(' ' | Take),
                                                                                         "Breakbulk No." = FILTER(0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70001; "Whse. Pick Outstanding Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" WHERE("Activity Type" = FILTER(Pick),
                                                                                  "Source Type" = CONST(5741),
                                                                                  "Source Subtype" = CONST(0),
                                                                                  "Source No." = FIELD("Document No."),
                                                                                  "Source Line No." = FIELD("Line No."),
                                                                                  "Action Type" = FILTER(' ' | Take),
                                                                                  "Breakbulk No." = FILTER(0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70005; "Whse. Ship. Qty (Base)"; Decimal)
        {
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship (Base)" WHERE("Source Type" = CONST(5741),
                                                                                    "Source Subtype" = CONST(0),
                                                                                     "Source No." = FIELD("Document No."),
                                                                                     "Source Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70006; "Whse. Shipment Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship" WHERE("Source Type" = CONST(5741),
                                                                              "Source Subtype" = CONST(0),
                                                                              "Source No." = FIELD("Document No."),
                                                                             "Source Line No." = FIELD("Line No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70010; "Invt. Pick Outst. Qty (Base)"; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Activity Type" = FILTER("Invt. Pick"),
                                                                                         "Source Type" = CONST(5741),
                                                                                         "Source Subtype" = CONST(0),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No."),
                                                                                         "Action Type" = FILTER(' ' | Take),
                                                                                         "Breakbulk No." = FILTER(0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70011; "Invt. Pick Outstanding Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" WHERE("Activity Type" = FILTER("Invt. Pick"),
                                                                                  "Source Type" = CONST(5741),
                                                                                  "Source Subtype" = CONST(0),
                                                                                  "Source No." = FIELD("Document No."),
                                                                                  "Source Line No." = FIELD("Line No."),
                                                                                  "Action Type" = FILTER(' ' | Take),
                                                                                  "Breakbulk No." = FILTER(0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

        field(50001; "FB Order No."; Code[20])//NV-FB 37015330->50001 BC Upgrade
        { }
    }

    LOCAL PROCEDURE GetPostedAssOrder();
    VAR
        PostedAssemblyHeader: Record 910;
        TransHeader: Record "Transfer Header";
    BEGIN
        //>> NF1.00:CIS.NG  10/06/15
        PostedAssemblyHeader.RESET;
        PostedAssemblyHeader.SETRANGE("Item No.", "Item No.");
        PostedAssemblyHeader.SETFILTER("Transfer Order No.", '=%1', '');
        IF PostedAssemblyHeader.FINDLAST THEN BEGIN
            TransHeader := GetTransferHeader();
            TransHeader."Posted Assembly Order No." := PostedAssemblyHeader."No.";
            TransHeader.MODIFY;
            PostedAssemblyHeader."Transfer Order No." := "Document No.";
            PostedAssemblyHeader.MODIFY;
        END;
        //<< NF1.00:CIS.NG  10/06/15
    END;
}
