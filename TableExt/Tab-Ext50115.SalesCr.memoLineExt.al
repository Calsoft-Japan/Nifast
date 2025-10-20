tableextension 50115 "Sales Cr.Memo Line Ext" extends "Sales Cr.Memo Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.55.08,NV4.29,NIF1.050,NIF.N15.C9IN.001,AKK1606.01
    fields
    {
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
        //TODO
        /*  field(14000351; "EDI Item Cross Ref."; Code[20])
         {
             CaptionML = ENU = 'EDI Item Cross Ref.';
         }

         field(14000352; "EDI Unit of Measure"; Code[10])
         {
             CaptionML = ENU = 'EDI Unit of Measure';
         }

         field(14000355; "EDI Segment Group"; Integer)
         {
             CaptionML = ENU = 'EDI Segment Group';
             Editable = false;
         }

         field(14000602; "Over Receive"; Boolean)
         {
             CaptionML = ENU = 'Over Receive';
             Editable = false;
         }

         field(14000603; "Over Receive Verified"; Boolean)
         {
             CaptionML = ENU = 'Over Receive Verified';
         }
  */
        //TODO
        field(14017611; "Order Date"; Date)
        {
            Description = 'NV';
        }

        field(14017612; "Manufacturer Code"; Code[10])
        {
            TableRelation = Manufacturer.Code;
        }

        field(14017614; "Tool Repair Tech"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(Yes));
        }

        field(14017615; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Sales" = CONST(Yes));
            Description = 'NV';
        }

        field(14017616; "Inside Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(Yes));
            Description = 'NV';
        }

        field(14017617; "NV Posting Date"; Date)
        {
        }

        field(14017618; "External Document No."; Code[20])
        {
            Description = 'NV';
        }

        field(14017621; "List Price"; Decimal)
        {
        }

        field(14017624; "Alt. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(14017625; "Alt. Qty. UOM"; Code[10])
        {
            Editable = false;
        }

        field(14017626; "Alt. Price"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            trigger OnValidate()
            var
                ItemUOMRec2: Record 5404;
            BEGIN

            END;
        }

        field(14017627; "Alt. Price UOM"; Code[10])
        {
            Editable = false;
        }

        field(14017628; "Alt. Sales Cost"; Decimal)
        {
            Editable = false;
        }

        field(14017631; "Net Unit Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }

        field(14017633; "Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(14017640; "Ship-to PO No."; Code[20])
        {
        }

        field(14017641; "Shipping Advice"; Option)
        {
            OptionCaptionML = ENU = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }

        field(14017645; "Contract No."; Code[20])
        {
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'NV';
        }

        field(14017650; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(14017660; "Order Outstanding Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017661; "Order Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017750; "Line Gross Weight"; Decimal)
        {
        }

        field(14017751; "Line Net Weight"; Decimal)
        {
        }

        field(14017752; "Ship-to Code"; Code[10])
        {
            Description = 'NV';
        }

        field(14017753; "Line Cost"; Decimal)
        {
            Editable = false;
        }

        field(14017756; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(14017757; "Vendor No."; Code[20])
        {
        }

        field(14017758; "Vendor Item No."; Text[20])
        {
        }

        field(14017903; "BOM Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Editable = false;
        }

        field(14017904; "Prod. Order No."; Code[20])
        {
        }

    }
    keys
    {
        key(Key9; "Shipment Date")
        {
        }
    }
}
