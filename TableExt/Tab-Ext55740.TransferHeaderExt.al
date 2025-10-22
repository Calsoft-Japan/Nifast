tableextension 55740 "Transfer Header Ext" extends "Transfer Header"
{
    fields
    {
        field(50000; "Vessel Name"; Code[50])
        {
            Editable = false;
            TableRelation = "Shipping Vessels";
        }
        field(50009; "Posted Assembly Order No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
            TableRelation = "Posted Assembly Header"."No." where("Transfer Order No." = filter(''));
            trigger OnValidate();
            var
                PostedAssemblyHeader: Record "Posted Assembly Header";
                TransLines: Record "Transfer Line";
            begin
                //>> NF1.00:CIS.NG  10/26/15
                TestStatusOpen();

                if (xRec."Posted Assembly Order No." <> '') then begin
                    TransLines.RESET();
                    TransLines.SETRANGE("Document No.", "No.");
                    if TransLines.FINDSET() then
                        repeat
                            TransLines.TESTFIELD("Quantity Shipped", 0);
                        until TransLines.NEXT() = 0;

                end;

                if "Posted Assembly Order No." <> '' then begin
                    PostedAssemblyHeader.GET("Posted Assembly Order No.");
                    PostedAssemblyHeader."Transfer Order No." := "No.";
                    PostedAssemblyHeader.MODIFY();
                end;

                if xRec."Posted Assembly Order No." <> '' then begin
                    PostedAssemblyHeader.GET(xRec."Posted Assembly Order No.");
                    PostedAssemblyHeader."Transfer Order No." := '';
                    PostedAssemblyHeader.MODIFY();
                end;
                //<< NF1.00:CIS.NG  10/26/15
            end;
        }
        field(50010; "Sail-On Date"; Date)
        {
            Editable = false;
        }
        field(14017619; "Total Net Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Line"."Line Net Weight" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(14017620; "Total Gross Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transfer Line"."Line Gross Weight" WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(14017621; "Reason Code"; code[10])
        {
            TableRelation = "Reason Code";
        }
        field(14017630; "Inbound Bill of Lading"; code[20])
        {
        }
        field(14017631; "Carrier Vendor No."; code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(14017632; "Carrier Trailer ID"; code[20])
        {
        }
        field(14017660; "No;Outstanding Gross Weight"; Decimal)
        {
            //  FieldClass = FlowField;
            //CalcFormula = Sum("Transfer Line".Field2837012 WHERE("Document No." = FIELD("No.")));//TODO
            Editable = false;
        }
        field(14017661; "No;Outstanding Net Weight"; Decimal)
        {
            //FieldClass = FlowField;
            //CalcFormula = Sum("Transfer Line".Field2837012 WHERE("Document No." = FIELD("No.")));//TODO
            Editable = false;
        }
        field(14017790; "Container No."; code[20])
        {
            Editable = false;
        }
        field(14017930; "Rework No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017931; "Rework Line No."; Integer)
        {
        }
        field(37015330; "FB Order No."; code[20])
        {
            Description = 'NV-FB';
        }
        field(37015590; "In-Transit Lines"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Transfer Line" WHERE("Document No." = FIELD("No."), "Qty. in Transit" = FILTER(<> 0)));
            Editable = false;
        }
        field(37015680; "Delivery Route"; code[10])
        {
        }
        field(37015681; "Delivery Stop"; code[10])
        {
        }
    }
    trigger OnAfterDelete()
    var
        PostedAssemblyHeader: Record "Posted Assembly Header";
    begin
        //>> NF1.00:CIS.NG  10/30/15
        IF "Posted Assembly Order No." <> '' THEN BEGIN
            PostedAssemblyHeader.GET("Posted Assembly Order No.");
            PostedAssemblyHeader."Transfer Order No." := "No.";
            PostedAssemblyHeader.MODIFY();
        END;
        //<< NF1.00:CIS.NG  10/30/15
    end;
}
