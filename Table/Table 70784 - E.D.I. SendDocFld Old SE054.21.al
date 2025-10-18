table 70784 "E.D.I. SendDocFld Old SE054.21"
{
    Caption = 'E.D.I. SendDocFld Old SE054.21';
    fields
    {
        field(1; "Internal Doc No."; Code[10])
        {
            Caption = 'Internal Doc No.';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; Version; Integer)
        {
            Caption = 'Version';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(11; "Trade Partner No."; Code[20])
        {
            Caption = 'Trade Partner No.';
            //TODO
            //  TableRelation = "E.D.I. Receive Document Hdr."."Trade Partner No.";
            //TODO
        }
        field(12; "Navision Document"; Code[10])
        {
            Caption = 'Navision Document';
        }
        field(13; "EDI Document No."; Code[6])
        {
            Caption = 'EDI Document No.';
        }
        field(14; Segment; Code[15])
        {
            Caption = 'Segment';
            Editable = false;
        }
        field(15; Element; Code[5])
        {
            Caption = 'Element';
            Editable = false;
        }
        field(16; "Field Name"; Text[40])
        {
            Caption = 'Field Name';
            Editable = false;
        }
        field(17; "NAV Table Name"; Text[40])
        {
            Caption = 'NAV Table Name';
        }
        field(18; "NAV Table No."; Integer)
        {
            Caption = 'NAV Table No.';
        }
        field(19; "NAV Field No."; Integer)
        {
            Caption = 'NAV Field No.';
            Editable = false;
        }
        field(20; "Field Type"; Option)
        {
            Caption = 'Field Type';
            OptionCaption = 'Integer,Text,Code,Decimal,Option,Boolean,Date,Time,Binary,BLOB,N/A';
            OptionMembers = "Integer",Text,"Code",Decimal,Option,Boolean,Date,Time,Binary,BLOB,"N/A";
        }
        field(21; "Data Type"; Option)
        {
            Caption = 'Data Type';
            OptionCaption = 'Text,Dec Implied,Dec Explicit,Integer,Date YYMMDD,Date YYYYMMDD';
            OptionMembers = Text,"Dec Implied","Dec Explicit","Integer","Date YYMMDD","Date YYYYMMDD";
        }
        field(22; "Field Text Value"; Text[80])
        {
            Caption = 'Field Text Value';
        }
        field(23; "Field Length"; Integer)
        {
            Caption = 'Field Length';
        }
        field(24; "Data Error"; Boolean)
        {
            Caption = 'Data Error';
            Editable = true;
        }
        field(25; "New Segment"; Boolean)
        {
            Caption = 'New Segment';
        }
        field(26; "Use Component Delimiter"; Boolean)
        {
            Caption = 'Use Component Delimiter';
        }
        field(27; "Bypass Blank Trailing Element"; Boolean)
        {
            Caption = 'Bypass Blank Trailing Element';
        }
        field(200; "Date Changed"; Date)
        {
            Caption = 'Date Changed';
        }
        field(201; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
    }
    keys
    {
        key(Key1; "Internal Doc No.", "Document No.", Version, "Line No.")
        {
        }
        key(Key2; "Internal Doc No.", "Document No.", Version, "Data Error")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        "Date Changed" := TODAY;
        "User ID" := USERID;
    end;
}
