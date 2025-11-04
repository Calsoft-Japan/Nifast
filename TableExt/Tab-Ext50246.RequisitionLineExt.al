tableextension 50246 "Requisition Line _Ext" extends "Requisition Line"
{
    fields
    {
        field(70000; "Priority Code"; code[10])
        {
            Caption = '';
            Description = 'NF1.00:CIS.CM 09-29-15';
            DataClassification = ToBeClassified;
        }
        field(70001; "Ship-to PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Combine Lines"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            //ReserveReqLine: Codeunit reser
            begin
                IF "Combine Lines" THEN BEGIN
                    "Sell-to Customer No." := '';
                    "Ship-to Code" := '';
                END ELSE BEGIN
                    IF SalesLine.GET(SalesLine."Document Type"::Order, "Sales Order No.", "Sales Order Line No.") THEN BEGIN
                        "Sell-to Customer No." := SalesLine."Sell-to Customer No.";
                        "Ship-to Code" := SalesLine."Ship-to Code";
                    END;
                END;
                // ReserveReqLine.VerifyChange(Rec, xRec);
            END;

        }
        field(70003; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70005; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70006; "FB Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV-FB';
        }
        field(70007; "FB Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "FB Tag No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "FB Customer Bin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}
