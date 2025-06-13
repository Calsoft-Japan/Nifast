tableextension 55700 "Stockkeeping Unit Ext" extends "Stockkeeping Unit"
{
    fields
    {
        field(50000;"Units per Parcel";Decimal)
        {
            Description = 'Lookup(Item."Units per Parcel" WHERE (No.=FIELD(Item No.)))';
            Editable = false;
        }
        field(70011;"Consumptions (Qty.)";Decimal)
        {
            Caption = 'Consumptions (Qty.)';
            DecimalPlaces = 0:5;
            Description = 'NIF - was 10011 in T27';
            Editable = false;
        }
        field(70072;"Sales (Qty.)";Decimal)
        {
            Caption = 'Sales (Qty.)';
            DecimalPlaces = 0:5;
            Description = 'NIF - was 72 in T27';
            Editable = false;
        }
        field(70074;"Negative Adjmt. (Qty.)";Decimal)
        {
            Caption = 'Negative Adjmt. (Qty.)';
            DecimalPlaces = 0:5;
            Description = 'NIF - was 74 in T27';
            Editable = false;
        }
    }
}
