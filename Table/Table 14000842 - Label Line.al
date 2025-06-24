table 99993 "Label Line"
{
    Caption = 'Label Line';

    fields
    {
        field(1; "Label Code"; Code[10])
        {
            Caption = 'Label Code';
            TableRelation = "Label Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Barcode,Text,Line,,,Zone,Bitmap,2D Barcode,RF-ID';
            OptionMembers = " ",Barcode,Text,Line,,,Zone,Bitmap,"2D Barcode","RF-ID";


        }
        field(4; "Horizontal Position"; Integer)
        {
            Caption = 'Horizontal Position';


        }
        field(5; "Vertical Position"; Integer)
        {
            Caption = 'Vertical Position';

        }
        field(6; "Rotation Degrees"; Option)
        {
            Caption = 'Rotation Degrees';
            OptionCaption = '0,90,180,270';
            OptionMembers = "0","90","180","270";
        }
        field(7; Font; Option)
        {
            Caption = 'Font';
            InitValue = "10 Point";
            OptionCaption = ' ,6 Point,7 Point,10 Point,12 Point,24 Point,Custom';
            OptionMembers = " ","6 Point","7 Point","10 Point","12 Point","24 Point",Custom;
        }
        field(8; "Horizontal Multiplier"; Code[1])
        {
            Caption = 'Horizontal Multiplier';
            CharAllowed = '09';
            InitValue = '1';
        }
        field(9; "Vertical Multiplier"; Code[1])
        {
            Caption = 'Vertical Multiplier';
            CharAllowed = '09';
            InitValue = '1';
        }
        field(10; Image; Option)
        {
            Caption = 'Image';
            InitValue = Normal;
            OptionCaption = ' ,Normal,Reverse';
            OptionMembers = " ",Normal,Reverse;
        }
        field(11; "Table No."; Integer)
        {
            Caption = 'Table No.';
            TableRelation = "Label Mapping Table";


        }
        field(12; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            Editable = false;

        }
        field(13; "Field No."; Integer)
        {
            Caption = 'Field No.';

        }
        field(14; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            Editable = false;
        }
        field(15; "Line Length"; Integer)
        {
            Caption = 'Line Length';
        }
        field(16; "Line Height"; Integer)
        {
            Caption = 'Line Height';
        }
        field(17; "Barcode Type"; Option)
        {
            Caption = 'Barcode Type';
            InitValue = "Code 128 A B and C";
            OptionCaption = ' ,Code 39 Std,Code 39 with Mod 10,Code 93,Code 128 Serial Ship Container No.,Code 128 A B and C,Codebar,Interleaved 2 of 5,Interleaved 2 of 5 and Mod 10,Interleaved 2 of 5 and Text,Postnet 5 6 8 and 9 Digit,UPC A,UPC A 2 Dig Add On,UPC A 5 Dig Add On,UPC E,UPC E 2 Dig Add On,UPC E 5 Dig Add On,UPC Interleaved 2 of 5,Plessy with Mod 10,MSI-3 with Mod 10,UCC-EAN 128';
            OptionMembers = " ","Code 39 Std","Code 39 with Mod 10","Code 93","Code 128 Serial Ship Container No.","Code 128 A B and C",Codebar,"Interleaved 2 of 5","Interleaved 2 of 5 and Mod 10","Interleaved 2 of 5 and Text","Postnet 5 6 8 and 9 Digit","UPC A","UPC A 2 Dig Add On","UPC A 5 Dig Add On","UPC E","UPC E 2 Dig Add On","UPC E 5 Dig Add On","UPC Interleaved 2 of 5","Plessy with Mod 10","MSI-3 with Mod 10","UCC-EAN 128";
        }
        field(18; "Narrow Barcode Width"; Integer)
        {
            Caption = 'Narrow Barcode Width';
        }
        field(19; "Wide Barcode Width"; Integer)
        {
            Caption = 'Wide Barcode Width';
        }
        field(20; "Barcode Height"; Integer)
        {
            Caption = 'Barcode Height';
        }
        field(21; "Print Barcode Text"; Boolean)
        {
            Caption = 'Print Barcode Text';
        }
        field(22; Text; Text[250])
        {
            Caption = 'Text';
            InitValue = '%1';
        }
        field(23; Description; Text[40])
        {
            Caption = 'Description';
        }
        field(24; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(25; "Use Formatted Text"; Boolean)
        {
            Caption = 'Use Formatted Text';

        }
        field(26; "Max Data Length"; Integer)
        {
            Caption = 'Max Data Length';
        }
        field(27; "Min Data Length"; Integer)
        {
            Caption = 'Min Data Length';
        }
        field(28; "Record No."; Integer)
        {
            Caption = 'Record No.';
            MinValue = 0;

        }
        field(29; "Skip If All Elements Blank"; Boolean)
        {
            Caption = 'Skip If All Elements Blank';
        }
        field(30; "Elements Exists"; Boolean)
        {
            Caption = 'Elements Exists';
            Editable = false;
        }
        field(31; "Horizontal Relative Position"; Integer)
        {
            Caption = 'Horizontal Relative Position';

        }
        field(32; "Vertical Relative Position"; Integer)
        {
            Caption = 'Vertical Relative Position';

        }
        field(33; "Zone Code"; Option)
        {
            Caption = 'Zone Code';
            OptionCaption = ' ,0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,I,H,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z';
            OptionMembers = " ","0","1","2","3","4","5","6","7","8","9",A,B,C,D,E,F,G,I,H,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z;

        }
        field(34; "Virtual Field"; Option)
        {
            Caption = 'Virtual Field';
            OptionCaption = ' ,,,WorkDate,Today,Time,,,,,,Test';
            OptionMembers = " ",,,WorkDate,Today,Time,,,,,,Test;

        }
        field(35; "Line Thickness"; Integer)
        {
            Caption = 'Line Thickness';

        }
        field(36; "Barcode Ratio"; Decimal)
        {
            Caption = 'Barcode Ratio';

        }
        field(37; Bitmap; BLOB)
        {
            Caption = 'Bitmap';
        }
        field(38; "Bitmap Name"; Text[250])
        {
            Caption = 'Bitmap Name';
            Editable = false;
        }
        field(39; "Bitmap Width"; Integer)
        {
            Caption = 'Bitmap Width';
            Editable = false;
        }
        field(40; "Bitmap Height"; Integer)
        {
            Caption = 'Bitmap Height';
            Editable = false;
        }
        field(41; "Raster Start Position"; Integer)
        {
            Caption = 'Raster Start Position';
            Editable = false;
        }
        field(42; "Custom Font"; Text[30])
        {
            Caption = 'Custom Font';

        }
        field(43; "2D Barcode Command"; Text[100])
        {
            Caption = '2D Barcode Command';
        }
        field(44; "Extended Data Code"; Code[10])
        {
            Caption = 'Extended Data Code';
        }
        field(45; "Substitution Separator Char"; Code[1])
        {
        }
        field(100; Properties; Boolean)
        {
            Caption = 'Properties';

            trigger OnValidate()
            begin
                Properties := FALSE;
            end;
        }
        field(101; "Printer String"; Text[200])
        {
            Caption = 'Printer String';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Label Code", "Line No.")
        {
        }
    }

}

