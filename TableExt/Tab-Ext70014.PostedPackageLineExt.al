tableextension 70114 PostedPackageLineExt extends "LAX Posted Package Line"
{
    fields
    {
        field(50000; "Mfg. Lot No."; Code[30])

        {

        }

        field(50005; "Certificate No."; Code[30])

        {

        }

        field(50010; "Drawing No."; Code[30])

        {

        }

        field(50020; "Revision No."; Code[20])

        {

        }

        field(50025; "Revision Date"; Date)

        {

        }

        field(50035; "Bin Code"; Code[20])

        {

            TableRelation = Bin;

        }

        field(50040; "Cross Reference No."; Code[30])

        {

            Description = 'was 20 NIFAST';

        }

        field(50100; "Storage Location"; Code[10])

        {

        }

        field(50105; "Line Supply Location"; Code[10])

        {

        }

        field(50110; "Deliver To"; Code[10])

        {

        }

        field(50115; "Receiving Area"; Code[10])

        {

        }

        field(50120; "Ran No."; Code[20])

        {

        }

        field(50125; "Container No."; Code[20])

        {

        }

        field(50130; "Kanban No."; Code[20])

        {

        }

        field(50135; "Res. Mfg."; Code[20])

        {

        }

        field(50140; "Release No."; Code[20])

        {

        }

        field(50145; "Mfg. Date"; Date)

        {

        }

        field(50150; "Man No."; Code[20])

        {

        }

        field(50155; "Delivery Order No."; Code[20])

        {

        }

        field(50160; "Dock Code"; Code[10])

        {

        }

        field(50165; "Box Weight"; Decimal)

        {

        }

        field(50170; "Store Address"; Text[50])

        {

        }

        field(50175; "FRS No."; Code[10])

        {

        }

        field(50180; "Main Route"; Code[10])

        {

        }

        field(50185; "Line Side Address"; Text[50])

        {

        }

        field(50190; "Sub Route Number"; Code[10])

        {

        }

        field(50195; "Special Markings"; Text[30])

        {

        }

        field(50200; "Eng. Change No."; Code[20])

        {

        }

        field(50500; "Order Line No."; Integer)

        {

        }

        field(50510; "External Document No."; Code[20])

        {

        }

        field(60010; "Carton First SrNo."; Text[30])

        {

        }

        field(60020; "Carton Last SrNo."; Text[30])

        {

        }

        field(60030; "Master Label SrNo."; Text[30])

        {

        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}