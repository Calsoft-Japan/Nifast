table 50042 "IoT Data Staging"
{
    // CIS.IoT 07/22/22 RAM Created new Object
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Description = 'PK';
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Invt. Pick,Trans. Rcpt.,Sales Ship';
            OptionMembers = " ","Invt. Pick","Trans. Rcpt.","Sales Ship";
        }
        field(3; "Document No."; Code[20])
        {
            Description = 'Whse. Activity Tbl No. field';
        }
        field(4; "Line No."; Integer)
        {
            Description = 'Whse. Activity Tbl Line No. field';
        }
        field(5; "Table No."; Integer)
        {
            // cleaned
        }
        field(6; "Item No."; Code[20])
        {
            // cleaned
            TableRelation = Item;
        }
        field(7; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(8; Quantity; Decimal)
        {
            Description = 'In Boxes';
        }
        field(9; "Location From"; Code[20])
        {
            // cleaned
            TableRelation = Location;
        }
        field(10; "Location To"; Code[20])
        {
            // cleaned
            TableRelation = Location;
        }
        field(11; "RFID Gate No."; Code[10])
        {
            // cleaned
        }
        field(20; "Record Status"; Option)
        {
            OptionCaption = 'Pending,Error,Processed';
            OptionMembers = Pending,Error,Processed;
            trigger OnValidate()
            begin
                IF ("Record Status" = "Record Status"::Pending) AND
                   (xRec."Record Status" = xRec."Record Status"::Processed)
                THEN BEGIN
                    "Date Processed On" := 0D;
                    "Output Document Type" := "Output Document Type"::" ";
                    "Output Document No." := '';
                    "Output Invt. Pick Type" := 0;
                    "Output Pick No." := '';
                    MODIFY();
                END;
            end;
        }
        field(21; "Email Notification Sent"; Boolean)
        {
            // cleaned
        }
        field(22; "Email Recipients"; Text[150])
        {
            // cleaned
        }
        field(23; "Resend Email Notfication"; Boolean)
        {
            // cleaned
        }
        field(24; "Error Message"; Text[250])
        {
            // cleaned
        }
        field(25; "Email Notifications Sent On"; DateTime)
        {
            // cleaned
        }
        field(26; "Email Notifications Sent On 2"; DateTime)
        {
            // cleaned
        }
        field(27; "Date Processed On"; Date)
        {
            // cleaned
        }
        field(28; "Output Document Type"; Option)
        {
            Description = ' ,Sales Order,Invt. Pick';
            OptionCaption = ' ,Sales Order,Invt. Pick';
            OptionMembers = " ","Sales Order","Invt. Pick";
        }
        field(29; "Output Document No."; Code[20])
        {
            // cleaned
            TableRelation = IF ("Output Document Type" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE IF ("Output Document Type" = CONST("Invt. Pick")) "Warehouse Activity Header" WHERE(Type = CONST("Invt. Pick"));
        }
        field(30; "Output Invt. Pick Type"; Option)
        {
            Description = 'Invt. Pick';
            OptionCaption = ' ,Sales Order,Invt. Pick';
            OptionMembers = " ","Sales Order","Invt. Pick";
        }
        field(31; "Output Pick No."; Code[20])
        {
            // cleaned
            TableRelation = IF ("Output Invt. Pick Type" = CONST("Invt. Pick")) "Warehouse Activity Header" WHERE (Type=CONST("Invt. Pick"));
        }
        field(32; "File Name"; Text[250])
        {
            // cleaned
        }
        field(33; "Date Imported"; Date)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}
