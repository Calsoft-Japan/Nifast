table 99996 "Package Line"
{
    // 09/26/16: Added fields for carton Sr#s   (60010-60030)
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //   >>NIF
    //   Fields Added:
    //   50000  "Mfg. Lot No."
    //   50005 Certificate No.
    //   50010 Drawing No.
    //   50020 Revision No.
    //   50025 Revision Date
    //   50030 Location Code
    //   50035 Bin Code
    //   50040 Cross Reference No.
    //   50100 Storage Location
    //   50105 Line Supply Location
    //   50110 Deliver To
    //   50115 Receiving Area
    //   50120 Ran No.
    //   50125 Container No.
    //   50130 Kanban No.
    //   50135 Res. Mfg.
    //   50140 Release No.
    //   50145 Mfg. Date
    //   50150 Man No.
    //   50155 Delivery Order No.
    //   50160 Dock Code
    //   50165 Box Weight
    //   50170 Store Address
    //   50175 FRS No.
    //   50180 Main Route
    //   50185 Line Side Address
    //   50190 Sub Route Number
    //   50195 Special Markings
    //   50200 Eng. Change No.
    //   50500 Order Line No.
    //   50510 External Document No.
    // 
    //   Functions Added:
    //     SetCreatedFromPick
    //   Functions Modified:
    //     CalcValue
    //   Code Modified:
    //     Lot No. - OnValidate
    //   Globals Added:
    //     CreatedFromPick
    //   Keys Added:
    //     Sales Order No.,Order Line No.
    //   Date      Init     Proj     Description
    //   03-22-05  RTT      #9851    new field "Mfg. Lot No."
    //   03-28-05  RTT      #9865    new fields for labels
    //   06-29-05  RTT               code at CalcValue to disregard Pack field when filtering
    //   06-29-05  RTT               code at Lot No.-OnValidate() to override lot inv check if creating from pick; new var/fcn
    //   08-29-05  MAK      GOLIVE   Changed "Cross-Reference No." to 30 characters
    //   <<NIF
    // 
    //   >>IST
    //   Date   Init GranID SCRID  Description
    //                             Properties Modified:
    //                             Fields Added:
    //                             Fields Modified:
    //   081808 CCL $12797 #12797    50030 "Location Code" Removed, new Lanham field
    //   081808 CCL $12797 #12797    50035 "Bin Code" Set TableRelation=Bin
    //                             Globals Added:
    //                             Globals Modified:
    //                             TextConstant Added:
    //                             TextConstant Modified:
    //                             Functions Added:
    //                             Functions Modified:
    //                             Keys Added:
    //                             Keys Modified:
    //   081808 CCL $12797 #12797    From "Sales Order No.,Order Line No." to "Source ID,Order Line No.", "Sales Order No." no longer exists
    //                             Other:
    //   <<IST
    //   //>> WC
    //   001 05/07/09 WC/HH  Only override Location Code, if blank --  Nifast custom code populates location and bin earlier in the process
    //   //<< WC

    Caption = 'Package Line';

    fields
    {
        field(1; "Package No."; Code[20])
        {
            Caption = 'Package No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(11; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Account (G/L),Item,Resource,,,,,,,Package';
            OptionMembers = " ","Account (G/L)",Item,Resource,,,,,,,Package;

        }
        field(12; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(13; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(14; Quantity; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Quantity (Base)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(16; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE IF (Type = FILTER(<> Item)) "Unit of Measure";

        }
        field(17; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(18; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(21; "Net Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Gross Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(23; "Dim. Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Dim. Weight';
            DecimalPlaces = 0 : 5;
        }
        field(24; "Value (Price)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Value (Price)';

        }
        field(25; "Value (Cost)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Value (Cost)';
        }
        field(26; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';

        }
        field(27; Volume; Decimal)
        {
            BlankZero = true;
            Caption = 'Volume';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(28; "Pack Serial Number"; Boolean)
        {
            Caption = 'Pack Serial Number';
            Editable = false;
        }
        field(29; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';

        }
        field(30; "Pack Lot Number"; Boolean)
        {
            Caption = 'Pack Lot Number';
            Editable = false;
        }
        field(33; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            Editable = false;
        }
        field(34; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(35; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
            Editable = false;
        }
        field(36; "Selected Source ID"; Code[20])
        {
            Caption = 'Selected Source ID';

        }
        field(37; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location;
        }
        field(41; "Schedule B code"; Code[10])
        {
            Caption = 'Schedule B code';
            Editable = false;
        }
        field(44; "Preference Criteria"; Option)
        {
            Caption = 'Preference Criteria';
            OptionCaption = ' ,A,B,C,D,E,F';
            OptionMembers = " ",A,B,C,D,E,F;
        }
        field(45; "Producer of Good Indicator"; Option)
        {
            Caption = 'Producer of Good Indicator';
            OptionCaption = ' ,YES,1,2,3';
            OptionMembers = " ",YES,"1","2","3";
        }
        field(46; "RVC in Net Cost Method"; Boolean)
        {
            Caption = 'RVC in Net Cost Method';
        }
        field(51; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(52; "Pack Warranty Date"; Boolean)
        {
            Caption = 'Pack Warranty Date';
            Editable = false;
        }
        field(53; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(54; "Pack Expiration Date"; Boolean)
        {
            Caption = 'Pack Expiration Date';
            Editable = false;
        }
        field(55; "Scanned No."; Text[30])
        {
            Caption = 'Scanned No.';
            Editable = false;
        }
        field(56; "Schedule B Quantity 1"; Decimal)
        {
            Caption = 'Schedule B Quantity 1';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(57; "Schedule B Unit of Measure 1"; Code[10])
        {
            Caption = 'Schedule B Unit of Measure 1';
            Editable = false;
        }
        field(58; "Schedule B Quantity 2"; Decimal)
        {
            Caption = 'Schedule B Quantity 2';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Schedule B Unit of Measure 2"; Code[10])
        {
            Caption = 'Schedule B Unit of Measure 2';
            Editable = false;
        }
        field(60; "NMFC Code"; Code[10])
        {
            Caption = 'NMFC Code';
        }
        field(7300; "Unit Length"; Decimal)
        {
            Caption = 'Unit Length';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Use Unit of measure Dimensions" THEN
                    IF Quantity <> 0 THEN
                        Length := "Unit Length";
            end;
        }
        field(7301; "Unit Width"; Decimal)
        {
            Caption = 'Unit Width';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Use Unit of measure Dimensions" THEN
                    IF Quantity <> 0 THEN
                        Width := "Unit Width";
            end;
        }
        field(7302; "Unit Height"; Decimal)
        {
            Caption = 'Unit Height';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Use Unit of measure Dimensions" THEN
                    Height := Quantity * "Unit Height";
            end;
        }
        field(7303; "Unit Cubage"; Decimal)
        {
            Caption = 'Unit Cubage';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7304; "Unit Weight"; Decimal)
        {
            Caption = 'Unit Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7305; "Use Unit of measure Dimensions"; Boolean)
        {
            Caption = 'Use Unit of measure Dimensions';
        }
        field(7306; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7307; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7308; Height; Decimal)
        {
            Caption = 'Height';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7309; Cubage; Decimal)
        {
            Caption = 'Cubage';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7310; "Unit of Measure Weight"; Decimal)
        {
            Caption = 'Unit of Measure Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(50000; "Mfg. Lot No."; Code[30])
        {
        }
        field(50005; "Certificate No."; Code[30])
        {
        }
        field(50010; "Drawing No."; Code[30])
        {
        }
        field(50020; "Revision No."; Code[20])
        {
        }
        field(50025; "Revision Date"; Date)
        {
        }
        field(50035; "Bin Code"; Code[20])
        {
            TableRelation = Bin;
        }
        field(50040; "Cross Reference No."; Code[30])
        {
            Description = 'Was 20!  Nifast';
        }
        field(50100; "Storage Location"; Code[10])
        {
        }
        field(50105; "Line Supply Location"; Code[10])
        {
        }
        field(50110; "Deliver To"; Code[10])
        {
        }
        field(50115; "Receiving Area"; Code[10])
        {
        }
        field(50120; "Ran No."; Code[20])
        {
        }
        field(50125; "Container No."; Code[20])
        {
        }
        field(50130; "Kanban No."; Code[20])
        {
        }
        field(50135; "Res. Mfg."; Code[20])
        {
        }
        field(50140; "Release No."; Code[20])
        {
        }
        field(50145; "Mfg. Date"; Date)
        {
        }
        field(50150; "Man No."; Code[20])
        {
        }
        field(50155; "Delivery Order No."; Code[20])
        {
        }
        field(50160; "Dock Code"; Code[10])
        {
        }
        field(50165; "Box Weight"; Decimal)
        {
        }
        field(50170; "Store Address"; Text[50])
        {
        }
        field(50175; "FRS No."; Code[10])
        {
        }
        field(50180; "Main Route"; Code[10])
        {
        }
        field(50185; "Line Side Address"; Text[50])
        {
        }
        field(50190; "Sub Route Number"; Code[10])
        {
        }
        field(50195; "Special Markings"; Text[30])
        {
        }
        field(50200; "Eng. Change No."; Code[20])
        {
        }
        field(50500; "Order Line No."; Integer)
        {
        }
        field(50510; "External Document No."; Code[20])
        {
        }
        field(50520; "Model Year"; Code[10])
        {
        }
        field(60000; "Warehouse Act Line No."; Integer)
        {
            Description = 'NileshGajjar';
        }
        field(60010; "Carton First SrNo."; Text[30])
        {
        }
        field(60020; "Carton Last SrNo."; Text[30])
        {
        }
        field(60030; "Master Label SrNo."; Text[30])
        {
        }
        field(14000721; "Multi Document Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Multi Document Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14000722; "Multi Document Qty. (Base)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Multi Document Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14000723; "Distribution Factor"; Decimal)
        {
            Caption = 'Distribution Factor';
            Editable = false;
        }
        field(14000761; "Certificate of Origin No."; Code[10])
        {
            Caption = 'Certificate of Origin No.';
        }
        field(14000762; "Goods Not In Free Circulation"; Boolean)
        {
            Caption = 'Goods Not In Free Circulation';
        }
        field(14000763; "Total Quantity Exported"; Decimal)
        {
            Caption = 'Total Quantity Exported';
            DecimalPlaces = 0 : 5;
        }
        field(14000764; "Total Value Exported"; Decimal)
        {
            Caption = 'Total Value Exported';
        }
        field(14000765; "Line Weight Type"; Option)
        {
            Caption = 'Line Weight Type';
            OptionCaption = 'Pounds,Kilograms';
            OptionMembers = Pounds,Kilograms;
        }
        field(14000781; "Country of Manufacture"; Code[10])
        {
            Caption = 'Country of Manufacture';
            TableRelation = "Country/Region".Code;
        }
        field(14000782; "Handling Units"; Decimal)
        {
            Caption = 'Handling Units';
            DecimalPlaces = 0 : 0;
        }
        field(14000783; "Export License Required"; Boolean)
        {
            Caption = 'Export License Required';
        }
        field(14000785; "Export Controls Class No."; Code[15])
        {
            Caption = 'Export Controls Class No.';
        }
        field(14000786; "FXF Hazmat"; Boolean)
        {
            Caption = 'FXF Hazmat';
        }
        field(14000787; "FXF Hazmat Item No."; Code[20])
        {
            Caption = 'FXF Hazmat Item No.';
        }
        field(14000801; "LTL Freight Type"; Code[10])
        {
            Caption = 'LTL Freight Type';
        }
        field(14000821; "Item UPC/EAN Number"; Code[20])
        {
            Caption = 'Item UPC/EAN Number';
        }
        field(14000822; "Item UPC/EAN Number (Print)"; Code[50])
        {
            Caption = 'Item UPC/EAN Number (Print)';
            Editable = false;
        }
        field(14000823; "Std. Pack UPC/EAN Number"; Code[20])
        {
            Caption = 'Std. Pack UPC/EAN Number';
        }
        field(14000824; "Std. Pack UPC/EAN No. (Print)"; Code[50])
        {
            Caption = 'Std. Pack UPC/EAN No. (Print)';
            Editable = false;
        }
        field(14000981; "Tariff No."; Code[10])
        {
            Caption = 'Tariff No.';
        }
        field(14050001; "UPS ISC Type"; Option)
        {
            Caption = 'UPS ISC Type';
            OptionCaption = ' ,Seeds,Perishables,Tobacco,Plants,Alcoholic Beverages,Biological Substance,Special Exceptions';
            OptionMembers = " ",Seeds,Perishables,Tobacco,Plants,"Alcoholic Beverages","Biological Substance","Special Exceptions";
        }
    }

    keys
    {
        key(Key1; "Package No.", "Line No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Net Weight", "Value (Price)", "Value (Cost)", Quantity, "Dim. Weight", "Gross Weight", Volume, "Unit of Measure Weight", Cubage, Height;
        }
        key(Key2; "Source Type", "Source Subtype", "Source ID", "No.", "Variant Code", Type, "Location Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)", Quantity;
        }
        key(Key3; "No.", "Serial No.")
        {
        }
        key(Key4; Type, "No.")
        {
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckModify();
    end;

    trigger OnInsert()
    begin
        CheckModify();
        GetPackage();
        //>> 001 WC/HH
        //<< 001 WC/HH
        CalcValue(FALSE, FALSE);

        UpdateOptionPage();
    end;

    trigger OnModify()
    begin
        CheckModify();

        IF (Type <> xRec.Type) OR ("No." <> xRec."No.") THEN
            UpdateOptionPage();
    end;

    var
        /*   QtyToShip: Decimal;
          QtyPacked: Decimal; */
        ShippingSetupRetrieved: Boolean;
        /*  Text001: Label 'Mixed packages not allowed.';
         Text002: Label 'Duplicate Serial Number on %1 package %2 is packed but not shipped.';
         Text003: Label 'Serial No. %1 is not on inventory.';
         Text004: Label 'Lot No. %1 is not on inventory.';
         Text005: Label 'You are attempting to pack more of %1 %2 %3 than is scheduled to ship.';
         Text006: Label 'Package is already packed in another package %1.';
         ">>NIF_GV": Integer; */
        CreatedFromPick: Boolean;

    procedure CalcBaseQty()
    begin

    end;

    procedure GetPackage()
    begin

    end;

    procedure GetShippingAgent()
    begin
        GetPackage();

    end;

    procedure CalcValue(FromUnitOfMeasureCode: Boolean; FilterVariant: Boolean)
    var
    /*   TotalQuantityBase: Decimal;
      TotalValueCostBase: Decimal;
      TotalValuePriceBase: Decimal;
      NewUnitOfMeasureCode: Code[10]; */
    begin
        GetPackage();

    end;

    procedure OverPackError(): Boolean
    begin
        IF ("Source ID" = '') OR ("No." = '') THEN
            EXIT(FALSE);

        GetPackage();

    end;

    procedure CheckModify()
    begin
        GetPackage();
    end;

    procedure UpdateExportDocumentTotals()
    begin
        GetPackage();

    end;

    procedure UpdateOptionPage()
    begin
        IF (Type <> Type::Item) AND (Type <> Type::Resource) OR ("No." = '') THEN
            EXIT;

        GetPackage();
        GetShippingAgent();
    end;

    procedure DivideQuantityAndValueFields(MultiDocPackageLine: Record "Package Line"; var TotalPackageLine: Record "Package Line"; CorrectionFactor: Decimal; UseRemainingAmounts: Boolean)
    begin
        IF UseRemainingAmounts THEN BEGIN
            Quantity := MultiDocPackageLine.Quantity - TotalPackageLine.Quantity;
            "Quantity (Base)" :=
              MultiDocPackageLine."Quantity (Base)" - TotalPackageLine."Quantity (Base)";
            "Net Weight" := MultiDocPackageLine."Net Weight" - TotalPackageLine."Net Weight";
            "Gross Weight" := MultiDocPackageLine."Gross Weight" - TotalPackageLine."Gross Weight";
            "Dim. Weight" := MultiDocPackageLine."Dim. Weight" - TotalPackageLine."Dim. Weight";
            "Value (Price)" := MultiDocPackageLine."Value (Price)" - TotalPackageLine."Value (Price)";
            "Value (Cost)" := MultiDocPackageLine."Value (Cost)" - TotalPackageLine."Value (Cost)";
            Volume := MultiDocPackageLine.Volume - TotalPackageLine.Volume;
            "Total Quantity Exported" :=
              MultiDocPackageLine."Total Quantity Exported" - TotalPackageLine."Total Quantity Exported";
            "Total Value Exported" :=
              MultiDocPackageLine."Total Value Exported" - TotalPackageLine."Total Value Exported";
            "Handling Units" := MultiDocPackageLine."Handling Units" - TotalPackageLine."Handling Units";
        END ELSE BEGIN
            Quantity := ROUND(CorrectionFactor * MultiDocPackageLine.Quantity, 0.0001);
            "Quantity (Base)" := ROUND(CorrectionFactor * MultiDocPackageLine."Quantity (Base)", 0.0001);
            "Net Weight" := ROUND(CorrectionFactor * MultiDocPackageLine."Net Weight", 0.0001);
            "Gross Weight" := ROUND(CorrectionFactor * MultiDocPackageLine."Gross Weight", 0.0001);
            "Dim. Weight" := ROUND(CorrectionFactor * MultiDocPackageLine."Dim. Weight", 0.0001);
            "Value (Price)" := ROUND(CorrectionFactor * MultiDocPackageLine."Value (Price)", 0.0001);
            "Value (Cost)" := ROUND(CorrectionFactor * MultiDocPackageLine."Value (Cost)", 0.0001);
            Volume := ROUND(CorrectionFactor * MultiDocPackageLine.Volume, 0.0001);
            "Total Quantity Exported" :=
              ROUND(CorrectionFactor * MultiDocPackageLine."Total Quantity Exported", 0.0001);
            "Total Value Exported" :=
              ROUND(CorrectionFactor * MultiDocPackageLine."Total Value Exported", 0.0001);
            "Handling Units" := ROUND(CorrectionFactor * MultiDocPackageLine."Handling Units", 1)
        END;
        "Distribution Factor" := CorrectionFactor;

        TotalPackageLine.Quantity := TotalPackageLine.Quantity + Quantity;
        TotalPackageLine."Quantity (Base)" := TotalPackageLine."Quantity (Base)" + "Quantity (Base)";
        TotalPackageLine."Net Weight" := TotalPackageLine."Net Weight" + "Net Weight";
        TotalPackageLine."Gross Weight" := TotalPackageLine."Gross Weight" + "Gross Weight";
        TotalPackageLine."Dim. Weight" := TotalPackageLine."Dim. Weight" + "Dim. Weight";
        TotalPackageLine."Value (Price)" := TotalPackageLine."Value (Price)" + "Value (Price)";
        TotalPackageLine."Value (Cost)" := TotalPackageLine."Value (Cost)" + "Value (Cost)";
        TotalPackageLine.Volume := TotalPackageLine.Volume + Volume;
        TotalPackageLine."Total Quantity Exported" := TotalPackageLine."Total Quantity Exported" + "Total Quantity Exported";
        TotalPackageLine."Total Value Exported" := TotalPackageLine."Total Value Exported" + "Total Value Exported";
        TotalPackageLine."Handling Units" := TotalPackageLine."Handling Units" + "Handling Units";
    end;

    local procedure GetShippingSetup()
    begin
        IF NOT ShippingSetupRetrieved THEN
            ShippingSetupRetrieved := TRUE;
    end;

    procedure LookupSerialNo()
    begin

    end;

    procedure LookupLotNo()
    begin

    end;

    procedure GetWeight(): Decimal
    begin
        GetShippingSetup();

    end;

    procedure SetCreatedFromPick()
    begin
        CreatedFromPick := TRUE;
    end;
}

