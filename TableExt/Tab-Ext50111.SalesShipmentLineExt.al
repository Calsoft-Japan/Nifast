tableextension 50111 "Sales Shipment Line Ext" extends "Sales Shipment Line"
{
    fields
    {
        field(50005;"Certificate No.";Code[30])
        {
            // cleaned
        }
        field(50010;"Drawing No.";Code[30])
        {
            // cleaned
        }
        field(50020;"Revision No.";Code[20])
        {
            // cleaned
        }
        field(50025;"Revision Date";Date)
        {
            // cleaned
        }
        field(50027;"Revision No. (Label Only)";Code[20])
        {
            // cleaned
        }
        field(50030;"Total Parcels";Decimal)
        {
            DecimalPlaces = 0:2;
            Description = '#10069';
        }
        field(50100;"Storage Location";Code[10])
        {
            // cleaned
        }
        field(50105;"Line Supply Location";Code[10])
        {
            // cleaned
        }
        field(50110;"Deliver To";Code[10])
        {
            // cleaned
        }
        field(50115;"Receiving Area";Code[10])
        {
            // cleaned
        }
        field(50120;"Ran No.";Code[20])
        {
            // cleaned
        }
        field(50125;"Container No.";Code[20])
        {
            // cleaned
        }
        field(50130;"Kanban No.";Code[20])
        {
            // cleaned
        }
        field(50135;"Res. Mfg.";Code[20])
        {
            // cleaned
        }
        field(50140;"Release No.";Code[20])
        {
            // cleaned
        }
        field(50145;"Mfg. Date";Date)
        {
            // cleaned
        }
        field(50150;"Man No.";Code[20])
        {
            // cleaned
        }
        field(50155;"Delivery Order No.";Code[20])
        {
            // cleaned
        }
        field(50157;"Plant Code";Code[10])
        {
            // cleaned
        }
        field(50160;"Dock Code";Code[10])
        {
            // cleaned
        }
        field(50165;"Box Weight";Decimal)
        {
            // cleaned
        }
        field(50170;"Store Address";Text[50])
        {
            // cleaned
        }
        field(50175;"FRS No.";Code[10])
        {
            // cleaned
        }
        field(50180;"Main Route";Code[10])
        {
            // cleaned
        }
        field(50185;"Line Side Address";Text[50])
        {
            // cleaned
        }
        field(50190;"Sub Route Number";Code[10])
        {
            // cleaned
        }
        field(50195;"Special Markings";Text[30])
        {
            // cleaned
        }
        field(50200;"Eng. Change No.";Code[20])
        {
            // cleaned
        }
        field(50205;"Group Code";Code[20])
        {
            // cleaned
        }
        field(50500;"Model Year";Code[10])
        {
            // cleaned
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
    }
}
