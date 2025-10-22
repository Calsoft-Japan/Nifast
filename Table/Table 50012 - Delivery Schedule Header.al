table 50012 "Delivery Schedule Header"
{
    LookupPageID = 50074;
    fields
    {
        field(1; "Delivery Schedule Batch No."; Code[20])
        {
            // cleaned
        }
        field(2; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            // cleaned
        }
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Item: Record 27;
            begin
                IF Item.GET("Item No.") THEN
                    Description := Item.Description
                ELSE
                    "Item Not Found" := TRUE;
            end;
        }
        field(11; "Cross-Reference No."; Code[30])
        {
            Caption = 'Cross-Reference No.';

            trigger OnLookup()
            var
            //  ItemCrossReference: Record 5717;
            begin
            end;

            trigger OnValidate()
            var
                ReturnedCrossRef: Record 5777;
                SalesLine: Record 37;
                DistIntegration: Codeunit 5702;
                CustomerNo: Code[20];
            begin
                CustomerNo := "Customer No.";
                ReturnedCrossRef.INIT();
                IF "Cross-Reference No." <> '' THEN BEGIN
                    SalesLine.INIT();
                    SalesLine."Item Reference No." := "Cross-Reference No.";
                    //TODO
                    //DistIntegration.ICRLookupSalesItem(SalesLine, ReturnedCrossRef);
                    VALIDATE("Item No.", ReturnedCrossRef."Item No.");
                END;

                IF ReturnedCrossRef."Reference No." <> '' THEN BEGIN
                    "Cross-Reference Type" := ReturnedCrossRef."Reference Type".AsInteger();
                    "Cross-Reference Type No." := ReturnedCrossRef."Reference Type No.";
                    "Cross-Reference No." := ReturnedCrossRef."Reference No.";

                    IF ReturnedCrossRef.Description <> '' THEN
                        Description := ReturnedCrossRef.Description

                END ELSE BEGIN
                    DelvieryScheduleHdr."Cross-Reference No. Not Found" := TRUE;
                    DelvieryScheduleHdr."Item Not Found" := TRUE;
                END;
            end;
        }
        field(12; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(13; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(14; "Location Code"; Code[20])
        {
            // cleaned
        }
        field(15; "Model Year"; Code[10])
        {
            // cleaned
        }
        field(16; "Release Number"; Code[10])
        {
            // cleaned
        }
        field(17; "Receiving Dock Code"; Code[10])
        {
            // cleaned
        }
        field(18; "Stockman Code"; Code[10])
        {
            // cleaned
        }
        field(19; "Order Reference No."; Code[20])
        {
            // cleaned
        }
        field(20; "Quantity CYTD"; Integer)
        {
            // cleaned
        }
        field(21; "Unit of Measure CYTD"; Text[10])
        {
            // cleaned
        }
        field(22; "Start Date CYTD"; Date)
        {
            // cleaned
        }
        field(23; "End Date CYTD"; Date)
        {
            // cleaned
        }
        field(24; "Quantity Shipped CYTD"; Integer)
        {
            // cleaned
        }
        field(25; "Unit of Measure Shipped CYTD"; Text[10])
        {
            // cleaned
        }
        field(26; "Start Date Shipped CYTD"; Date)
        {
            // cleaned
        }
        field(27; "End Date Shipped CYTD"; Date)
        {
            // cleaned
        }
        field(28; Description; Text[50])
        {
            // cleaned
        }
        field(200; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(5000; "EDI Item Cross Ref."; Code[20])
        {
            // cleaned
        }
        field(5001; "EDI Unit of Measure"; Code[2])
        {
            // cleaned
        }
        field(5002; "Item Not Found"; Boolean)
        {
            Editable = false;
        }
        field(5003; "Cross-Reference No. Not Found"; Boolean)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Delivery Schedule Batch No.", "Customer No.", "No.")
        {
        }
        key(Key2; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        DelvieryScheduleLine.SETRANGE("Delivery Schedule Batch No.", "Delivery Schedule Batch No.");
        DelvieryScheduleLine.SETRANGE("Customer No.", "Customer No.");
        DelvieryScheduleLine.SETRANGE("Document No.", "No.");
        DelvieryScheduleLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        SalesReceivablesSetup.GET();
        IF "No." = '' THEN BEGIN
            SalesReceivablesSetup.TESTFIELD("Delivery Schedule Nos.");
            NoSeriesMgt.AreRelated(SalesReceivablesSetup."Delivery Schedule Nos.", '');
        END;
    end;

    var
        SalesReceivablesSetup: Record 311;
        DelvieryScheduleHdr: Record 50012;
        DelvieryScheduleLine: Record 50013;
        NoSeriesMgt: Codeunit "No. Series";

}
