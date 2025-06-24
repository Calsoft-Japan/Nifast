table 99994 "Receive Station"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //   >> NIF
    // 
    //   Date     Init   Proj   Desc
    //   04-26-05 RTT   #9978   new fields 50000,50005,50010
    //   05-07-05 RTT  #10005   new field 50020
    //   04-12-06 RTT           new field "Default Item Receive Rule Code"
    //   << NIF

    Caption = 'Receive Station';

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
        field(13; "Print Receipt Report on Close"; Boolean)
        {
            Caption = 'Print Receipt Report on Close';
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

            trigger OnValidate()
            begin
                IF NOT "Enter Quantities" THEN
                    "Do Not Enter Quantity of One" := FALSE;
            end;
        }
        field(17; "Always Enter Total Receives"; Boolean)
        {
            Caption = 'Always Enter Total Receives';
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
        field(22; "Test Receive No. on Close Ord."; Boolean)
        {
            Caption = 'Test Receive No. on Close Ord.';
        }
        field(23; "Do Not Enter Quantity of One"; Boolean)
        {
            Caption = 'Do Not Enter Quantity of One';

            trigger OnValidate()
            begin
                TESTFIELD("Enter Quantities");
            end;
        }
        field(24; "Create Item Cross Reference"; Boolean)
        {
            Caption = 'Create Item Cross Reference';
        }
        field(25; "Manually Enter Weight"; Boolean)
        {
            Caption = 'Manually Enter Weight';
        }
        field(26; "Scale Inferface Code"; Code[10])
        {
            Caption = 'Scale Inferface Code';
        }
        field(27; "Scale Update Interval (second)"; Integer)
        {
            Caption = 'Scale Update Interval (second)';

            trigger OnValidate()
            begin
                TESTFIELD("Scale Inferface Code");
            end;
        }
        field(28; "Show What During Receive"; Option)
        {
            Caption = 'Show What During Receive';
            OptionCaption = 'Net Weight,Gross Weight,Dimmed Weight,Volume,Scale Weight';
            OptionMembers = "Net Weight","Gross Weight","Dimmed Weight",Volume,"Scale Weight";

            trigger OnValidate()
            begin
                IF "Show What During Receive" = "Show What During Receive"::"Scale Weight" THEN BEGIN
                    TESTFIELD("Scale Inferface Code");
                    TESTFIELD("Scale Update Interval (second)");
                END;
            end;
        }
        field(29; "Default Receive Description"; Text[30])
        {
            Caption = 'Default Receive Description';
        }
        field(30; "Accumulate Qty when Entered"; Boolean)
        {
            Caption = 'Accumulate Qty when Entered';
        }
        field(31; "Correct Actions Early"; Boolean)
        {
            Caption = 'Correct Actions Early';
        }
        field(32; "Use Scale on Close Receive"; Boolean)
        {
            Caption = 'Use Scale on Close Receive';
        }
        field(33; "Enter Ext. Track. No. on Close"; Boolean)
        {
            Caption = 'Enter Ext. Track. No. on Close';
        }
        field(34; "Change Posting Date on Close"; Boolean)
        {
            Caption = 'Change Posting Date on Close';
        }
        field(35; "Open Order after Close"; Boolean)
        {
            Caption = 'Open Order after Close';
        }
        field(36; "SHELL Command Type"; Option)
        {
            Caption = 'SHELL Command Type';
            InitValue = "With Parameters";
            OptionCaption = 'One String,With Parameters,Oyster OCX,.NET Automation';
            OptionMembers = "One String","With Parameters","Oyster OCX",".NET Automation";
        }
        field(37; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(38; "Select Receive Bin"; Boolean)
        {
            Caption = 'Select Receive Bin';
        }
        field(39; "Default Receive Bin Code"; Code[10])
        {
            Caption = 'Default Receive Bin Code';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(40; "Print Put-Away on Close"; Boolean)
        {
            Caption = 'Print Put-Away on Close';
        }
        field(41; "Purchase Order Close Action"; Option)
        {
            Caption = 'Purchase Order Close Action';
            OptionCaption = ' ,Receive,Receive and Invoice';
            OptionMembers = " ",Receive,"Receive and Invoice";
        }
        field(42; "Purchase Invoice Close Action"; Option)
        {
            Caption = 'Purchase Invoice Close Action';
            OptionCaption = ' ,Invoice';
            OptionMembers = " ",Invoice;

        }
        field(43; "Sales Cr. Memo Close Action"; Option)
        {
            Caption = 'Sales Cr. Memo Close Action';
            OptionCaption = ' ,Invoice';
            OptionMembers = " ",Invoice;


        }
        field(44; "Return Order Close Action"; Option)
        {
            Caption = 'Return Order Close Action';
            OptionCaption = ' ,Receive,Receive and Invoice';
            OptionMembers = " ",Receive,"Receive and Invoice";

        }
        field(45; "Transfer Order Close Action"; Option)
        {
            Caption = 'Transfer Order Close Action';
            OptionCaption = ' ,Receive';
            OptionMembers = " ",Receive;

        }
        field(46; "Default F3 Option"; Option)
        {
            Caption = 'Default F3 Option';
            OptionCaption = ' ,Create Receive,Create Receive Print,,,Receive All,Receive All Print,Receive Remaining,Receive Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Receive","Create Receive Print",,,"Receive All","Receive All Print","Receive Remaining","Receive Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(47; "Default Shift+F3 Option"; Option)
        {
            Caption = 'Default Shift+F3 Option';
            OptionCaption = ' ,Create Receive,Create Receive Print,,,Receive All,Receive All Print,Receive Remaining,Receive Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Receive","Create Receive Print",,,"Receive All","Receive All Print","Receive Remaining","Receive Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(48; "Default Ctrl+F3 Option"; Option)
        {
            Caption = 'Default Ctrl+F3 Option';
            OptionCaption = ' ,Create Receive,Create Receive Print,,,Receive All,Receive All Print,Receive Remaining,Receive Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Receive","Create Receive Print",,,"Receive All","Receive All Print","Receive Remaining","Receive Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(49; "Default Alt+F3 Option"; Option)
        {
            Caption = 'Default Alt+F3 Option';
            OptionCaption = ' ,Create Receive,Create Receive Print,,,Receive All,Receive All Print,Receive Remaining,Receive Remaining Print,,,,,,,,,,,,,Custom 1,Custom 2,Custom 3';
            OptionMembers = " ","Create Receive","Create Receive Print",,,"Receive All","Receive All Print","Receive Remaining","Receive Remaining Print",,,,,,,,,,,,,"Custom 1","Custom 2","Custom 3";
        }
        field(50; "Simple Multi Document Posting"; Boolean)
        {
            Caption = 'Simple Multi Document Posting';
            InitValue = true;
        }
        field(51; "Allow Over Receive"; Boolean)
        {
            Caption = 'Allow Over Receive';
        }
        field(52; "Confirm Rec. Line Scan. Close"; Boolean)
        {
            Caption = 'Confirm Rec. Line Scan. Close';
            InitValue = true;
        }
        field(53; "Sales Order Qty. Date Calc."; DateFormula)
        {
            Caption = 'Sales Order Qty. Date Calc.';
        }
        field(54; "Auto Delete Label Buffer File"; Boolean)
        {
            Caption = 'Auto Delete Label Buffer File';
            InitValue = true;
        }
        field(55; "Change Put-away on Close"; Boolean)
        {
            Caption = 'Change Put-away on Close';
            InitValue = true;
        }
        field(56; "Register Put-away on Close"; Boolean)
        {
            Caption = 'Register Put-away on Close';
        }
        field(57; "Select Put-away Bin"; Boolean)
        {
            Caption = 'Select Put-away Bin';
        }
        field(58; "Do Not Import Label File"; Boolean)
        {
            Caption = 'Do Not Import Label File';
        }
        field(59; "Scanning Form ID"; Integer)
        {
            Caption = 'Scanning Form ID';
            InitValue = 14000624;

            trigger OnValidate()
            begin
                CALCFIELDS("Scanning Form Name");
            end;
        }
        field(60; "Scanning Form Name"; Text[30])
        {
            Caption = 'Scanning Form Name';
            Editable = false;
        }
        field(61; "RTC Scanning Form ID"; Integer)
        {
            Caption = 'RTC Scanning Form ID';
            InitValue = 14050062;

            trigger OnValidate()
            begin
                CALCFIELDS("Scanning Form Name");
            end;
        }
        field(62; "RTC Scanning Form Name"; Text[30])
        {
            Caption = 'RTC Scanning Form Name';
            Editable = false;
        }
        field(63; "Text Editor"; Text[100])
        {
            Caption = 'Text Editor';
            InitValue = 'C:\Windows\Notepad.exe';
        }
        field(64; "Manually Enter Dimensions"; Boolean)
        {
            Caption = 'Manually Enter Dimensions';
        }
        field(65; "Filter Incoming Location Code"; Boolean)
        {
            Caption = 'Filter Incoming Location Code';
            InitValue = true;
        }
        field(101; "Add Receive Command"; Boolean)
        {
            Caption = 'Add Receive Command';
        }
        field(102; "Close Receive Command"; Boolean)
        {
            Caption = 'Close Receive Command';
        }
        field(103; "Close Receive Print Command"; Boolean)
        {
            Caption = 'Close Receive Print Command';
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
        field(108; "Receive All Command"; Boolean)
        {
            Caption = 'Receive All Command';
        }
        field(109; "Print Std. Receive Labels Cmd."; Boolean)
        {
            Caption = 'Print Std. Receive Labels Cmd.';
        }
        field(110; "Total Receive Count Command"; Boolean)
        {
            Caption = 'Total Receive Count Command';
        }
        field(111; "Override Receive Volume Cmd."; Boolean)
        {
            Caption = 'Override Receive Volume Cmd.';
        }
        field(112; "Override Receive Weight Cmd."; Boolean)
        {
            Caption = 'Override Receive Weight Cmd.';
        }
        field(113; "View Order Command"; Boolean)
        {
            Caption = 'View Order Command';
        }
        field(114; "Copy Last Receive Command"; Boolean)
        {
            Caption = 'Copy Last Receive Command';
        }
        field(115; "Copy Last Receive Print Cmd."; Boolean)
        {
            Caption = 'Copy Last Receive Print Cmd.';
        }
        field(116; "Close Order Print Force Cmd."; Boolean)
        {
            Caption = 'Close Order Print Force Cmd.';
        }
        field(117; "Add All Receives Command"; Boolean)
        {
            Caption = 'Add All Receives Command';
        }
        field(118; "View Order Comments Command"; Boolean)
        {
            Caption = 'View Order Comments Command';
        }
        field(120; "Delete All Receives Command"; Boolean)
        {
            Caption = 'Delete All Receives Command';
        }
        field(122; "Zero Scale Command"; Boolean)
        {
            Caption = 'Zero Scale Command';
        }
        field(124; "Missing Order Lines Command"; Boolean)
        {
            Caption = 'Missing Order Lines Command';
        }
        field(125; "Add Multiple Receives Command"; Boolean)
        {
            Caption = 'Add Multiple Receives Command';
        }
        field(126; "Xtra Option Command"; Boolean)
        {
            Caption = 'Xtra Option Command';
        }
        field(127; "Open Receive Command"; Boolean)
        {
            Caption = 'Open Receive Command';
        }
        field(128; "Add Selected Receives Command"; Boolean)
        {
            Caption = 'Add Selected Receives Command';
        }
        field(129; "Receive Remaining Command"; Boolean)
        {
            Caption = 'Receive Remaining Command';
        }
        field(130; "Reset Order Quantity Command"; Boolean)
        {
            Caption = 'Reset Order Quantity Command';
        }
        field(131; "Toggle Always Enter Qty. Cmd."; Boolean)
        {
            Caption = 'Toggle Always Enter Qty. Cmd.';
        }
        field(132; "List Orders Command"; Boolean)
        {
            Caption = 'List Orders Command';
        }
        field(133; "View Item Command"; Boolean)
        {
            Caption = 'View Item Command';
        }
        field(134; "Main Menu Command"; Boolean)
        {
            Caption = 'Main Menu Command';
        }
        field(135; "Multi Document Command"; Boolean)
        {
            Caption = 'Multi Document Command';
        }
        field(136; "View Whse. Receipt Lines Cmd."; Boolean)
        {
            Caption = 'View Whse. Receipt Lines Cmd.';
        }
        field(137; "Multi Document Lookup Cmd"; Boolean)
        {
            Caption = 'Multi Document Lookup Cmd';
        }
        field(138; "Print Item Label Command"; Boolean)
        {
            Caption = 'Print Item Label Command';
        }
        field(139; "Receive Package Command"; Boolean)
        {
            Caption = 'Receive Package Command';
        }
        field(140; "View All Item Actions Command"; Boolean)
        {
            Caption = 'View All Item Actions Command';
        }
        field(141; "Select Receive Bin Command"; Boolean)
        {
            Caption = 'Select Receive Bin Command';
        }
        field(142; "Scan Missing Serial Lot Cmd."; Boolean)
        {
            Caption = 'Scan Missing Serial Lot Cmd.';
        }
        field(143; "Scan All Serial Lot Command"; Boolean)
        {
            Caption = 'Scan All Serial Lot Command';
        }
        field(144; "Select Put-away Bin Command"; Boolean)
        {
            Caption = 'Select Put-away Bin Command';
        }
        field(145; "Auto Create Sales Return Cmd."; Boolean)
        {
            Caption = 'Auto Create Sales Return Cmd.';
        }
        field(146; "Auto Create Purchase Order Cmd"; Boolean)
        {
            Caption = 'Auto Create Purchase Order Cmd';
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
        field(50030; "Default Item Receive Rule Code"; Code[10])
        {
        }
        field(14000841; "Label Printer Port"; Code[100])
        {
            Caption = 'Label Printer Port';
        }
        field(14000842; "Item Label Printer Port"; Code[100])
        {
            Caption = 'Item Label Printer Port';
        }
        field(14000843; "Label Buffer File"; Text[100])
        {
            Caption = 'Label Buffer File';
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

