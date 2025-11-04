tableextension 70008 "Packing Control Ext" extends "LAX Packing Control"
{
    fields
    {
        field(50000; "Mfg. Lot No."; Code[30])
        {
        }
        field(50002; "Drawing No."; Code[30])
        {
        }
        field(50003; "Revision No."; Code[20])
        {
            Editable = true;
        }
        field(50004; "Revision Date"; Date)
        {
        }
        field(50005; "Certificate No."; Code[30])
        {
        }
        field(50030; "Location Code"; Code[20])
        {
            TableRelation = Bin;
        }
        field(50035; "Bin Code"; Code[20])
        {
        }
        field(50040; "Cross Reference No."; Code[20])
        {
        }
        field(50500; "Order Line No."; Integer)
        {
        }
    }
}
