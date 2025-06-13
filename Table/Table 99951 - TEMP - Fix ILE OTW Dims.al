table 99951 "TEMP - Fix ILE OTW Dims"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
        }
        field(2;"Item No.";Code[20])
        {
            Caption = 'Item No.';
        }
        field(3;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(4;"Entry Type";Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(5;"Source No.";Code[20])
        {
            Caption = 'Source No.';
        }
        field(6;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(7;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(8;"Location Code";Code[10])
        {
            Caption = 'Location Code';
        }
        field(10;Updated;Boolean)
        {
            // cleaned
        }
        field(12;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;
        }
        field(13;"Remaining Quantity";Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0:5;
        }
        field(14;"Invoiced Quantity";Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0:5;
        }
        field(28;"Applies-to Entry";Integer)
        {
            Caption = 'Applies-to Entry';
        }
        field(29;Open;Boolean)
        {
            Caption = 'Open';
        }
        field(33;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
        }
        field(34;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
        }
        field(36;Positive;Boolean)
        {
            Caption = 'Positive';
        }
        field(41;"Source Type";Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(47;"Drop Shipment";Boolean)
        {
            Caption = 'Drop Shipment';
        }
        field(50;"Transaction Type";Code[10])
        {
            Caption = 'Transaction Type';
        }
        field(51;"Transport Method";Code[10])
        {
            Caption = 'Transport Method';
        }
        field(52;"Country Code";Code[10])
        {
            Caption = 'Country Code';
        }
        field(59;"Entry/Exit Point";Code[10])
        {
            Caption = 'Entry/Exit Point';
        }
        field(60;"Document Date";Date)
        {
            Caption = 'Document Date';
        }
        field(61;"External Document No.";Code[20])
        {
            Caption = 'External Document No.';
        }
        field(63;"Transaction Specification";Code[10])
        {
            Caption = 'Transaction Specification';
        }
        field(64;"No. Series";Code[10])
        {
            Caption = 'No. Series';
        }
        field(70;"Reserved Quantity";Decimal)
        {
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(5401;"Prod. Order No.";Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(5404;"Qty. per Unit of Measure";Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0:5;
        }
        field(5407;"Unit of Measure Code";Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(5408;"Derived from Blanket Order";Boolean)
        {
            Caption = 'Derived from Blanket Order';
        }
        field(5700;"Cross-Reference No.";Code[30])
        {
            Caption = 'Cross-Reference No.';
            Description = 'Was 20 - NIFAST';
        }
        field(5704;"Item Category Code";Code[10])
        {
            Caption = 'Item Category Code';
        }
        field(5705;Nonstock;Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5706;"Purchasing Code";Code[10])
        {
            Caption = 'Purchasing Code';
        }
        field(5740;"Transfer Order No.";Code[20])
        {
            Caption = 'Transfer Order No.';
            Editable = false;
        }
        field(5800;"Completely Invoiced";Boolean)
        {
            Caption = 'Completely Invoiced';
        }
        field(5801;"Last Invoice Date";Date)
        {
            Caption = 'Last Invoice Date';
        }
        field(5802;"Applied Entry to Adjust";Boolean)
        {
            Caption = 'Applied Entry to Adjust';
        }
        field(5803;"Cost Amount (Expected)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected)';
            Editable = false;
        }
        field(5804;"Cost Amount (Actual)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
            Editable = false;
        }
        field(5805;"Cost Amount (Non-Invtbl.)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)';
            Editable = false;
        }
        field(5806;"Cost Amount (Expected) (ACY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected) (ACY)';
            Editable = false;
        }
        field(5807;"Cost Amount (Actual) (ACY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual) (ACY)';
            Editable = false;
        }
        field(5808;"Cost Amount (Non-Invtbl.)(ACY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
            Editable = false;
        }
        field(5813;"Purchase Amount (Expected)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Expected)';
            Editable = false;
        }
        field(5814;"Purchase Amount (Actual)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Actual)';
            Editable = false;
        }
        field(5815;"Sales Amount (Expected)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Expected)';
            Editable = false;
        }
        field(5816;"Sales Amount (Actual)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Actual)';
            Editable = false;
        }
        field(5817;Correction;Boolean)
        {
            Caption = 'Correction';
        }
        field(5832;"Prod. Order Line No.";Integer)
        {
            Caption = 'Prod. Order Line No.';
        }
        field(5833;"Prod. Order Comp. Line No.";Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
        }
        field(6501;"Lot No.";Code[20])
        {
            Caption = 'Lot No.';
            
        }
        field(50000;"Inspected Parts";Boolean)
        {
            Editable = false;
        }
        field(50005;"Mfg. Lot No.";Text[30])
        {
            Editable = false;
        }
        field(50007;"Revision No.";Code[20])
        {
            Editable = false;
        }
        field(60000;"New Dimension 1 Code";Code[10])
        {
            // cleaned
        }
        field(60010;"From ILE";Integer)
        {
            // cleaned
        }
    }
}
