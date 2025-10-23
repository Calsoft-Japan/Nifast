tableextension 57317 "Warehouse Receipt Line Ext" extends "Warehouse Receipt Line"
{
    fields
    {
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        field(60002; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            Editable = false;
        }
        field(60004; "Assignment Date"; Date)
        {
            Caption = 'Assignment Date';
            Editable = false;
        }
        field(60005; "Assignment Time"; Time)
        {
            Caption = 'Assignment Time';
            Editable = false;
        }
        field(14017610; "To Put-away Group Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            trigger OnValidate()
            begin
                // >> NV - 09-09-03 MV
                IF "To Put-away Group Code" <> '' THEN
                    TESTFIELD("To Put-away Template Code", '');
                // << NV - 09-09-03 MV
            end;
        }
        field(14017611; "To Put-away Template Code"; code[10])
        {
            TableRelation = "Put-away Template Header";
            trigger OnValidate()
            begin
                // >> NV - 09-09-03 MV
                IF "To Put-away Template Code" <> '' THEN
                    TESTFIELD("To Put-away Group Code", '');
                // << NV - 09-09-03 MV
            end;
        }
        field(14017614; "Special Order Sales No."; code[20])
        {
        }
        field(14017615; "Special Order Sales Line No."; Integer)
        {
        }
        field(14017620; "Posting Date"; Date)
        {
        }
        field(14017621; "External Document No."; code[20])
        {
        }
        field(14017685; "Skip Line"; Boolean)
        {
        }
        field(14017761; "Prod. Kit Order No."; code[20])
        {
            Editable = false;
        }
        field(14017762; "Prod. Kit Order Line No"; Integer)
        {
            Editable = false;
        }
        field(14017990; "Qty. to Receive Weight"; Decimal)
        {
        }
        field(14017999; "License Plate No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14018000; "Transfer License Plate No."; code[20])
        {
            Editable = false;
        }
        field(14018070; "QC Hold"; Boolean)
        {
        }
        field(37015592; "Destination Name"; text[50])
        {
        }
        field(37015593; "Destination Type"; Option)
        {
            OptionMembers = ,Customer,Vendor,Location;
        }
        field(37015594; "Destination No."; code[20])
        {
            TableRelation = IF ("Destination Type" = CONST(Customer)) Customer."No."
            ELSE IF ("Destination Type" = CONST(Vendor)) Vendor."No."
            ELSE IF ("Destination Type" = CONST(Location)) Location.Code;
        }
    }
}
