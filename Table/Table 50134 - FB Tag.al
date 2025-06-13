table 50134 "FB Tag"
{
    fields
    {
        field(10;"No.";Code[20])
        {
            // cleaned
        }
        field(20;"Customer No.";Code[20])
        {
            // cleaned
        }
        field(30;"Ship-to Code";Code[10])
        {
            // cleaned
        }
        field(40;"Customer Bin";Code[20])
        {
            // cleaned
        }
        field(45;"Location Code";Code[10])
        {
            // cleaned
        }
        field(80;"Item No.";Code[20])
        {
            // cleaned
        }
        field(85;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
        }
        field(110;"Reorder Quantity";Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(120;"Min. Quantity";Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(130;"Max. Quantity";Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(140;"External Document No.";Code[20])
        {
            // cleaned
        }
        field(170;"Unit of Measure Code";Code[10])
        {
            // cleaned
        }
        field(180;"Selling Location";Code[10])
        {
            // cleaned
        }
        field(190;"Shipping Location";Code[10])
        {
            // cleaned
        }
        field(200;"Contract No.";Code[20])
        {
            
        }
        field(250;"FB Order Type";Option)
        {
            OptionCaption = ' ,Consigned,Non-Consigned';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
        field(300;"Replenishment Method";Option)
        {
            Caption = 'Replenishment Method';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(350;"Quantity Type";Option)
        {
            OptionCaption = 'Order,Usage,Count';
            OptionMembers = "Order",Usage,"Count";
        }
        field(500;"No. Series";Code[10])
        {
            // cleaned
        }
        field(5705;"Cross-Reference No.";Code[20])
        {
            Caption = 'Cross-Reference No.';
            
        }
    }
}
