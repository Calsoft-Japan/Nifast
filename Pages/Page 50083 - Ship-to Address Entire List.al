page 50083 "Ship-to Address Entire List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Ship-to Address";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Caption = 'Customer No.';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Code';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    Caption = 'Name';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.';
                    Caption = 'Name 2';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                    Caption = 'Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                    Caption = 'Address 2';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                    Caption = 'City';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.';
                    Caption = 'Contact';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    Caption = 'Phone No.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.';
                    Caption = 'Telex No.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                    Caption = 'Shipment Method Code';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                    Caption = 'Shipping Agent Code';
                }
                field("Place of Export"; Rec."Place of Export")
                {
                    ToolTip = 'Specifies the value of the Place of Export field.';
                    Caption = 'Place of Export';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                    Caption = 'Country/Region Code';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                    Caption = 'Last Date Modified';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.';
                    Caption = 'Fax No.';
                }
                field("Telex Answer Back"; Rec."Telex Answer Back")
                {
                    ToolTip = 'Specifies the value of the Telex Answer Back field.';
                    Caption = 'Telex Answer Back';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                    Caption = 'Post Code';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.';
                    Caption = 'County';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    Caption = 'Email';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies the value of the Home Page field.';
                    Caption = 'Home Page';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the value of the Tax Area Code field.';
                    Caption = 'Tax Area Code';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.';
                    Caption = 'Tax Liable';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                    Caption = 'Shipping Agent Service Code';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ToolTip = 'Specifies the value of the Service Zone Code field.';
                    Caption = 'Service Zone Code';
                }
                field("UPS Zone"; Rec."UPS Zone")
                {
                    ToolTip = 'Specifies the value of the UPS Zone field.';
                    Caption = 'UPS Zone';
                }
                field("Freight Code"; Rec."Freight Code")
                {
                    ToolTip = 'Specifies the value of the Freight Code field.';
                    Caption = 'Freight Code';
                }
                field("Effective Date"; Rec."lax edi Effective Date")
                {
                    ToolTip = 'Specifies the value of the Effective Date field.';
                    Caption = 'Effective Date';
                }
                field("Open Date"; Rec."lax edi Open Date")
                {
                    ToolTip = 'Specifies the value of the Open Date field.';
                    Caption = 'Open Date';
                }
                field("Close Date"; Rec."lax edi Close Date")
                {
                    ToolTip = 'Specifies the value of the Close Date field.';
                    Caption = 'Close Date';
                }
                field("Change Date"; Rec."lax edi Change Date")
                {
                    ToolTip = 'Specifies the value of the Change Date field.';
                    Caption = 'Change Date';
                }
                field("EDI Internal Doc. No."; Rec."LAX EDI Internal Doc. No.")
                {
                    ToolTip = 'Specifies the value of the EDI Internal Doc. No. field.';
                    Caption = 'EDI Internal Doc. No.';
                }
                field("Dist. Center Ext. Code"; Rec."LAX EDI Dist. Center Ext. Code")
                {
                    ToolTip = 'Specifies the value of the Dist. Center Ext. Code field.';
                    Caption = 'Dist. Center Ext. Code';
                }
                field("E-Ship Agent Service"; Rec."LAX E-Ship Agent Service")
                {
                    ToolTip = 'Specifies the value of the E-Ship Agent Service field.';
                    Caption = 'E-Ship Agent Service';
                }
                field("Free Freight"; Rec."LAX Free Freight")
                {
                    ToolTip = 'Specifies the value of the Free Freight field.';
                    Caption = 'Free Freight';
                }
                field("Residential Delivery"; Rec."lax Residential Delivery")
                {
                    ToolTip = 'Specifies the value of the Residential Delivery field.';
                    Caption = 'Residential Delivery';
                }
                field("Blind Shipment"; Rec."lax Blind Shipment")
                {
                    ToolTip = 'Specifies the value of the Blind Shipment field.';
                    Caption = 'Blind Shipment';
                }
                field("Double Blind Ship-from Cust No"; Rec."LAX Dbl Blind Ship-from CustNo")
                {
                    ToolTip = 'Specifies the value of the Double Blind Ship-from Cust No field.';
                    Caption = 'Double Blind Ship-from Cust No';
                }
                field("Double Blind Shipment"; Rec."lax Double Blind Shipment")
                {
                    ToolTip = 'Specifies the value of the Double Blind Shipment field.';
                    Caption = 'Double Blind Shipment';
                }
                field("No Free Freight Lines on Order"; Rec."LAX No Free Frght Lines on Ord")
                {
                    ToolTip = 'Specifies the value of the No Free Freight Lines on Order field.';
                    Caption = 'No Free Freight Lines on Order';
                }
                field("Shipping Payment Type"; Rec."lax Shipping Payment Type")
                {
                    ToolTip = 'Specifies the value of the Shipping Payment Type field.';
                    Caption = 'Shipping Payment Type';
                }
                field("Shipping Insurance"; Rec."lax Shipping Insurance")
                {
                    ToolTip = 'Specifies the value of the Shipping Insurance field.';
                    Caption = 'Shipping Insurance';
                }
                field("External No."; Rec."lax External No.")
                {
                    ToolTip = 'Specifies the value of the External No. field.';
                    Caption = 'External No.';
                }
                field("Distribition Center"; Rec."LAX Distribution Center")
                {
                    ToolTip = 'Specifies the value of the Distribition Center field.';
                    Caption = 'Distribition Center';
                }
                field("Dist. Center Ship-to Code"; Rec."LAX Dist. Center Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Dist. Center Ship-to Code field.';
                    Caption = 'Dist. Center Ship-to Code';
                }
                field("Packing Rule Code"; Rec."lax Packing Rule Code")
                {
                    ToolTip = 'Specifies the value of the Packing Rule Code field.';
                    Caption = 'Packing Rule Code';
                }
                field("E-Mail Rule Code"; Rec."lax E-Mail Rule Code")
                {
                    ToolTip = 'Specifies the value of the E-Mail Rule Code field.';
                    Caption = 'E-Mail Rule Code';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                    Caption = 'Salesperson Code';
                }
                field("Inside Salesperson"; Rec."Inside Salesperson")
                {
                    ToolTip = 'Specifies the value of the Inside Salesperson field.';
                    Caption = 'Inside Salesperson';
                }
                field("Broker/Agent Code"; Rec."Broker/Agent Code")
                {
                    ToolTip = 'Specifies the value of the Broker/Agent Code field.';
                    Caption = 'Broker/Agent Code';
                }
                field("Delivery Route"; Rec."Delivery Route")
                {
                    ToolTip = 'Specifies the value of the Delivery Route field.';
                    Caption = 'Delivery Route';
                }
                field("Delivery Stop"; Rec."Delivery Stop")
                {
                    ToolTip = 'Specifies the value of the Delivery Stop field.';
                    Caption = 'Delivery Stop';
                }
            }
        }
    }

    actions
    {
    }
}

