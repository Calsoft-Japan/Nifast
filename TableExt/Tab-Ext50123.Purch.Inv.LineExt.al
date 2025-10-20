tableextension 50123 "Purch. Inv. Line Ext" extends "Purch. Inv. Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.51.20,NV4.32,4x,NIF1.086,NMX1.000,NIF.N15.C9IN.001,FOREX,AKK1606.01,AKK1607.01
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
        }
        field(50000; "Contract Note No."; Code[20])
        {
            // cleaned
            TableRelation = "4X Contract"."No.";
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            // cleaned
        }
        field(50002; "USD Value"; Decimal)
        {
            Description = 'Forex';
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(50803; "Is retention Line"; Boolean)
        {
            Description = 'RET1.0';
        }
        field(50804; "Is Withholding Tax"; Boolean)
        {
            Description = 'RET1.0';
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            // cleaned
            TableRelation = "Country/Region";
        }
        field(52010; Manufacturer; Code[50])
        {
            // cleaned
            TableRelation = Manufacturer;
        }
        //TODO
        /*  field(14000601; "Shipping Charge"; Boolean)
         {
             CaptionML = ENU = 'Shipping Charge';
         }

         field(14000602; "Over Receive"; Boolean)
         {
             CaptionML = ENU = 'Over Receive';
             Editable = false;
         }

         field(14000603; "Over Receive Verified"; Boolean)
         {
             CaptionML = ENU = 'Over Receive Verified';
         } */
        //TODO

        field(14017612; "NV Posting Date"; Date)
        {
        }

        field(14017613; "Purchaser Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Purchase = CONST(True));
        }

        field(14017614; "Vendor Shipment No."; Code[20])
        {
        }

        field(14017615; "Vendor Invoice No."; Code[20])
        {
        }

        field(14017616; "Vendor Cr. Memo No."; Code[20])
        {
        }

        field(14017633; "Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
        }

        field(14017640; "Ship-to PO No."; Code[20])
        {
        }

        field(14017650; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(14017670; "Alt. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14017671; "Alt. Qty. UOM"; Code[10])
        {
            Editable = false;
        }

        field(14017672; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            trigger OnValidate()
            var
                ItemUOMRec2: Record 5404;
            BEGIN

            END;
        }

        field(14017673; "Alt. Price UOM"; Code[10])
        {
            Editable = false;
        }

        field(14017750; "Line Gross Weight"; Decimal)
        {
        }

        field(14017751; "Line Net Weight"; Decimal)
        {
        }

        field(14017756; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(14017930; "Rework No."; Code[20])
        {
        }

        field(14017931; "Rework Line No."; Integer)
        {
        }

    }
    keys
    {
        key(Key8; Type, "No.", "Unit Cost")
        {
        }
        key(Key9; "Exchange Contract No.")
        {
            //SumIndexFields = Amount;
        }
        key(Key10; "Posting Date", Type, "No.", "Buy-from Vendor No.")
        {
        }
    }
}
