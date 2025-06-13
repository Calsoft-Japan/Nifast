table 50137 "FB Line"
{
    fields
    {
        field(10;"Document No.";Code[20])
        {
            // cleaned
        }
        field(20;"Line No.";Integer)
        {
            // cleaned
        }
        field(25;"Order Date";Date)
        {
            // cleaned
        }
        field(30;"Sell-to Customer No.";Code[20])
        {
            // cleaned
        }
        field(40;"Ship-To Code";Code[10])
        {
            // cleaned
        }
        field(45;"Location Code";Code[10])
        {
            // cleaned
        }
        field(50;"Item No.";Code[20])
        {
            
        }
        field(52;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
        }
        field(60;Quantity;Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(70;"Unit of Measure Code";Code[10])
        {
            
        }
        field(80;"Tag No.";Code[20])
        {
            
        }
        field(85;"Lot No.";Code[20])
        {
            // cleaned
        }
        field(90;"Customer Bin";Code[20])
        {
            // cleaned
        }
        field(100;"Sales Order No.";Code[20])
        {
            // cleaned
        }
        field(101;"Sales Order Line No.";Integer)
        {
            // cleaned
        }
        field(102;"Transfer Order No.";Code[20])
        {
            // cleaned
        }
        field(103;"Transfer Order Line No.";Integer)
        {
            // cleaned
        }
        field(110;Status;Option)
        {
            OptionCaption = 'New,Errors,Processed';
            OptionMembers = New,Errors,Processed;
        }
        field(120;"FB Order Type";Option)
        {
            OptionCaption = ' ,Consigned,Non-Consigned';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
        field(140;"External Document No.";Code[20])
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
        field(300;"Replenishment Method";Option)
        {
            Caption = 'Replenishment Method';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(900;"Import Data Log No.";Code[20])
        {
            // cleaned
        }
        field(901;"Import Data Log Line No.";Integer)
        {
            // cleaned
        }
        field(5705;"Cross-Reference No.";Code[20])
        {
            Caption = 'Cross-Reference No.';
            
        }
        field(5706;"Unit of Measure (Cross Ref.)";Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
        }
        field(5707;"Cross-Reference Type";Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708;"Cross-Reference Type No.";Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
    }
}
