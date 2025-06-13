table 50016 "Ship Authorization Line"
{
    fields
    {
        field(1;"Sell-to Customer No.";Code[20])
        {
            // cleaned
        }
        field(2;"Document No.";Code[20])
        {
            // cleaned
        }
        field(3;"Line No.";Integer)
        {
            // cleaned
        }
        field(4;"Item No.";Code[20])
        {
            
        }
        field(5;"Cross-Reference No.";Code[20])
        {
            // cleaned
        }
        field(6;"Cross-Reference Type";Option)
        {
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(7;"Cross-Reference Type No.";Code[30])
        {
            
        }
        field(8;Quantity;Integer)
        {
            // cleaned
        }
        field(9;"Quantity Per Pack";Integer)
        {
            // cleaned
        }
        field(10;"Delivery Order Number";Text[35])
        {
            // cleaned
        }
        field(11;"Transport route";Text[35])
        {
            // cleaned
        }
        field(12;"Purchase Order Number";Text[35])
        {
            // cleaned
        }
        field(13;"Purchase Order Line No.";Code[10])
        {
            // cleaned
        }
        field(14;"Delivery Plan";Option)
        {
            OptionMembers = " ",Firm;
        }
        field(15;"Place ID";Code[25])
        {
            // cleaned
        }
        field(16;"Place Description";Text[30])
        {
            // cleaned
        }
        field(17;"Requested Delivery Date";Date)
        {
            // cleaned
        }
        field(18;"Requested Shipment Date";Date)
        {
            // cleaned
        }
        field(19;Description;Text[50])
        {
            // cleaned
        }
        field(20;"Unit of Measure";Text[10])
        {
            // cleaned
        }
        field(21;"Unit of Measure Code";Code[10])
        {
            // cleaned
        }
        field(30;"Kanban Plan Code";Text[35])
        {
            // cleaned
        }
        field(31;"Label 11z";Text[35])
        {
            // cleaned
        }
        field(32;"Label 12z";Text[35])
        {
            // cleaned
        }
        field(33;"Label 13z";Text[35])
        {
            // cleaned
        }
        field(34;"Label 14z";Text[35])
        {
            // cleaned
        }
        field(35;"Label 15z";Text[35])
        {
            // cleaned
        }
        field(36;"Label 16z";Text[35])
        {
            // cleaned
        }
        field(37;"Label 17z";Text[35])
        {
            // cleaned
        }
        field(40;"Kanban Serial Number Start";Text[35])
        {
            // cleaned
        }
        field(41;"Kanban Serial Number End";Text[35])
        {
            // cleaned
        }
        field(100;"EDI Unit of Measure";Code[10])
        {
            // cleaned
        }
        field(50000;"Item Type 1";Text[30])
        {
            // cleaned
        }
        field(50001;"Item Value 1";Text[30])
        {
            // cleaned
        }
        field(50002;"Item Type 2";Text[30])
        {
            // cleaned
        }
        field(50003;"Item Value 2";Text[30])
        {
            // cleaned
        }
        field(50004;"Receiving Dock";Text[30])
        {
            // cleaned
        }
        field(50005;"Additional Internal Destinatio";Text[30])
        {
            // cleaned
        }
        field(50006;"Shippers ID Number";Text[30])
        {
            // cleaned
        }
        field(50007;"Qty. Type";Option)
        {
            OptionMembers = " ","Cum. Qty. Shipped","Cum. Qty. Scheduled","Qty. to Ship","Period Qty. Planned";
        }
        field(50008;"Quantity Qualifier";Integer)
        {
            // cleaned
        }
        field(50051;"Ship Authorization No.";Code[10])
        {
            // cleaned
        }
    }
}
