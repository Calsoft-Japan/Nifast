tableextension 50125 "Purch. Cr. Memo Line Ext" extends "Purch. Cr. Memo Line"
{
    // version NAVW18.00,NAVNA8.00,NV4.29,NIF1.104,NMX1.000,NIF.N15.C9IN.001
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
        field(14017612; "NV Posting Date"; Date)
        {
        }

        field(14017613; "Purchaser Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Purchase = CONST(true));
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

    }
}
