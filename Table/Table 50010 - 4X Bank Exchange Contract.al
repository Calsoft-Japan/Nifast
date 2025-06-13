table 50010 "4X Bank Exchange Contract"
{
    fields
    {
        field(1;"No.";Code[10])
        {
            
            
        }
        field(2;BankName;Text[30])
        {
            // cleaned
        }
        field(3;Bank;Code[10])
        {
            
        }
        field(4;"Amount $";Decimal)
        {
            // cleaned
        }
        field(5;ExchangeRate;Decimal)
        {
            DecimalPlaces = 1:10;
            
        }
        field(6;AmountYen;Decimal)
        {
            
        }
        field(7;"Date Created";Date)
        {
            // cleaned
        }
        field(8;PeriodStart;Date)
        {
            
        }
        field(9;PeriodEnd;Date)
        {
            
        }
        field(10;Approved;Code[50])
        {
            Description = '10-->50 NF1.00:CIS.NG  10-10-15';
            //This property is currently not supported
            //TestTableRelation = false;
            
        }
        field(11;RemainingAmount;Decimal)
        {
            
        }
        field(12;"Sell Back Rate";Decimal)
        {
            DecimalPlaces = 2:5;
            
        }
        field(14;"Bank Contract No.";Code[30])
        {
            // cleaned
        }
        field(15;"No. Series";Code[10])
        {
            // cleaned
        }
        field(16;"Contract Complete";Boolean)
        {
            // cleaned
        }
        field(17;Expired;Boolean)
        {
            Editable = true;
        }
        field(18;JournalAmount;Decimal)
        {
            // cleaned
        }
        field(19;"Current Assigned Amount";Decimal)
        {
            Editable = false;
        }
        field(20;"Sell Back Amount";Decimal)
        {
            // cleaned
        }
        field(21;"Posted Amount";Decimal)
        {
            // cleaned
        }
    }
}
