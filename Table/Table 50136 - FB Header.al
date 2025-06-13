table 50136 "FB Header"
{
    fields
    {
        field(10;"No.";Code[20])
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
        field(49;"Import Date";Date)
        {
            // cleaned
        }
        field(50;"Import File Name";Code[200])
        {
            // cleaned
        }
        field(51;"Import Data Log No.";Code[20])
        {
            // cleaned
        }
        field(60;"Sales Order No.";Code[20])
        {
            // cleaned
        }
        field(100;"No. Series";Code[10])
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
            
            //<< NIF
        }
        field(50000;"Import Time";Time)
        {
            // cleaned
        }
    }
}
