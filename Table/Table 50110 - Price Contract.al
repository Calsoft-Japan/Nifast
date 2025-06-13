table 50110 "Price Contract"
{
    fields
    {
        field(1; "No."; Code[20])
        {

        }
        field(2; "Customer No."; Code[20])
        {


            // HandleRename(Rec,xRec);
        }
        field(3; "Customer Name"; Text[50])
        {
            Editable = false;
        }
        field(10; Description; Text[80])
        {
            // cleaned
        }
        field(20; "Starting Date"; Date)
        {
            NotBlank = true;

        }
        field(21; "Ending Date"; Date)
        {
            NotBlank = true;

        }
        field(24; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(25; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; "External Document No."; Code[20])
        {
            // cleaned
        }
        field(50; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';

            // ShipToAddr.GET("Customer No.","Ship-to Code");
            // END ELSE
            // Cust.GET("Customer No.");
        }
        field(51; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(52; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(53; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(54; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(55; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';


        }
        field(56; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(57; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to ZIP Code';
            //This property is currently not supported
            //TestTableRelation = false;


        }
        field(58; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to State';
        }
        field(59; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
        }
        field(60; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(70; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
        }
        field(71; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';

        }
        field(72; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
        }
        field(80; "Payment Terms Code"; Code[10])
        {
            // cleaned
        }
        field(85; "Salesperson Code"; Code[10])
        {
            // cleaned
        }
        field(86; "Location Code"; Code[10])
        {

        }
        field(87; "Shipping Location Code"; Code[10])
        {
            // cleaned
        }
        field(89; "Selling Location Code"; Code[10])
        {
            // cleaned
        }
        field(90; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(92; "E-Mail"; Text[80])
        {
            // cleaned
        }
        field(94; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(100; "No. Series"; Code[10])
        {
            // cleaned
        }
        field(110; "Total Value"; Decimal)
        {
            // cleaned
        }
        field(120; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(122; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
        }
        field(124; "UPS Zone"; Code[2])
        {
            Caption = 'UPS Zone';
        }
        field(140; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
        }
        field(141; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(200; Comments; Boolean)
        {
            // cleaned
        }
        field(50000; "Default Repl. Method"; Option)
        {
            Caption = 'Default Repl. Method';
            Description = 'NV';
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(50010; "Def. Method of Fullfillment"; Option)
        {
            Description = 'NV';
            OptionCaption = 'Standard,FillBill';
            OptionMembers = Standard,FillBill;
        }
        field(50108; "Inside Salesperson"; Code[10])
        {
            // cleaned
        }
        field(50117; "Broker/Agent Code"; Code[10])
        {
            Description = 'NF1.00:CIS.NG  10-10-15';
        }
        field(50147; "Delivery Route"; Code[10])
        {
            // cleaned
        }
        field(50148; "Delivery Stop"; Code[10])
        {
            // cleaned
        }
    }
}
