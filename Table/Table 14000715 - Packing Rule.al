table 99997 "Packing Rule"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //   >> NIF
    //   Fields Added:
    //     50000 Automatic Print Label
    //     50010 Package Line Label Code
    //     50030 Std. Package Label Code 2  12-08-05 RTT
    //   << NIF

    Caption = 'Packing Rule';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(11; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(13; "Allow UCC Label"; Boolean)
        {
            Caption = 'Allow UCC Label';

            trigger OnValidate()
            begin
                IF NOT "Allow UCC Label" THEN
                    "Print UCC Closing Package" := FALSE;
            end;
        }
        field(15; "Print UCC Closing Package"; Boolean)
        {
            Caption = 'Print UCC Closing Package';

        }
        field(16; "Default Package Type"; Code[1])
        {
            Caption = 'Default Package Type';
            CharAllowed = '09';
            InitValue = '1';
        }
        field(17; "Manufacturer Identification"; Code[10])
        {
            Caption = 'Manufacturer Identification';
            CharAllowed = '09';
        }
        field(18; "ASN Summary Type"; Option)
        {
            Caption = 'ASN Summary Type';
            OptionCaption = ' ,Shipment-Order-Item,Shipment-Order-Package-Item,Shipment-Order-Tare-Package-Item,Shipment-Order-Item-Package,Shipment-Package-Order-Item,Prioritized,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Shipment-Order-Item","Shipment-Order-Package-Item","Shipment-Order-Tare-Package-Item","Shipment-Order-Item-Package","Shipment-Package-Order-Item",Prioritized,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(19; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(23; "UCC Label Code (Item Only)"; Code[10])
        {
            Caption = 'UCC Label Code (Item Only)';
        }
        field(29; "Std. Package Label Code"; Code[10])
        {
            Caption = 'Std. Package Label Code';
        }
        field(30; "UCC 128 Mask"; Code[30])
        {
            Caption = 'UCC 128 Mask';
            InitValue = '00PMMMMMMMSSSSSSSSSC';

        }
        field(31; "UCC 128 Weight"; Code[30])
        {
            Caption = 'UCC 128 Weight';
            InitValue = '3131313131313131313';

        }
        field(34; "UCC 128 Printing Mask"; Code[50])
        {
            Caption = 'UCC 128 Printing Mask';
            InitValue = '(##) # ####### ######### #';

        }
        field(36; "Item UPC/EAN Printing Mask"; Code[50])
        {
            Caption = 'Item UPC/EAN Printing Mask';
            InitValue = '#  ##### #####  #';

        }
        field(37; "Std. Pack UPC/EAN Print. Mask"; Code[50])
        {
            Caption = 'Std. Pack UPC/EAN Print. Mask';
            InitValue = '##  #  ##### #####  #';

        }
        field(38; "Auto Bill of Lading When Ship"; Boolean)
        {
            Caption = 'Auto Bill of Lading When Ship';

        }
        field(39; "Auto Bill of Lading by Package"; Boolean)
        {
            Caption = 'Auto Bill of Lading by Package';

            trigger OnValidate()
            begin
                IF "Auto Bill of Lading by Package" THEN
                    TESTFIELD("Auto Bill of Lading When Ship");
            end;
        }
        field(40; "ASN Require UCC No."; Boolean)
        {
            Caption = 'ASN Require UCC No.';
        }
        field(41; "UCC Type"; Option)
        {
            Caption = 'UCC Type';
            OptionCaption = 'UCC 128,Item UPC/EAN,Std. Pack UPC/EAN';
            OptionMembers = "UCC 128","Item UPC/EAN","Std. Pack UPC/EAN";
        }
        field(42; "ASN with PO per Document"; Boolean)
        {
            Caption = 'ASN with PO per Document';
        }
        field(43; "UCC Label Code (Packages)"; Code[10])
        {
            Caption = 'UCC Label Code (Packages)';
        }
        field(44; "Default Fast Pack to Std. UOM"; Boolean)
        {
            Caption = 'Default Fast Pack to Std. UOM';
        }
        field(45; "Blank BOL No. when Post. Ship"; Boolean)
        {
            Caption = 'Blank BOL No. when Post. Ship';
        }
        field(46; "Release Bill of Lading Action"; Option)
        {
            Caption = 'Release Bill of Lading Action';
            OptionCaption = 'Ask,Create New Bill of Lading,Remove Document from Bill of Lading';
            OptionMembers = Ask,"Create New Bill of Lading","Remove Document from Bill of Lading";
        }
        field(48; "Add to Open Bill of Lading"; Boolean)
        {
            Caption = 'Add to Open Bill of Lading';
        }
        field(49; "Bill of Lading No. Mandatory"; Boolean)
        {
            Caption = 'Bill of Lading No. Mandatory';

            trigger OnValidate()
            begin
                IF "Bill of Lading No. Mandatory" THEN
                    TESTFIELD("Auto Bill of Lading When Ship", FALSE);
            end;
        }
        field(50; "Mixed Packages not Allowed"; Boolean)
        {
            Caption = 'Mixed Packages not Allowed';
        }
        field(51; "Custom Value 1"; Text[80])
        {
            Caption = 'Custom Value 1';
        }
        field(52; "Custom Value 2"; Text[80])
        {
            Caption = 'Custom Value 2';
        }
        field(53; "Custom Value 3"; Text[80])
        {
            Caption = 'Custom Value 3';
        }
        field(54; "Custom Value 4"; Text[80])
        {
            Caption = 'Custom Value 4';
        }
        field(55; "Custom Value 5"; Text[80])
        {
            Caption = 'Custom Value 5';
        }
        field(56; "Prioritized Level 1"; Option)
        {
            Caption = 'Prioritized Level 1';
            OptionCaption = ' ,Order,Tare,Package,Item';
            OptionMembers = " ","Order",Tare,Package,Item;
        }
        field(57; "Prioritized Level 2"; Option)
        {
            Caption = 'Prioritized Level 2';
            OptionCaption = ' ,Order,Tare,Package,Item';
            OptionMembers = " ","Order",Tare,Package,Item;
        }
        field(58; "Prioritized Level 3"; Option)
        {
            Caption = 'Prioritized Level 3';
            OptionCaption = ' ,Order,Tare,Package,Item';
            OptionMembers = " ","Order",Tare,Package,Item;
        }
        field(59; "Prioritized Level 4"; Option)
        {
            Caption = 'Prioritized Level 4';
            OptionCaption = ' ,Order,Tare,Package,Item';
            OptionMembers = " ","Order",Tare,Package,Item;
        }
        field(60; "Use OUM and Qty. in Prior."; Boolean)
        {
            Caption = 'Use OUM and Qty. in Prior.';
        }
        field(61; "Close Package Report ID"; Integer)
        {
            Caption = 'Close Package Report ID';

            trigger OnValidate()
            begin
                // CALCFIELDS("Close Package Report Name");
            end;
        }
        field(62; "Close Package Report Name"; Text[30])
        {
            Caption = 'Close Package Report Name';
            Editable = false;
        }
        field(63; "Close Sales Report ID"; Integer)
        {
            Caption = 'Close Sales Report ID';
            trigger OnValidate()
            begin
                // CALCFIELDS("Close Sales Report Name");
            end;
        }
        field(64; "Close Sales Report Name"; Text[30])
        {
            Caption = 'Close Sales Report Name';
            Editable = false;
        }
        field(65; "Item Label Code"; Code[10])
        {
            Caption = 'Item Label Code';
        }
        field(66; "Resource Label Code"; Code[10])
        {
            Caption = 'Resource Label Code';
        }
        field(67; "Shipment Invoicing Required"; Boolean)
        {
            Caption = 'Shipment Invoicing Required';
        }
        field(68; "Auto Release Summary"; Boolean)
        {
            Caption = 'Auto Release Summary';

            trigger OnValidate()
            begin
                TESTFIELD("Auto Bill of Lading When Ship");
                IF "Auto Release Summary" THEN
                    TESTFIELD("Auto Bill of Lading When Ship");
            end;
        }
        field(69; "Auto Post when ASN Send"; Boolean)
        {
            Caption = 'Auto Post when ASN Send';
        }
        field(70; "Do not Print Ship. Agent Label"; Boolean)
        {
            Caption = 'Do not Print Ship. Agent Label';
        }
        field(71; "VICS BOL Manufacturer Ident."; Code[20])
        {
            Caption = 'VICS BOL Manufacturer Ident.';
        }
        field(72; "VICS BOL 128 Mask"; Code[20])
        {
            Caption = 'VICS BOL 128 Mask';
            InitValue = 'MMMMMMMSSSSSSSSSC';

        }
        field(73; "VICS BOL 128 Weight"; Code[20])
        {
            Caption = 'VICS BOL 128 Weight';
            InitValue = '1313131313131313';

            trigger OnValidate()
            begin
                TESTFIELD("VICS BOL 128 Mask");

                CheckWeight("VICS BOL 128 Weight", "VICS BOL 128 Mask");
            end;
        }
        field(74; "VICS BOL 128 Printing Mask"; Code[30])
        {
            Caption = 'VICS BOL 128 Printing Mask';
            InitValue = '(402) #################';

        }
        field(75; "Create VICS BOL No. on Close"; Boolean)
        {
            Caption = 'Create VICS BOL No. on Close';
        }
        field(76; "VICS BOL Nos."; Code[10])
        {
            Caption = 'VICS BOL Nos.';
            TableRelation = "No. Series";
        }
        field(77; "Close Purchase Report ID"; Integer)
        {
            Caption = 'Close Purchase Report ID';

            trigger OnValidate()
            begin
                // CALCFIELDS("Close Sales Report Name");
            end;
        }
        field(78; "Close Purchase Report Name"; Text[30])
        {
            Caption = 'Close Purchase Report Name';
            Editable = false;
        }
        field(79; "Close Transfer Report ID"; Integer)
        {
            Caption = 'Close Transfer Report ID';

            trigger OnValidate()
            begin
                // CALCFIELDS("Close Sales Report Name");
            end;
        }
        field(80; "Close Transfer Report Name"; Text[30])
        {
            Caption = 'Close Transfer Report Name';
            Editable = false;
        }
        field(81; "Sales Order Pack Detail"; Boolean)
        {
            Caption = 'Sales Order Pack Detail';
        }
        field(82; "Sales Invoice Pack Detail"; Boolean)
        {
            Caption = 'Sales Invoice Pack Detail';
        }
        field(83; "Purch. Credit Memo Pack Detail"; Boolean)
        {
            Caption = 'Purch. Credit Memo Pack Detail';
        }
        field(84; "Purch.Return Order Pack Detail"; Boolean)
        {
            Caption = 'Purch.Return Order Pack Detail';
        }
        field(85; "Transfer Order Pack Detail"; Boolean)
        {
            Caption = 'Transfer Order Pack Detail';
        }
        field(86; "Update Package Type on Close"; Boolean)
        {
            Caption = 'Update Package Type on Close';
        }
        field(87; "Package Type (Item Only)"; Code[1])
        {
            Caption = 'Package Type (Item Only)';
            CharAllowed = '09';

            trigger OnValidate()
            begin
                IF "Package Type (Item Only)" <> '' THEN
                    TESTFIELD("Update Package Type on Close");
            end;
        }
        field(88; "Package Type (Packages)"; Code[1])
        {
            Caption = 'Package Type (Packages)';
            CharAllowed = '09';

            trigger OnValidate()
            begin
                IF "Package Type (Packages)" <> '' THEN
                    TESTFIELD("Update Package Type on Close");
            end;
        }
        field(89; "Bill of Lading Label Code"; Code[10])
        {
            Caption = 'Bill of Lading Label Code';
        }
        field(90; "Increment Level 1 (Advanced)"; Boolean)
        {
            Caption = 'Increment Level 1 (Advanced)';

            trigger OnValidate()
            begin
                IF "Increment Level 1 (Advanced)" THEN
                    TESTFIELD("ASN Summary Type");
            end;
        }
        field(91; "Increment Level 2 (Advanced)"; Boolean)
        {
            Caption = 'Increment Level 2 (Advanced)';

            trigger OnValidate()
            begin
                IF "Increment Level 2 (Advanced)" THEN
                    TESTFIELD("ASN Summary Type");
            end;
        }
        field(92; "Increment Level 3 (Advanced)"; Boolean)
        {
            Caption = 'Increment Level 3 (Advanced)';

            trigger OnValidate()
            begin
                IF "Increment Level 3 (Advanced)" THEN
                    TESTFIELD("ASN Summary Type");
            end;
        }
        field(93; "Increment Level 4 (Advanced)"; Boolean)
        {
            Caption = 'Increment Level 4 (Advanced)';

            trigger OnValidate()
            begin
                IF "Increment Level 4 (Advanced)" THEN
                    TESTFIELD("ASN Summary Type");
            end;
        }
        field(94; "Increment Level 5 (Advanced)"; Boolean)
        {
            Caption = 'Increment Level 5 (Advanced)';

            trigger OnValidate()
            begin
                IF "Increment Level 5 (Advanced)" THEN
                    TESTFIELD("ASN Summary Type");
            end;
        }
        field(95; "UCC 128 Sequence Nos."; Code[10])
        {
            Caption = 'UCC 128 Sequence Nos.';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                IF "UCC 128 Sequence Nos." <> '' THEN
                    // CALCFIELDS("Last UCC 128 Sequence No.");
                    TESTFIELD("Last UCC 128 Sequence No.", '');
            end;
        }
        field(96; "Last UCC 128 Sequence No."; Code[20])
        {
            Caption = 'Last UCC 128 Sequence No.';
            Editable = false;
        }
        field(97; "RF-ID Sequence Nos."; Code[10])
        {
            Caption = 'RF-ID Sequence Nos.';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                IF "RF-ID Sequence Nos." <> '' THEN
                    //CALCFIELDS("Last RF-ID Sequence No.");
                    TESTFIELD("Last RF-ID Sequence No.", '');

            end;
        }
        field(98; "Last RF-ID Sequence No."; Code[20])
        {
            Caption = 'Last RF-ID Sequence No.';
            Editable = false;
        }
        field(99; "Use UCC 128 Sequence for RF-ID"; Boolean)
        {
            Caption = 'Use UCC 128 Sequence for RF-ID';
        }
        field(100; "Print RF-ID Closing Package"; Boolean)
        {
            Caption = 'Print RF-ID Closing Package';
        }
        field(101; "Allow RF-ID Label"; Boolean)
        {
            Caption = 'Allow RF-ID Label';

            trigger OnValidate()
            begin
                IF NOT "Allow UCC Label" THEN
                    "Print UCC Closing Package" := FALSE;
            end;
        }
        field(102; "RF-ID Label Code (SGTIN)"; Code[10])
        {
            Caption = 'RF-ID Label Code (SGTIN)';
        }
        field(103; "RF-ID Label Code (SSCC)"; Code[10])
        {
            Caption = 'RF-ID Label Code (SSCC)';
        }
        field(104; "RF-ID Label Code (SGLN)"; Code[10])
        {
            Caption = 'RF-ID Label Code (SGLN)';
        }
        field(105; "Update RF-ID Type on Close"; Boolean)
        {
            Caption = 'Update RF-ID Type on Close';
        }
        field(106; "Fixed RF-ID Type"; Option)
        {
            Caption = 'Fixed RF-ID Type';
            OptionCaption = ' ,SGTIN,SSCC,SGLN,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ",SGTIN,SSCC,SGLN,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(107; "Assign UCC Closing Package"; Boolean)
        {
            Caption = 'Assign UCC Closing Package';
        }
        field(108; "Assign RF-ID Closing Package"; Boolean)
        {
            Caption = 'Assign RF-ID Closing Package';
        }
        field(109; "RF-ID Company Identification"; Code[10])
        {
            Caption = 'RF-ID Company Identification';
        }
        field(110; "Package Summary Type"; Option)
        {
            Caption = 'Package Summary Type';
            OptionCaption = ' ,Item all Levels,Item all Levels Summarize,Item all Levels Summarize Group by Box Size,Only Items,Only Items by Item,Only Items by Item and Variant,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Item all Levels","Item all Levels Summarize","Item all Levels Summarize Group by Box Size","Only Items","Only Items by Item","Only Items by Item and Variant",,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(111; "BOL Summary from Pack. Summary"; Boolean)
        {
            Caption = 'BOL Summary from Pack. Summary';

            trigger OnValidate()
            begin
                IF NOT "BOL Summary from Pack. Summary" THEN
                    TESTFIELD("ASN Summary from Pack. Summary", FALSE);
            end;
        }
        field(112; "ASN Summary from Pack. Summary"; Boolean)
        {
            Caption = 'ASN Summary from Pack. Summary';

            trigger OnValidate()
            begin
                IF "ASN Summary from Pack. Summary" THEN
                    TESTFIELD("BOL Summary from Pack. Summary");
            end;
        }
        field(113; "Lines from Pack. Summary Lines"; Boolean)
        {
            Caption = 'Lines from Pack. Summary Lines';
        }
        field(114; "Package Dimensions Required"; Boolean)
        {
            Caption = 'Package Dimensions Required';
        }
        field(115; "Use Ship-To Address from Doc."; Boolean)
        {
            Caption = 'Use Ship-To Address from Doc.';
        }
        field(50000; "Automatic Print Label"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Automatic Print Label" THEN
                    TESTFIELD("Package Line Label Code");
            end;
        }
        field(50010; "Package Line Label Code"; Code[10])
        {
        }
        field(50020; "No. of Labels"; Option)
        {
            OptionMembers = Quantity,"Quantity (Base)","One per Scan";
        }
        field(50030; "Std. Package Label Code 2"; Code[10])
        {
        }
        field(14000351; "Ship Notice Type"; Option)
        {
            Caption = 'Ship Notice Type';
            OptionCaption = 'ASN,ASN (Billing)';
            OptionMembers = ASN,"ASN (Billing)";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "ASN Summary Type")
        {
        }
    }



    var

        /*   Numbers: Integer;
          i: Integer;
   */
        ShippingSetupRetrieved: Boolean;
        /*  Text001: Label 'Item UPC/EAN Number is normally 12 digit, use this string anyway?';
         Text002: Label 'Nothing Changed.';
         Text003: Label 'Std. Pack. UPC/EAN Number is normally 14 digit, use this string anyway?'; */
        Text004: Label 'M part is not consecutive.';
        Text005: Label 'S part is not consecutive.';
        Text006: Label 'C must be last.';
        Text007: Label 'Only digits (1234567890) or\';
        Text008: Label 'P - Package Indicator (1 digit)\';
        Text009: Label 'M - Manufacturer Identification\';
        Text010: Label 'S - Sequence Number\';
        Text011: Label 'C - Check Digit (1 digit)\';
        Text012: Label 'are allowed in this field.';
        Text013: Label 'Maksimum 1 P is allowed.';
        Text014: Label 'Maksimum 1 C is allowed.';
        Text015: Label 'Length is %1 it must be %2.',
          Comment = '%1 = Current length, %2 = Required length.';

        Text016: Label 'Only digits allowed (1234567890).';
        Text017: Label 'A - VICS Bill of Lading (1 digit)\';
        Text018: Label 'Maksimum 1 A is allowed.';
    // Text019: Label 'Package Rule Code cannot be blank.';

    procedure CheckMask(Mask: Code[30])
    var
        i: Integer;
        Pos: Integer;
        PDigits: Integer;
        CDigits: Integer;
        MLast: Integer;
        SLast: Integer;
        ErrTxt: Text;
    begin
        PDigits := 0;
        CDigits := 0;
        FOR i := 1 TO STRLEN(Mask) DO BEGIN
            Pos := STRPOS('1234567890PMSC', COPYSTR(Mask, i, 1));

            CASE Pos OF
                11:
                    PDigits := PDigits + 1;
                12:
                    IF (MLast = 0) OR (MLast + 1 = i) THEN
                        MLast := i
                    ELSE
                        ERROR(Text004);
                13:
                    IF (SLast = 0) OR (SLast + 1 = i) THEN
                        SLast := i
                    ELSE
                        ERROR(Text005);
                14:
                    IF i <> STRLEN(Mask) THEN
                        ERROR(Text006)
                    ELSE
                        CDigits := CDigits + 1;
            END;

            ErrTxt := Text007 + Text008 + Text009 + Text010 + Text011 + Text012;
            IF Pos = 0 THEN
                ERROR(ErrTxt);
        END;

        IF PDigits > 1 THEN
            ERROR(Text013);
        IF CDigits > 1 THEN
            ERROR(Text014);
    end;

    procedure CheckWeight(Weight: Code[30]; Mask: Code[30])
    var
        i: Integer;
        Length: Integer;
    begin
        IF Weight = '' THEN
            EXIT;

        Length := STRLEN(Mask);
        IF STRPOS(Mask, 'C') <> 0 THEN
            Length := Length - 1;
        IF STRLEN(Weight) <> Length THEN
            ERROR(Text015, STRLEN(Weight), Length);

        FOR i := 1 TO STRLEN(Weight) DO
            IF STRPOS('1234567890', COPYSTR(Weight, i, 1)) = 0 THEN
                ERROR(Text016);
    end;

    procedure CheckMaskVicsBOL(Mask: Code[30])
    var
        i: Integer;
        Pos: Integer;
        ADigits: Integer;
        CDigits: Integer;
        MLast: Integer;
        SLast: Integer;
        ErrTxt: Text;
    begin
        ADigits := 0;
        CDigits := 0;
        FOR i := 1 TO STRLEN(Mask) DO BEGIN
            Pos := STRPOS('1234567890AMSC', COPYSTR(Mask, i, 1));

            CASE Pos OF
                11:
                    ADigits := ADigits + 1;
                12:
                    IF (MLast = 0) OR (MLast + 1 = i) THEN
                        MLast := i
                    ELSE
                        ERROR(Text004);
                13:
                    IF (SLast = 0) OR (SLast + 1 = i) THEN
                        SLast := i
                    ELSE
                        ERROR(Text005);
                14:
                    IF i <> STRLEN(Mask) THEN
                        ERROR(Text006)
                    ELSE
                        CDigits := CDigits + 1;
            END;

            ErrTxt := Text007 +
                              Text017 +
                              Text009 +
                              Text010 +
                              Text011 +
                              Text012;
            IF Pos = 0 THEN
                ERROR(ErrTxt);
        END;

        IF ADigits > 1 THEN
            ERROR(Text018);
        IF CDigits > 1 THEN
            ERROR(Text014);
    end;

    procedure GetPackingRule(ShipToType: Integer; ShipToNo: Code[20]; ShipToCode: Code[10]): Boolean

    begin

    end;

    procedure PackDetail(SourceType: Integer; SourceSubtype: Integer; ShippingAgentCode: Code[10]): Boolean
    begin
        GetShippingSetup();
    end;

    procedure CopyToNewPackingRule()

    begin

    end;

    local procedure GetShippingSetup()
    begin
        IF ShippingSetupRetrieved THEN
            EXIT;
    end;
}

