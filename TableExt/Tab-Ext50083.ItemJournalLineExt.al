tableextension 50083 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(50000;"Mfg. Lot No.";Code[30])
        {
            // cleaned
        }
        field(50010;"Drawing No.";Code[30])
        {
            // cleaned
        }
        field(50011;"Revision No.";Code[20])
        {
            // cleaned
        }
        field(50012;"Revision Date";Date)
        {
            // cleaned
        }
        field(50013;"PIJ Lot No.";Code[20])
        {
            Description = 'NF1.00:CIS.NG  06-29-16';
            Editable = false;
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
        field(52000;"Country of Origin Code";Code[10])
        {
            // cleaned
        }
        field(52010;Manufacturer;Code[50])
        {
            // cleaned
        }
        field(60022;"Tipo Cambio (ACY)";Decimal)
        {
            DecimalPlaces = 0:15;
            MinValue = 0;
        }
        field(60023;"Adjustment Batch Entry";Boolean)
        {
            Description = 'NF1.00:CIS.NG 07-21-16';
            Editable = false;
        }
    }
}
