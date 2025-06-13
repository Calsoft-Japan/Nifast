table 80001 "Purchase Header NV"
{
    fields
    {
        field(1;"Document Type";Code[10])
        {
            // cleaned
        }
        field(2;"Buy-from Vendor No.";Code[20])
        {
            Caption = 'Buy-from Vendor No.';
        }
        field(3;"No.";Code[20])
        {
            Caption = 'No.';
        }
        field(4;"Pay-to Vendor No.";Code[20])
        {
            Caption = 'Pay-to Vendor No.';
        }
        field(5;"Pay-to Name";Text[50])
        {
            Description = 'NV3.60';
        }
        field(6;"Pay-to Name 2";Text[50])
        {
            Description = 'NV3.60';
        }
        field(7;"Pay-to Address";Text[30])
        {
            Caption = 'Address';
        }
        field(8;"Pay-to Address 2";Text[30])
        {
            Caption = 'Address 2';
        }
        field(9;"Pay-to City";Text[30])
        {
            Caption = 'City';
        }
        field(10;"Pay-to Contact";Text[30])
        {
            Caption = 'Contact';
        }
        field(11;"Your Reference";Text[30])
        {
            Caption = 'Your Reference';
        }
        field(12;"Ship-to Code";Code[10])
        {
            Caption = 'Ship-to Code';
        }
        field(13;"Ship-to Name";Text[50])
        {
            Description = 'NV3.60';
        }
        field(14;"Ship-to Name 2";Text[50])
        {
            Description = 'NV3.60';
        }
        field(15;"Ship-to Address";Text[30])
        {
            Caption = 'Ship-to Address';
        }
        field(16;"Ship-to Address 2";Text[30])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17;"Ship-to City";Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18;"Ship-to Contact";Text[30])
        {
            Caption = 'Ship-to Contact';
        }
        field(19;"Order Date";Date)
        {
            Caption = 'Order Date';
        }
        field(20;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(21;"Expected Receipt Date";Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(22;"Posting Description";Text[50])
        {
            Caption = 'Posting Description';
        }
        field(23;"Payment Terms Code";Code[10])
        {
            Caption = 'Payment Terms Code';
        }
        field(24;"Due Date";Date)
        {
            Caption = 'Due Date';
        }
        field(25;"Payment Discount %";Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0:5;
        }
        field(26;"Pmt. Discount Date";Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27;"Shipment Method Code";Code[10])
        {
            Caption = 'Shipment Method Code';
        }
        field(28;"Location Code";Code[10])
        {
            Caption = 'Location Code';
        }
        field(29;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(30;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(31;"Vendor Posting Group";Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
        }
        field(32;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
        }
        field(35;"Prices Including VAT";Boolean)
        {
            Caption = 'Prices Including Tax';
            
        }
        field(37;"Invoice Disc. Code";Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(41;"Language Code";Code[10])
        {
            Caption = 'Language Code';
        }
        field(43;"Purchaser Code";Code[10])
        {
            Description = 'NV3.60';
        }
        field(45;"Order Class";Code[10])
        {
            Caption = 'Order Class';
        }
        field(51;"On Hold";Code[3])
        {
            Caption = 'On Hold';
        }
        field(52;"Applies-to Doc. Type";Code[10])
        {
            // cleaned
        }
        field(53;"Applies-to Doc. No.";Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(55;"Bal. Account No.";Code[20])
        {
            Caption = 'Bal. Account No.';
        }
        field(56;"Job No.";Code[20])
        {
            Caption = 'Job No.';
        }
        field(66;"Vendor Order No.";Code[20])
        {
            Caption = 'Vendor Order No.';
        }
        field(67;"Vendor Shipment No.";Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(68;"Vendor Invoice No.";Code[20])
        {
            Caption = 'Vendor Invoice No.';
        }
        field(69;"Vendor Cr. Memo No.";Code[20])
        {
            Caption = 'Vendor Cr. Memo No.';
        }
        field(72;"Sell-to Customer No.";Code[20])
        {
            Caption = 'Sell-to Customer No.';
        }
        field(73;"Reason Code";Code[10])
        {
            Caption = 'Reason Code';
        }
        field(79;"Buy-from Vendor Name";Text[50])
        {
            Description = 'NV3.60';
        }
        field(80;"Buy-from Vendor Name 2";Text[50])
        {
            Description = 'NV3.60';
        }
        field(81;"Buy-from Address";Text[30])
        {
            Caption = 'Buy-from Address';
        }
        field(82;"Buy-from Address 2";Text[30])
        {
            Caption = 'Buy-from Address 2';
        }
        field(83;"Buy-from City";Text[30])
        {
            Caption = 'Buy-from City';
        }
        field(84;"Buy-from Contact";Text[30])
        {
            Caption = 'Buy-from Contact';
        }
        field(85;"Pay-to Post Code";Code[20])
        {
            Caption = 'ZIP Code';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(86;"Pay-to County";Text[30])
        {
            Caption = 'State';
        }
        field(87;"Pay-to Country Code";Code[10])
        {
            Caption = 'Country Code';
        }
        field(88;"Buy-from Post Code";Code[20])
        {
            Caption = 'Buy-from ZIP Code';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(89;"Buy-from County";Text[30])
        {
            Caption = 'Buy-from State';
        }
        field(90;"Buy-from Country Code";Code[10])
        {
            Caption = 'Buy-from Country Code';
        }
        field(91;"Ship-to Post Code";Code[20])
        {
            Caption = 'Ship-to ZIP Code';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(92;"Ship-to County";Text[30])
        {
            Caption = 'Ship-to State';
        }
        field(93;"Ship-to Country Code";Code[10])
        {
            Caption = 'Ship-to Country Code';
        }
        field(94;"Bal. Account Type";Code[10])
        {
            // cleaned
        }
        field(95;"Order Address Code";Code[10])
        {
            Caption = 'Order Address Code';
        }
        field(99;"Document Date";Date)
        {
            Caption = 'Document Date';
        }
        field(104;"Payment Method Code";Code[10])
        {
            Caption = 'Payment Method Code';
        }
        field(114;"Tax Area Code";Code[20])
        {
            Caption = 'Tax Area Code';
        }
        field(115;"Tax Liable";Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(118;"Applies-to ID";Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(120;Status;Code[10])
        {
            Editable = false;
        }
        field(121;"Invoice Discount Calculation";Code[10])
        {
            Editable = false;
        }
        field(122;"Invoice Discount Value";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(5700;"Responsibility Center";Code[10])
        {
            Caption = 'Responsibility Center';
        }
        field(5790;"Requested Receipt Date";Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791;"Promised Receipt Date";Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5800;"Vendor Authorization No.";Code[20])
        {
            Caption = 'Vendor Authorization No.';
        }
        field(5801;"Return Shipment No.";Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(5802;"Return Shipment No. Series";Code[10])
        {
            Caption = 'Return Shipment No. Series';
        }
        field(10005;"Ship-to UPS Zone";Code[2])
        {
            Caption = 'Ship-to UPS Zone';
        }
        field(10020;"1099 Code";Code[10])
        {
            Caption = '1099 Code';
        }
    }
}
