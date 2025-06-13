table 50030 "3 Way Currency Exchange Rate"
{
    fields
    {
        field(1;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            NotBlank = true;
            
        }
        field(2;"Starting Date";Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(3;"Exchange Rate Amount";Decimal)
        {
            Caption = 'Exchange Rate Amount';
            DecimalPlaces = 1:6;
            MinValue = 0;
            
        }
        field(4;"Adjustment Exch. Rate Amount";Decimal)
        {
            AccessByPermission = TableData 4=R;
            Caption = 'Adjustment Exch. Rate Amount';
            DecimalPlaces = 1:6;
            MinValue = 0;
            
        }
        field(5;"Relational Currency Code";Code[10])
        {
            Caption = 'Relational Currency Code';
            
        }
        field(6;"Relational Exch. Rate Amount";Decimal)
        {
            AccessByPermission = TableData 4=R;
            Caption = 'Relational Exch. Rate Amount';
            DecimalPlaces = 1:6;
            MinValue = 0;
            
        }
        field(7;"Fix Exchange Rate Amount";Option)
        {
            Caption = 'Fix Exchange Rate Amount';
            OptionCaption = 'Currency,Relational Currency,Both';
            OptionMembers = Currency,"Relational Currency",Both;
        }
        field(8;"Relational Adjmt Exch Rate Amt";Decimal)
        {
            AccessByPermission = TableData 4=R;
            Caption = 'Relational Adjmt Exch Rate Amt';
            DecimalPlaces = 1:6;
            MinValue = 0;
            
        }
    }
}
