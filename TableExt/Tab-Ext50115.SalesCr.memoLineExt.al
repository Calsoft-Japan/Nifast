tableextension 50115 "Sales Cr.Memo Line Ext" extends "Sales Cr.Memo Line"
{
    fields
    {
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
    }
}
