page 50086 "Sales Shipment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Shipment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                    Caption = 'Sell-to Customer No.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Caption = 'Document No.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Caption = 'Line No.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                    Caption = 'Posting Group';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date field.';
                    Caption = 'Shipment Date';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    Caption = 'Description 2';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                    Caption = 'Unit of Measure';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Caption = 'Unit Price';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field.';
                    Caption = 'Unit Cost (LCY)';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ToolTip = 'Specifies the value of the VAT % field.';
                    Caption = 'VAT %';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                    Caption = 'Line Discount %';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                    Caption = 'Allow Invoice Disc.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the value of the Gross Weight field.';
                    Caption = 'Gross Weight';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the value of the Net Weight field.';
                    Caption = 'Net Weight';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ToolTip = 'Specifies the value of the Units per Parcel field.';
                    Caption = 'Units per Parcel';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ToolTip = 'Specifies the value of the Unit Volume field.';
                    Caption = 'Unit Volume';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the value of the Appl.-to Item Entry field.';
                    Caption = 'Appl.-to Item Entry';
                }
                field("Item Shpt. Entry No."; Rec."Item Shpt. Entry No.")
                {
                    ToolTip = 'Specifies the value of the Item Shpt. Entry No. field.';
                    Caption = 'Item Shpt. Entry No.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                    Caption = 'Customer Price Group';
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the value of the Project No. field.';
                    Caption = 'Project No.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                    Caption = 'Work Type Code';
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Qty. Shipped Not Invoiced field.';
                    Caption = 'Qty. Shipped Not Invoiced';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies the value of the Quantity Invoiced field.';
                    Caption = 'Quantity Invoiced';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.';
                    Caption = 'Order No.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                    Caption = 'Order Line No.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                    Caption = 'Bill-to Customer No.';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order No. field.';
                    Caption = 'Purchase Order No.';
                }
                field("Purch. Order Line No."; Rec."Purch. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Purch. Order Line No. field.';
                    Caption = 'Purch. Order Line No.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ToolTip = 'Specifies the value of the Drop Shipment field.';
                    Caption = 'Drop Shipment';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                    Caption = 'Gen. Bus. Posting Group';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                    Caption = 'Gen. Prod. Posting Group';
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ToolTip = 'Specifies the value of the VAT Calculation Type field.';
                    Caption = 'VAT Calculation Type';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                    Caption = 'Transaction Type';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the value of the Transport Method field.';
                    Caption = 'Transport Method';
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ToolTip = 'Specifies the value of the Attached to Line No. field.';
                    Caption = 'Attached to Line No.';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the value of the Exit Point field.';
                    Caption = 'Exit Point';
                }
                /*   field(Area;Area)
          {
                                 ToolTip = 'Specifies the value of the  field.';
          } */
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the value of the Transaction Specification field.';
                    Caption = 'Transaction Specification';
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
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ToolTip = 'Specifies the value of the Tax Group Code field.';
                    Caption = 'Tax Group Code';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                    Caption = 'VAT Bus. Posting Group';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                    Caption = 'VAT Prod. Posting Group';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency that is used on the entry.';
                    Caption = 'Currency Code';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Caption = 'Blanket Order No.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Caption = 'Blanket Order Line No.';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Base Amount field.';
                    Caption = 'VAT Base Amount';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                    Caption = 'Unit Cost';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Caption = 'Posting Date';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                    Caption = 'Dimension Set ID';
                }
                field("Authorized for Credit Card"; Rec."Authorized for Credit Card")
                {
                    ToolTip = 'Specifies the value of the Authorized for Credit Card field.';
                    Caption = 'Authorized for Credit Card';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the number of the related project task.';
                    Caption = 'Project Task No.';
                }
                field("Job Contract Entry No."; Rec."Job Contract Entry No.")
                {
                    ToolTip = 'Specifies the value of the Project Contract Entry No. field.';
                    Caption = 'Project Contract Entry No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Caption = 'Variant Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Caption = 'Bin Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                    Caption = 'Qty. per Unit of Measure';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Caption = 'Unit of Measure Code';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                    Caption = 'Quantity (Base)';
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. Invoiced (Base) field.';
                    Caption = 'Qty. Invoiced (Base)';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ToolTip = 'Specifies the value of the FA Posting Date field.';
                    Caption = 'FA Posting Date';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                    Caption = 'Depreciation Book Code';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
                    Caption = 'Depr. until FA Posting Date';
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ToolTip = 'Specifies the value of the Duplicate in Depreciation Book field.';
                    Caption = 'Duplicate in Depreciation Book';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ToolTip = 'Specifies the value of the Use Duplication List field.';
                    Caption = 'Use Duplication List';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Caption = 'Responsibility Center';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                    Caption = 'Cross-Reference No.';
                }
                field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure (Cross Ref.) field.';
                    Caption = 'Unit of Measure (Cross Ref.)';
                }
                field("Cross-Reference Type"; Rec."Cross-Reference Type")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference Type field.';
                    Caption = 'Cross-Reference Type';
                }
                field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                {
                    ToolTip = 'Specifies the value of the Cross-Reference Type No. field.';
                    Caption = 'Cross-Reference Type No.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                    Caption = 'Item Category Code';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ToolTip = 'Specifies that the item on the sales line is a catalog item, which means it is not normally kept in inventory.';
                    Caption = 'Catalog';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ToolTip = 'Specifies the value of the Purchasing Code field.';
                    Caption = 'Purchasing Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Code field.';
                    Caption = 'Product Group Code';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    Caption = 'Requested Delivery Date';
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
                    Caption = 'Promised Delivery Date';
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                    Caption = 'Shipping Time';
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                    Caption = 'Outbound Whse. Handling Time';
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address. If the customer requests a delivery date, the program calculates whether the items will be available for delivery on this date. If the items are available, the planned delivery date will be the same as the requested delivery date. If not, the program calculates the date that the items are available for delivery and enters this date in the Planned Delivery Date field.';
                    Caption = 'Planned Delivery Date';
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ToolTip = 'Specifies the date that the shipment should ship from the warehouse. If the customer requests a delivery date, the program calculates the planned shipment date by subtracting the shipping time from the requested delivery date. If the customer does not request a delivery date or the requested delivery date cannot be met, the program calculates the content of this field by adding the shipment time to the shipping date.';
                    Caption = 'Planned Shipment Date';
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    Caption = 'Appl.-from Item Entry';
                }
                field("Item Charge Base Amount"; Rec."Item Charge Base Amount")
                {
                    ToolTip = 'Specifies the value of the Item Charge Base Amount field.';
                    Caption = 'Item Charge Base Amount';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies that this sales shipment line has been posted as a corrective entry.';
                    Caption = 'Correction';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    Caption = 'Return Reason Code';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.';
                    Caption = 'Allow Line Disc.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.';
                    Caption = 'Customer Disc. Group';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ToolTip = 'Specifies the Package Tracking No. field on the sales line.';
                    Caption = 'Package Tracking No.';
                }
                field("Certificate No."; Rec."Certificate No.")
                {
                    ToolTip = 'Specifies the value of the Certificate No. field.';
                    Caption = 'Certificate No.';
                }
                field("Drawing No."; Rec."Drawing No.")
                {
                    ToolTip = 'Specifies the value of the Drawing No. field.';
                    Caption = 'Drawing No.';
                }
                field("Revision No."; Rec."Revision No.")
                {
                    ToolTip = 'Specifies the value of the Revision No. field.';
                    Caption = 'Revision No.';
                }
                field("Revision Date"; Rec."Revision Date")
                {
                    ToolTip = 'Specifies the value of the Revision Date field.';
                    Caption = 'Revision Date';
                }
                field("Revision No. (Label Only)"; Rec."Revision No. (Label Only)")
                {
                    ToolTip = 'Specifies the value of the Revision No. (Label Only) field.';
                    Caption = 'Revision No. (Label Only)';
                }
                field("Total Parcels"; Rec."Total Parcels")
                {
                    ToolTip = 'Specifies the value of the Total Parcels field.';
                    Caption = 'Total Parcels';
                }
                field("Storage Location"; Rec."Storage Location")
                {
                    ToolTip = 'Specifies the value of the Storage Location field.';
                    Caption = 'Storage Location';
                }
                field("Line Supply Location"; Rec."Line Supply Location")
                {
                    ToolTip = 'Specifies the value of the Line Supply Location field.';
                    Caption = 'Line Supply Location';
                }
                field("Deliver To"; Rec."Deliver To")
                {
                    ToolTip = 'Specifies the value of the Deliver To field.';
                    Caption = 'Deliver To';
                }
                field("Receiving Area"; Rec."Receiving Area")
                {
                    ToolTip = 'Specifies the value of the Receiving Area field.';
                    Caption = 'Receiving Area';
                }
                field("Ran No."; Rec."Ran No.")
                {
                    ToolTip = 'Specifies the value of the Ran No. field.';
                    Caption = 'Ran No.';
                }
                field("Container No."; Rec."Container No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    Caption = 'Container No.';
                }
                field("Kanban No."; Rec."Kanban No.")
                {
                    ToolTip = 'Specifies the value of the Kanban No. field.';
                    Caption = 'Kanban No.';
                }
                field("Res. Mfg."; Rec."Res. Mfg.")
                {
                    ToolTip = 'Specifies the value of the Res. Mfg. field.';
                    Caption = 'Res. Mfg.';
                }
                field("Release No."; Rec."Release No.")
                {
                    ToolTip = 'Specifies the value of the Release No. field.';
                    Caption = 'Release No.';
                }
                field("Mfg. Date"; Rec."Mfg. Date")
                {
                    ToolTip = 'Specifies the value of the Mfg. Date field.';
                    Caption = 'Mfg. Date';
                }
                field("Man No."; Rec."Man No.")
                {
                    ToolTip = 'Specifies the value of the Man No. field.';
                    Caption = 'Man No.';
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    Caption = 'Delivery Order No.';
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ToolTip = 'Specifies the value of the Plant Code field.';
                    Caption = 'Plant Code';
                }
                field("Dock Code"; Rec."Dock Code")
                {
                    ToolTip = 'Specifies the value of the Dock Code field.';
                    Caption = 'Dock Code';
                }
                field("Box Weight"; Rec."Box Weight")
                {
                    ToolTip = 'Specifies the value of the Box Weight field.';
                    Caption = 'Box Weight';
                }
                field("Store Address"; Rec."Store Address")
                {
                    ToolTip = 'Specifies the value of the Store Address field.';
                    Caption = 'Store Address';
                }
                field("FRS No."; Rec."FRS No.")
                {
                    ToolTip = 'Specifies the value of the FRS No. field.';
                    Caption = 'FRS No.';
                }
                field("Main Route"; Rec."Main Route")
                {
                    ToolTip = 'Specifies the value of the Main Route field.';
                    Caption = 'Main Route';
                }
                field("Line Side Address"; Rec."Line Side Address")
                {
                    ToolTip = 'Specifies the value of the Line Side Address field.';
                    Caption = 'Line Side Address';
                }
                field("Sub Route Number"; Rec."Sub Route Number")
                {
                    ToolTip = 'Specifies the value of the Sub Route Number field.';
                    Caption = 'Sub Route Number';
                }
                field("Special Markings"; Rec."Special Markings")
                {
                    ToolTip = 'Specifies the value of the Special Markings field.';
                    Caption = 'Special Markings';
                }
                field("Eng. Change No."; Rec."Eng. Change No.")
                {
                    ToolTip = 'Specifies the value of the Eng. Change No. field.';
                    Caption = 'Eng. Change No.';
                }
                field("Group Code"; Rec."Group Code")
                {
                    ToolTip = 'Specifies the value of the Group Code field.';
                    Caption = 'Group Code';
                }
                field("Model Year"; Rec."Model Year")
                {
                    ToolTip = 'Specifies the value of the Model Year field.';
                    Caption = 'Model Year';
                }
                field("Entry/Exit Date"; Rec."Entry/Exit Date")
                {
                    ToolTip = 'Specifies the value of the Entry/Exit Date field.';
                    Caption = 'Entry/Exit Date';
                }
                field("Entry/Exit No."; Rec."Entry/Exit No.")
                {
                    ToolTip = 'Specifies the value of the Entry/Exit No. field.';
                    Caption = 'Entry/Exit No.';
                }
                field(National; Rec.National)
                {
                    ToolTip = 'Specifies the value of the National field.';
                    Caption = 'National';
                }
                field("EDI Item Cross Ref."; Rec."Item Cross Ref.")
                {
                    ToolTip = 'Specifies the value of the EDI Item Cross Ref. field.';
                    Caption = 'EDI Item Cross Ref.';
                }
                field("EDI Unit of Measure"; Rec."EDI Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the EDI Unit of Measure field.';
                    Caption = 'EDI Unit of Measure';
                }
                field("EDI Unit Price"; Rec."EDI Unit Price")
                {
                    ToolTip = 'Specifies the value of the EDI Unit Price field.';
                    Caption = 'EDI Unit Price';
                }
                field("EDI Price Discrepancy"; Rec."EDI Price Discrepancy")
                {
                    ToolTip = 'Specifies the value of the EDI Price Discrepancy field.';
                    Caption = 'EDI Price Discrepancy';
                }
                field("EDI Segment Group"; Rec."EDI Segment Group")
                {
                    ToolTip = 'Specifies the value of the EDI Segment Group field.';
                    Caption = 'EDI Segment Group';
                }
                field("EDI Original Qty."; Rec."EDI Original Qty.")
                {
                    ToolTip = 'Specifies the value of the EDI Original Qty. field.';
                    Caption = 'EDI Original Qty.';
                }
                field("EDI Status Pending"; Rec."EDI Status Pending")
                {
                    ToolTip = 'Specifies the value of the EDI Status Pending field.';
                    Caption = 'EDI Status Pending';
                }
                field("EDI Release No."; Rec."EDI Release No.")
                {
                    ToolTip = 'Specifies the value of the EDI Release No. field.';
                    Caption = 'EDI Release No.';
                }
                field("EDI Ship Req. Date"; Rec."EDI Ship Req. Date")
                {
                    ToolTip = 'Specifies the value of the EDI Ship Req. Date field.';
                    Caption = 'EDI Ship Req. Date';
                }
                field("EDI Kanban No."; Rec."EDI Kanban No.")
                {
                    ToolTip = 'Specifies the value of the EDI Kanban No. field.';
                    Caption = 'EDI Kanban No.';
                }
                field("EDI Line Type"; Rec."EDI Line Type")
                {
                    ToolTip = 'Specifies the value of the EDI Line Type field.';
                    Caption = 'EDI Line Type';
                }
                field("EDI Line Status"; Rec."EDI Line Status")
                {
                    ToolTip = 'Specifies the value of the EDI Line Status field.';
                    Caption = 'EDI Line Status';
                }
                field("EDI Cumulative Quantity"; Rec."EDI Cumulative Quantity")
                {
                    ToolTip = 'Specifies the value of the EDI Cumulative Quantity field.';
                    Caption = 'EDI Cumulative Quantity';
                }
                field("EDI Forecast Begin Date"; Rec."EDI Forecast Begin Date")
                {
                    ToolTip = 'Specifies the value of the EDI Forecast Begin Date field.';
                    Caption = 'EDI Forecast Begin Date';
                }
                field("EDI Forecast End Date"; Rec."EDI Forecast End Date")
                {
                    ToolTip = 'Specifies the value of the EDI Forecast End Date field.';
                    Caption = 'EDI Forecast End Date';
                }
                field("EDI Code"; Rec."EDI Code")
                {
                    ToolTip = 'Specifies the value of the EDI Code field.';
                    Caption = 'EDI Code';
                }
                field("Shipping Charge"; Rec."Shipping Charge")
                {
                    ToolTip = 'Specifies the value of the Shipping Charge field.';
                    Caption = 'Shipping Charge';
                }
                field("Qty. Packed (Base)"; Rec."Qty. Packed (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. Packed (Base) field.';
                    Caption = 'Qty. Packed (Base)';
                }
                field(Pack; Rec.Pack)
                {
                    ToolTip = 'Specifies the value of the Pack field.';
                    Caption = 'Pack';
                }
                field("Rate Quoted"; Rec."Rate Quoted")
                {
                    ToolTip = 'Specifies the value of the Rate Quoted field.';
                    Caption = 'Rate Quoted';
                }
                field("Std. Package Unit of Meas Code"; Rec."Std. Package Unit of Meas Code")
                {
                    ToolTip = 'Specifies the value of the Std. Package Unit of Meas Code field.';
                    Caption = 'Std. Package Unit of Meas Code';
                }
                field("Std. Package Quantity"; Rec."Std. Package Quantity")
                {
                    ToolTip = 'Specifies the value of the Std. Package Quantity field.';
                    Caption = 'Std. Package Quantity';
                }
                field("Qty. per Std. Package"; Rec."Qty. per Std. Package")
                {
                    ToolTip = 'Specifies the value of the Qty. per Std. Package field.';
                    Caption = 'Qty. per Std. Package';
                }
                field("Std. Package Qty. to Ship"; Rec."Std. Package Qty. to Ship")
                {
                    ToolTip = 'Specifies the value of the Std. Package Qty. to Ship field.';
                    Caption = 'Std. Package Qty. to Ship';
                }
                field("Std. Packs per Package"; Rec."Std. Packs per Package")
                {
                    ToolTip = 'Specifies the value of the Std. Packs per Package field.';
                    Caption = 'Std. Packs per Package';
                }
                field("Package Quantity"; Rec."Package Quantity")
                {
                    ToolTip = 'Specifies the value of the Package Quantity field.';
                    Caption = 'Package Quantity';
                }
                field("Package Qty. to Ship"; Rec."Package Qty. to Ship")
                {
                    ToolTip = 'Specifies the value of the Package Qty. to Ship field.';
                    Caption = 'Package Qty. to Ship';
                }
                field("E-Ship Whse. Outst. Qty (Base)"; Rec."E-Ship Whse. Outst. Qty (Base)")
                {
                    ToolTip = 'Specifies the value of the E-Ship Whse. Outst. Qty (Base) field.';
                    Caption = 'E-Ship Whse. Outst. Qty (Base)';
                }
                field("Shipping Charge BOL No."; Rec."Shipping Charge BOL No.")
                {
                    ToolTip = 'Specifies the value of the Shipping Charge BOL No. field.';
                    Caption = 'Shipping Charge BOL No.';
                }
                field("Required Shipping Agent Code"; Rec."Required Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Required Shipping Agent Code field.';
                    Caption = 'Required Shipping Agent Code';
                }
                field("Required E-Ship Agent Service"; Rec."Required E-Ship Agent Service")
                {
                    ToolTip = 'Specifies the value of the Required E-Ship Agent Service field.';
                    Caption = 'Required E-Ship Agent Service';
                }
                field("Allow Other Ship. Agent/Serv."; Rec."Allow Other Ship. Agent/Serv.")
                {
                    ToolTip = 'Specifies the value of the Allow Other Ship. Agent/Serv. field.';
                    Caption = 'Allow Other Ship. Agent/Serv.';
                }
                field("E-Ship Agent Code"; Rec."E-Ship Agent Code")
                {
                    ToolTip = 'Specifies the value of the E-Ship Agent Code field.';
                    Caption = 'E-Ship Agent Code';
                }
                field("E-Ship Agent Service"; Rec."E-Ship Agent Service")
                {
                    ToolTip = 'Specifies the value of the E-Ship Agent Service field.';
                    Caption = 'E-Ship Agent Service';
                }
                field("Shipping Payment Type"; Rec."Shipping Payment Type")
                {
                    ToolTip = 'Specifies the value of the Shipping Payment Type field.';
                    Caption = 'Shipping Payment Type';
                }
                field("Third Party Ship. Account No."; Rec."Third Party Ship. Account No.")
                {
                    ToolTip = 'Specifies the value of the Third Party Ship. Account No. field.';
                    Caption = 'Third Party Ship. Account No.';
                }
                field("Shipping Insurance"; Rec."Shipping Insurance")
                {
                    ToolTip = 'Specifies the value of the Shipping Insurance field.';
                    Caption = 'Shipping Insurance';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                    Caption = 'Order Date';
                }
                field("Manufacturer Code"; Rec."Manufacturer Code")
                {
                    ToolTip = 'Specifies the value of the Manufacturer Code field.';
                    Caption = 'Manufacturer Code';
                }
                field("Tool Repair Tech"; Rec."Tool Repair Tech")
                {
                    ToolTip = 'Specifies the value of the Tool Repair Tech field.';
                    Caption = 'Tool Repair Tech';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                    Caption = 'Salesperson Code';
                }
                field("Inside Salesperson Code"; Rec."Inside Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Inside Salesperson Code field.';
                    Caption = 'Inside Salesperson Code';
                }
                field("NV Posting Date"; Rec."NV Posting Date")
                {
                    ToolTip = 'Specifies the value of the NV Posting Date field.';
                    Caption = 'NV Posting Date';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    Caption = 'External Document No.';
                }
                field("List Price"; Rec."List Price")
                {
                    ToolTip = 'Specifies the value of the List Price field.';
                    Caption = 'List Price';
                }
                field("Net Unit Price"; Rec."Net Unit Price")
                {
                    ToolTip = 'Specifies the value of the Net Unit Price field.';
                    Caption = 'Net Unit Price';
                }
                field("Ship-to PO No."; Rec."Ship-to PO No.")
                {
                    ToolTip = 'Specifies the value of the Ship-to PO No. field.';
                    Caption = 'Ship-to PO No.';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ToolTip = 'Specifies the value of the Shipping Advice field.';
                    Caption = 'Shipping Advice';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    Caption = 'Contract No.';
                }
                field("Resource Group No."; Rec."Resource Group No.")
                {
                    ToolTip = 'Specifies the value of the Resource Group No. field.';
                    Caption = 'Resource Group No.';
                }
                field("Order Outstanding Qty. (Base)"; Rec."Order Outstanding Qty. (Base)")
                {
                    ToolTip = 'Specifies the value of the Order Outstanding Qty. (Base) field.';
                    Caption = 'Order Outstanding Qty. (Base)';
                }
                field("Order Quantity (Base)"; Rec."Order Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Order Quantity (Base) field.';
                    Caption = 'Order Quantity (Base)';
                }
                field("Tag No."; Rec."Tag No.")
                {
                    ToolTip = 'Specifies the value of the Tag No. field.';
                    Caption = 'Tag No.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                    Caption = 'Customer Bin';
                }
                field("Line Gross Weight"; Rec."Line Gross Weight")
                {
                    ToolTip = 'Specifies the value of the Line Gross Weight field.';
                    Caption = 'Line Gross Weight';
                }
                field("Line Net Weight"; Rec."Line Net Weight")
                {
                    ToolTip = 'Specifies the value of the Line Net Weight field.';
                    Caption = 'Line Net Weight';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                    Caption = 'Ship-to Code';
                }
                field("Line Cost"; Rec."Line Cost")
                {
                    ToolTip = 'Specifies the value of the Line Cost field.';
                    Caption = 'Line Cost';
                }
                field("Item Group Code"; Rec."Item Group Code")
                {
                    ToolTip = 'Specifies the value of the Item Group Code field.';
                    Caption = 'Item Group Code';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    Caption = 'Vendor No.';
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ToolTip = 'Specifies the value of the Vendor Item No. field.';
                    Caption = 'Vendor Item No.';
                }
                field("BOM Item"; Rec."BOM Item")
                {
                    ToolTip = 'Specifies the value of the BOM Item field.';
                    Caption = 'BOM Item';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                    Caption = 'Prod. Order No.';
                }
                field("FB Order No."; Rec."FB Order No.")
                {
                    ToolTip = 'Specifies the value of the FB Order No. field.';
                    Caption = 'FB Order No.';
                }
                field("FB Line No."; Rec."FB Line No.")
                {
                    ToolTip = 'Specifies the value of the FB Line No. field.';
                    Caption = 'FB Line No.';
                }
                field("FB Tag No."; Rec."FB Tag No.")
                {
                    ToolTip = 'Specifies the value of the FB Tag No. field.';
                    Caption = 'FB Tag No.';
                }
                field("FB Customer Bin"; Rec."FB Customer Bin")
                {
                    ToolTip = 'Specifies the value of the FB Customer Bin field.';
                    Caption = 'FB Customer Bin';
                }
            }
        }
    }

    actions
    {
    }
}

