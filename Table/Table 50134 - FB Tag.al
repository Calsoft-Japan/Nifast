table 50134 "FB Tag"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    DrillDownPageID = 50135;
    LookupPageID = 50135;

    fields
    {
        field(10; "No."; Code[20])
        {
            // cleaned
        }
        field(20; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(30; "Ship-to Code"; Code[10])
        {
            // cleaned
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(40; "Customer Bin"; Code[20])
        {
            // cleaned
        }
        field(45; "Location Code"; Code[10])
        {
            // cleaned
            //TODO
            /*  TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false)); */
            //TODO
        }
        field(80; "Item No."; Code[20])
        {
            // cleaned
            TableRelation = Item;
        }
        field(85; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(110; "Reorder Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(120; "Min. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(130; "Max. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(140; "External Document No."; Code[20])
        {
            // cleaned
        }
        field(170; "Unit of Measure Code"; Code[10])
        {
            // cleaned
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(180; "Selling Location"; Code[10])
        {
            // cleaned
            //TODO
            /*  TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false)); */
            //TODO
        }
        field(190; "Shipping Location"; Code[10])
        {
            // cleaned
            //TODO
            /*    TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                               "Rework Location" = CONST(false)); */
            //TODO
        }
        field(200; "Contract No."; Code[20])
        {
            TableRelation = "Price Contract"."No." WHERE("Customer No." = FIELD("Customer No."),
                                                        "Ship-to Code" = FIELD("Ship-to Code"));

            trigger OnValidate()
            begin
                //TODO
                /*   IF "Contract No." <> '' THEN BEGIN
                      SalesPrice.SETRANGE("Item No.", "Item No.");
                      SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::Customer);
                      SalesPrice.SETRANGE("Sales Code", "Customer No.");
                      SalesPrice.SETRANGE("Starting Date", 0D, WORKDATE());
                      SalesPrice.SETRANGE("Variant Code", "Variant Code");
                      SalesPrice.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                      SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, WORKDATE());
                      SalesPrice.SETRANGE("Contract No.", "Contract No.");
                      SalesPrice.SETRANGE("Contract Ship-to Code", "Ship-to Code");
                      IF SalesPrice.FIND('-') THEN BEGIN
                          "Reorder Quantity" := SalesPrice."Reorder Quantity";
                          "Min. Quantity" := SalesPrice."Min. Quantity";
                          "Max. Quantity" := SalesPrice."Max. Quantity";
                          "External Document No." := SalesPrice."External Document No.";
                          "FB Order Type" := SalesPrice."FB Order Type";
                          "Replenishment Method" := SalesPrice."Replenishment Method";
                          "Selling Location" := SalesPrice."Contract Location Code";
                          "Shipping Location" := SalesPrice."Contract Ship Location Code";
                      END;
                  END; */
                //TODO
            end;

        }
        field(250; "FB Order Type"; Option)
        {
            OptionCaption = ' ,Consigned,Non-Consigned';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
        field(300; "Replenishment Method"; Option)
        {
            Caption = 'Replenishment Method';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(350; "Quantity Type"; Option)
        {
            OptionCaption = 'Order,Usage,Count';
            OptionMembers = "Order",Usage,"Count";
        }
        field(500; "No. Series"; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            TableRelation = "Item Reference"."Reference No." WHERE("Item No." = FIELD("Item No."),
                                                                                "Variant Code" = FIELD("Variant Code"),
                                                                                "Unit of Measure" = FIELD("Unit of Measure Code"),
                                                                                "Reference Type" = CONST(Customer),
                                                                                "Reference Type No." = FIELD("Customer No."));

            trigger OnValidate()
            var
            // ReturnedCrossRef: Record 5717;
            begin
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TagSetup.GET();
        IF "No." = '' THEN BEGIN
            TagSetup.TESTFIELD("Tag Nos.");
            NoSeriesMgt.InitSeries(TagSetup."Tag Nos.", xRec."No. Series", WORKDATE(), "No.", "No. Series");
        END;
    end;

    var
        TagSetup: Record 50133;
        // SalesPrice: Record 7002;
        NoSeriesMgt: Codeunit 396;
}
