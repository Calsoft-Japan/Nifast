table 50020 "Delivery Schedule Batch"
{
    // //>> NIF
    // Fields Added:
    //   50020 Model Year
    // 
    // Date    Init    Proj   Description
    // 111505  RTT   #10477   new field 50020,change Forecast Quantity from Integer to Decimal
    // //<< NIF

    LookupPageID = 50072;
    fields
    {
        field(1; "No."; Code[20])
        {
            // cleaned
        }
        field(2; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(10; "Release No."; Code[20])
        {
            // cleaned
        }
        field(11; "Document Function"; Option)
        {
            OptionMembers = " ",Replacing,Original;
        }
        field(12; "Expected Delivery Date"; Date)
        {
            // cleaned
        }
        field(13; "Horizon Start Date"; Date)
        {
            // cleaned
        }
        field(14; "Horizon End Date"; Date)
        {
            // cleaned
        }
        field(20; "Material Issuer No."; Code[20])
        {
            // cleaned
        }
        field(21; "Material Issuer Name"; Text[50])
        {
            // cleaned
        }
        field(22; "Material Issuer Name 2"; Text[50])
        {
            // cleaned
        }
        field(23; "Material Issuer Address"; Text[30])
        {
            // cleaned
        }
        field(24; "Material Issuer Address 2"; Text[30])
        {
            // cleaned
        }
        field(25; "Material Issuer City"; Text[30])
        {
            // cleaned
        }
        field(26; "Material Issuer State"; Text[30])
        {
            // cleaned
        }
        field(27; "Material Issuer Postal Code"; Code[20])
        {
            // cleaned
        }
        field(28; "Material Issuer Country Code"; Text[30])
        {
            // cleaned
        }
        field(30; "Supplier No."; Code[20])
        {
            // cleaned
        }
        field(31; "Supplier Name"; Text[50])
        {
            // cleaned
        }
        field(32; "Supplier Name 2"; Text[50])
        {
            // cleaned
        }
        field(33; "Supplier Address"; Text[30])
        {
            // cleaned
        }
        field(34; "Supplier Address 2"; Text[30])
        {
            // cleaned
        }
        field(35; "Supplier City"; Text[30])
        {
            // cleaned
        }
        field(36; "Supplier State"; Text[30])
        {
            // cleaned
        }
        field(37; "Supplier Postal Code"; Code[20])
        {
            // cleaned
        }
        field(38; "Supplier Country Code"; Text[30])
        {
            // cleaned
        }
        field(200; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(1011; "Document Function Code"; Integer)
        {
            trigger OnValidate()
            begin
                CASE "Document Function Code" OF
                    5:
                        "Document Function" := "Document Function"::Replacing;
                    9:
                        "Document Function" := "Document Function"::Original;
                END;
            end;
        }
        field(50000; "EDI Trade Partner"; Code[20])
        {
            // cleaned
        }
        field(50010; "EDI Internal Doc. No."; Code[10])
        {
            // cleaned
        }
        field(50020; "Model Year"; Code[10])
        {
            CalcFormula = Lookup("Delivery Schedule Header"."Model Year" WHERE("Delivery Schedule Batch No." = FIELD("No.")));
            Description = 'Delivery Schedule Batch No.=FIELD(No.)';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No.", "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DeliveryScheduleHdr.SETRANGE("Delivery Schedule Batch No.", "No.");
        DeliveryScheduleHdr.SETRANGE("Customer No.", "Customer No.");
        DeliveryScheduleHdr.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin

        SalesReceivablesSetup.GET();
        IF "No." = '' THEN BEGIN
            SalesReceivablesSetup.TESTFIELD("Delivery Schedule Batch Nos.");
            //NoSeriesMgt.InitSeries(SalesReceivablesSetup."Delivery Schedule Batch Nos.", '', 0D, "No.", "No. Series");
            NoSeriesMgt.AreRelated(SalesReceivablesSetup."Delivery Schedule Batch Nos.", '');
        END;
    end;

    var
        SalesReceivablesSetup: Record 311;
        DeliveryScheduleHdr: Record 50012;
        NoSeriesMgt: Codeunit "No. Series";
}
