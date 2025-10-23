table 70701 "_Shipping Agent Change"
{
    fields
    {
        field(1; "Line No."; Integer)
        {
            // cleaned
        }
        field(11; Description; Text[30])
        {
            // cleaned
        }
        field(21; "Shipping Agent Code"; Code[10])
        {
            // cleaned
            TableRelation = "Shipping Agent";
        }
        field(22; "Shipment Method Code"; Code[10])
        {
            // cleaned
            TableRelation = "Shipment Method";
        }
        field(23; "Blank Shipment Method Code"; Boolean)
        {
            // cleaned
        }
        field(24; "Filter Shipping Agent Code"; Boolean)
        {
            // cleaned
        }
        field(25; "Filter Shipping Method Code"; Boolean)
        {
            // cleaned
        }
        field(26; "Shipping Agent Name"; Text[50])
        {
            CalcFormula = Lookup("Shipping Agent".Name WHERE(Code = FIELD("Shipping Agent Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Shipment Method Description"; Text[50])
        {
            CalcFormula = Lookup("Shipment Method".Description WHERE(Code = FIELD("Shipment Method Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Filter Blank E-Ship Agent Serv"; Boolean)
        {
            // cleaned
        }
        field(31; "New Shipping Agent Code"; Code[10])
        {
            // cleaned
            TableRelation = "Shipping Agent";
        }
        field(32; "New Dom. E-Ship Agent Service"; Code[30])
        {
            // cleaned

            TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("New Shipping Agent Code"),
                                                                "World Wide Service" = CONST(False));

        }
        field(33; "New Int. E-Ship Agent Service"; Code[30])
        {
            // cleaned

            TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("New Shipping Agent Code"),
                                                                "World Wide Service" = CONST(True));

        }
        field(34; "New UPS CA E-Ship Agent Serv."; Code[30])
        {
            // cleaned

            TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("New Shipping Agent Code"),
                                                                "World Wide Service" = CONST(False),
                                                                "UPS Canadian Service" = CONST(True),
                                                                "UPS Puerto Rico Service" = CONST(False));

        }
        field(35; "New UPS PR E-Ship Agent Serv."; Code[30])
        {
            // cleaned

            TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("New Shipping Agent Code"),
                                                               "World Wide Service" = CONST(False),
                                                               "UPS Canadian Service" = CONST(False),
                                                               "UPS Puerto Rico Service" = CONST(True));

        }
        field(36; "New Residential Delivery"; Boolean)
        {
            // cleaned
        }
        field(37; "New Free Freight"; Boolean)
        {
            // cleaned
        }
        field(38; "New No Free Freight Lines"; Boolean)
        {
            // cleaned
        }
        field(39; "New Shipping Payment Type"; Option)
        {
            OptionMembers = Prepaid,"Third Party","Freight Collect",Consignee;
        }
        field(40; "New Shipping Insurance"; Option)
        {
            OptionMembers = " ",Never,Always;
        }
        field(41; "Change Customer"; Boolean)
        {
            // cleaned
        }
        field(42; "Change Ship-to Address"; Boolean)
        {
            // cleaned
        }
        field(43; "Change Sales Header"; Boolean)
        {
            // cleaned
        }
        field(44; "Change Sales Shipment"; Boolean)
        {
            // cleaned
        }
        field(45; "Change Sales Invoice"; Boolean)
        {
            // cleaned
        }
        field(51; "Changed Customer"; Boolean)
        {
            // cleaned
        }
        field(52; "Changed Ship-to Address"; Boolean)
        {
            // cleaned
        }
        field(53; "Changed Sales Header"; Boolean)
        {
            // cleaned
        }
        field(54; "Changed Sales Shipment"; Boolean)
        {
            // cleaned
        }
        field(55; "Changed Sales Invoice"; Boolean)
        {
            // cleaned
        }
        field(61; "Changed Customers"; Integer)
        {
            Editable = false;
        }
        field(62; "Changed Ship-to Address's"; Integer)
        {
            Editable = false;
        }
        field(63; "Changed Sales Headers"; Integer)
        {
            Editable = false;
        }
        field(64; "Changed Sales Shipments"; Integer)
        {
            Editable = false;
        }
        field(65; "Changed Sales Invoices"; Integer)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Line No.")
        {
        }
        key(Key2; "Shipping Agent Code", "Shipment Method Code")
        {
        }
        key(Key3; "New Shipping Agent Code", "New Dom. E-Ship Agent Service")
        {
        }
    }

    fieldgroups
    {
    }

    procedure TestUnique()
    var
    //  ShippingAgentChange: Record 70701;
    begin
    end;

    procedure ModifyRecords()
    begin
    end;
}
