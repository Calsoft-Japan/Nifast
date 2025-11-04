table 50015 "Ship Authorization"
{
    LookupPageID = 50069;

    fields
    {
        field(1; "Sell-to Customer No."; Code[20])
        {
            // cleaned
        }
        field(2; "No."; Code[20])
        {
            // cleaned
        }
        field(3; "Sales Order No."; Code[20])
        {
            // cleaned
        }
        field(4; Archive; Boolean)
        {
            // cleaned
        }
        field(5; "Reference No."; Code[35])
        {
            // cleaned
        }
        field(10; "Document Date"; Date)
        {
            // cleaned
        }
        field(11; "Horizon Start Date"; Date)
        {
            // cleaned
        }
        field(12; "Horizon End Date"; Date)
        {
            // cleaned
        }
        field(13; "Planning Schedule Party ID"; Text[35])
        {
            // cleaned
        }
        field(14; "Ship From Party ID"; Text[35])
        {
            // cleaned
        }
        field(15; "Ship To Party ID"; Text[35])
        {
            // cleaned
        }
        field(16; "Supplier Party ID"; Text[35])
        {
            // cleaned
        }
        field(50; "Planning Schedule No."; Code[20])
        {
            // cleaned
        }
        field(100; "EDI Trade Partner"; Code[20])
        {
            // cleaned
        }
        field(101; "EDI Internal Doc. No."; Code[10])
        {
            // cleaned
        }
        field(200; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(50000; "Release Number"; Text[30])
        {
            // cleaned
        }
        field(50001; "Ship To Party Name"; Text[50])
        {
            // cleaned
        }
        field(50002; "Ship From Party Name"; Text[50])
        {
            // cleaned
        }
        field(50003; "Supplier Party Name"; Text[50])
        {
            // cleaned
        }
        field(50004; "Ship Scheduler ID"; Text[35])
        {
            // cleaned
        }
        field(50005; "Ship Scheduler Name"; Text[50])
        {
            // cleaned
        }
        field(50006; "Planning Schedule Party Name"; Text[50])
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "Sell-to Customer No.", "No.")
        {
        }
        key(Key2; "No.", "Sales Order No.", Archive)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ShipAuthorizationLine.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        ShipAuthorizationLine.SETRANGE("Document No.", "No.");
        IF ShipAuthorizationLine.FIND('-') THEN
            ShipAuthorizationLine.DELETEALL();
    end;

    trigger OnInsert()
    begin

        SalesReceivablesSetup.GET();
        IF "No." = '' THEN BEGIN
            SalesReceivablesSetup.TESTFIELD("Shipment Authorization Nos.");
            // NoSeriesMgt.InitSeries(SalesReceivablesSetup."Shipment Authorization Nos.", '', 0D, "No.", "No. Series");
            NoSeriesMgt.AreRelated(SalesReceivablesSetup."Shipment Authorization Nos.", '');
        END;
    end;

    var
        ShipAuthorizationLine: Record 50016;
        SalesReceivablesSetup: Record 311;
        NoSeriesMgt: Codeunit "No. Series";
}
