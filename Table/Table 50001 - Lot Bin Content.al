table 50001 "Lot Bin Content"
{
    fields
    {
        field(1;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
            
        }
        field(2;"Zone Code";Code[10])
        {
            Caption = 'Zone Code';
            Editable = false;
            NotBlank = true;
            
        }
        field(3;"Bin Code";Code[20])
        {
            Caption = 'Bin Code';
            NotBlank = true;
            
        }
        field(4;"Item No.";Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            
            
        }
        field(5;"Lot No.";Code[20])
        {
            
        }
        field(10;"Bin Type Code";Code[10])
        {
            Caption = 'Bin Type Code';
            Editable = false;
        }
        field(11;"Warehouse Class Code";Code[10])
        {
            Caption = 'Warehouse Class Code';
            Editable = false;
        }
        field(12;"Block Movement";Option)
        {
            Caption = 'Block Movement';
            OptionCaption = ' ,Inbound,Outbound,All';
            OptionMembers = " ",Inbound,Outbound,All;
        }
        field(15;"Min. Qty.";Decimal)
        {
            Caption = 'Min. Qty.';
            DecimalPlaces = 0:5;
            MinValue = 0;
        }
        field(16;"Max. Qty.";Decimal)
        {
            Caption = 'Max. Qty.';
            DecimalPlaces = 0:5;
            MinValue = 0;
            
        }
        field(21;"Bin Ranking";Integer)
        {
            Caption = 'Bin Ranking';
            Editable = false;
        }
        field(26;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(29;"Pick Qty.";Decimal)
        {
            Caption = 'Pick Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(30;"Neg. Adjmt. Qty.";Decimal)
        {
            Caption = 'Neg. Adjmt. Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(31;"Put-away Qty.";Decimal)
        {
            Caption = 'Put-away Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(32;"Pos. Adjmt. Qty.";Decimal)
        {
            Caption = 'Pos. Adjmt. Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(37;"Fixed";Boolean)
        {
            Caption = 'Fixed';
        }
        field(40;"Cross-Dock Bin";Boolean)
        {
            Caption = 'Cross-Dock Bin';
        }
        field(41;Default;Boolean)
        {
            Caption = 'Default';
            
        }
        field(5402;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
            
        }
        field(5404;"Qty. per Unit of Measure";Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0:5;
            Editable = false;
            InitValue = 1;
        }
        field(5407;"Unit of Measure Code";Code[10])
        {
            Caption = 'Unit of Measure Code';
            NotBlank = true;
            
        }
        field(6501;"Serial No. Filter";Code[20])
        {
            Caption = 'Serial No. Filter';
        }
        field(50000;"Expiration Date";Date)
        {
            // cleaned
        }
        field(50001;"Creation Date";Date)
        {
            // cleaned
        }
        field(50005;"External Lot No.";Text[30])
        {
            // cleaned
        }
        field(50010;"Qty. to Handle";Decimal)
        {
            // cleaned
        }
        field(50020;"Qty. to Handle (Base)";Decimal)
        {
            // cleaned
        }
        field(50025;"Inspected Parts";Boolean)
        {
            Editable = false;
        }
        field(50027;Blocked;Boolean)
        {
            Editable = false;
        }
        field(50030;"Units per Parcel";Decimal)
        {
            // cleaned
        }
        field(50031;"Total Parcels";Decimal)
        {
            // cleaned
        }
        field(50035;"Revision No.";Code[20])
        {
            Editable = false;
        }
        field(50080;"Country of Origin";Code[10])
        {
            Editable = false;
        }
        field(60000;"CVE Pediment No.";Code[10])
        {
            Editable = false;
        }
    }
}
