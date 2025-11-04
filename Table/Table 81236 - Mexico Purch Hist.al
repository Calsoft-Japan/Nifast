table 81236 "Mexico Purch Hist"
{
    fields
    {
        field(1; EntryNo; Integer)
        {
            // cleaned
        }
        field(2; ItemNo; Code[20])
        {
            // cleaned
        }
        field(4; VendNo; Code[20])
        {
            // cleaned
        }
        field(5; VOInvoiceNo; Code[20])
        {
            // cleaned
        }
        field(10; ItemDesc; Text[30])
        {
            // cleaned
        }
        field(11; ItemDesc2; Text[30])
        {
            // cleaned
        }
        field(12; CoutryOfOrigin; Code[10])
        {
            // cleaned
        }
        field(15; StdNetPack; Decimal)
        {
            // cleaned
        }
        field(16; NetWeightKG; Decimal)
        {
            // cleaned
        }
        field(20; "AvgCost(NVL)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(21; "UnitCost/M"; Decimal)
        {
            // cleaned
        }
        field(22; "UnitCost/PC"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(23; "UnitCostLCY/PC"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(24; "UnitCostLCY/M"; Decimal)
        {
            // cleaned
        }
        field(25; CommRate; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(26; "Qty (Calc)"; Decimal)
        {
            // cleaned
        }
        field(27; "Qty (Purch)"; Decimal)
        {
            // cleaned
        }
        field(28; LineAmount; Decimal)
        {
            // cleaned
        }
        field(30; DateRcvd; Date)
        {
            // cleaned
        }
        field(31; VendInvDate; Date)
        {
            // cleaned
        }
        field(32; VendInvNo; Code[10])
        {
            // cleaned
        }
        field(35; CustAgentLicNo; Code[10])
        {
            // cleaned
        }
        field(36; SummEntryNo; Code[20])
        {
            // cleaned
        }
        field(37; CustAgentES; Code[10])
        {
            // cleaned
        }
        field(40; SummEntryCode; Code[10])
        {
            // cleaned
        }
        field(41; DateOfEntry; Date)
        {
            // cleaned
        }
        field(42; "ExchRate(OfficialList)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(43; ExchRateDayPrior; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(44; ExchRateImportDoc; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50; NifastPONo; Code[20])
        {
            // cleaned
        }
        field(51; LotNo; Code[20])
        {
            // cleaned
        }
        field(500; "2005OH"; Decimal)
        {
            // cleaned
        }
        field(501; "2006Sales"; Decimal)
        {
            // cleaned
        }
        field(502; "2006OH"; Decimal)
        {
            // cleaned
        }
        field(503; NewRcvdQty; Decimal)
        {
            // cleaned
        }
        field(1000; "NV Lot No."; Code[20])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; EntryNo)
        {
            SumIndexFields = "Qty (Purch)";
        }
    }

    fieldgroups
    {
    }
}
