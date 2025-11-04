tableextension 50765 Warehouserequest_Ext extends "Warehouse Request"
{
    fields
    {
        field(70000; "Priority Code"; code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(70001; "Assigned Warehouse Shipment"; Code[20])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Shipment Line"."No." WHERE("Source Document" = FIELD("Source Document"),
                                                                                                           "Source No." = FIELD("Source No."),
                                                                                                           "Location Code" = FIELD("Location Code")));
        }
        field(70002; "Assigned Warehouse Receipt"; Code[20])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Receipt Line"."No." WHERE("Source Document" = FIELD("Source Document"),
                                                                                                          "Source No." = FIELD("Source No."),
                                                                                                          "Location Code" = FIELD("Location Code")));
        }
        field(70003; "Destination Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            TableRelation = IF ("Destination Type" = FILTER(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Destination No."))
            ELSE IF ("Destination Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Destination No."));
        }
        field(70004; "Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70005; "Outstanding Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(70006; "Outstanding Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(70007; "Destination Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }
}

