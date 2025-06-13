table 70785 "Conv. SE0.55.06 Data"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            // cleaned
        }
        field(10;Type;Option)
        {
            OptionCaption = 'Package,Document,Setup,Rate Shop,Item,Resource,Standard Option,Bill of Lading,Master Data';
            OptionMembers = Package,Document,Setup,"Rate Shop",Item,Resource,"Standard Option","Bill of Lading","Master Data";
        }
        field(20;"Source ID";Code[20])
        {
            // cleaned
        }
        field(30;"Source Type";Integer)
        {
            // cleaned
        }
        field(40;"Source SubType";Integer)
        {
            // cleaned
        }
        field(50;Posted;Boolean)
        {
            // cleaned
        }
        field(60;"Mailpiece Shape";Option)
        {
            OptionCaption = ' ,Card,Letter,Flat,Parcel,Medium Flat Rate Box,Flat Rate Envelope,Irregular Parcel,Large Flat Rate Box,Large Parcel,Oversized Parcel,Small Flat Rate Box,Flat Rate Padded Envelope';
            OptionMembers = " ",Card,Letter,Flat,Parcel,"Medium Flat Rate Box","Flat Rate Envelope","Irregular Parcel","Large Flat Rate Box","Large Parcel","Oversized Parcel","Small Flat Rate Box","Flat Rate Padded Envelope";
        }
    }
}
