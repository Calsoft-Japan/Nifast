table 99953 "TEMP - Fix Reservation Entry"
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
        field(3;"Location Code";Code[10])
        {
            Caption = 'Location Code';
        }
        field(4;"Quantity (Base)";Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0:5;
            
        }
        field(5;"Reservation Status";Option)
        {
            Caption = 'Reservation Status';
            OptionCaption = 'Reservation,Tracking,Surplus,Prospect';
            OptionMembers = Reservation,Tracking,Surplus,Prospect;
        }
        field(7;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(8;"Creation Date";Date)
        {
            Caption = 'Creation Date';
        }
        field(9;"Transferred from Entry No.";Integer)
        {
            Caption = 'Transferred from Entry No.';
        }
        field(10;"Source Type";Integer)
        {
            Caption = 'Source Type';
        }
        field(11;"Source Subtype";Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(12;"Source ID";Code[20])
        {
            Caption = 'Source ID';
        }
        field(13;"Source Batch Name";Code[10])
        {
            Caption = 'Source Batch Name';
        }
        field(14;"Source Prod. Order Line";Integer)
        {
            Caption = 'Source Prod. Order Line';
        }
        field(15;"Source Ref. No.";Integer)
        {
            Caption = 'Source Ref. No.';
        }
        field(16;"Appl.-to Item Entry";Integer)
        {
            Caption = 'Appl.-to Item Entry';
            Editable = false;
        }
        field(22;"Expected Receipt Date";Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(23;"Shipment Date";Date)
        {
            Caption = 'Shipment Date';
        }
        field(24;"Serial No.";Code[20])
        {
            Caption = 'Serial No.';
        }
        field(25;"Created By";Code[20])
        {
            Caption = 'Created By';
            //This property is currently not supported
            //TestTableRelation = false;
            
        }
        field(27;"Changed By";Code[20])
        {
            Caption = 'Changed By';
            //This property is currently not supported
            //TestTableRelation = false;
            
        }
        field(28;Positive;Boolean)
        {
            Caption = 'Positive';
            Editable = false;
        }
        field(29;"Qty. per Unit of Measure";Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0:5;
            Editable = false;
            InitValue = 1;
            
        }
        field(30;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;
        }
        field(31;"Action Message Adjustment";Decimal)
        {
            Caption = 'Action Message Adjustment';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(32;Binding;Option)
        {
            Caption = 'Binding';
            Editable = false;
            OptionCaption = ' ,Order-to-Order';
            OptionMembers = " ","Order-to-Order";
        }
        field(33;"Suppressed Action Msg.";Boolean)
        {
            Caption = 'Suppressed Action Msg.';
        }
        field(34;"Planning Flexibility";Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
        field(40;"Warranty Date";Date)
        {
            Caption = 'Warranty Date';
            Editable = false;
        }
        field(41;"Expiration Date";Date)
        {
            Caption = 'Expiration Date';
            Editable = false;
        }
        field(50;"Qty. to Handle (Base)";Decimal)
        {
            Caption = 'Qty. to Handle (Base)';
            DecimalPlaces = 0:5;
        }
        field(51;"Qty. to Invoice (Base)";Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0:5;
        }
        field(53;"Quantity Invoiced (Base)";Decimal)
        {
            Caption = 'Quantity Invoiced (Base)';
            DecimalPlaces = 0:5;
        }
        field(55;"Reserved Pick & Ship Qty.";Decimal)
        {
            Caption = 'Reserved Pick & Ship Qty.';
            DecimalPlaces = 0:5;
        }
        field(80;"New Serial No.";Code[20])
        {
            Caption = 'New Serial No.';
            Editable = false;
        }
        field(81;"New Lot No.";Code[20])
        {
            Caption = 'New Lot No.';
            Editable = false;
        }
        field(5400;"Lot No.";Code[20])
        {
            Caption = 'Lot No.';
        }
        field(5401;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
        }
        field(5817;Correction;Boolean)
        {
            Caption = 'Correction';
        }
        field(50000;"Mfg. Lot No.";Code[30])
        {
            // cleaned
        }
        field(50010;Updated;Boolean)
        {
            // cleaned
        }
    }
}
