table 99998 "Posted Package"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //   >> NIF
    //   Functions Added:
    //     GetTotalParcels
    // 
    //   09-20-05 Extended Ship-to Name and Ship-to Name 2 from 30 to 50 characters
    //   << NIF

    Caption = 'Posted Package';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(12; Closed; Boolean)
        {
            Caption = 'Closed';
            Editable = false;
        }
        field(13; "Closed by Packing Station Code"; Code[10])
        {
            Caption = 'Closed by Packing Station Code';
            Editable = false;
        }
        field(14; "Manual Shipment"; Boolean)
        {
            Caption = 'Manual Shipment';
            Editable = false;
        }
        field(16; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
            Editable = false;
        }
        field(17; "Packing Date"; Date)
        {
            Caption = 'Packing Date';
            Editable = false;
        }
        field(18; "Pickup Date"; Date)
        {
            Caption = 'Pickup Date';
            Editable = false;
        }
        field(19; "Exist in Other Package"; Boolean)
        {
            CalcFormula = Exist("Posted Package Line" WHERE(Type = CONST(Package),
                                                             "No." = FIELD("No.")));
            Caption = 'Exist in Other Package';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(22; "Scale Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Scale Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(23; "Calculation Weight (LBS)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Weight (LBS)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(24; "Use Dim Weight"; Boolean)
        {
            Caption = 'Use Dim Weight';
            Editable = false;
        }
        field(25; "Override Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Override Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(26; "Calculation Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Override Volume"; Decimal)
        {
            BlankZero = true;
            Caption = 'Override Volume';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(28; "Calculation Volume"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Volume';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(31; "Net Weight"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Posted Package Line"."Net Weight" WHERE("Package No." = FIELD("No.")));
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Gross Weight"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Posted Package Line"."Gross Weight" WHERE("Package No." = FIELD("No.")));
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Dim. Weight"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Posted Package Line"."Dim. Weight" WHERE("Package No." = FIELD("No.")));
            Caption = 'Dim. Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Value (Price)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Posted Package Line"."Value (Price)" WHERE("Package No." = FIELD("No.")));
            Caption = 'Value (Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Value (Cost)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Posted Package Line"."Value (Cost)" WHERE("Package No." = FIELD("No.")));
            Caption = 'Value (Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Calculation Value"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Value';
            Editable = false;
        }
        field(37; "Override Value"; Decimal)
        {
            BlankZero = true;
            Caption = 'Override Value';
            Editable = false;
            NotBlank = true;
        }
        field(38; "Calculation Insured Value"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Insured Value';
            Editable = false;
        }
        field(39; "Override Insured Value"; Decimal)
        {
            BlankZero = true;
            Caption = 'Override Insured Value';
            Editable = false;
        }
        field(40; Volume; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Posted Package Line".Volume WHERE("Package No." = FIELD("No.")));
            Caption = 'Volume';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; Miscellaneous; Boolean)
        {
            Caption = 'Miscellaneous';
            Editable = false;
        }
        field(42; "Override Shipping Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Override Shipping Charge';
            Editable = false;
        }
        field(43; "Additional Shipping Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Additional Shipping Charge';
            Editable = false;
        }
        field(44; "Dimensional Weight"; Decimal)
        {
            Caption = 'Dimensional Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Editable = false;
            TableRelation = "Shipping Agent".Code;
        }
        field(62; "World Wide Service"; Boolean)
        {
            Caption = 'World Wide Service';
            Editable = false;
        }
        field(63; "Shipping Agent Service"; Code[30])
        {
            Caption = 'Shipping Agent Service';
            Editable = false;
        }
        field(64; "Service Indicator"; Code[10])
        {
            Caption = 'Service Indicator';
            Editable = false;
        }
        field(65; "External Tracking No."; Text[30])
        {
            Caption = 'External Tracking No.';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(66; "Manifest No."; Code[20])
        {
            Caption = 'Manifest No.';
            Editable = false;
        }
        field(67; "Delivery Days"; Integer)
        {
            Caption = 'Delivery Days';
            Editable = false;
        }
        field(68; "Creation Time"; Time)
        {
            Caption = 'Creation Time';
            Editable = false;
        }
        field(69; "Packing Time"; Time)
        {
            Caption = 'Packing Time';
            Editable = false;
        }
        field(70; "Packed By"; Code[50])
        {
            Caption = 'Packed By';
            Editable = false;
            TableRelation = User;
        }
        field(71; "Shipping Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Shipping Charge';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(72; "Accessorial Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Accessorial Charge';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(73; Surcharge; Decimal)
        {
            BlankZero = true;
            Caption = 'Surcharge';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(74; Markup; Decimal)
        {
            BlankZero = true;
            Caption = 'Markup';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(75; "Base Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Base Charge';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(76; "Rebate Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Rebate Amount';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(77; "Discount Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Discount Amount';

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(78; "Shipping Charge Updated"; Boolean)
        {
            Caption = 'Shipping Charge Updated';
            Editable = false;
        }
        field(79; "Shipping Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Shipping Cost';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                TESTFIELD("Manual Shipment");
            end;
        }
        field(80; "First Package No."; Code[20])
        {
            Caption = 'First Package No.';
        }
        field(81; "Package No."; Integer)
        {
            Caption = 'Package No.';
            Editable = false;
        }
        field(82; "Total Packages"; Integer)
        {
            Caption = 'Total Packages';
            Editable = false;
        }
        field(85; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
        }
        field(86; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(87; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Editable = false;
        }
        field(89; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            Editable = false;
        }
        field(90; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(91; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
            Editable = false;
        }
        field(92; "Posted Source ID"; Code[20])
        {
            Caption = 'Posted Source ID';
            Editable = false;
        }
        field(93; "Shipping Agent Account No."; Code[30])
        {
            Caption = 'Shipping Agent Account No.';
            Editable = false;
        }
        field(96; "Shipping Payment Type"; Option)
        {
            Caption = 'Shipping Payment Type';
            Editable = false;
            OptionCaption = 'Prepaid,Third Party,Freight Collect,Consignee';
            OptionMembers = Prepaid,"Third Party","Freight Collect",Consignee;
        }
        field(97; "Third Party Ship. Account No."; Code[20])
        {
            Caption = 'Third Party Ship. Account No.';
            Editable = false;
        }
        field(104; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(105; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location;
        }
        field(111; COD; Boolean)
        {
            Caption = 'COD';
            Editable = false;
        }
        field(112; "COD Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'COD Amount';
            Editable = false;
        }
        field(113; "COD Cashiers Check"; Boolean)
        {
            Caption = 'COD Cashiers Check';
            Editable = false;
        }
        field(114; "Add Shipping Charge to COD Amt"; Boolean)
        {
            Caption = 'Add Shipping Charge to COD Amt';
            Editable = false;
        }
        field(115; "Insure Through Shipping Agent"; Boolean)
        {
            Caption = 'Insure Through Shipping Agent';
            Editable = false;
        }
        field(116; "Shipping Insurance"; Option)
        {
            Caption = 'Shipping Insurance';
            Editable = false;
            OptionCaption = ' ,Never,Always';
            OptionMembers = " ",Never,Always;
        }
        field(117; "Additional COD Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Additional COD Amount';
            Editable = false;
        }
        field(121; "Ship-to Type"; Option)
        {
            Caption = 'Ship-to Type';
            Editable = false;
            OptionCaption = 'Customer,Vendor,Bank,Contact,Resource,Employee,,Location';
            OptionMembers = Customer,Vendor,Bank,Contact,Resource,Employee,,Location;
        }
        field(122; "Ship-to No."; Code[20])
        {
            Caption = 'Ship-to No.';
            Editable = false;
            TableRelation = IF ("Ship-to Type" = CONST(Customer)) Customer
            ELSE IF ("Ship-to Type" = CONST(Vendor)) Vendor
            ELSE IF ("Ship-to Type" = CONST(Bank)) "Bank Account"
            ELSE IF ("Ship-to Type" = CONST(Contact)) Contact
            ELSE IF ("Ship-to Type" = CONST(Resource)) Resource
            ELSE IF ("Ship-to Type" = CONST(Location)) Location;
        }
        field(123; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = IF ("Ship-to Type" = CONST(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Ship-to No."))
            ELSE IF ("Ship-to Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Ship-to No."));
        }
        field(124; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            Editable = false;
        }
        field(125; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            Editable = false;
        }
        field(126; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
            Editable = false;
        }
        field(127; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            Editable = false;
        }
        field(128; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            Editable = false;
        }
        field(129; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            Editable = false;
        }
        field(130; "Ship-to ZIP Code"; Code[20])
        {
            Caption = 'Ship-to ZIP Code';
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(131; "Ship-to State"; Text[30])
        {
            Caption = 'Ship-to State';
            Editable = false;
        }
        field(132; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(133; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
            Editable = false;
        }
        field(134; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
            Editable = false;
        }
        field(135; "Residential Delivery"; Boolean)
        {
            Caption = 'Residential Delivery';
            Editable = false;
        }
        field(141; "Blind Shipment"; Boolean)
        {
            Caption = 'Blind Shipment';
            Editable = false;
        }
        field(142; "Double Blind Shipment"; Boolean)
        {
            Caption = 'Double Blind Shipment';
            Editable = false;
        }
        field(143; "Double Blind Ship-from Cust No"; Code[20])
        {
            Caption = 'Double Blind Ship-from Cust No';
            Editable = false;
            TableRelation = Customer;
        }
        field(144; "Blind Ship-from Customer No."; Code[20])
        {
            Caption = 'Blind Ship-from Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(145; "Blind Ship-from Name"; Text[50])
        {
            Caption = 'Blind Ship-from Name';
            Editable = false;
        }
        field(146; "Blind Ship-from Name 2"; Text[50])
        {
            Caption = 'Blind Ship-from Name 2';
            Editable = false;
        }
        field(147; "Blind Ship-from Address"; Text[50])
        {
            Caption = 'Blind Ship-from Address';
            Editable = false;
        }
        field(148; "Blind Ship-from Address 2"; Text[50])
        {
            Caption = 'Blind Ship-from Address 2';
            Editable = false;
        }
        field(149; "Blind Ship-from City"; Text[30])
        {
            Caption = 'Blind Ship-from City';
            Editable = false;
        }
        field(150; "Blind Ship-from Contact"; Text[50])
        {
            Caption = 'Blind Ship-from Contact';
            Editable = false;
        }
        field(151; "Blind Ship-from ZIP Code"; Code[20])
        {
            Caption = 'Blind Ship-from ZIP Code';
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(152; "Blind Ship-from State"; Text[30])
        {
            Caption = 'Blind Ship-from State';
            Editable = false;
        }
        field(153; "Blind Ship-from Country Code"; Code[10])
        {
            Caption = 'Blind Ship-from Country Code';
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(154; "Blind Ship-from Phone No."; Text[30])
        {
            Caption = 'Blind Ship-from Phone No.';
            Editable = false;
        }
        field(155; "Blind Ship-from Fax No."; Text[30])
        {
            Caption = 'Blind Ship-from Fax No.';
            Editable = false;
        }
        field(161; "Third Party Shipping Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Shipping Charge';
            Editable = false;
        }
        field(162; "Third Party Accessorial Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Accessorial Charge';
            Editable = false;
        }
        field(163; "Third Party Surcharge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Surcharge';
            Editable = false;
        }
        field(164; "Third Party Markup"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Markup';
            Editable = false;
        }
        field(165; "Third Party Base Charge"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Base Charge';
            Editable = false;
        }
        field(166; "Third Party Rebate Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Rebate Amount';
            Editable = false;
        }
        field(167; "Third Party Discount Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Discount Amount';
            Editable = false;
        }
        field(169; "Third Party Shipping Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Third Party Shipping Cost';
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(170; "AES ITN No."; Text[20])
        {
            Caption = 'AES ITN No.';
        }
        field(7300; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7301; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7302; Height; Decimal)
        {
            CalcFormula = Sum("Posted Package Line".Height WHERE("Package No." = FIELD("No.")));
            Caption = 'Height';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(7303; Cubage; Decimal)
        {
            CalcFormula = Sum("Posted Package Line".Cubage WHERE("Package No." = FIELD("No.")));
            Caption = 'Cubage';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(7304; "Unit of Measure Weight"; Decimal)
        {
            CalcFormula = Sum("Posted Package Line"."Unit of Measure Weight" WHERE("Package No." = FIELD("No.")));
            Caption = 'Unit of Measure Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(7305; "Override Dimensions"; Boolean)
        {
            Caption = 'Override Dimensions';
            Editable = false;
        }
        field(7306; "Override Length"; Decimal)
        {
            Caption = 'Override Length';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7307; "Override Width"; Decimal)
        {
            Caption = 'Override Width';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7308; "Override Height"; Decimal)
        {
            Caption = 'Override Height';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7309; "Calculation Length"; Decimal)
        {
            Caption = 'Calculation Length';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7310; "Calculation Width"; Decimal)
        {
            Caption = 'Calculation Width';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(7311; "Calculation Height"; Decimal)
        {
            Caption = 'Calculation Height';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(14000350; "EDI Trade Partner"; Code[20])
        {
            Caption = 'EDI Trade Partner';
            Editable = false;
        }
        field(14000720; "Multi Document Package"; Boolean)
        {
            Caption = 'Multi Document Package';
            Editable = false;
        }
        field(14000721; "Multi Document No."; Code[250])
        {
            Caption = 'Multi Document No.';
            Editable = false;
        }
        field(14000722; "Multi Document Package Split"; Boolean)
        {
            Caption = 'Multi Document Package Split';
            Editable = false;
        }
        field(14000723; "Original Package No."; Code[20])
        {
            Caption = 'Original Package No.';
            Editable = false;
        }
        field(14000724; "Original Shipping Charge"; Decimal)
        {
            Caption = 'Original Shipping Charge';
            Editable = false;
        }
        field(14000725; "Original Shipping Cost"; Decimal)
        {
            Caption = 'Original Shipping Cost';
            Editable = false;
        }
        field(14000726; "Org. Third Party Ship. Charge"; Decimal)
        {
            Caption = 'Org. Third Party Ship. Charge';
            Editable = false;
        }
        field(14000727; "Org. Third Party Shipping Cost"; Decimal)
        {
            Caption = 'Org. Third Party Shipping Cost';
            Editable = false;
        }
        field(14000728; "Exclude From Manifest"; Boolean)
        {
            Caption = 'Exclude From Manifest';
            Editable = false;
        }
        field(14000729; "Distribution Factor"; Decimal)
        {
            Caption = 'Distribution Factor';
            Editable = false;
        }
        field(14000730; "Original Exist in Other Pack."; Boolean)
        {
            CalcFormula = Exist("Posted Package Line" WHERE(Type = CONST(Package),
                                                             "No." = FIELD("Original Package No.")));
            Caption = 'Original Exist in Other Pack.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14000751; "Shipping Bill Verified"; Boolean)
        {
            Caption = 'Shipping Bill Verified';
            Editable = false;
        }
        field(14000752; "Shipping Bill Verified Date"; Date)
        {
            Caption = 'Shipping Bill Verified Date';
            Editable = false;
        }
        field(14000753; "Shipping Bill Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Shipping Bill Amount';
            Editable = false;
        }
        field(14000754; "Shipping Bill Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Shipping Bill Weight';
            DecimalPlaces = 0 : 5;
        }
        field(14000755; "Shipping Bill Volume"; Decimal)
        {
            BlankZero = true;
            Caption = 'Shipping Bill Volume';
            DecimalPlaces = 0 : 5;
        }
        field(14000756; "Shipping Bill Delivery Date"; Date)
        {
            Caption = 'Shipping Bill Delivery Date';
            Editable = false;
        }
        field(14000757; "Shipping Bill COD Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Shipping Bill COD Amount';
            Editable = false;
        }
        field(14000761; "UPS Zone"; Code[10])
        {
            Caption = 'UPS Zone';
            Editable = false;
        }
        field(14000762; "UPS Hundred Weight"; Boolean)
        {
            Caption = 'UPS Hundred Weight';
            Editable = false;
        }
        field(14000764; "UPS Manifest Entry No."; Integer)
        {
            Caption = 'UPS Manifest Entry No.';
            Editable = false;
        }
        field(14000766; "UPS Transaction ID"; Code[20])
        {
            Caption = 'UPS Transaction ID';
            Editable = false;
        }
        field(14000767; "Insurance Charge"; Decimal)
        {
            Caption = 'Insurance Charge';
        }
        field(14000768; "UPS Canadian Service"; Boolean)
        {
            Caption = 'UPS Canadian Service';
        }
        field(14000769; "Oversize Actual Weight"; Decimal)
        {
            Caption = 'Oversize Actual Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14000770; "UPS Puerto Rico Service"; Boolean)
        {
            Caption = 'UPS Puerto Rico Service';
        }
        field(14000782; "FedEx Transaction ID"; Code[40])
        {
            Caption = 'FedEx Transaction ID';
            Editable = false;
        }
        field(14000801; "LTL Freight Type"; Code[10])
        {
            Caption = 'LTL Freight Type';
            Editable = false;
        }
        field(14000822; "Bill of Lading No."; Code[20])
        {
            Caption = 'Bill of Lading No.';
            Editable = false;
        }
        field(14000823; "Used on Bill of Lading No."; Code[20])
        {
            Caption = 'Used on Bill of Lading No.';
            Editable = false;

        }
        field(14000825; "UCC No."; Code[30])
        {
            Caption = 'UCC No.';
        }
        field(14000828; "Label Package Type"; Code[1])
        {
            Caption = 'Label Package Type';
            CharAllowed = '09';
        }
        field(14000829; "UCC No. (Print)"; Code[50])
        {
            Caption = 'UCC No. (Print)';
        }
        field(14000941; "Airborne Sort code"; Code[10])
        {
            Caption = 'Airborne Sort code';
        }
        field(14000942; "Airborne Airbill Type"; Option)
        {
            Caption = 'Airborne Airbill Type';
            OptionCaption = ' ,AHM,DEL,AMM,AMD,PRI,CAN,COD,PTR';
            OptionMembers = " ",AHM,DEL,AMM,AMD,PRI,CAN,COD,PTR;
        }
        field(14000944; "Airborne Manifest Entry No."; Integer)
        {
            Caption = 'Airborne Manifest Entry No.';
        }
        field(14000945; "Airborne Canadian Service"; Boolean)
        {
            Caption = 'Airborne Canadian Service';
        }
        field(14000946; "Airborne Puerto Rico Service"; Boolean)
        {
            Caption = 'Airborne Puerto Rico Service';
        }
        field(14000947; "Airborne Regional Hub Code"; Code[10])
        {
            Caption = 'Airborne Regional Hub Code';
        }
        field(14000948; "Airborne ABX Hub Code"; Code[10])
        {
            Caption = 'Airborne ABX Hub Code';
        }
        field(14000961; "RF-ID (Hex)"; Code[50])
        {
            Caption = 'RF-ID (Hex)';
        }
        field(14000962; "RF-ID Type"; Option)
        {
            Caption = 'RF-ID Type';
            OptionCaption = ' ,SGTIN,SSCC,SGLN,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ",SGTIN,SSCC,SGLN,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(14000981; "Export Document No."; Code[10])
        {
            Caption = 'Export Document No.';
        }
        field(14000982; "No AES Required"; Boolean)
        {
            Caption = 'No AES Required';
        }
        field(14002801; "Tote No."; Code[20])
        {
            Caption = 'Tote No.';
            Editable = false;
        }
        field(14002802; "USPS Tracking ID"; Code[30])
        {
            Caption = 'USPS Tracking ID';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Shipping Agent Code", "Shipping Agent Service")
        {
            SumIndexFields = "Calculation Weight";
        }
        key(Key3; "Source Type", "Source Subtype", "Posted Source ID", "Bill of Lading No.")
        {
            SumIndexFields = "Calculation Weight", "Calculation Volume", "Calculation Value", "Shipping Charge";
        }
        key(Key4; "Source Type", "Source Subtype", "Source ID")
        {
        }
        key(Key5; "External Tracking No.")
        {
        }
        key(Key6; "Ship-to Type", "Ship-to No.", "Ship-to Code")
        {
        }
        key(Key7; "Shipping Bill Verified", "Shipping Agent Code", "Shipping Agent Service", "Ship-to State", "Ship-to ZIP Code", "UPS Zone", "Shipping Bill Weight", Miscellaneous)
        {
            MaintainSQLIndex = false;
        }
        key(Key8; "Manifest No.", "Shipping Agent Code", "Shipping Agent Account No.", Closed, "Manual Shipment", "Exclude From Manifest")
        {
            MaintainSQLIndex = false;
        }
        key(Key9; "Bill of Lading No.")
        {
        }
        key(Key10; "Source Type", "Source Subtype", "Posted Source ID", "Posting Date")
        {
            MaintainSQLIndex = false;
        }
        key(Key11; "Shipping Agent Code", "Pickup Date", "Shipping Bill Verified")
        {
        }
        key(Key12; "Original Package No.")
        {
        }
        key(Key13; "Manifest No.", "Shipping Agent Account No.", "Shipping Agent Service")
        {
        }
        key(Key14; "UCC No.")
        {
        }
        key(Key15; "First Package No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Calculation Weight (LBS)";
        }
        key(Key16; "Export Document No.")
        {
        }
        key(Key17; "Used on Bill of Lading No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "External Tracking No.", "Shipping Agent Code", "Shipping Agent Service")
        {
        }
    }

    trigger OnDelete()
    begin

        // Package Labels are not deleted by Purpose
    end;

    var
        ShippingAgent: Record "Shipping Agent";
        NavigateForm: Page Navigate;
        ShippingSetupRetrieved: Boolean;
        Text001: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';

    procedure StartTrackingPackage()
    begin
    end;

    procedure InsertLabelFile(LabelFile: Text[250]; LabelDescription: Text[30]; LabelType: Integer; PrinterPort: Code[100]; PackingStationCode: Code[10]; LabelPrinted: Boolean; DoNotImportLabelFile: Boolean)
    begin
    end;

    procedure PrintStdPackageLabel()
    begin
    end;

    procedure CreatePrintUCC128Label()
    begin
    end;

    procedure CreatePrintRFIDLabel()
    begin
    end;

    procedure Navigate()
    begin
        NavigateForm.SetDoc("Posting Date", "Posted Source ID");
        NavigateForm.RUN;
    end;

    procedure LookupMultiDocPackage()
    begin
        TESTFIELD("Multi Document Package");

    end;

    procedure PackageLevel(): Integer
    var
        MinimumLevel: Integer;
        TempLevel: Integer;
    begin

    end;

    local procedure GetShippingSetup()
    begin

    end;

    procedure DisplayMap()
    var
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    begin
        IF MapPoint.FIND('-') THEN
            MapMgt.MakeSelection(DATABASE::"Posted Package", GETPOSITION)
        ELSE
            MESSAGE(Text001);
    end;

    procedure ">>NIF_fcn"()
    begin
    end;

    procedure GetTotalParcels() TotalParcels: Decimal
    begin

    end;
}

