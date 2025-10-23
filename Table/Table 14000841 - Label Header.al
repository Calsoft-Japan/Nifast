table 99995 "Label Header"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    // NF1.00:CIS.NG  09-03-15 Merged during upgrade (Merge the code from page - 14000841 "Label")
    //   >> NIF
    //   Fields Modified:
    //      Label Usage Type  (new options "Package Line" and "Production" and "Contract Line")
    // 
    //   Properties Modified:
    //     LookupFormID
    // 
    //   Fields Added:
    //     50000,50010   #10005
    // 
    //   Code Modified:
    //     OnDelete()
    // 
    //   Globals Added:
    //     LabelFieldContent
    // 
    //   Date     Init   Proj  Desc
    //   05-07-05 RTT  #10005  changed lookup form to use NIF custom form
    //   06-11-05 RTT  #10005  code at OnDelete() to remove related records from Label Field Content table
    //   12-08-05 RTT          new label usage type "Contract Line"
    //   << NIF
    // 
    // 
    // //>> NIF
    // Code Modified:
    //   Help on Formatting-OnPush()
    // Variables Added:
    //   PackageLineLabel
    // 
    // Date     Init  Proj  Desc
    // 04-26-05 RTT         code at Help on Formatting-OnPush to include Package Line labels
    // << NIF

    Caption = 'Label Header';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Printer Type"; Option)
        {
            Caption = 'Printer Type';
            OptionCaption = ' ,Eltron Orion,Zebra,Text File';
            OptionMembers = " ","Eltron Orion",Zebra,"Text File";
        }
        field(4; "Print From"; Option)
        {
            Caption = 'Print From';
            OptionCaption = 'Top,Bottom';
            OptionMembers = Top,Bottom;
        }
        field(5; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(6; "Label Height"; Integer)
        {
            Caption = 'Label Height';
            InitValue = 1250;
        }
        field(7; "Dot per Inch"; Integer)
        {
            Caption = 'Dot per Inch';
        }
        field(8; "Label Usage"; Option)
        {
            Caption = 'Label Usage';
            OptionCaption = 'Package,Item,Customer,Resource,Receive,Receive Line,Bill of Lading,Bin,,,Package Line,Production,Contract Line';
            OptionMembers = Package,Item,Customer,Resource,Receive,"Receive Line","Bill of Lading",Bin,,,"Package Line",Production,"Contract Line";

        }
        field(9; "Add Item Info on Label"; Boolean)
        {
            Caption = 'Add Item Info on Label';

        }
        field(10; "Text File Command String"; Text[250])
        {
            Caption = 'Text File Command String';

        }
        field(11; "Header Text"; Text[250])
        {
            Caption = 'Header Text';

            trigger OnValidate()
            begin
                IF "Header Text" <> '' THEN
                    TESTFIELD("Printer Type", "Printer Type"::"Text File");
            end;
        }
        field(12; "Footer Text"; Text[250])
        {
            Caption = 'Footer Text';

            trigger OnValidate()
            begin
                IF "Footer Text" <> '' THEN
                    TESTFIELD("Printer Type", "Printer Type"::"Text File");
            end;
        }
        field(13; "Line Break Text Character"; Text[1])
        {
            Caption = 'Line Break Text Character';
            InitValue = '\';
        }
        field(50000; "No. of Fields"; Integer)
        {
            Editable = false;
        }
        field(50005; "Format Path"; Text[250])
        {
        }
        field(50006; "Label Type"; Option)
        {
            Description = 'CIS.RAM050322';
            OptionCaption = ' ,Const+Date+Serial';
            OptionMembers = " ","Const+Date+Serial";
        }
        field(50007; "Label Constant"; Text[30])
        {
            Description = 'CIS.RAM050322';
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

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;

    var
        /*  Text001: Label 'Label Lines has been updated, but not all lines can be changed correctly.';
         Text002: Label 'Please test the label.';
         Text003: Label 'Lines will maybe not be correct when changing the %1, ';
         Text004: Label 'Are you sure you want to change this value?';
         Text005: Label 'Nothing changed.';
         Text007: Label 'Label Code cannot be blank.';
         Text008: Label 'New Label %1 has been inserted.';
         Text009: Label 'No lines to renumber.';
         Text010: Label 'cannot be %1.'; */
        Text011: Label 'Header Text arguments',Comment='%1 = User ID, %2 = Today and %3 = Time';
        Text012: Label 'Footer Text arguments',Comment='%1 = No. of Copies, %2 = User ID, %3 = Today and %4 = Time';
        Text013: Label 'Text File Command String will have',Comment='%1 = Temporary Filename, %2 = Reference No., %3 = Printer Port, %4 = User ID, %5 = Today and %6 = Time';
    /*  Text014: Label 'Remove old data in unused fields?';
     "<<NIF_GV>>": Integer; */

    procedure CopyLabelAskNewCode()
    begin
    end;

    procedure CopyLabel(NewLabelCode: Code[10])
    begin
    end;

    procedure HelpOnFormatting()
    begin
    end;

    procedure ConvertLabel()
    begin
    end;

    procedure PrintLabelLayout()
    begin
    end;

    procedure RenumberLabel()
    begin
    end;

    procedure TextFileHelp()
    begin
        MESSAGE(Text011 + '\' + Text012 + '\' + Text013, '%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9');
    end;
}

