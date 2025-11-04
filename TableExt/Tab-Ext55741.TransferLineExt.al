tableextension 55741 "Transfer Line Ext" extends "Transfer Line"
{
    // version NAVW18.00,SE0.55.08,NV4.35,NIF1.058,NIF.N15.C9IN.001,CIS.IoT
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                GetPostedAssOrder();  //NF1.00:CIS.NG  10/06/15
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

        /*  field(50001; "FB Order No."; Code[20])//NV-FB 37015330->50001 BC Upgrade
         { } */

        //TODO
        /*  field(14000351; "EDI Segment Group"; Integer)
         {
             Caption = 'EDI Segment Group';
             Editable = false;
         }

         field(14000701; "E-Ship Whse. Outst. Qty (Base)"; Decimal)
         {
             Caption = 'E-Ship Whse. Outst. Qty (Base)';
             FieldClass = FlowField;
             DecimalPlaces = 0 : 5;
             Editable = false;
             CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" where
     (
         "Activity Type" = Filter(Pick),
         "Source Type" = Const(5741),
         "Source Subtype" = Const(0),
         "Source No." = Field("Document No."),
         "Source Line No." = Field("Line No."),
         "Action Type" = Filter(' ' | Take),
         "Breakbulk No." = Filter(0)
     ));
         }

         field(14000702; "E-Ship Whse. Outstanding Qty."; Decimal)
         {
             Caption = 'E-Ship Whse. Outstanding Qty.';
             FieldClass = FlowField;
             DecimalPlaces = 0 : 5;
             Editable = false;
             CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" where
     (
         "Activity Type" = Filter(Pick),
         "Source Type" = Const(5741),
         "Source Subtype" = Const(0),
         "Source No." = Field("Document No."),
         "Source Line No." = Field("Line No."),
         "Action Type" = Filter(' ' | Take),
         "Breakbulk No." = Filter(0)
     ));
         }

         field(14000703; "E-Ship Whse. Ship. Qty (Base)"; Decimal)
         {
             Caption = 'E-Ship Whse. Ship. Qty (Base)';
             FieldClass = FlowField;
             DecimalPlaces = 0 : 5;
             Editable = false;
             CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship (Base)" where
     (
         "Source Type" = Const(5741),
         "Source Subtype" = Const(0),
         "Source No." = Field("Document No."),
         "Source Line No." = Field("Line No.")
     ));
         }

         field(14000704; "E-Ship Whse. Shipment Qty"; Decimal)
         {
             Caption = 'E-Ship Whse. Shipment Qty';
             FieldClass = FlowField;
             DecimalPlaces = 0 : 5;
             Editable = false;
             CalcFormula = Sum("Warehouse Shipment Line"."Qty. to Ship" where
     (
         "Source Type" = Const(5741),
         "Source Subtype" = Const(0),
         "Source No." = Field("Document No."),
         "Source Line No." = Field("Line No.")
     ));
         }

         field(14000705; "E-Ship Invt. Outst. Qty (Base)"; Decimal)
         {
             Caption = 'E-Ship Invt. Outst. Qty (Base)';
             FieldClass = FlowField;
             DecimalPlaces = 0 : 5;
             Editable = false;
             CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" where
     (
         "Activity Type" = Filter("Invt. Pick"),
         "Source Type" = Const(5741),
         "Source Subtype" = Const(0),
         "Source No." = Field("Document No."),
         "Source Line No." = Field("Line No."),
         "Action Type" = Filter(' ' | Take),
         "Breakbulk No." = Filter(0)
     ));
         }

         field(14000706; "E-Ship Invt. Outstanding Qty."; Decimal)
         {
             Caption = 'E-Ship Invt. Outstanding Qty.';
             FieldClass = FlowField;
             DecimalPlaces = 0 : 5;
             Editable = false;
             CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding" where
     (
         "Activity Type" = Filter("Invt. Pick"),
         "Source Type" = Const(5741),
         "Source Subtype" = Const(0),
         "Source No." = Field("Document No."),
         "Source Line No." = Field("Line No."),
         "Action Type" = Filter(' ' | Take),
         "Breakbulk No." = Filter(0)
     ));
         }

  */
        //TODO
        field(14017610; "Line Gross Weight"; Decimal)
        {
        }

        field(14017748; "Outstanding Gross Weight"; Decimal)
        {
        }

        field(14017749; "Outstanding Net Weight"; Decimal)
        {
        }

        field(14017751; "Line Net Weight"; Decimal)
        {
            Editable = false;
        }

        field(14017790; "Container No."; Code[20])
        {
            Editable = false;
        }

        field(14017791; "Final Destination"; Code[10])
        {
            TableRelation = Location.Code where("Use As In-Transit" = Const(false));
        }

        field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10-10-15';
            Editable = false;
        }

        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV-FB';
        }

        field(37015331; "FB Line No."; Integer)
        {
            Description = 'NV-FB';
        }

        field(37015332; "FB Tag No."; Code[20])
        {
            Description = 'NV-FB';
        }

        field(37015333; "FB Customer Bin"; Code[20])
        {
            Description = 'NV-FB';
        }

        field(37015590; "In-Transit Gross Weight"; Decimal)
        {
        }
    }

    PROCEDURE CalcEShipWhseOutstQtyBase(LocationPacking: Boolean; LocationCode: Code[10]) QtyBase: Decimal;
    VAR
        TransferLine: Record 5741;
    BEGIN
        QtyBase := 0;

        TransferLine.COPY(Rec);
        IF LocationPacking THEN
            TransferLine.SETRANGE("Transfer-from Code", LocationCode);
        IF TransferLine.FIND('-') THEN
            REPEAT
                TransferLine.CALCFIELDS("LAX EShip Invt Outst Qty(Base)");
                IF (TransferLine."Qty. to Ship (Base)" = 0) OR
                   (TransferLine."LAX EShip Invt Outst Qty(Base)" <> 0)
                THEN BEGIN
                    TransferLine.CALCFIELDS(
                      "LAX EShip Whse Outst.Qty(Base)", "LAX EShip Whse Ship. Qty(Base)");
                    QtyBase :=
                      QtyBase +
                      TransferLine."LAX EShip Whse Outst.Qty(Base)" +
                      TransferLine."LAX EShip Whse Ship. Qty(Base)" +
                      TransferLine."LAX EShip Invt Outst Qty(Base)";
                END;
            UNTIL TransferLine.NEXT = 0;
    END;

    PROCEDURE UpdateWeight();
    BEGIN
        "Line Gross Weight" := Quantity * "Gross Weight";
        "Line Net Weight" := Quantity * "Net Weight";
        "Outstanding Gross Weight" := "Outstanding Quantity" * "Gross Weight";
        "Outstanding Net Weight" := "Outstanding Quantity" * "Net Weight";
        "In-Transit Gross Weight" := "Qty. in Transit" * "Gross Weight";
    END;

    LOCAL PROCEDURE GetPostedAssOrder();
    VAR
        PostedAssemblyHeader: Record 910;
        TransHeader: Record "Transfer Header";
    BEGIN
        //>> NF1.00:CIS.NG  10/06/15
        PostedAssemblyHeader.RESET();
        PostedAssemblyHeader.SETRANGE("Item No.", "Item No.");
        PostedAssemblyHeader.SETFILTER("Transfer Order No.", '=%1', '');
        IF PostedAssemblyHeader.FINDLAST() THEN BEGIN
            TransHeader := GetTransferHeader();
            TransHeader."Posted Assembly Order No." := PostedAssemblyHeader."No.";
            TransHeader.MODIFY();
            PostedAssemblyHeader."Transfer Order No." := "Document No.";
            PostedAssemblyHeader.MODIFY();
        END;
        //<< NF1.00:CIS.NG  10/06/15
    END;
}
