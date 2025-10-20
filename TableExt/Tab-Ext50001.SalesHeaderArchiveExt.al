tableextension 50001 "Sales Header Archive Ext" extends "Sales Header Archive"
{
    fields
    {
        /*    field(14000350; "EDI Order"; Boolean)
           {
               Caption = 'EDI Order';
           }

           field(14000351; "EDI Internal Doc. No."; Code[10])
           {
               Caption = 'EDI Internal Doc. No.';
               Editable = true;
           }

           field(14000354; "EDI Ack. Generated"; Boolean)
           {
               Caption = 'EDI Ack. Generated';
               Editable = true;
           }

           field(14000355; "EDI Ack. Gen. Date"; Date)
           {
               Caption = 'EDI Ack. Gen. Date';
               Editable = true;
           }

           field(14000360; "EDI Released"; Boolean)
           {
               Caption = 'EDI Released';
           }

           field(14000361; "EDI WHSE Shp. Gen"; Boolean)
           {
               Caption = 'EDI WHSE Shp. Gen';
               Editable = true;
           }

           field(14000362; "EDI WHSE Shp. Gen Date"; Date)
           {
               Caption = 'EDI WHSE Shp. Gen Date';
               Editable = true;
           }

           field(14000365; "EDI Expected Delivery Date"; Date)
           {
               Caption = 'EDI Expected Delivery Date';
           }

           field(14000366; "EDI Trade Partner"; Code[20])
           {
               Caption = 'EDI Trade Partner';
               trigger OnLookup()
               var
                   EDIIntegration: Codeunit 14000363;
               begin
                   EDIIntegration.TradePtnrLookupSalesHdrArchive(Rec);
               end;
           }

           field(14000367; "EDI Sell-to Code"; Code[20])
           {
               Caption = 'EDI Sell-to Code';
               trigger OnLookup()
               var
                   EDIIntegration: Codeunit 14000363;
               begin
                   EDIIntegration.ArchiveSellToCodeLookup(Rec);
               end;
           }

           field(14000368; "EDI Ship-to Code"; Code[20])
           {
               Caption = 'EDI Ship-to Code';
               trigger OnLookup()
               var
                   EDIIntegration: Codeunit 14000363;
               begin
                   EDIIntegration.ArchiveShipToCodeLookup(Rec);
               end;
           }

           field(14000369; "EDI Ship-for Code"; Code[20])
           {
               Caption = 'EDI Ship-for Code';
               trigger OnLookup()
               var
                   EDIIntegration: Codeunit 14000363;
               begin
                   EDIIntegration.ArchiveShipForCodeLookup(Rec);
               end;
           }

           field(14000370; "Order Status Required"; Boolean)
           {
               Caption = 'Order Status Required';
           }

           field(14000371; "Pricing Discrepancy"; Boolean)
           {
               Caption = 'Pricing Discrepancy';
               FieldClass = FlowField;
               CalcFormula = exist("Sales Line Archive" where("Document Type" = field("Document Type"),
                                                          "Document No." = field("No."),
                                                          "EDI Price Discrepancy" = const(Yes)));
               Editable = true;
           }

           field(14000372; "EDI Cancel After Date"; Date)
           {
               Caption = 'EDI Cancel After Date';
           }

           field(14000373; "Shipment Release"; Boolean)
           {
               Caption = 'Shipment Release';
           }

           field(14000374; "EDI Invoice"; Boolean)
           {
               Caption = 'EDI Invoice';
           }

           field(14000375; "EDI Cancellation Request"; Boolean)
           {
               Caption = 'EDI Cancellation Request';
           }

           field(14000376; "EDI Cancellation Date"; Date)
           {
               Caption = 'EDI Cancellation Date';
               Editable = true;
           }

           field(14000701; "E-Ship Agent Service"; Code[30])
           {
               Caption = 'E-Ship Agent Service';
               TableRelation = "E-Ship Agent Service".Code where("Shipping Agent Code" = field("Shipping Agent Code"),
                                                             "World Wide Service" = field("World Wide Service"));
           }

           field(14000704; "Residential Delivery"; Boolean)
           {
               Caption = 'Residential Delivery';
           }

           field(14000705; "Free Freight"; Boolean)
           {
               Caption = 'Free Freight';
           }

           field(14000706; "COD Payment"; Boolean)
           {
               Caption = 'COD Payment';
               BlankZero = true;
           }

           field(14000709; "World Wide Service"; Boolean)
           {
               Caption = 'World Wide Service';
               Editable = true;
           }

           field(14000710; "Blind Shipment"; Boolean)
           {
               Caption = 'Blind Shipment';
           }

           field(14000711; "Double Blind Shipment"; Boolean)
           {
               Caption = 'Double Blind Shipment';
           }

           field(14000712; "Double Blind Ship-from Cust No"; Code[20])
           {
               Caption = 'Double Blind Ship-from Cust No';
               TableRelation = Customer;
           }

           field(14000713; "No Free Freight Lines on Order"; Boolean)
           {
               Caption = 'No Free Freight Lines on Order';
           }

           field(14000714; "COD Cashiers Check"; Boolean)
           {
               Caption = 'COD Cashiers Check';
               Editable = true;
           }

           field(14000716; "Shipping Payment Type"; Option)
           {
               Caption = 'Shipping Payment Type';
               OptionMembers = Prepaid,"Third Party","Freight Collect",Consignee;
               OptionCaption = 'Prepaid,Third Party,Freight Collect,Consignee';
           }

           field(14000717; "Third Party Ship. Account No."; Code[20])
           {
               Caption = 'Third Party Ship. Account No.';
               trigger OnLookup()
               var
                   ShippingAccount: Record 14000714;
               begin
                   if ShippingAccount.LookupThirdPartyAccountNo(
                        "Shipping Agent Code",
                        ShippingAccount."Ship-to Type"::Customer,
                        "Sell-to Customer No.",
                        "Ship-to Code")
                   then
                       Validate("Third Party Ship. Account No.", ShippingAccount.GetLookupAccountNo);
               end;
           }

           field(14000718; "Shipping Insurance"; Option)
           {
               Caption = 'Shipping Insurance';
               OptionMembers = " ",Never,Always;
               OptionCaption = ' ,Never,Always';
           }

           field(14000825; "Ship-for Code"; Code[20])
           {
               Caption = 'Ship-for Code';
               TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));
           }

           field(14000826; "External Sell-to No."; Code[20])
           {
               Caption = 'External Sell-to No.';
           }

           field(14000827; "External Ship-to No."; Code[20])
           {
               Caption = 'External Ship-to No.';
           }

           field(14000828; "External Ship-for No."; Code[20])
           {
               Caption = 'External Ship-for No.';
           }

           field(14000829; "Invoice for Bill of Lading No."; Code[20])
           {
               Caption = 'Invoice for Bill of Lading No.';
               TableRelation = "Bill of Lading";
           }

           field(14000831; "Invoice for Shipment No."; Code[20])
           {
               Caption = 'Invoice for Shipment No.';
               TableRelation = "Sales Shipment Header".No. where("Order No." = field("No."),
                                                             "Shipment Invoice No." = filter(''));
           }

           field(14000832; "Shipment Invoice Override"; Boolean)
           {
               Caption = 'Shipment Invoice Override';
           }

           field(14000901; "E-Mail Confirmation Handled"; Boolean)
           {
               Caption = 'E-Mail Confirmation Handled';
           }
       }
    */
    }
}