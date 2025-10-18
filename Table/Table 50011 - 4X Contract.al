table 50011 "4X Contract"
{
    // NF1.00:CIS.NG  09-04-15 Merged during upgrade (Added function "CrossRefName" require for page 50008)
    // >> IST
    // Date   Init SCR    Description
    // 041105 DPC  #9806  New Table to hold "Master Quotes and Orders"
    // 051805 DPC  #9806  Fields added: Division No., Total, Requested By, Authorized By, Foreign Exchange Requested
    // 053005 DPC  #9806  Fields added: Window From, Window To
    // << IST

    LookupPageID = 50033;
    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    GLSetup.GET();
                    NoSeriesMgt.TestManual(GLSetup."Foreign Exchange Contract Nos.");
                    "No. Series" := '';
                END;
                "Date Created" := WORKDATE();
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(3; "Contract Note No."; Code[20])
        {

            //<< NIF 07-22-05 RTT
            trigger OnValidate()
            var
                "4xContract": Record 50011;
            begin
                //>>NIF 07-22-05 RTT
                IF ("Contract Note No." <> '') THEN BEGIN
                    "4xContract".SETFILTER("No.", '<>%1', "No.");
                    "4xContract".SETRANGE("Contract Note No.", "Contract Note No.");
                    IF "4xContract".FIND('-') THEN
                        ERROR('%1 %2 already exists on %3 %4.',
                            FIELDNAME("Contract Note No."), "Contract Note No.", "4xContract".TABLENAME, "4xContract"."No.");
                END;
                //<< NIF 07-22-05 RTT
            end;
        }
        field(4; Closed; Boolean)
        {
            // cleaned
        }
        field(5; "Date Created"; Date)
        {
            // cleaned
        }
        field(6; "Division Code"; Code[10])
        {
            // cleaned
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; Total; Decimal)
        {
            // cleaned
            CalcFormula = Sum("4X Purchase Header"."Ext. Cost" WHERE("Contract Note No." = FIELD("Contract Note No.")));
            FieldClass = FlowField;
        }
        field(8; "Requested By"; Code[10])
        {
            // cleaned
        }
        field(9; "Authorized By"; Code[10])
        {
            // MESSAGE('Purchase Order Lines Updated with Contract Note No. %1', "Contract Note No.");

            trigger OnValidate()
            var
                LTEXT50000: Label 'You do not have permissions to Approve Contract Notes';
            begin
                IF UserSetup.GET(USERID) THEN
                    IF NOT UserSetup."Approve Contract Notes" THEN
                        ERROR(LTEXT50000);

                "4X PurchaseHeader".SETRANGE("Contract Note No.", "Contract Note No.");
                IF "4X PurchaseHeader".FIND('-') THEN BEGIN
                    REPEAT
                        //IF PurchaseHeader.GET("4X PurchaseHeader"."Document Type", "4X PurchaseHeader"."Document No.") THEN BEGIN
                        //  PurchaseHeader.VALIDATE("Contract Note No.", "4X PurchaseHeader"."Contract Note No.");
                        //  PurchaseHeader.MODIFY;
                        IF PurchLine.GET("4X PurchaseHeader"."Document Type", "4X PurchaseHeader"."Document No.",
                             "4X PurchaseHeader"."Document Line No.") THEN BEGIN
                            PurchLine.VALIDATE("Contract Note No.", "No.");
                            PurchLine.MODIFY();
                        END;
                    UNTIL "4X PurchaseHeader".NEXT() = 0;
                    MESSAGE('Purchase Order Lines Updated with Contract Note No. %1', "Contract Note No.");
                END;
            end;

        }
        field(10; "Foreign Exchange Requested"; Date)
        {
            // cleaned
        }
        field(11; "Window From"; Date)
        {
            // cleaned
        }
        field(12; "Window To"; Date)
        {
            // cleaned
        }
        field(13; Posted; Boolean)
        {
            // cleaned
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Contract Note No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        "4X PurchaseHeader".SETRANGE("Contract Note No.", "No.");
        IF "4X PurchaseHeader".FIND('-') THEN
            PurchaseHeader.DELETEALL();
    end;

    trigger OnInsert()
    begin
        GLSetup.GET();
        IF "No." = '' THEN
            NoSeriesMgt.AreRelated(GLSetup."Foreign Exchange Contract Nos.", xRec."No. Series");
        "Date Created" := WORKDATE();
    end;

    var
        // PurchSetup: Record 312;
        GLSetup: Record 98;
        UserSetup: Record 91;
        "4X PurchaseHeader": Record 50008;
        PurchaseHeader: Record 38;
        PurchLine: Record 39;
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(OldMaster: Record 50011): Boolean
    begin
        GLSetup.GET();
        IF NoSeriesMgt.LookupRelatedNoSeries(GLSetup."Foreign Exchange Contract Nos.", OldMaster."No. Series", "No. Series") THEN BEGIN
            GLSetup.GET();
            NoSeriesMgt.GetLastNoUsed("No.");
            EXIT(TRUE);
        END;
    end;
}
