tableextension 50111 "Sales Shipment Line Ext" extends "Sales Shipment Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.60,NV4.35,NIF1.095,NIF.N15.C9IN.001,AKK1606.01
    fields
    {
        field(50005; "Certificate No."; Code[30])
        {
            // cleaned
        }
        field(50010; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50020; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50025; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50027; "Revision No. (Label Only)"; Code[20])
        {
            // cleaned
        }
        field(50030; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50100; "Storage Location"; Code[10])
        {
            // cleaned
        }
        field(50105; "Line Supply Location"; Code[10])
        {
            // cleaned
        }
        field(50110; "Deliver To"; Code[10])
        {
            // cleaned
        }
        field(50115; "Receiving Area"; Code[10])
        {
            // cleaned
        }
        field(50120; "Ran No."; Code[20])
        {
            // cleaned
        }
        field(50125; "Container No."; Code[20])
        {
            // cleaned
        }
        field(50130; "Kanban No."; Code[20])
        {
            // cleaned
        }
        field(50135; "Res. Mfg."; Code[20])
        {
            // cleaned
        }
        field(50140; "Release No."; Code[20])
        {
            // cleaned
        }
        field(50145; "Mfg. Date"; Date)
        {
            // cleaned
        }
        field(50150; "Man No."; Code[20])
        {
            // cleaned
        }
        field(50155; "Delivery Order No."; Code[20])
        {
            // cleaned
        }
        field(50157; "Plant Code"; Code[10])
        {
            // cleaned
        }
        field(50160; "Dock Code"; Code[10])
        {
            // cleaned
        }
        field(50165; "Box Weight"; Decimal)
        {
            // cleaned
        }
        field(50170; "Store Address"; Text[50])
        {
            // cleaned
        }
        field(50175; "FRS No."; Code[10])
        {
            // cleaned
        }
        field(50180; "Main Route"; Code[10])
        {
            // cleaned
        }
        field(50185; "Line Side Address"; Text[50])
        {
            // cleaned
        }
        field(50190; "Sub Route Number"; Code[10])
        {
            // cleaned
        }
        field(50195; "Special Markings"; Text[30])
        {
            // cleaned
        }
        field(50200; "Eng. Change No."; Code[20])
        {
            // cleaned
        }
        field(50205; "Group Code"; Code[20])
        {
            // cleaned
        }
        field(50500; "Model Year"; Code[10])
        {
            // cleaned
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        //TODO

        /*  field(14000351; "EDI Item Cross Ref."; Code[20])
         {
             CaptionML = ENU = 'EDI Item Cross Ref.';
         }

         field(14000352; "EDI Unit of Measure"; Code[10])
         {
             CaptionML = ENU = 'EDI Unit of Measure';
         }

         field(14000353; "EDI Unit Price"; Decimal)
         {
             CaptionML = ENU = 'EDI Unit Price';
         }

         field(14000354; "EDI Price Discrepancy"; Boolean)
         {
             CaptionML = ENU = 'EDI Price Discrepancy';
         }

         field(14000355; "EDI Segment Group"; Integer)
         {
             CaptionML = ENU = 'EDI Segment Group';
             Editable = false;
         }

         field(14000356; "EDI Original Qty."; Decimal)
         {
             CaptionML = ENU = 'EDI Original Qty.';
             DecimalPlaces = 0 : 5;
             Editable = false;
         }

         field(14000357; "EDI Status Pending"; Boolean)
         {
             CaptionML = ENU = 'EDI Status Pending';
             Editable = false;
         }

         field(14000358; "EDI Release No."; Code[20])
         {
             CaptionML = ENU = 'EDI Release No.';
         }

         field(14000359; "EDI Ship Req. Date"; Date)
         {
             CaptionML = ENU = 'EDI Ship Req. Date';
         }

         field(14000360; "EDI Kanban No."; Code[20])
         {
             CaptionML = ENU = 'EDI Kanban No.';
         }

         field(14000361; "EDI Line Type"; Option)
         {
             CaptionML = ENU = 'EDI Line Type';
             OptionCaptionML = ENU = ' ,Forecast,Release,Change,Forecast & Release';
             OptionMembers = " ",Forecast,Release,Change,"Forecast & Release";
         }

         field(14000362; "EDI Line Status"; Option)
         {
             CaptionML = ENU = 'EDI Line Status';
             OptionCaptionML = ENU = ' ,New,Order Exists,Shipment Exists,Release Created,Change Made,Cancellation,Add Item';
             OptionMembers = " ",New,"Order Exists","Shipment Exists","Release Created","Change Made",Cancellation,"Add Item";
         }

         field(14000363; "EDI Cumulative Quantity"; Decimal)
         {
             CaptionML = ENU = 'EDI Cumulative Quantity';
         }

         field(14000364; "EDI Forecast Begin Date"; Date)
         {
             CaptionML = ENU = 'EDI Forecast Begin Date';
         }

         field(14000365; "EDI Forecast End Date"; Date)
         {
             CaptionML = ENU = 'EDI Forecast End Date';
         }

         field(14000366; "EDI Code"; Code[35])
         {
             CaptionML = ENU = 'EDI Code';
         }

         field(14000701; "Shipping Charge"; Boolean)
         {
             CaptionML = ENU = 'Shipping Charge';
         }

         field(14000702; "Qty. Packed (Base)"; Decimal)
         {
             CaptionML = ENU = 'Qty. Packed (Base)';
             Editable = false;
         }

         field(14000703; "Pack"; Boolean)
         {
             CaptionML = ENU = 'Pack';
             Editable = false;
         }

         field(14000704; "Rate Quoted"; Boolean)
         {
             CaptionML = ENU = 'Rate Quoted';
         }

         field(14000705; "Std. Package Unit of Meas Code"; Code[10])
         {
             TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
             CaptionML = ENU = 'Std. Package Unit of Meas Code';
         }

         field(14000706; "Std. Package Quantity"; Decimal)
         {
             CaptionML = ENU = 'Std. Package Quantity';
             DecimalPlaces = 0 : 5;
             BlankZero = true;
             Editable = false;
         }

         field(14000707; "Qty. per Std. Package"; Decimal)
         {
             CaptionML = ENU = 'Qty. per Std. Package';
             DecimalPlaces = 0 : 5;
             Editable = false;
         }

         field(14000708; "Std. Package Qty. to Ship"; Decimal)
         {
             CaptionML = ENU = 'Std. Package Qty. to Ship';
             DecimalPlaces = 0 : 5;
             BlankZero = true;
             Editable = false;
         }

         field(14000709; "Std. Packs per Package"; Integer)
         {
             CaptionML = ENU = 'Std. Packs per Package';
         }

         field(14000710; "Package Quantity"; Decimal)
         {
             CaptionML = ENU = 'Package Quantity';
             DecimalPlaces = 0 : 5;
             BlankZero = true;
             Editable = false;
         }

         field(14000711; "Package Qty. to Ship"; Decimal)
         {
             CaptionML = ENU = 'Package Qty. to Ship';
             DecimalPlaces = 0 : 5;
             BlankZero = true;
             Editable = false;
         }

         field(14000712; "E-Ship Whse. Outst. Qty (Base)"; Decimal)
         {
             CaptionML = ENU = 'E-Ship Whse. Outst. Qty (Base)';
             Editable = false;
         }

         field(14000713; "Shipping Charge BOL No."; Code[20])
         {
             TableRelation = "LAX Bill of Lading";
             CaptionML = ENU = 'Shipping Charge BOL No.';
         }

         field(14000715; "Required Shipping Agent Code"; Code[10])
         {
             TableRelation = "Shipping Agent";
             CaptionML = ENU = 'Required Shipping Agent Code';
         }

         field(14000716; "Required E-Ship Agent Service"; Code[30])
         {
             TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("Required Shipping Agent Code"));
             CaptionML = ENU = 'Required E-Ship Agent Service';
         }

         field(14000717; "Allow Other Ship. Agent/Serv."; Boolean)
         {
             CaptionML = ENU = 'Allow Other Ship. Agent/Serv.';
         }

         field(14000720; "E-Ship Agent Code"; Code[10])
         {
             TableRelation = "Shipping Agent";
             CaptionML = ENU = 'E-Ship Agent Code';
         }

         field(14000721; "E-Ship Agent Service"; Code[30])
         {
             CaptionML = ENU = 'E-Ship Agent Service';
         }

         field(14000722; "Shipping Payment Type"; Option)
         {
             CaptionML = ENU = 'Shipping Payment Type';
             OptionCaptionML = ENU = 'Prepaid,Third Party,Freight Collect,Consignee';
             OptionMembers = Prepaid,"Third Party","Freight Collect",Consignee;
         }

         field(14000723; "Third Party Ship. Account No."; Code[20])
         {
             CaptionML = ENU = 'Third Party Ship. Account No.';
         }

         field(14000724; "Shipping Insurance"; Option)
         {
             CaptionML = ENU = 'Shipping Insurance';
             OptionCaptionML = ENU = ' ,Never,Always';
             OptionMembers = "",Never,Always;
         }
  */
        //TODO
        field(14017611; "Order Date"; Date)
        {
            Description = 'NV';
        }

        field(14017612; "Manufacturer Code"; Code[10])
        {
            TableRelation = Manufacturer.Code;
        }

        field(14017614; "Tool Repair Tech"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(true));
        }

        field(14017615; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE(Sales = CONST(true));
            Description = 'NV';
        }

        field(14017616; "Inside Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(true));
            Description = 'NV';
        }

        field(14017617; "NV Posting Date"; Date)
        {
        }

        field(14017618; "External Document No."; Code[20])
        {
            Description = 'NV';
        }

        field(14017621; "List Price"; Decimal)
        {
        }

        field(14017631; "Net Unit Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
        }

        field(14017633; "Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }

        field(14017640; "Ship-to PO No."; Code[20])
        {
        }

        field(14017641; "Shipping Advice"; Option)
        {
            OptionCaptionML = ENU = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }

        field(14017645; "Contract No."; Code[20])
        {
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'NV';
        }

        field(14017650; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(14017660; "Order Outstanding Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017661; "Order Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(14017671; "Tag No."; Code[20])
        {
        }

        field(14017672; "Customer Bin"; Text[12])
        {
        }

        field(14017750; "Line Gross Weight"; Decimal)
        {
        }

        field(14017751; "Line Net Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }

        field(14017752; "Ship-to Code"; Code[10])
        {
            Description = 'NV';
        }

        field(14017753; "Line Cost"; Decimal)
        {
            Editable = false;
        }

        field(14017756; "Item Group Code"; Code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(14017757; "Vendor No."; Code[20])
        {
        }

        field(14017758; "Vendor Item No."; Text[20])
        {
        }

        field(14017903; "BOM Item"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Editable = false;
        }

        field(14017904; "Prod. Order No."; Code[20])
        {
        }

        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV';
        }

        field(37015331; "FB Line No."; Integer)
        {
            Description = 'NV';
        }

        field(37015332; "FB Tag No."; Code[20])
        {
            Description = 'NV';
        }

        field(37015333; "FB Customer Bin"; Code[20])
        {
            Description = 'NV';
        }

    }
    keys
    {
        key(Key9; "Shipment Date")
        {
        }
        /*  key(Key10; "Sell-to Customer No.", "Ship-to Code", Type, "No.", "Location Code", "Model Year", "Posting Date")
         {
             SumIndexFields = Quantity, "Quantity (Base)";
         }
         key(Key11; "Sell-to Customer No.", "No.", "LAX EDI Release No.", "LAX EDI Ship Req. Date")
         {
         } */
    }
    PROCEDURE ">>NIF_fcn"();
    BEGIN
    END;

    PROCEDURE ShowSpecialFields();
    VAR
        SalesShptLine: Record 111;
        SpecialFields: Page 50007;
    BEGIN
        IF (Type <> Type::Item) OR ("No." = '') THEN
            EXIT;
        SalesShptLine.SETRANGE("Document No.", "Document No.");
        SalesShptLine.SETRANGE("Line No.", "Line No.");
        SpecialFields.SETTABLEVIEW(SalesShptLine);
        SpecialFields.RUN();
    END;

    PROCEDURE ShowItemTrackingLines_gFnc(VAR TempItemLedgEntry_vRecTmp: Record 32 temporary);
    VAR
        ItemTrackingMgt: Codeunit 6500;
    BEGIN
        //TODO
        //>> NF1.00:CIS.NG    09/12/16
        // ItemTrackingMgt.CallPostedItemTrackingForm_gFnc(DATABASE::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.", TempItemLedgEntry_vRecTmp);
        //<< NF1.00:CIS.NG    09/12/16 
        //TODO
    END;
}
