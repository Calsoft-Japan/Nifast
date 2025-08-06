tableextension 50222 "Ship-to Address Ext" extends "Ship-to Address"
{
    fields
    {
        modify("Country/Region Code")
        {
            trigger OnBeforeValidate()
            begin
                // >> Shipping
                IF "Country/Region Code" <> xRec."Country/Region Code" THEN
                    IF "Shipping Agent Code" <> '' THEN BEGIN
                        xRec."Shipping Agent Code" := '';
                        VALIDATE("Shipping Agent Code");
                    END;
                // << Shipping
            end;
        }
        field(50000; "Freight Code"; Code[10])
        {
            // cleaned
            TableRelation = "Freight Code";
        }
    }
    var
        ShippingAgent: Record 291;
        SalesSetup: Record 311;

    trigger OnAfterInsert()
    var
        Cust: Record Customer;
    begin
        Cust.GET("Customer No.");
        // >> Shipping
        "Shipping Agent Code" := Cust."Shipping Agent Code";
        // << Shipping
    end;
}
