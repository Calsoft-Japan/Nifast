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
