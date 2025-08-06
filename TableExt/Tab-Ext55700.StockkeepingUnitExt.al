tableextension 55700 "Stockkeeping Unit Ext" extends "Stockkeeping Unit"
{
    fields
    {
        field(50000; "Units per Parcel"; Decimal)
        {
            Description = 'Lookup(Item."Units per Parcel" WHERE (No.=FIELD(Item No.)))';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Units per Parcel" WHERE("No." = FIELD("Item No.")));
        }
        field(70011; "Consumptions (Qty.)"; Decimal)
        {
            Caption = 'Consumptions (Qty.)';
            DecimalPlaces = 0 : 5;
            Description = 'NIF - was 10011 in T27';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST(Consumption),
                                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                                                   "Location Code" = FIELD("Location Code"),
                                                                                                                   "Variant Code" = FIELD("Variant Code"),
                                                                                                                   "Posting Date" = FIELD("Date Filter")));
        }
        field(70072; "Sales (Qty.)"; Decimal)
        {
            Caption = 'Sales (Qty.)';
            DecimalPlaces = 0 : 5;
            Description = 'NIF - was 72 in T27';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST(Sale),
                                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                                                   "Location Code" = FIELD("Location Code"),
                                                                                                                   "Variant Code" = FIELD("Variant Code"),
                                                                                                                   "Posting Date" = FIELD("Date Filter")));
        }
        field(70074; "Negative Adjmt. (Qty.)"; Decimal)
        {
            Caption = 'Negative Adjmt. (Qty.)';
            DecimalPlaces = 0 : 5;
            Description = 'NIF - was 74 in T27';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST("Negative Adjmt."),
                                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                                                   "Location Code" = FIELD("Location Code"),
                                                                                                                   "Variant Code" = FIELD("Variant Code"),
                                                                                                                   "Posting Date" = FIELD("Date Filter")));
        }
    }
}
