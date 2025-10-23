tableextension 50246 "Requisition Line _Ext" extends "Requisition Line"
{
    fields
    {
        field(14017610; "Priority Code"; code[10])
        {
            Caption = '';
            Description = 'NF1.00:CIS.CM 09-29-15';
            DataClassification = ToBeClassified;
        }
        field(14017640; "Ship-to PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017730; "Combine Lines"; Boolean)
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
        field(14017760; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14017761; "Prod. Kit Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14017762; "Prod. Kit Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37015330; "FB Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV-FB';
        }
        field(37015331; "FB Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37015332; "FB Tag No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37015333; "FB Customer Bin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}
