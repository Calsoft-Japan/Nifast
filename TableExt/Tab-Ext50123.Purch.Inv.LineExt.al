tableextension 50123 "Purch. Inv. Line Ext" extends "Purch. Inv. Line"
{
    fields
    {
        field(50000;"Contract Note No.";Code[20])
        {
            // cleaned
        }
        field(50001;"Exchange Contract No.";Code[20])
        {
            // cleaned
        }
        field(50002;"USD Value";Decimal)
        {
            Description = 'Forex';
        }
        field(50800;"Entry/Exit Date";Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801;"Entry/Exit No.";Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802;National;Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(50803;"Is retention Line";Boolean)
        {
            Description = 'RET1.0';
        }
        field(50804;"Is Withholding Tax";Boolean)
        {
            Description = 'RET1.0';
        }
        field(52000;"Country of Origin Code";Code[10])
        {
            // cleaned
        }
        field(52010;Manufacturer;Code[50])
        {
            // cleaned
        }
    }
}
