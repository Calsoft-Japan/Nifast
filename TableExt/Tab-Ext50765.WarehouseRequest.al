tableextension 50765 Warehouserequest_Ext extends "Warehouse Request"
{
    fields
    {
        field(14017610; "Priority Code"; code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(14017630; "Assigned Warehouse Shipment"; Code[20])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Shipment Line"."No." WHERE("Source Document" = FIELD("Source Document"),
                                                                                                           "Source No." = FIELD("Source No."),
                                                                                                           "Location Code" = FIELD("Location Code")));
        }
        field(14017631; "Assigned Warehouse Receipt"; Code[20])
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Lookup("Warehouse Receipt Line"."No." WHERE("Source Document" = FIELD("Source Document"),
                                                                                                          "Source No." = FIELD("Source No."),
                                                                                                          "Location Code" = FIELD("Location Code")));
        }
        field(14017640; "Destination Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            
            TableRelation=IF ("Destination Type"=FILTER(Customer)) "Ship-to Address".Code WHERE ("Customer No."=FIELD("Destination No."))
                                                                 ELSE IF ("Destination Type"=CONST(Vendor)) "Order Address".Code WHERE ("Vendor No."=FIELD("Destination No.")); 
        }
        field(14017790; "Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14018000; "Outstanding Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:5;
        }
        field(14018001; "Outstanding Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:5;
        }
        field(14018002; "Destination Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }
}

                                                   