table 50002 "Lot Entry"
{
    fields
    {
        field(1;"Document Type";Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Purchase Order",,,"Transfer Order","Whse. Shipment";
        }
        field(2;"Document No.";Code[20])
        {
            // cleaned
        }
        field(3;"Order Line No.";Integer)
        {
            // cleaned
        }
        field(4;"Line No.";Integer)
        {
            // cleaned
        }
        field(5;"Item No.";Code[20])
        {
            // cleaned
        }
        field(6;Description;Text[50])
        {
            // cleaned
        }
        field(7;"Unit of Measure Code";Code[10])
        {
            // cleaned
        }
        field(8;Quantity;Decimal)
        {
            // cleaned
        }
        field(9;"Lot No.";Code[20])
        {
            
        }
        field(10;"External Lot No.";Code[30])
        {
            Editable = false;
            
        }
        field(13;"Location Code";Code[10])
        {
            // cleaned
        }
        field(15;"Variant Code";Code[10])
        {
            // cleaned
        }
        field(17;"Expiration Date";Date)
        {
            // cleaned
        }
        field(18;"Creation Date";Date)
        {
            // cleaned
        }
        field(50000;"Inspected Parts";Boolean)
        {
            Editable = false;
        }
        field(50010;"Revision No.";Code[20])
        {
            Description = 'flowfield based on lot chosen';
            Editable = false;
        }
        field(50011;"Use Revision No.";Code[20])
        {
            Description = 'used internal for filters and info';
        }
        field(50080;"Country of Origin";Code[10])
        {
            Editable = false;
        }
        field(60000;"CVE Pediment No.";Code[10])
        {
            Editable = false;
        }
    }
}
