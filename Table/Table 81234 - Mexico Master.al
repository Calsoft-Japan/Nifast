table 81234 "Mexico Master"
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
        field(3; CustNo; Code[20])
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
        field(23; "UnitPrice/M"; Decimal)
        {
            // cleaned
        }
        field(24; "UnitPrice/PC"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(25; CommRate; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(27; "UnitCostLCY/PC"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(28; "UnitCostLCY/M"; Decimal)
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
        field(60; NewRcvdCTNS; Decimal)
        {
            // cleaned
        }
        field(61; ForEaCust; Decimal)
        {
            // cleaned
        }
        field(62; NewRcvdPCS; Decimal)
        {
            // cleaned
        }
        field(63; NewRcvdWtKG; Decimal)
        {
            // cleaned
        }
        field(64; NewRcvdMXP; Decimal)
        {
            // cleaned
        }
        field(65; NewRcvdUSD; Decimal)
        {
            // cleaned
        }
        field(70; Location; Code[10])
        {
            // cleaned
        }
        field(71; StockCTNS; Decimal)
        {
            // cleaned
        }
        field(72; StockQtyPCS; Decimal)
        {
            // cleaned
        }
        field(73; "StockAmtMXP-Invoice"; Decimal)
        {
            // cleaned
        }
        field(74; "StockAmtMXP-Entry"; Decimal)
        {
            // cleaned
        }
        field(75; StockAmtUSD; Decimal)
        {
            // cleaned
        }
        field(101; "1Sales1"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(102; "1Sales2"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(103; "1Sales3"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(104; "1Sales4"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(105; "1Sales5"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(110; "1TotalSoldCTNS"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(111; "1TotalSoldQty"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(112; "1TotalSoldKG"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(113; "1TotalSoldUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(114; "1TotalProfitUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(115; "1Filler"; Code[10])
        {
            // cleaned
        }
        field(201; "2Sales1"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(202; "2Sales2"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(203; "2Sales3"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(204; "2Sales4"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(205; "2Sales5"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(210; "2TotalSoldCTNS"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(211; "2TotalSoldQty"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(212; "2TotalSoldKG"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(213; "2TotalSoldUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(214; "2TotalProfitUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(215; "2Filler"; Code[10])
        {
            // cleaned
        }
        field(301; "3Sales1"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(302; "3Sales2"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(303; "3Sales3"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(304; "3Sales4"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(305; "3Sales5"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(310; "3TotalSoldCTNS"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(311; "3TotalSoldQty"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(312; "3TotalSoldKG"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(313; "3TotalSoldUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(314; "3TotalProfitUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(315; "3Filler"; Code[10])
        {
            // cleaned
        }
        field(401; "4Sales1"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(402; "4Sales2"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(403; "4Sales3"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(404; "4Sales4"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(405; "4Sales5"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(410; "4TotalSoldCTNS"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(411; "4TotalSoldQty"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(412; "4TotalSoldKG"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(413; "4TotalSoldUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(414; "4TotalProfitUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(415; "4Filler"; Code[10])
        {
            // cleaned
        }
        field(501; "5Sales1"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(502; "5Sales2"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(503; "5Sales3"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(504; "5Sales4"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(505; "5Sales5"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(510; "5TotalSoldCTNS"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(511; "5TotalSoldQty"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(512; "5TotalSoldKG"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(513; "5TotalSoldUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(514; "5TotalProfitUSD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(515; "5Filler"; Code[10])
        {
            // cleaned
        }
        field(600; Blank; Code[10])
        {
            // cleaned
        }
        field(1000; "2005Onhand"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(1100; CurrOnhand; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(1200; "2006 Sales"; Decimal)
        {
            // cleaned
            CalcFormula = Sum(MexicoSalesHist.Qty WHERE("Master Entry No"=FIELD(EntryNo)));
            FieldClass = FlowField;
        }
        field(2000;PurchEntryNo;Integer)
        {
            // cleaned
        }
        field(2010;"Purch Qty";Decimal)
        {
            // cleaned
             CalcFormula = Sum("Mexico Purch Hist"."Qty (Purch)" WHERE (EntryNo=FIELD(PurchEntryNo)));
            FieldClass = FlowField;
        }
        field(3000;"NV Lot No.";Code[20])
        {
            // cleaned
        }
        field(3010;"Default CVE Pedimento";Code[10])
        {
            // cleaned
            CalcFormula = Lookup("Lot No. Information"."CVE Pedimento" WHERE ("Item No."=FIELD(ItemNo),
                                                                              "Lot No."=FIELD("NV Lot No.")));
            FieldClass = FlowField;
        }
        field(3020;PedimentoMismatch;Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1;EntryNo)
        {
        }
    }

    fieldgroups
    {
    }
}
