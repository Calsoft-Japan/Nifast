tableextension 50900 "Assembly Header Ext" extends "Assembly Header"
{
    fields
    {
        field(50000; "Purchase Order No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));

            trigger OnValidate();
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                //>>NF1.00:CIS.NG  10/06/15
                TestStatusOpen();
                if "Purchase Order No." <> '' then begin
                    PurchaseHeader.Get("Document Type"::Order, "Purchase Order No.");
                    PurchaseHeader."Assembly Order No." := "No.";
                    PurchaseHeader.Modify();
                end;
                //<<NF1.00:CIS.NG  10/06/15
            end;
        }
    }
}
