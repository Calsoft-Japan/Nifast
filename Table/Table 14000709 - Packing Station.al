table 99990 "Packing Station"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //   >> NIF
    //   Fields Added:
    //     "Def. Commodity Desc."
    //     "Def. NMFC#"
    //     "Def. Class Code"
    // 
    //   Date     Init   Proj   Desc
    //   04-26-05 RTT   #9978   new fields 50000,50005,50010
    //   05-07-05 RTT  #10005   new field 50020
    //   << NIF

    Caption = 'Packing Station';

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
        field(13; "Print Shipment Report on Close"; Boolean)
        {
            Caption = 'Print Shipment Report on Close';
        }
        field(14; "Print Invoice Report on Close"; Boolean)
        {
            Caption = 'Print Invoice Report on Close';
        }
        field(15; "Show Order Comments if Exists"; Boolean)
        {
            Caption = 'Show Order Comments if Exists';
        }
        field(16; "Enter Quantities"; Boolean)
        {
            Caption = 'Enter Quantities';

        }
        field(17; "Always Enter Total Packages"; Boolean)
        {
            Caption = 'Always Enter Total Packages';
        }
        field(18; "Create Barcode Conversion"; Boolean)
        {
            Caption = 'Create Barcode Conversion';
        }
        field(19; "No Label Printer"; Boolean)
        {
            Caption = 'No Label Printer';
        }
        field(20; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(21; "Confirm on Errors"; Boolean)
        {
            Caption = 'Confirm on Errors';
        }
        field(22; "Test Package No. on Close Ord."; Boolean)
        {
            Caption = 'Test Package No. on Close Ord.';
        }
        field(23; "Do Not Enter Quantity of One"; Boolean)
        {
            Caption = 'Do Not Enter Quantity of One';

        }
        field(24; "Create Item Cross Reference"; Boolean)
        {
            Caption = 'Create Item Cross Reference';
        }
        field(25; "Auto Post Pick"; Boolean)
        {
            Caption = 'Auto Post Pick';
        }
        field(26; "Allow Item/Resource Lookup"; Boolean)
        {
            Caption = 'Allow Item/Resource Lookup';
        }
        field(27; "Change Posting Date on Close"; Boolean)
        {
            Caption = 'Change Posting Date on Close';
        }
        field(28; "Editable Address in Package"; Boolean)
        {
            Caption = 'Editable Address in Package';
        }
        field(29; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(31; "Manually Enter Weight"; Boolean)
        {
            Caption = 'Manually Enter Weight';
        }
        field(32; "Manually Enter Value"; Boolean)
        {
            Caption = 'Manually Enter Value';
        }
        field(33; "Rateshop Enter Weight"; Boolean)
        {
            Caption = 'Rateshop Enter Weight';
        }
        field(34; "Rateshop Enter Value"; Boolean)
        {
            Caption = 'Rateshop Enter Value';
        }
        field(35; "Rateshop Enter No. of Packages"; Boolean)
        {
            Caption = 'Rateshop Enter No. of Packages';
        }
        field(36; "Add Shipping to Document on"; Option)
        {
            Caption = 'Add Shipping to Document on';
            InitValue = "Close Order";
            OptionCaption = 'Close Package and Order,Close Order';
            OptionMembers = "Close Package and Order","Close Order";
        }
        field(37; "Auto Create Pack. When No Det."; Boolean)
        {
            Caption = 'Auto Create Pack. When No Det.';
        }
        field(38; "Reset Order Qty. When Opened"; Boolean)
        {
            Caption = 'Reset Order Qty. When Opened';
        }
        field(39; "Auto Fill Qty. to Handle"; Boolean)
        {
            Caption = 'Auto Fill Qty. to Handle';
        }
        field(61; "Ship-from Company"; Text[50])
        {
            Caption = 'Ship-from Company';
        }
        field(62; "Ship-from Address"; Text[50])
        {
            Caption = 'Ship-from Address';
        }
        field(63; "Ship-from Address2"; Text[50])
        {
            Caption = 'Ship-from Address2';
        }
        field(64; "Ship-from City"; Text[30])
        {
            Caption = 'Ship-from City';
        }
        field(65; "Ship-from State"; Text[30])
        {
            Caption = 'Ship-from State';
        }
        field(66; "Ship-from ZIP Code"; Code[20])
        {
            Caption = 'Ship-from ZIP Code';
            TableRelation = "Post Code".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

        }
        field(67; "Ship-from Country Code"; Code[10])
        {
            Caption = 'Ship-from Country Code';
        }
        field(68; "Ship-from Phone No."; Text[30])
        {
            Caption = 'Ship-from Phone No.';
        }
        field(69; "Ship-from Contact"; Text[50])
        {
            Caption = 'Ship-from Contact';
        }
        field(70; "Ship-from Fax No."; Text[30])
        {
            Caption = 'Ship-from Fax No.';
        }
        field(71; "Scale Interface Code"; Code[10])
        {
            Caption = 'Scale Interface Code';
        }
        field(72; "Scale Update Interval (second)"; Integer)
        {
            Caption = 'Scale Update Interval (second)';

            trigger OnValidate()
            begin
                TESTFIELD("Scale Interface Code");
            end;
        }
        field(73; "Show What During Packing"; Option)
        {
            Caption = 'Show What During Packing';
            OptionCaption = 'Net Weight,Gross Weight,Dimmed Weight,Volume,Scale Weight';
            OptionMembers = "Net Weight","Gross Weight","Dimmed Weight",Volume,"Scale Weight";

            trigger OnValidate()
            begin
                IF "Show What During Packing" = "Show What During Packing"::"Scale Weight" THEN BEGIN
                    TESTFIELD("Scale Interface Code");
                    TESTFIELD("Scale Update Interval (second)");
                END;
            end;
        }
        field(74; "Default Package Description"; Text[30])
        {
            Caption = 'Default Package Description';
        }
        field(75; "Accumulate Qty when Entered"; Boolean)
        {
            Caption = 'Accumulate Qty when Entered';
        }
        field(76; "Open with Prepack"; Boolean)
        {
            Caption = 'Open with Prepack';
        }
        field(77; "Ship-from E-Mail"; Text[80])
        {
            Caption = 'Ship-from E-Mail';
        }
        field(78; "Ship-from Airport Code"; Code[10])
        {
            Caption = 'Ship-from Airport Code';
        }
        field(79; "Open BOL on Close Order"; Boolean)
        {
            Caption = 'Open BOL on Close Order';
        }
        field(80; "Open Bill of Lading Form"; Option)
        {
            Caption = 'Open Bill of Lading Form';
            OptionCaption = 'Bill of Lading,Worksheet,Bill of Lading Scanning';
            OptionMembers = "Bill of Lading",Worksheet,"Bill of Lading Scanning";
        }
        field(81; "Phone No. to use If Blank"; Text[30])
        {
            Caption = 'Phone No. to use If Blank';
        }
        field(82; "Open Order after Close"; Boolean)
        {
            Caption = 'Open Order after Close';
        }
        field(83; "SHELL Command Type"; Option)
        {
            Caption = 'SHELL Command Type';
            InitValue = ".NET Automation";
            OptionCaption = 'One String,With Parameters,Oyster OCX,.NET Automation';
            OptionMembers = "One String","With Parameters","Oyster OCX",".NET Automation";

        }
        field(84; "Sales Order Close Action"; Option)
        {
            Caption = 'Sales Order Close Action';
            OptionCaption = ' ,Ship,Ship and Invoice';
            OptionMembers = " ",Ship,"Ship and Invoice";

        }
        field(85; "Sales Invoice Close Action"; Option)
        {
            Caption = 'Sales Invoice Close Action';
            OptionCaption = ' ,Invoice';
            OptionMembers = " ",Invoice;

        }
        field(86; "Purchase Cr. Memo Close Action"; Option)
        {
            Caption = 'Purchase Cr. Memo Close Action';
            OptionCaption = ' ,Invoice';
            OptionMembers = " ",Invoice;
        }
        field(87; "Return Order Close Action"; Option)
        {
            Caption = 'Return Order Close Action';
            OptionCaption = ' ,Ship,Ship and Invoice';
            OptionMembers = " ",Ship,"Ship and Invoice";
        }
        field(88; "Transfer Order Close Action"; Option)
        {
            Caption = 'Transfer Order Close Action';
            OptionCaption = ' ,Ship';
            OptionMembers = " ",Ship;
        }
        field(89; "Simple Multi Document Posting"; Boolean)
        {
            Caption = 'Simple Multi Document Posting';
        }
        field(90; "Register Pick on Future Close"; Boolean)
        {
            Caption = 'Register Pick on Future Close';

            trigger OnValidate()
            begin
                IF "Register Pick on Future Close" THEN
                    TESTFIELD("Auto Post Pick");
            end;
        }
        field(91; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;

        }
        field(92; "Default F3 Option"; Option)
        {
            Caption = 'Default F3 Option';
            OptionCaption = ' ,Create Package,Create Package Print,Create Standard Pack,Create Standard Pack Print,Pack All,Pack All Print,Pack Remaining,Pack Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Package","Create Package Print","Create Standard Pack","Create Standard Pack Print","Pack All","Pack All Print","Pack Remaining","Pack Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(93; "Default Shift+F3 Option"; Option)
        {
            Caption = 'Default Shift+F3 Option';
            OptionCaption = ' ,Create Package,Create Package Print,Create Standard Pack,Create Standard Pack Print,Pack All,Pack All Print,Pack Remaining,Pack Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Package","Create Package Print","Create Standard Pack","Create Standard Pack Print","Pack All","Pack All Print","Pack Remaining","Pack Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(94; "Default Ctrl+F3 Option"; Option)
        {
            Caption = 'Default Ctrl+F3 Option';
            OptionCaption = ' ,Create Package,Create Package Print,Create Standard Pack,Create Standard Pack Print,Pack All,Pack All Print,Pack Remaining,Pack Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Package","Create Package Print","Create Standard Pack","Create Standard Pack Print","Pack All","Pack All Print","Pack Remaining","Pack Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(95; "Default Alt+F3 Option"; Option)
        {
            Caption = 'Default Alt+F3 Option';
            OptionCaption = ' ,Create Package,Create Package Print,Create Standard Pack,Create Standard Pack Print,Pack All,Pack All Print,Pack Remaining,Pack Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Package","Create Package Print","Create Standard Pack","Create Standard Pack Print","Pack All","Pack All Print","Pack Remaining","Pack Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(96; "Renumber not Requiring Prepack"; Boolean)
        {
            Caption = 'Renumber not Requiring Prepack';
            InitValue = true;
        }
        field(97; "View Opt on Close in Fast Pack"; Boolean)
        {
            Caption = 'View Opt on Close in Fast Pack';
        }
        field(98; "Auto Post Pick with No Action"; Boolean)
        {
            Caption = 'Auto Post Pick with No Action';
            InitValue = true;
        }
        field(99; "Check Name Addr. on Open Order"; Boolean)
        {
            Caption = 'Check Name Addr. on Open Order';
            InitValue = true;
        }
        field(100; "Confirm Pack Line Scan. Close"; Boolean)
        {
            Caption = 'Confirm Pack Line Scan. Close';
            InitValue = true;
        }
        field(101; "Add Package Command"; Boolean)
        {
            Caption = 'Add Package Command';
        }
        field(102; "Close Package Command"; Boolean)
        {
            Caption = 'Close Package Command';
        }
        field(103; "Close Package Print Command"; Boolean)
        {
            Caption = 'Close Package Print Command';
        }
        field(104; "Close Order Command"; Boolean)
        {
            Caption = 'Close Order Command';
        }
        field(105; "Close Order Print Command"; Boolean)
        {
            Caption = 'Close Order Print Command';
        }
        field(106; "Close Order Force Command"; Boolean)
        {
            Caption = 'Close Order Force Command';
        }
        field(107; "Fix Package Address Command"; Boolean)
        {
            Caption = 'Fix Package Address Command';
        }
        field(108; "Pack All Command"; Boolean)
        {
            Caption = 'Pack All Command';
        }
        field(110; "Print Std. Package Labels Cmd."; Boolean)
        {
            Caption = 'Print Std. Package Labels Cmd.';
        }
        field(111; "Print UCC Labels Command"; Boolean)
        {
            Caption = 'Print UCC Labels Command';
        }
        field(112; "Rate Shop Package Command"; Boolean)
        {
            Caption = 'Rate Shop Package Command';
        }
        field(113; "Rate Shop Order Command"; Boolean)
        {
            Caption = 'Rate Shop Order Command';
        }
        field(114; "Total Package Count Command"; Boolean)
        {
            Caption = 'Total Package Count Command';
        }
        field(115; "Override Package Value Command"; Boolean)
        {
            Caption = 'Override Package Value Command';
        }
        field(116; "Override Package Volume Cmd."; Boolean)
        {
            Caption = 'Override Package Volume Cmd.';
        }
        field(117; "Override Package Weight Cmd."; Boolean)
        {
            Caption = 'Override Package Weight Cmd.';
        }
        field(118; "View Order Command"; Boolean)
        {
            Caption = 'View Order Command';
        }
        field(119; "View Order Options Cmd."; Boolean)
        {
            Caption = 'View Order Options Cmd.';
        }
        field(120; "Copy Last Package Command"; Boolean)
        {
            Caption = 'Copy Last Package Command';
        }
        field(121; "Copy Last Package Print Cmd."; Boolean)
        {
            Caption = 'Copy Last Package Print Cmd.';
        }
        field(122; "Close Order Print Force Cmd."; Boolean)
        {
            Caption = 'Close Order Print Force Cmd.';
        }
        field(123; "Add All Packages Command"; Boolean)
        {
            Caption = 'Add All Packages Command';
        }
        field(124; "View Order Comments Cmd."; Boolean)
        {
            Caption = 'View Order Comments Cmd.';
        }
        field(126; "Delete All Packages Command"; Boolean)
        {
            Caption = 'Delete All Packages Command';
        }
        field(127; "Print All Shipping Labels Cmd."; Boolean)
        {
            Caption = 'Print All Shipping Labels Cmd.';
        }
        field(128; "Zero Scale Command"; Boolean)
        {
            Caption = 'Zero Scale Command';
        }
        field(129; "Create Std. Packages Cmd."; Boolean)
        {
            Caption = 'Create Std. Packages Cmd.';
        }
        field(130; "Create Std. Packages Print Cmd"; Boolean)
        {
            Caption = 'Create Std. Packages Print Cmd';
        }
        field(131; "Create Extra Package Command"; Boolean)
        {
            Caption = 'Create Extra Package Command';
        }
        field(132; "Missing Order Lines Command"; Boolean)
        {
            Caption = 'Missing Order Lines Command';
        }
        field(133; "Create Misc. Package Command"; Boolean)
        {
            Caption = 'Create Misc. Package Command';
        }
        field(134; "Create Manifest Command"; Boolean)
        {
            Caption = 'Create Manifest Command';
        }
        field(135; "Add Multiple Packages Command"; Boolean)
        {
            Caption = 'Add Multiple Packages Command';
        }
        field(136; "Xtra Option Command"; Boolean)
        {
            Caption = 'Xtra Option Command';
        }
        field(137; "Set Prepack Command"; Boolean)
        {
            Caption = 'Set Prepack Command';
        }
        field(138; "Open Package Command"; Boolean)
        {
            Caption = 'Open Package Command';
        }
        field(139; "Change Shipping Agent Command"; Boolean)
        {
            Caption = 'Change Shipping Agent Command';
        }
        field(140; "Change Ship. Agent Print Cmd."; Boolean)
        {
            Caption = 'Change Ship. Agent Print Cmd.';
        }
        field(141; "Bill of Lading Command"; Boolean)
        {
            Caption = 'Bill of Lading Command';
        }
        field(142; "Add Selected Packages Command"; Boolean)
        {
            Caption = 'Add Selected Packages Command';
        }
        field(143; "Pack Remaining Command"; Boolean)
        {
            Caption = 'Pack Remaining Command';
        }
        field(144; "Reset Order Quantity Command"; Boolean)
        {
            Caption = 'Reset Order Quantity Command';
        }
        field(145; "Toggle Always Enter Qty. Cmd."; Boolean)
        {
            Caption = 'Toggle Always Enter Qty. Cmd.';
        }
        field(146; "List Orders Command"; Boolean)
        {
            Caption = 'List Orders Command';
        }
        field(147; "View Item Command"; Boolean)
        {
            Caption = 'View Item Command';
        }
        field(148; "Main Menu Command"; Boolean)
        {
            Caption = 'Main Menu Command';
        }
        field(149; "Set Order Quantity Command"; Boolean)
        {
            Caption = 'Set Order Quantity Command';
        }
        field(150; "Copy Last Label(s) Command"; Boolean)
        {
            Caption = 'Copy Last Label(s) Command';
        }
        field(151; "View Whse. Activity Lines Cmd."; Boolean)
        {
            Caption = 'View Whse. Activity Lines Cmd.';
        }
        field(152; "View Whse. Shipment Lines Cmd."; Boolean)
        {
            Caption = 'View Whse. Shipment Lines Cmd.';
        }
        field(153; "Fast Pack Command"; Boolean)
        {
            Caption = 'Fast Pack Command';
        }
        field(154; "View Invt. Activity Lines Cmd."; Boolean)
        {
            Caption = 'View Invt. Activity Lines Cmd.';
        }
        field(155; "Print All Labels Command"; Boolean)
        {
            Caption = 'Print All Labels Command';
        }
        field(156; "Print All labels And Docs. Cmd"; Boolean)
        {
            Caption = 'Print All labels And Docs. Cmd';
        }
        field(157; "Renumber All Packages Command"; Boolean)
        {
            Caption = 'Renumber All Packages Command';
        }
        field(158; "Renumber All Pcks. Print Cmd."; Boolean)
        {
            Caption = 'Renumber All Pcks. Print Cmd.';
        }
        field(159; "Scan Missing Serial Lot Cmd."; Boolean)
        {
            Caption = 'Scan Missing Serial Lot Cmd.';
        }
        field(160; "Scan All Serial Lot Command"; Boolean)
        {
            Caption = 'Scan All Serial Lot Command';
        }
        field(161; "Enter Tote Command"; Boolean)
        {
            Caption = 'Enter Tote Command';
        }
        field(162; "Select Tote Command"; Boolean)
        {
            Caption = 'Select Tote Command';
        }
        field(163; "Fedex Master Label Command"; Boolean)
        {
            Caption = 'Fedex Master Label Command';
        }
        field(164; "Fedex Master Label Print Cmd."; Boolean)
        {
            Caption = 'Fedex Master Label Print Cmd.';
        }
        field(165; "Export All Shipping Labels"; Boolean)
        {
            Caption = 'Export All Shipping Labels';
        }
        field(166; "Print Item/Resource Label"; Boolean)
        {
            Caption = 'Print Item/Resource Label';
        }
        field(167; "Export All Item/Res. Labels"; Boolean)
        {
            Caption = 'Export All Item/Res. Labels';
        }
        field(168; "Export All Labels"; Boolean)
        {
            Caption = 'Export All Labels';
        }
        field(169; "Future Close Order Command"; Boolean)
        {
            Caption = 'Future Close Order Command';
        }
        field(170; "View Bill of Lading Command"; Boolean)
        {
            Caption = 'View Bill of Lading Command';
        }
        field(171; "Future Close Order Force Cmd."; Boolean)
        {
            Caption = 'Future Close Order Force Cmd.';
        }
        field(172; "Print Bill of Lading Label Cmd"; Boolean)
        {
            Caption = 'Print Bill of Lading Label Cmd';
        }
        field(173; "Print RF-ID Label Command"; Boolean)
        {
            Caption = 'Print RF-ID Label Command';
        }
        field(174; "Register Whse. Pick Command"; Boolean)
        {
            Caption = 'Register Whse. Pick Command';
        }
        field(175; "View Warehouse Statistics Cmd."; Boolean)
        {
            Caption = 'View Warehouse Statistics Cmd.';
        }
        field(176; "Select Wave Pick Order Command"; Boolean)
        {
            Caption = 'Select Wave Pick Order Command';
        }
        field(201; "Auto Delete Label Buffer File"; Boolean)
        {
            Caption = 'Auto Delete Label Buffer File';
            InitValue = true;
        }
        field(202; "Carrier Packing Station Code"; Code[10])
        {
            Caption = 'Carrier Packing Station Code';
        }
        field(203; "Do Not Import Label File"; Boolean)
        {
            Caption = 'Do Not Import Label File';
        }
        field(204; "Scanning Form ID"; Integer)
        {
            Caption = 'Scanning Form ID';
            InitValue = 14000716;
        }
        field(205; "Scanning Form Name"; Text[30])
        {
            Caption = 'Scanning Form Name';
            Editable = false;
        }
        field(206; "Show Warehouse Stat. on Open"; Boolean)
        {
            Caption = 'Show Warehouse Stat. on Open';
        }
        field(207; "Do not Show BOL on Create"; Boolean)
        {
            Caption = 'Do not Show BOL on Create';
        }
        field(208; "RTC Scanning Form ID"; Integer)
        {
            Caption = 'RTC Scanning Form ID';
            InitValue = 14050138;

        }
        field(209; "RTC Scanning Form Name"; Text[30])
        {
            Caption = 'RTC Scanning Form Name';
            Editable = false;
        }
        field(210; "Text Editor"; Text[100])
        {
            Caption = 'Text Editor';
            InitValue = 'C:\Windows\Notepad.exe';
        }
        field(211; "Manually Enter Dimensions"; Boolean)
        {
            Caption = 'Manually Enter Dimensions';
        }
        field(50000; "Print Server"; Boolean)
        {
            Description = '#9978';
        }
        field(50005; "FTP Command File"; Text[30])
        {
            Description = '#9978';
        }
        field(50010; "Printer Server IP"; Text[30])
        {
            Description = '#9978';
        }
        field(50020; "Printer Name"; Text[250])
        {
            Caption = 'Printer Name';
            Description = '#10005';
            TableRelation = Printer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50030; "Def. Commodity Desc."; Text[100])
        {
        }
        field(50035; "Def. NMFC No."; Text[20])
        {
        }
        field(50037; "Def. Class Code"; Code[10])
        {
        }
        field(14000720; "Multi Document Command"; Boolean)
        {
            Caption = 'Multi Document Command';
        }
        field(14000721; "Multi Document Lookup Cmd"; Boolean)
        {
            Caption = 'Multi Document Lookup Cmd';
        }
        field(14000781; "Export License No."; Code[20])
        {
            Caption = 'Export License No.';
        }
        field(14000782; "Export License Expiration Date"; Date)
        {
            Caption = 'Export License Expiration Date';
        }
        field(14000783; "Export License Exception"; Code[4])
        {
            Caption = 'Export License Exception';
        }
        field(14000784; "Create FedEx Freight BOL"; Boolean)
        {
            Caption = 'Create FedEx Freight BOL';
        }
        field(14000785; "FedEx Freight Palletized"; Boolean)
        {
            Caption = 'FedEx Freight Palletized';
        }
        field(14000821; "Add Sales Orders BOL Command"; Boolean)
        {
            Caption = 'Add Sales Orders BOL Command';
        }
        field(14000822; "Add Sales Shipments BOL Cmd."; Boolean)
        {
            Caption = 'Add Sales Shipments BOL Cmd.';
        }
        field(14000823; "Add Posted Packages BOL Cmd."; Boolean)
        {
            Caption = 'Add Posted Packages BOL Cmd.';
        }
        field(14000824; "Close Bill of Lading BOL Cmd."; Boolean)
        {
            Caption = 'Close Bill of Lading BOL Cmd.';
        }
        field(14000825; "Close BillOfLad Print BOL Cmd."; Boolean)
        {
            Caption = 'Close BillOfLad Print BOL Cmd.';
        }
        field(14000826; "New Bill of Lading BOL Command"; Boolean)
        {
            Caption = 'New Bill of Lading BOL Command';
        }
        field(14000827; "Close Bill of Lading Action"; Option)
        {
            Caption = 'Close Bill of Lading Action';
            OptionCaption = ' ,Release,Summary Release,Post';
            OptionMembers = " ",Release,"Summary Release",Post;
        }
        field(14000828; "Show Document BOL Warnings"; Boolean)
        {
            Caption = 'Show Document BOL Warnings';
        }
        field(14000829; "Show Posted Doc. BOL Warnings"; Boolean)
        {
            Caption = 'Show Posted Doc. BOL Warnings';
        }
        field(14000830; "Show Package BOL Warnings"; Boolean)
        {
            Caption = 'Show Package BOL Warnings';
        }
        field(14000831; "Change Shipping Agent BOL Cmd."; Boolean)
        {
            Caption = 'Change Shipping Agent BOL Cmd.';
        }
        field(14000832; "Show Worksheet BOL Command"; Boolean)
        {
            Caption = 'Show Worksheet BOL Command';
        }
        field(14000841; "Std. Pack. Label Printer Port"; Code[100])
        {
            Caption = 'Std. Pack. Label Printer';
        }
        field(14000842; "UCC/UPC Label Printer Port"; Code[100])
        {
            Caption = 'UCC/UPC Label Printer';
        }
        field(14000844; "Label Buffer File"; Text[100])
        {
            Caption = 'Label Buffer File';
        }
        field(14000961; "RF-ID Label Printer Port"; Code[100])
        {
            Caption = 'RF-ID Label Printer';
        }
        field(14000981; "Export Document Command"; Boolean)
        {
            Caption = 'Export Document Command';
        }
        field(14000982; "View Export Document Command"; Boolean)
        {
            Caption = 'View Export Document Command';
        }
        field(14000984; "No Preview on AES Submit"; Boolean)
        {
            Caption = 'No Preview on AES Submit';
        }
        field(14000985; "No AES Required Command"; Boolean)
        {
            Caption = 'No AES Required Command';
        }
        field(14000986; "Export License Type"; Code[10])
        {
            Caption = 'Export License Type';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(14000987; "Export Information Code"; Code[10])
        {
            Caption = 'Export Information Code';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(14000988; "Do Not Show Exp Doc On Create"; Boolean)
        {
            Caption = 'Do Not Show Exp Doc On Create';
        }
        field(14000989; "Export Doc. Temp. Files Dir."; Text[200])
        {
            Caption = 'Export Doc. Temp. Files Dir.';
        }
        field(14000990; "Federal ID No."; Text[30])
        {
            Caption = 'Federal ID No.';
        }
        field(14000993; "Require AES ITN for Export"; Boolean)
        {
            Caption = 'Require AES ITN for Export';
        }
        field(14000995; "Update Export Doc Detail Cmd."; Boolean)
        {
            Caption = 'Update Export Doc Detail Cmd.';
        }
        field(14000996; "Label Printing"; Option)
        {
            Caption = 'Label Printing';
            OptionCaption = 'Ports,Printer Name';
            OptionMembers = Ports,"Printer Name";

        }
        field(14050501; "Local US Post Office Zip Code"; Code[20])
        {
            Caption = 'Local US Post Office Zip Code';
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
        fieldgroup(DropDown; "Code", Description, "Location Code")
        {
        }
    }

}

