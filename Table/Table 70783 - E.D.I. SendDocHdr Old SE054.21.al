table 70783 "E.D.I. SendDocHdr Old SE054.21"
{
    Caption = 'E.D.I. SendDocHdr Old SE054.21';
    DrillDownPageID = 14002383;
    LookupPageID = 14002383;
    Permissions = TableData 112 = rm;
    fields
    {
        field(1; "Internal Doc No."; Code[10])
        {
            Caption = 'Internal Doc No.';
            Editable = false;
        }
        field(2; "Navision Document"; Code[10])
        {
            Caption = 'Navision Document';
            Editable = false;
            TableRelation = "E.D.I. Navision Available Doc.".Document;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(4; Version; Integer)
        {
            Caption = 'Version';
            Editable = false;
        }
        field(11; "Trade Partner No."; Code[20])
        {
            Caption = 'Trade Partner No.';
            Editable = false;
            // TableRelation = "E.D.I. Trade Partner"."No.";
            TableRelation = "LAX EDI Trade Partner"."No.";
        }
        field(12; "EDI Document No."; Code[6])
        {
            Caption = 'EDI Document No.';
            Editable = false;
        }
        field(13; "EDI Version"; Code[10])
        {
            Caption = 'EDI Version';
            Editable = false;
        }
        field(14; "EDI Template Name"; Code[10])
        {
            Caption = 'EDI Template Name';
            Editable = false;
            // TableRelation = "E.D.I. Template";
            TableRelation = "LAX EDI Template";
        }
        field(15; "Interchange Control No."; Text[30])
        {
            Caption = 'Interchange Control No.';
            Editable = false;
        }
        field(16; "Group Control No."; Text[30])
        {
            Caption = 'Group Control No.';
            Editable = false;
        }
        field(17; "Transaction Set Control No."; Text[30])
        {
            Caption = 'Transaction Set Control No.';
            Editable = false;
        }
        field(18; "EDI Trade Partner Name"; Text[40])
        {
            FieldClass = FlowField;
            //  CalcFormula = Lookup("E.D.I. Trade Partner".Name WHERE("No." = FIELD("Trade Partner No.")));
            CalcFormula = Lookup("LAX EDI Trade Partner".Name WHERE("No." = FIELD("Trade Partner No.")));
            Caption = 'EDI Trade Partner Name';
            Editable = false;

        }
        field(19; "Funct. Ack. Required"; Boolean)
        {
            Caption = 'Funct. Ack. Required';
            Editable = false;
        }
        field(20; "Funct. Group Ack. Status"; Option)
        {
            Caption = 'Funct. Group Ack. Status';
            Editable = false;
            OptionCaption = ' ,Accepted,Accepted Errors,Part Accepted,Rejected';
            OptionMembers = " ",Accepted,"Accepted Errors","Part Accepted",Rejected;
        }
        field(21; "Tran. Set Funct. Ack. Status"; Option)
        {
            Caption = 'Tran. Set Funct. Ack. Status';
            Editable = false;
            OptionCaption = ' ,Accepted,Accepted Errors,Part Accepted,Rejected';
            OptionMembers = " ",Accepted,"Accepted Errors","Part Accepted",Rejected;
        }
        field(22; "Data Error"; Boolean)
        {

            /*  CalcFormula = Exist("E.D.I. Send Document Field" WHERE("Internal Doc No." = FIELD("Internal Doc No."),
                                                                        "Document No." = FIELD("Document No."),
                                                                        Version = FIELD(Version),
                                                                        "Data Error" = CONST(true))); */
            CalcFormula = Exist("LAX EDI Send Document Field" WHERE("Internal Doc No." = FIELD("Internal Doc No."),
                                                                       "Document No." = FIELD("Document No."),
                                                                       Version = FIELD(Version),
                                                                       "Data Error" = CONST(true)));

            Caption = 'Data Error';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(24; "Created Time"; Time)
        {
            Caption = 'Created Time';
            Editable = false;
        }
        field(25; "Sent Date"; Date)
        {
            Caption = 'Sent Date';
            Editable = false;
        }
        field(26; "Sent Time"; Time)
        {
            Caption = 'Sent Time';
            Editable = false;
        }
        field(27; "Document Sent"; Boolean)
        {
            Caption = 'Document Sent';
        }
        field(28; "Funct. Ack. Internal Doc. No."; Code[10])
        {
            Caption = 'Funct. Ack. Internal Doc. No.';
        }
    }
    keys
    {
        key(Key1; "Internal Doc No.", "Navision Document", "Document No.", Version)
        {
        }
        key(Key2; "Trade Partner No.", "Navision Document", "Sent Date")
        {
        }
        key(Key3; "Navision Document", "Document No.", "Sent Date")
        {
        }
        key(Key4; "Document Sent", "Funct. Ack. Required", "Funct. Group Ack. Status", "Tran. Set Funct. Ack. Status")
        {
        }
        key(Key5; "Trade Partner No.", "Group Control No.", "Transaction Set Control No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EDISendDocFldOld.RESET();
        EDISendDocFldOld.SETRANGE("Internal Doc No.", "Internal Doc No.");
        EDISendDocFldOld.SETRANGE("Document No.", "Document No.");
        EDISendDocFldOld.SETRANGE(Version, Version);
        EDISendDocFldOld.DELETEALL();
    end;

    var
        EDISendDocFldOld: Record 70784;
}
