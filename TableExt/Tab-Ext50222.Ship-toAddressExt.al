tableextension 50222 "Ship-to Address Ext" extends "Ship-to Address"
{
    fields
    {
        modify("Shipping Agent Code")
        {
            trigger OnBeforeValidate()
            begin
                //TODO
                /*   // >> Shipping
                  SalesSetup.GET;
                  IF ("Shipping Agent Code" <> xRec."Shipping Agent Code") AND SalesSetup."Enable Shipping" THEN
                      IF "Shipping Agent Code" = '' THEN
                          "E-Ship Agent Service" := ''
                      ELSE BEGIN
                          ShippingAgent.GET("Shipping Agent Code");
                          VALIDATE(
                            "E-Ship Agent Service",
                            EShipAgentService.DefaultShipAgentService(ShippingAgent, "Country/Region Code"));

                          IF CurrFieldNo = FIELDNO("Shipping Agent Code") THEN
                              EShipAgentService.CheckNameAddressShipToAddress(ShippingAgent, Rec);
                      END;
                  // << Shipping */
                //TODO
            end;
        }
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
        modify("E-Mail")
        {
            trigger OnBeforeValidate()
            begin
                //TODO
                /*  // >> Shipping
                 IF "E-Mail" <> '' THEN BEGIN
                     SalesSetup.GET();

                     IF SalesSetup."Enable E-Mail" THEN
                         EMailListEntry.InsertNewEMailListEntry(
                           Contact, "E-Mail", DATABASE::"Ship-to Address", 0, "Customer No.", Code, TRUE);
                 END;
                 // << Shipping */
                //TODO
            end;
        }
        field(50000; "Freight Code"; Code[10])
        {
            // cleaned
            TableRelation = "Freight Code";
        }
        //TODO
        field(14017650; "Broker/Agent Code"; Code[10])
        {
            Description = 'NF1.00:CIS.NG  10-10-15';
        }
        //TODO
    }
    var
    //TODO
    /*   ShippingAgent: Record 291;
      EShipAgentService: Record 14000708; 
    SalesSetup: Record 311;
    EMailListEntry: Record 14000908;
    ShippingAccount: Record 14000714;*/
    //TODO

    trigger OnAfterInsert()
    var
    // Cust: Record Customer;
    begin
        //TODO
        /*  Cust.GET("Customer No.");
         // >> Shipping
         "Shipping Agent Code" := Cust."Shipping Agent Code";
         "E-Ship Agent Service" := Cust."E-Ship Agent Service";
         "Free Freight" := Cust."Free Freight";
         "Residential Delivery" := Cust."Residential Delivery";
         "Blind Shipment" := Cust."Blind Shipment";
         "Double Blind Ship-from Cust No" := Cust."Double Blind Ship-from Cust No";
         "Double Blind Shipment" := Cust."Double Blind Shipment";
         "No Free Freight Lines on Order" := Cust."No Free Freight Lines on Order";
         "Packing Rule Code" := Cust."Packing Rule Code";
         "Shipping Payment Type" := Cust."Shipping Payment Type";
         "Shipping Insurance" := Cust."Shipping Insurance";
         // << Shipping */
        //TODO
    end;

    trigger OnDelete()
    begin
        //TODO
        /*    // >> Shipping
           EMailListEntry.RESET;
           EMailListEntry.SETRANGE("Table ID", DATABASE::"Ship-to Address");
           EMailListEntry.SETRANGE(Type, 0);
           EMailListEntry.SETRANGE(Code, "Customer No.");
           EMailListEntry.SETRANGE("Code 2", Code);
           EMailListEntry.DELETEALL;

           ShippingAccount.RESET;
           ShippingAccount.SETRANGE("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
           ShippingAccount.SETRANGE("Ship-to No.", "Customer No.");
           ShippingAccount.SETRANGE("Ship-to Code", Code);
           ShippingAccount.DELETEALL;
           // << Shipping */
        //TODO
    end;
}
