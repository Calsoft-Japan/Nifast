table 50138 "FB Import Data Log"
{
    fields
    {
        field(5;"No.";Code[20])
        {
            // cleaned
        }
        field(12;"Line No.";Integer)
        {
            // cleaned
        }
        field(15;"Import File Name";Code[200])
        {
            // cleaned
        }
        field(20;"Import Date";Date)
        {
            // cleaned
        }
        field(25;"Import Time";Time)
        {
            // cleaned
        }
        field(30;"Customer No.";Code[20])
        {
            // cleaned
        }
        field(40;"Contract No.";Code[20])
        {
            // cleaned
        }
        field(50;"Location Code";Code[10])
        {
            // cleaned
        }
        field(60;"Ship-to Code";Code[10])
        {
            // cleaned
        }
        field(70;"Item No.";Code[20])
        {
            // cleaned
        }
        field(80;"Lot No.";Code[20])
        {
            // cleaned
        }
        field(90;"Tag No.";Code[20])
        {
            // cleaned
        }
        field(95;"Cross-Reference No.";Code[20])
        {
            // cleaned
        }
        field(100;"Variant Code";Code[10])
        {
            // cleaned
        }
        field(110;Quantity;Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(120;"Unit of Measure Code";Code[10])
        {
            // cleaned
        }
        field(140;"External Document No.";Code[20])
        {
            // cleaned
        }
        field(150;"Order Date";Date)
        {
            // cleaned
        }
        field(160;"Order Time";Time)
        {
            // cleaned
        }
        field(170;"Salesperson Code";Code[10])
        {
            Caption = 'Salesperson Code';
            
        }
        field(175;"Inside Salesperson Code";Code[10])
        {
            // cleaned
        }
        field(180;"Required Date";Date)
        {
            // cleaned
        }
        field(190;"Customer Bin";Code[20])
        {
            // cleaned
        }
        field(200;"Purchase Price";Decimal)
        {
            DecimalPlaces = 2:5;
        }
        field(210;"Sale Price";Decimal)
        {
            DecimalPlaces = 2:5;
        }
        field(350;"Quantity Type";Option)
        {
            OptionCaption = 'Order,Usage,Count';
            OptionMembers = "Order",Usage,"Count";
        }
        field(500;"Error Messages";Integer)
        {
            Editable = false;
        }
        field(510;"FB Order Exists";Boolean)
        {
            Editable = false;
        }
    }
}
