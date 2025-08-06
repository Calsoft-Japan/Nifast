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
    }
}
