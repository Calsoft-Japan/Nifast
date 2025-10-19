table 50141 "FB Tag Journal Line"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    Caption = 'FB Tag Journal Line';

    fields
    {
        field(1; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "FB Tag Journal Batch";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(20; "Document No."; Code[20])
        {
            // cleaned
        }
        field(30; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(40; "Contract No."; Code[20])
        {
            // cleaned
            TableRelation = "Price Contract"."No." WHERE("Customer No." = FIELD("Customer No."),
                                                        "Ship-to Code" = FIELD("Ship-to Code"),
                                                        "Location Code" = FIELD("Location Code"));
        }
        field(50; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false));
        }
        field(60; "Ship-to Code"; Code[10])
        {
            // cleaned
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(70; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF "Item No." <> xRec."Item No." THEN
                    "Variant Code" := '';

                GetItem();
                //Item.TESTFIELD(Blocked,FALSE);

                "Unit of Measure Code" := Item."Sales Unit of Measure";
            end;

        }
        field(80; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            TableRelation = IF ("Item No." = FILTER(<> '')) "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("Item No."),
                                                                                              "Variant Code" = FIELD("Variant Code"),
                                                                                              Blocked = CONST(false))
            ELSE IF ("Item No." = CONST()) "Lot No. Information"."Lot No." WHERE(Blocked = CONST(false));
        }
        field(90; "Tag No."; Code[20])
        {
            TableRelation = "FB Tag";

            trigger OnValidate()
            begin
                FBTag.GET("Tag No.");

                "Customer No." := FBTag."Customer No.";
                "Ship-to Code" := FBTag."Ship-to Code";
                "Customer Bin" := FBTag."Customer Bin";
                "Location Code" := FBTag."Location Code";
                "Item No." := FBTag."Item No.";
                "Variant Code" := FBTag."Variant Code";
                "External Document No." := FBTag."External Document No.";
                "Unit of Measure Code" := FBTag."Unit of Measure Code";
                "Contract No." := FBTag."Contract No.";
                "Quantity Type" := FBTag."Quantity Type";
            end;
        }
        field(95; "Cross-Reference No."; Code[20])
        {
            // cleaned
        }
        field(100; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(110; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(120; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(140; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(150; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(160; "Order Time"; Time)
        {
            // cleaned
        }
        field(170; "Salesperson Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
             
            TableRelation = "Salesperson/Purchaser" WHERE(Sales = CONST(true));
             
        }
        field(175; "Inside Salesperson Code"; Code[10])
        {
            // cleaned
             
            TableRelation = "Salesperson/Purchaser" WHERE("Inside Sales" = CONST(true));
             
        }
        field(180; "Required Date"; Date)
        {
            // cleaned
        }
        field(190; "Customer Bin"; Code[20])
        {
            Caption = 'Customer Bin';
        }
        field(200; "Purchase Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(210; "Sale Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(350; "Quantity Type"; Option)
        {
            OptionCaption = 'Order,Usage,Count';
            OptionMembers = "Order",Usage,"Count";
        }
        field(400; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Journal Batch Name", "Line No.")
        {
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
        FBTagJnlLine: Record 50141;
        FBTagJnlBatch: Record 50140;
        FBTag: Record 50134;

    local procedure GetItem()
    begin
        IF Item."No." <> "Item No." THEN
            Item.GET("Item No.");
    end;

    procedure SetUpNewLine(LastFBTagJnlLine: Record 50141)
    begin
        FBTagJnlBatch.GET("Journal Batch Name");
        FBTagJnlBatch.TESTFIELD("No. Series");
        "No. Series" := FBTagJnlBatch."No. Series";
        FBTagJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF FBTagJnlLine.FIND('-') THEN BEGIN
            "Order Date" := LastFBTagJnlLine."Order Date";
            "Order Time" := LastFBTagJnlLine."Order Time";
        END ELSE BEGIN
            "Order Date" := WORKDATE();
            "Order Time" := TIME;
        END;
    end;
}
