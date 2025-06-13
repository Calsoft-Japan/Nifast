table 70778 "Conv. Package Info"
{
    fields
    {
        field(1;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Package,Document,Setup,Rate Shop,Item,Resource,Standard Option,Bill of Lading,,,,,Posted Package';
            OptionMembers = Package,Document,Setup,"Rate Shop",Item,Resource,"Standard Option","Bill of Lading",,,,,"Posted Package";
        }
        field(2;"Source ID";Code[20])
        {
            Caption = 'Source ID';
            NotBlank = false;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(3;"Source Type";Integer)
        {
            Caption = 'Source Type';
        }
        field(4;"Source Subtype";Integer)
        {
            Caption = 'Source Subtype';
        }
        field(11;Residential;Boolean)
        {
            // cleaned
        }
        field(12;Height;Decimal)
        {
            // cleaned
        }
        field(13;Width;Decimal)
        {
            // cleaned
        }
        field(14;Length;Decimal)
        {
            // cleaned
        }
    }
}
