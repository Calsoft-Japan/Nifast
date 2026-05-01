
tableextension 70017 "LAXManifestHeader_NF" extends "LAX Manifest Header"
{
    fields
    {
        field(50000; "Total Cartons"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = Sum("LAX Manifest Line".Cartons WHERE("Manifest No." = FIELD("No."),
                                                             Type = FILTER(< Summary)));
            DecimalPlaces = 0 : 0;
            Editable = false;

        }
        field(50006; "External Document No."; Code[20])
        {
        }
        field(50020; "Destination ZIP Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(60013; "Destination No."; Code[20])
        {
            TableRelation = IF ("Destination Type" = CONST(Customer)) Customer
            ELSE IF ("Destination Type" = CONST(Vendor)) Vendor
            ELSE IF ("Destination Type" = CONST(Bank)) "Bank Account"
            //ELSE IF ("Destination Type" = CONST(Prospect)) Table5000
            ELSE IF ("Destination Type" = CONST(Resource)) Resource
            ELSE IF ("Destination Type" = CONST(Employee)) Employee
            ELSE IF ("Destination Type" = CONST(Location)) Location;

            trigger OnValidate()
            begin
                IF "Destination No." = '' THEN BEGIN
                    "Destination Code" := '';
                    ClearShipToAddess;
                END ELSE BEGIN
                    CASE "Destination Type" OF
                        "Destination Type"::Customer:
                            BEGIN
                                IF ("Destination Code" <> '') AND ShipToAddress.GET("Destination No.", "Destination Code") THEN BEGIN
                                    TransferFromShipToAddress(ShipToAddress);
                                END ELSE BEGIN
                                    "Destination Code" := '';
                                    Customer.GET("Destination No.");
                                    TransferFromCustomer(Customer);
                                END;
                            END;
                        "Destination Type"::Vendor:
                            BEGIN
                                IF ("Destination Code" <> '') AND OrderAddress.GET("Destination No.", "Destination Code") THEN BEGIN
                                    TransferFromOrderAddress(OrderAddress);
                                END ELSE BEGIN
                                    "Destination Code" := '';
                                    Vendor.GET("Destination No.");
                                    TransferFromVendor(Vendor);
                                END;
                            END;
                        "Destination Type"::Bank:
                            BEGIN
                                BankAccount.GET("Destination No.");
                                TransferFromBankAccount(BankAccount);
                            END;
                        "Destination Type"::Prospect:
                            BEGIN
                                Prospect.GET("Destination No.");
                                TransferFromProspect(Prospect);
                            END;
                        "Destination Type"::Resource:
                            BEGIN
                                Resource.GET("Destination No.");
                                TransferFromResource(Resource);
                            END;
                        "Destination Type"::Employee:
                            BEGIN
                                Employee.GET("Destination No.");
                                TransferFromEmployee(Employee);
                            END;
                        // >> ISTShipping
                        "Destination Type"::Location:
                            BEGIN
                                "Destination Code" := '';
                                Location.GET("Destination No.");
                                TransferFromLocation(Location);
                            END;
                    // <<
                    END;
                END;
            end;
        }
        field(60014; "Destination Code"; Code[10])
        {
            TableRelation = IF ("Destination Type" = CONST(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Destination No."))
            ELSE IF ("Destination Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Destination No."));

            trigger OnValidate()
            begin
                TESTFIELD("Destination No.");

                IF ("Destination Type" <> "Destination Type"::Customer) AND
                   ("Destination Type" <> "Destination Type"::Vendor) AND
                   ("Destination Type" <> "Destination Type"::Contact) AND
                   ("Destination Code" <> '')
                THEN
                    ERROR('%1 must be Customer or Vendor.', FIELDNAME("Destination Type"));

                IF "Destination Code" <> '' THEN BEGIN
                    CASE "Destination Type" OF
                        "Destination Type"::Customer:
                            BEGIN
                                ShipToAddress.GET("Destination No.", "Destination Code");
                                TransferFromShipToAddress(ShipToAddress);
                            END;
                        "Destination Type"::Vendor:
                            BEGIN
                                OrderAddress.GET("Destination No.", "Destination Code");
                                TransferFromOrderAddress(OrderAddress);
                            END;
                    END;
                END ELSE
                    VALIDATE("Destination No.");
            end;
        }
        field(60020; "Destination Type"; Option)
        {
            OptionMembers = Customer,Vendor,Bank,Prospect,Resource,Employee,Contact,Location;

            trigger OnValidate()
            begin
                IF "Destination Type" <> xRec."Destination Type" THEN BEGIN
                    VALIDATE("Destination No.", '');
                END;
            end;
        }
        field(60031; "Destination Name"; Text[30])
        {
        }
        field(60032; "Destination Name 2"; Text[30])
        {
        }
        field(60033; "Destination Address"; Text[30])
        {
        }
        field(60034; "Destination Address 2"; Text[30])
        {
        }
        field(60035; "Destination City"; Text[30])
        {
        }
        field(60036; "Destination Contact"; Text[30])
        {
        }
        field(60038; "Destination State"; Text[30])
        {
        }
        field(60039; "Destination Country Code"; Code[10])
        {
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                IF "Destination Country Code" <> xRec."Destination Country Code" THEN
                    IF "Shipping Agent Code" <> '' THEN BEGIN
                        xRec."Shipping Agent Code" := '';
                        VALIDATE("Shipping Agent Code");
                    END;
            end;
        }
        field(60040; "Destination Phone No."; Text[30])
        {
        }
        field(60041; "Destination Fax No."; Text[30])
        {
        }

    }
    PROCEDURE TransferFromCustomer(CurrentCustomer: Record 18);
    VAR
        PaymentTerms: Record 3;
    BEGIN

        "Destination Name" := CurrentCustomer.Name;
        "Destination Name 2" := CurrentCustomer."Name 2";
        "Destination Address" := CurrentCustomer.Address;
        "Destination Address 2" := CurrentCustomer."Address 2";
        "Destination City" := CurrentCustomer.City;
        "Destination Contact" := CurrentCustomer.Contact;
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentCustomer."Post Code");
        "Destination State" := CurrentCustomer.County;
        "Destination Country Code" := CurrentCustomer."Country/Region Code";
        "Destination Phone No." := CurrentCustomer."Phone No.";
        "Destination Fax No." := CurrentCustomer."Fax No.";
    END;

    PROCEDURE TransferFromVendor(CurrentVendor: Record 23);
    BEGIN

        "Destination Name" := CurrentVendor.Name;
        "Destination Name 2" := CurrentVendor."Name 2";
        "Destination Address" := CurrentVendor.Address;
        "Destination Address 2" := CurrentVendor."Address 2";
        "Destination City" := CurrentVendor.City;
        "Destination Contact" := CurrentVendor.Contact;
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentVendor."Post Code");
        "Destination State" := CurrentVendor.County;
        "Destination Country Code" := CurrentVendor."Country/Region Code";
        "Destination Phone No." := CurrentVendor."Phone No.";
        "Destination Fax No." := CurrentVendor."Fax No.";
    END;

    PROCEDURE TransferFromBankAccount(CurrentBankAccount: Record 270);
    BEGIN

        "Destination Name" := CurrentBankAccount.Name;
        "Destination Name 2" := CurrentBankAccount."Name 2";
        "Destination Address" := CurrentBankAccount.Address;
        "Destination Address 2" := CurrentBankAccount."Address 2";
        "Destination City" := CurrentBankAccount.City;
        "Destination Contact" := CurrentBankAccount.Contact;
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentBankAccount."Post Code");
        "Destination State" := CurrentBankAccount.County;
        "Destination Country Code" := CurrentBankAccount."Country/Region Code";
        "Destination Phone No." := CurrentBankAccount."Phone No.";
        "Destination Fax No." := CurrentBankAccount."Fax No.";
    END;

    PROCEDURE TransferFromProspect(CurrentProspect: Record 5050);
    BEGIN

        "Destination Name" := CurrentProspect.Name;
        "Destination Name 2" := CurrentProspect."Name 2";
        "Destination Address" := CurrentProspect.Address;
        "Destination Address 2" := CurrentProspect."Address 2";
        "Destination City" := CurrentProspect.City;
        "Destination Contact" := '';
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentProspect."Post Code");
        "Destination State" := CurrentProspect.County;
        "Destination Country Code" := CurrentProspect."Country/Region Code";
        "Destination Phone No." := CurrentProspect."Phone No.";
        "Destination Fax No." := CurrentProspect."Fax No.";
    END;

    PROCEDURE TransferFromResource(CurrentResource: Record 156);
    BEGIN

        "Destination Name" := CurrentResource.Name;
        "Destination Name 2" := CurrentResource."Name 2";
        "Destination Address" := CurrentResource.Address;
        "Destination Address 2" := CurrentResource."Address 2";
        "Destination City" := CurrentResource.City;
        "Destination Contact" := '';
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentResource."Post Code");
        "Destination State" := CurrentResource.County;
        "Destination Country Code" := '';
        "Destination Phone No." := '';
        "Destination Fax No." := '';
    END;

    PROCEDURE TransferFromEmployee(CurrentEmployee: Record 5200);
    BEGIN
        IF CurrentEmployee."Middle Name" <> '' THEN
            "Destination Name" :=
              CurrentEmployee."First Name" + ' ' + CurrentEmployee."Middle Name" + ' ' +
              CurrentEmployee."Last Name"
        ELSE
            "Destination Name" :=
              CurrentEmployee."First Name" + ' ' + CurrentEmployee."Last Name";
        "Destination Name 2" := '';
        "Destination Address" := CurrentEmployee.Address;
        "Destination Address 2" := CurrentEmployee."Address 2";
        "Destination City" := CurrentEmployee.City;
        "Destination Contact" := '';
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentEmployee."Post Code");
        "Destination State" := CurrentEmployee.County;
        "Destination Country Code" := CurrentEmployee."Country/Region Code";
        "Destination Phone No." := CurrentEmployee."Phone No.";
        "Destination Fax No." := CurrentEmployee."Fax No.";
    END;

    PROCEDURE TransferFromShipToAddress(CurrentShipToAddress: Record 222);
    VAR
        Customer: Record 18;
    BEGIN

        "Destination Name" := CurrentShipToAddress.Name;
        "Destination Name 2" := CurrentShipToAddress."Name 2";
        "Destination Address" := CurrentShipToAddress.Address;
        "Destination Address 2" := CurrentShipToAddress."Address 2";
        "Destination City" := CurrentShipToAddress.City;
        "Destination Contact" := CurrentShipToAddress.Contact;
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentShipToAddress."Post Code");
        "Destination State" := CurrentShipToAddress.County;
        "Destination Country Code" := CurrentShipToAddress."Country/Region Code";
        "Destination Phone No." := CurrentShipToAddress."Phone No.";
        "Destination Fax No." := CurrentShipToAddress."Fax No.";
    END;

    PROCEDURE TransferFromOrderAddress(CurrentOrderAddress: Record 224);
    VAR
        Customer: Record 18;
    BEGIN

        "Destination Name" := CurrentOrderAddress.Name;
        "Destination Name 2" := CurrentOrderAddress."Name 2";
        "Destination Address" := CurrentOrderAddress.Address;
        "Destination Address 2" := CurrentOrderAddress."Address 2";
        "Destination City" := CurrentOrderAddress.City;
        "Destination Contact" := CurrentOrderAddress.Contact;
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentOrderAddress."Post Code");
        "Destination State" := CurrentOrderAddress.County;
        "Destination Country Code" := CurrentOrderAddress."Country/Region Code";
        "Destination Phone No." := CurrentOrderAddress."Phone No.";
        "Destination Fax No." := CurrentOrderAddress."Fax No.";
    END;

    PROCEDURE TransferFromLocation(CurrentLocation: Record 14);
    BEGIN

        "Destination Name" := CurrentLocation.Name;
        "Destination Name 2" := CurrentLocation."Name 2";
        "Destination Address" := CurrentLocation.Address;
        "Destination Address 2" := CurrentLocation."Address 2";
        "Destination City" := CurrentLocation.City;
        "Destination Contact" := CurrentLocation.Contact;
        "Destination ZIP Code" := ShippingSetup.AdjustZIPCode(CurrentLocation."Post Code");
        "Destination State" := CurrentLocation.County;
        "Destination Country Code" := CurrentLocation."Country/Region Code";
        "Destination Phone No." := CurrentLocation."Phone No.";
        "Destination Fax No." := CurrentLocation."Fax No.";
    END;

    PROCEDURE ClearShipToAddess();
    VAR
        Customer: Record 18;
    BEGIN
        "Destination Name" := '';
        "Destination Name 2" := '';
        "Destination Address" := '';
        "Destination Address 2" := '';
        "Destination City" := '';
        "Destination Contact" := '';
        "Destination ZIP Code" := '';
        "Destination State" := '';
        "Destination Country Code" := '';
        "Destination Phone No." := '';
        "Destination Fax No." := '';
    END;

    var
        Customer: Record 18;
        ShipToAddress: Record 222;
        Vendor: Record 23;
        OrderAddress: Record 224;
        BankAccount: Record 270;
        Prospect: Record 5050;
        Resource: Record 156;
        Employee: Record 5200;
        Location: Record 14;
        ShippingSetup: Record 14000707;

}
