table 90000 "Table Import"
{
    fields
    {
        field(1;"Code";Code[10])
        {
            // cleaned
        }
        field(2;"Table";Option)
        {
            OptionMembers = Customer,Vendor,Item,"Gen. Journal","Item Journal","Sales Header","Sales Line","Purchase Header","Purchase Line","Sales Shipment Header","Sales Shipment Line","Sales Invoice Header","Sales Invoice Line","Sales Cr.Memo Header","Sales Cr.Memo Line","Purchase Rcpt. Header","Purchase Rcpt. Line","Purchase Invoice Header","Purchase Invoice Line","Purchase Cr. Memo Header","Purchase Cr. Memo Line";
            
        }
        field(3;Filetype;Option)
        {
            OptionMembers = Variable,"Fixed";
        }
        field(4;"Field start dilimiter";Text[1])
        {
            InitValue = '"';
        }
        field(5;"Field end dilimiter";Text[1])
        {
            InitValue = '"';
        }
        field(6;"Field seperator";Text[1])
        {
            InitValue = ',';
        }
        field(7;"Start Lineno.";Integer)
        {
            // cleaned
        }
        field(8;"Char Table";Option)
        {
            OptionMembers = OEM,Ansi;
        }
        field(9;"Allow Duplicates";Boolean)
        {
            // cleaned
        }
        field(10;"Update existing records";Boolean)
        {
            
        }
        field(20;"Default filename";Text[250])
        {
            // cleaned
        }
        field(21;"Delete Table Before Import";Boolean)
        {
            
        }
        field(22;Description;Text[80])
        {
            // cleaned
        }
        field(50;"Last import";Date)
        {
            Editable = false;
        }
    }
}
