table 76505 "Renamed due to error(NIF Dupl)"
{
    // NF1.00:CIS.NG    10/10/15 Fix the Table Relation Property for fields (Remove the relationship for non exists table)

    Caption = 'Lot No. Information';
    DataCaptionFields = "Item No.", "Variant Code", "Lot No.", Description;
    DrillDownPageID = 6505;
    LookupPageID = 6505;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(3; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            NotBlank = true;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Test Quality"; Option)
        {
            Caption = 'Test Quality';
            OptionCaption = ' ,Good,Average,Bad';
            OptionMembers = " ",Good,"Average",Bad;
        }
        field(12; "Certificate Number"; Code[20])
        {
            Caption = 'Certificate Number';
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = Exist("Item Tracking Comment" WHERE(Type = CONST("Lot No."),
                                                               "Item No." = FIELD("Item No."),
                                                               "Variant Code" = FIELD("Variant Code"),
                                                               "Serial/Lot No." = FIELD("Lot No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                  "Lot No." = FIELD("Lot No."),
                                                                  "Location Code" = FIELD("Location Filter")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(22; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(23; "Bin Filter"; Code[20])
        {
            Caption = 'Bin Filter';
            FieldClass = FlowFilter;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Filter"));
        }
        field(24; "Expired Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Variant Code" = FIELD("Variant Code"),
                                                                              "Lot No." = FIELD("Lot No."),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Expiration Date" = FIELD("Date Filter"),
                                                                              Open = CONST(true),
                                                                              Positive = CONST(true)));
            Caption = 'Expired Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Mfg. Lot No."; Text[30])
        {
            // cleaned
        }
        field(50050; "Mfg. Date"; Date)
        {
            // cleaned
        }
        field(50055; "Mfg. Name"; Text[50])
        {
            // cleaned
        }
        field(50060; "Vendor No."; Code[20])
        {
            // cleaned
        }
        field(50070; "Vendor Name"; Text[50])
        {
            // cleaned
        }
        field(50075; "Date Received"; Date)
        {
            // cleaned
        }
        field(50080; "Country of Origin"; Code[10])
        {
            // cleaned
        }
        field(50090; "Source Location"; Code[10])
        {
            // cleaned
        }
        field(50100; "Multiple Certifications"; Integer)
        {
            CalcFormula = Count("Certifcation Results" WHERE("Lot No." = FIELD("Lot No."),
                                                              "Item No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50105; "Certification Number"; Code[20])
        {
            // cleaned
        }
        field(50110; "Certification Type"; Option)
        {
            OptionMembers = " ",Internal,Vendor,Manufacturer;
        }
        field(50115; "Certification Scope"; Option)
        {
            OptionMembers = " ","Visual Only",Sample,Full;
        }
        field(50120; "Passed Inspection"; Boolean)
        {
            trigger OnValidate()
            var
            /*   ">>NIF_LV": Integer;
              LotNoInfo2: Record 6505; */
            begin
            end;
        }
        field(50125; "Inspection Comments"; Text[100])
        {
            // cleaned
        }
        field(50130; "Quantity Tested"; Decimal)
        {
            // cleaned
        }
        field(50135; "Tested By"; Code[10])
        {
            // cleaned
        }
        field(50140; "Tested Date"; Date)
        {
            // cleaned
        }
        field(50150; "Tested Time"; Time)
        {
            // cleaned
        }
        field(50155; "QC Order Lines"; Integer)
        {
            Description = 'NF1.00:CIS.NG 10-10-15';
            Editable = false;
            Enabled = false;
            // FieldClass = FlowField;
        }
        field(50160; "PO Number"; Code[20])
        {
            // cleaned
        }
        field(50170; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50171; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50172; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50500; "Open Whse. Entries Exist"; Boolean)
        {
            CalcFormula = Exist("Warehouse Entry" WHERE("Item No." = FIELD("Item No."),
                                                          "Lot No." = FIELD("Lot No."),
                                                          Open = CONST(true),
                                                          "Location Code" = FIELD("Location Filter"),
                                                          "Bin Code" = FIELD("Bin Filter"),
                                                          "Variant Code" = FIELD("Variant Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Item No.", "Variant Code", "Lot No.")
        {
        }
        key(Key2; "Item No.", "Mfg. Lot No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //  ItemTrackingComment: Record 6506;

    procedure GetBinContentBuffer(var BinContentBuffer: Record 7330 temporary): Text[200]
    var
    /*   BinContent: Record 7302;
      Location: Record 14;
      ItemLedgEntry: Record 32;
      LotNoInfo: Record 6505; */
    begin
    end;

    procedure GetBinContentArray(var LocationBin: array[20, 20] of Code[20])
    var
    /*   BinContentBuffer: Record 7330 temporary;
      i: Integer; */
    begin
    end;

    procedure InLocationBin(): Text[200]
    var
    /*  BinContentBuffer: Record 7330 temporary;
     BinString: Code[200]; */
    begin
    end;

    procedure InLocationBinGross(): Text[200]
    var
    /*  BinContentBuffer: Record 7330 temporary;
     BinString: Code[200]; */
    begin
    end;

    procedure ShowBinContentBuffer()
    var
    // LotBinContentBuffer: Record 7330;
    begin
    end;

    procedure ShowBinContentBufferGross()
    var
    //LotBinContentBuffer: Record 7330;
    begin
    end;

    procedure OutstQtyOnSalesOrder() TotalQty: Decimal
    var
    //ReservEntry: Record 337;
    begin
    end;

    procedure OutstQtyOnTransfOrder() TotalQty: Decimal
    var
    //  ReservEntry: Record 337;
    begin
    end;

    procedure CalcUnassignedQty() TotalQty: Decimal
    var
    /*   ReservEntry: Record 337;
      WhseActvLine: Record 5767; */
    begin
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure CheckQCPermission(ChangedField: Text[50])
    var
    // UserSetup: Record 91;
    begin
    end;
}
