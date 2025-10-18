table 50136 "FB Header"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // >> NIF
    // Fields Added:
    //   Import Time
    // Fields Modified:
    //   Changed table relation for "Contract No.": removed Location Code and Ship-to Code
    // Code Modified:
    //   Contract No. - OnValidate
    // << NIF

    DrillDownPageID = 50138;
    LookupPageID = 50138;
    fields
    {
        field(10; "No."; Code[20])
        {
            // cleaned
        }
        field(25; "Order Date"; Date)
        {
            // cleaned
        }
        field(30; "Sell-to Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(40; "Ship-To Code"; Code[10])
        {
            // cleaned
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(45; "Location Code"; Code[10])
        {
            // cleaned
            //TODO
            /*  TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false)); */
            //TODO
        }
        field(49; "Import Date"; Date)
        {
            // cleaned
        }
        field(50; "Import File Name"; Code[200])
        {
            // cleaned
        }
        field(51; "Import Data Log No."; Code[20])
        {
            // cleaned
        }
        field(60; "Sales Order No."; Code[20])
        {
            // cleaned
        }
        field(100; "No. Series"; Code[10])
        {
            // cleaned
            TableRelation = "No. Series".Code;
        }
        field(110; Status; Option)
        {
            OptionCaption = 'New,Errors,Processed';
            OptionMembers = New,Errors,Processed;
        }
        field(120; "FB Order Type"; Option)
        {
            OptionCaption = ' ,Consigned,Non-Consigned';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
        field(140; "External Document No."; Code[20])
        {
            // cleaned
        }
        field(170; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            //TODO
            // TableRelation = "Salesperson/Purchaser" WHERE(Sales = CONST(true));
            //TODO

            trigger OnValidate()
            var
            /*   ">>LT_NV": ;
              LTEXT14170180: Label 'Sales Lines exist. All Lines will be changed to the new value.';
              LTEXT14170181: Label 'Operation Canceled'; */
            begin
            end;

        }
        field(175; "Inside Salesperson Code"; Code[10])
        {
            // cleaned
            //TODO
            // TableRelation = "Salesperson/Purchaser" WHERE("Inside Sales" = CONST(true));
            //TODO
        }
        field(180; "Selling Location"; Code[10])
        {
            // cleaned
            //TODO
            /*  TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                             "Rework Location" = CONST(false)); */
            //TODO
        }
        field(190; "Shipping Location"; Code[10])
        {
            // cleaned
            //TODO
            /*    TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                               "Rework Location" = CONST(false)); */
            //TODO
        }
        field(200; "Contract No."; Code[20])
        {
            //<< NIF
            TableRelation = "Price Contract"."No." WHERE("Customer No." = FIELD("Sell-to Customer No."));

            trigger OnValidate()
            begin
                //>> NIF
                IF PriceContract.GET("Contract No.") THEN BEGIN
                    "Ship-To Code" := PriceContract."Ship-to Code";
                    "Location Code" := PriceContract."Location Code";
                    //TODO
                    // "FB Order Type" := PriceContract."FB Order Type";
                    //TODO
                    "Selling Location" := PriceContract."Selling Location Code";
                    "Shipping Location" := PriceContract."Shipping Location Code";
                END;
                //<< NIF
            end;
        }
        field(50000; "Import Time"; Time)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; Status)
        {
        }
        key(Key3; "Sell-to Customer No.", "Ship-To Code")
        {
        }
        key(Key4; "Import Data Log No.", "Location Code", "Sell-to Customer No.", "Ship-To Code", "Contract No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        FBLine.SETRANGE("Document No.", "No.");
        FBLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        FBSetup.GET();
        IF "No." = '' THEN BEGIN
            FBSetup.TESTFIELD("Order Nos.");
            NoSeriesMgt.InitSeries(FBSetup."Order Nos.", xRec."No. Series", WORKDATE(), "No.", "No. Series");
        END;

        Status := Status::New;
        "Order Date" := WORKDATE();
    end;

    var
        FBSetup: Record 50133;
        FBHeader: Record 50136;
        FBLine: Record 50137;
        PriceContract: Record 50110;
        NoSeriesMgt: Codeunit 396;
    //">>NIF": Integer;

    procedure AssistEdit(OldFBHeader: Record 50136): Boolean
    begin
        FBHeader := Rec;
        FBSetup.GET();
        FBSetup.TESTFIELD("Order Nos.");
        IF NoSeriesMgt.SelectSeries(FBSetup."Order Nos.", OldFBHeader."No. Series", FBHeader."No. Series") THEN BEGIN
            FBSetup.GET();
            FBSetup.TESTFIELD("Order Nos.");
            NoSeriesMgt.SetSeries(FBHeader."No.");
            Rec := FBHeader;
            EXIT(TRUE);
        END;
    end;
}
