table 70776 "SE0.52 Conversion"
{
    fields
    {
        field(1; "Table ID"; Integer)
        {
            // cleaned
        }
        field(2; Type; Option)
        {
            Editable = false;
            OptionCaption = 'Package,Document,Setup,Rate Shop,Item,Resource,Standard Option,Bill of Lading';
            OptionMembers = Package,Document,Setup,"Rate Shop",Item,Resource,"Standard Option","Bill of Lading";
        }
        field(3; "Source ID"; Code[20])
        {
            Editable = false;
            NotBlank = false;
            TableRelation = IF (Type = CONST(Package)) Package
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST("Standard Option")) "LAX Standard Option Setup";

            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(4; "Source Type"; Integer)
        {
            // cleaned
        }
        field(5; "Source Subtype"; Integer)
        {
            // cleaned
        }
        field(6; "Schedule B Code"; Code[20])
        {
            // cleaned
        }
        field(7; "Sched B Unit of Measure 1"; Code[10])
        {
            // cleaned
        }
        field(8; "Sched B Quantity 1"; Decimal)
        {
            // cleaned
        }
        field(9; "AES/FTSR Exemption"; Code[32])
        {
            // cleaned
        }
        field(10; "ISO 2 char Country Code"; Code[2])
        {
            // cleaned
        }
        field(11; FEDEX; Boolean)
        {
            // cleaned
        }
        field(12; UPS; Boolean)
        {
            // cleaned
        }
        field(13; LTL; Boolean)
        {
            // cleaned
        }
        field(14; Airborne; Boolean)
        {
            // cleaned
        }
        field(15; "Data Converted"; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Table ID", Type, "Source ID", "Source Type", "Source Subtype")
        {
        }
    }

    fieldgroups
    {
    }

    procedure TestUnique()
    begin
    end;

    procedure ModifyRecords()
    begin
    end;
}
