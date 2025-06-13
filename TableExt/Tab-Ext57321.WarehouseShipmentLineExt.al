tableextension 57321 "Warehouse Shipment Line Ext" extends "Warehouse Shipment Line"
{
    fields
    {
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
