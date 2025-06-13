tableextension 50339 "Item Application Entry Ext" extends "Item Application Entry"
{
    fields
    {
        field(50800;"Entry/Exit Date";Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801;"Entry/Exit No.";Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50803;"Entry/Exit Point";Code[10])
        {
            Caption = 'Entry/Exit Point';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
    }
}
