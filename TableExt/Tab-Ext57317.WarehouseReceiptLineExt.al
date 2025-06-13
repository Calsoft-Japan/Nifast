tableextension 57317 "Warehouse Receipt Line Ext" extends "Warehouse Receipt Line"
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
        field(60002;"Assigned User ID";Code[20])
        {
            Caption = 'Assigned User ID';
            Editable = false;
        }
        field(60004;"Assignment Date";Date)
        {
            Caption = 'Assignment Date';
            Editable = false;
        }
        field(60005;"Assignment Time";Time)
        {
            Caption = 'Assignment Time';
            Editable = false;
        }
    }
}
