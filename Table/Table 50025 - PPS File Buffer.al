table 50025 "PPS File Buffer"
{
    fields
    {
        field(1; "Document No."; Code[30])
        {
            // cleaned
        }
        field(2; "Line No."; Integer)
        {
            // cleaned
        }
        field(5; "Customer No."; Code[20])
        {
            // cleaned
        }
        field(6; "Ship-to Code"; Code[10])
        {
            // cleaned
        }
        field(7; "Item No."; Code[20])
        {
            // cleaned
        }
        field(8; "Cross-Reference No."; Code[30])
        {
            // cleaned
        }
        field(10; Description; Text[50])
        {
            // cleaned
        }
        field(15; Quantity; Decimal)
        {
            // cleaned
        }
        field(20; "File Name"; Text[250])
        {
            Description = 'Full Path of File';
        }
        field(21; "File Name 2"; Text[100])
        {
            Description = 'File name only';
        }
        field(50; "EDI Control No."; Code[20])
        {
            // cleaned
            trigger OnValidate()
            var
            // EDISetup: Record "14002367";
            begin
            end;
        }
        field(100; "Error Found"; Boolean)
        {
            // cleaned
        }
        field(101; "Error Message"; Text[250])
        {
            // cleaned
        }
        field(102; "Plant Code"; Code[10])
        {
            // cleaned
        }
        field(103; "Dock Code"; Code[10])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }
}
