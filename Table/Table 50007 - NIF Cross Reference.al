table 50007 "NIF Cross Reference"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            // cleaned
        }
        field(10; Type; Option)
        {
            OptionCaption = ' ,Customer,Vendor,Item,Location';
            OptionMembers = " ",Customer,Vendor,Item,Location;
        }
        field(20; "Orig. No."; Code[30])
        {
            // cleaned
        }
        field(30; "Navision No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Customer)) Customer
            ELSE IF (Type = CONST(Vendor)) Vendor
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Location)) Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(40; Name; Text[80])
        {
            // cleaned
        }
        field(50; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(57; "Bin Code"; Code[20])
        {
            // cleaned
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(60; "Currency Code"; Code[10])
        {
            // cleaned
            TableRelation = Currency;
        }
        field(62; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(63; "Active Revision"; Boolean)
        {
            // cleaned
        }
        field(100; "Possible Duplicate"; Boolean)
        {
            // cleaned
        }
        field(110; "NIF Alt. No."; Code[30])
        {
            // cleaned
        }
        field(900; "Base No."; Code[20])
        {
            // cleaned
        }
        field(910; StrippedNo; Code[30])
        {
            // cleaned
        }
        field(950; "Exceeds Length"; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Type, "Location Code", "Orig. No.")
        {
        }
        key(Key3; Type, "Navision No.", "Orig. No.")
        {
        }
        key(Key4; Type, "Base No.")
        {
        }
        key(Key5; Type, "Orig. No.")
        {
        }
    }
    fieldgroups
    {
    }

    procedure GetNextEntryNo(): Integer
    var
        NIFCrossRef: Record 50007;
    begin
        NIFCrossRef.LOCKTABLE();
        IF NIFCrossRef.FindLast() THEN
            EXIT(NIFCrossRef."Entry No." + 1)
        ELSE
            EXIT(1);
    end;
}
