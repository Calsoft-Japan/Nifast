table 70777 "Conv. Carrier Packing Station"
{
    Caption = 'Packing Station';
    LookupPageID = 14000722;
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
        field(14000761; "UPS Shipping Agent Account No."; Code[10])
        {
            Caption = 'UPS Shipping Agent Account No.';
        }
        field(14000762; "UPS Buffer File"; Text[100])
        {
            Caption = 'UPS Buffer File';
        }
        field(14000763; "UPS Label Printer Port"; Code[10])
        {
            Caption = 'UPS Label Printer Port';
        }
        field(14000764; "UPS Manifest Upload Directory"; Text[200])
        {
            Caption = 'UPS Manifest Upload Directory';
        }
        field(14000765; "UPS Label Printer Type"; Option)
        {
            Caption = 'UPS Label Printer Type';
            OptionCaption = ' ,Eltron Orion,Zebra';
            OptionMembers = " ","Eltron Orion",Zebra;
        }
        field(14000766; "UPS Eltron Label Media Type"; Option)
        {
            Caption = 'UPS Eltron Label Media Type';
            OptionCaption = ' ,4X6 with Doc Tab,4X6 W/O Doc Tab';
            OptionMembers = " ","4X6 with Doc Tab","4X6 W/O Doc Tab";
        }
        field(14000767; "UPS Print From"; Option)
        {
            Caption = 'UPS Print From';
            OptionCaption = 'Bottom,Top';
            OptionMembers = Bottom,Top;
        }
        field(14000768; "UPS Add Item Info. on Label"; Boolean)
        {
            Caption = 'UPS Add Item Info. on Label';
        }
        field(14000769; "UPS Haz. Mat. Emergency No."; Text[30])
        {
            Caption = 'UPS Haz. Mat. Emergency No.';
        }
        field(14000784; "FedEx Buffer Directory"; Text[200])
        {
            Caption = 'FedEx Buffer Directory';
        }
        field(14000785; "FedEx Global Registration No."; Code[40])
        {
            Caption = 'FedEx Global Registration No.';
            TableRelation = "FedEx Global Registration"."Transaction ID";
        }
        field(14000786; "FedEx Label Printer Type"; Option)
        {
            Caption = 'FedEx Label Printer Type';
            OptionCaption = ' ,Laser Printer,Eltron Orion,Eltron Eclipse,Zebra (ZPL)';
            OptionMembers = " ","Laser Printer","Eltron Orion","Eltron Eclipse","Zebra (ZPL)";
        }
        field(14000787; "FedEx Eltron Label Media Type"; Option)
        {
            Caption = 'FedEx Eltron Label Media Type';
            OptionCaption = ' ,4X6 with Doc Tab,4X6 W/O Doc Tab';
            OptionMembers = " ","4X6 with Doc Tab","4X6 W/O Doc Tab";
        }
        field(14000788; "Proxy Address"; Code[15])
        {
            Caption = 'Proxy Address';
            InitValue = '127.0.0.1';
        }
        field(14000789; "Proxy Port"; Code[10])
        {
            Caption = 'Proxy Port';
            InitValue = '8190';
        }
        field(14000790; "FedEx Label Printer Port"; Code[10])
        {
            Caption = 'FedEx Label Printer Port';
        }
        field(14000791; "FedEx Label Buffer File"; Text[100])
        {
            Caption = 'FedEx Label Buffer File';
        }
        field(14000792; "FedEx Shipping Agent Acc. No."; Code[10])
        {
            Caption = 'FedEx Shipping Agent Acc. No.';
            TableRelation = "FedEx Shipping Agent Account";
        }
        field(14000793; "FedEx Print From"; Option)
        {
            Caption = 'FedEx Print From';
            OptionCaption = 'Top,Bottom';
            OptionMembers = Top,Bottom;
        }
        field(14000794; "FedEx Add Item Info. on Label"; Boolean)
        {
            Caption = 'FedEx Add Item Info. on Label';
        }
        field(14000795; "FedEx Label Template Directory"; Text[200])
        {
            Caption = 'FedEx Label Template Directory';
        }
        field(14000796; "FedEX Save RateShop Buffers"; Boolean)
        {
            Caption = 'FedEX Save RateShop Buffers';
        }
        field(14000861; "Generic Shipping Agent Acc. No"; Code[10])
        {
            Caption = 'Generic Shipping Agent Acc. No';
            TableRelation = "LAX Generic Ship. Agent Acct."
        }
        field(14000862; "Generic Label Printer Port"; Code[10])
        {
            Caption = 'Generic Label Printer Port';
        }
        field(14000863; "Generic Label Buffer File"; Text[100])
        {
            Caption = 'Generic Label Buffer File';
        }
        field(14000881; "USPS Shipping Agent Acc. No"; Code[10])
        {
            Caption = 'USPS Shipping Agent Acc. No';
            TableRelation = "USPS Shipping Agent Account";
        }
        field(14000882; "USPS Label Printer Port"; Code[10])
        {
            Caption = 'USPS Label Printer Port';
        }
        field(14000883; "USPS Label Buffer File"; Text[100])
        {
            Caption = 'USPS Label Buffer File';
        }
        field(14000941; "Airborne Shipping Agent Acc No"; Code[10])
        {
            Caption = 'Airborne Shipping Agent Acc No';
            TableRelation = "Airborne Ship. Agent Account";
        }
        field(14000942; "Airborne Label Printer Port"; Code[10])
        {
            Caption = 'Airborne Label Printer Port';
        }
        field(14000943; "Airborne Label Buffer File"; Text[100])
        {
            Caption = 'Airborne Label Buffer File';
        }
        field(14000944; "Airborne Label Printer Type"; Option)
        {
            Caption = 'Airborne Label Printer Type';
            OptionCaption = ' ,Eltron Orion,Zebra';
            OptionMembers = " ","Eltron Orion",Zebra;
        }
        field(14000945; "Airborne Eltron Label Media"; Option)
        {
            Caption = 'Airborne Eltron Label Media';
            OptionCaption = ' ,4X6 with Doc Tab,4X6 W/O Doc Tab';
            OptionMembers = " ","4X6 with Doc Tab","4X6 W/O Doc Tab";
        }
        field(14000946; "Airborne Print From"; Option)
        {
            Caption = 'Airborne Print From';
            OptionCaption = 'Bottom,Top';
            OptionMembers = Bottom,Top;
        }
        field(14000947; "Airborne Manifest Upload Dir."; Text[200])
        {
            Caption = 'Airborne Manifest Upload Dir.';
        }
        field(14000948; "Airborne Add Item Info on Labl"; Boolean)
        {
            Caption = 'Airborne Add Item Info on Labl';
        }
        field(14000949; "Airborne Gen.Commodity Rates"; Boolean)
        {
            Caption = 'Airborne Gen.Commodity Rates';
        }
        field(14050001; "UPSlink Temp. Files Directory"; Text[200])
        {
            Caption = 'UPSlink Temp. Files Directory';
        }
        field(14050003; "CASS Validated Address"; Boolean)
        {
            Caption = 'CASS Validated Address';
        }
        field(14050401; "DHL Shipping Agent Acc. No"; Code[10])
        {
            Caption = 'DHL Shipping Agent Acc. No';
            TableRelation = "LAX Generic Ship. Agent Acct."
        }
        field(14050402; "DHL Label Printer Port"; Code[10])
        {
            Caption = 'DHL Label Printer Port';
        }
        field(14050403; "DHL Label Buffer File"; Text[200])
        {
            Caption = 'DHL Label Buffer File';
        }
        field(14050451; "Rating Shipping Agent Acc. No"; Code[10])
        {
            Caption = 'Rating Shipping Agent Acc. No';
            TableRelation = "LAX Generic Ship. Agent Acct."
        }
        field(14050452; "Rating Label Printer Port"; Code[10])
        {
            Caption = 'Rating Label Printer Port';
        }
        field(14050453; "Rating Label Buffer File"; Text[200])
        {
            Caption = 'Rating Label Buffer File';
        }
        field(14050501; "USPS2 Shipping Agent Acc. No"; Code[10])
        {
            Caption = 'USPS2 Shipping Agent Acc. No';
            TableRelation = "LAX Generic Ship. Agent Acct."
        }
        field(14050502; "USPS2 Label Printer Port"; Code[10])
        {
            Caption = 'USPS2 Label Printer Port';
        }
        field(14050503; "USPS2 Label Buffer File"; Text[200])
        {
            Caption = 'USPS2 Label Buffer File';
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
    }
}
