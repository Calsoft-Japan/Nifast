tableextension 50039 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50000; "Contract Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "4X Contract"."No.";
        }
        field(50001; "Exchange Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "USD Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Forex';
            Editable = false;
        }
        field(50005; "Sail-on Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
        }
        field(50007; "Vessel Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '#10044';
            TableRelation = "Shipping Vessels";
        }
        field(50010; "Drawing No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Revision No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Item)) "Cust./Item Drawing2"."Revision No." where("Item No." = field("No."),
                                                                                              "Customer No." = filter(''));

            trigger OnLookup();
            begin
                if (Type = Type::Item) and ("No." <> '') then
                    NVM.LookupDrawingRevision("No.", "Revision No.", "Drawing No.", "Revision Date");
            end;

            trigger OnValidate();
            begin
                if "Revision No." = '' then begin
                    "Drawing No." := '';
                    "Revision Date" := 0D;
                end;
            end;
        }
        field(50012; "Revision Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            DataClassification = ToBeClassified;
            Description = 'AKK1606.01';
        }
        field(50803; "Is retention Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
        }
        field(50804; "Is Withholding Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
        }
        field(52000; "Country of Origin Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text";
        }
        field(52010; Manufacturer; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Manufacturer.Name;
        }

        field(50003; "Alt. Price"; Decimal)//14017672->50003 BC Upgrade 
        {
            DecimalPlaces = 2 : 5;
            trigger OnValidate()
            var
                ItemUOMRec2: Record "Item Unit of Measure";
            BEGIN
                IF ItemUOMRec2.GET("No.", "Alt. Price UOM") THEN BEGIN
                    VALIDATE("Line Discount Amount", 0);
                    VALIDATE("Direct Unit Cost", "Alt. Price" * ItemUOMRec2."Alt. Base Qty.");
                END;
                UpdateAmounts;
            end;
        }
        field(50004; "Alt. Price UOM"; Decimal)//14017673->50004 BC Upgrade 
        {
            Editable = false;
        }
        field(14017612; "Posting Date"; Date)
        {
        }
        field(14017613; "Purchaser Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Purchase = CONST(true));
        }
        field(14017614; "Vendor Shipment No"; Code[20])
        {
        }
        field(14017615; "Vendor Invoice No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header"."Vendor Invoice No." WHERE("No." = FIELD("Document No.")));
        }
        field(14017616; "Vendor Cr. Memo No."; Code[20])
        {
        }
        field(14017620; "Line Amount to Receive"; Decimal)
        {
            Editable = false;
        }
        field(14017621; "Line Amount to Invoice"; Decimal)
        {
            Editable = false;
        }
        field(14017633; "No;Line Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(14017640; "Ship-to PO No."; code[20])
        {
        }
        field(14017650; "Resource Group No."; code[20])
        {
            TableRelation = "Resource Group";
        }
        field(14017660; "Status"; Option)
        {
            OptionCaptionML = ENU = 'Open, Released';
            OptionMembers = Open,Released;
            Editable = false;
        }
        field(14017670; "Alt. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14017671; "Alt. Qty. UOM"; code[10])
        {
            Editable = false;
        }
        field(14017748; "Outstanding Gross Weight"; Decimal)
        {
        }
        field(14017749; "Outstanding Net Weight"; Decimal)
        {
        }
        field(14017750; "Line Gross Weight"; Decimal)
        {
        }
        field(14017751; "Line Net Weight"; Decimal)
        {
        }
        field(14017756; "Item Group Code"; code[10])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017761; "Prod. Kit Order No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(14017762; "Prod. Kit Order Line No."; Integer)
        {
            Editable = false;
        }
        field(14017930; "Rework No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017931; "Rework Line No."; Integer)
        {
        }
        field(14018070; "QC Hold"; Boolean)
        {
            Editable = false;
        }
        modify("Qty. to Invoice")
        {
            trigger OnAfterValidate()
            begin

                //>>NV4.33.01 08-20-04 RTT
                // set Qty. to Invoice on Item Tracking
                if CurrFieldNo <> 0 then  //NG-N System Make the Qty Zero on CM Post
                    UpdateItemTrackingLines(Rec);
                //<<NV4.33.01 08-20-04 RTT
            end;
        }
    }
    keys
    {
        key(SEESHIP; "Document Type", "Document No.", Type, "No.", "Variant Code", "Drop Shipment", "Location Code")
        {
            SumIndexFields = "Qty. to Receive (Base)", "Outstanding Qty. (Base)", "Return Qty. to Ship (Base)";
            MaintainSIFTIndex = false;
        }
    }
    procedure CheckParcelQty(var OrderQty: Decimal): Boolean;
    var
        Item: Record 27;
        OrderMultiple: Decimal;
        ParcelOrderQty: Decimal;
        ConfirmTxt1: Label 'Item %1 has a Standard Net Pack of %2 .\', Comment = '%1%2';
        ConfirmTxt2: Label 'A quantity of %3 %7 would create an even Pack quantity of %4.\\', Comment = '%3%7%4';
        ConfirmTxt3: Label 'Do you want to change the quantity from %5 to %6?', Comment = '%5%6';
    begin
        //function passes and returns qty through variable
        //also returns TRUE if qty was changed
        //if qty is zero, exit
        if OrderQty <= 1 then
            exit;

        //if no "Units per Parcel", then exit
        if "Units per Parcel" = 0 then
            exit;

        Item.GET("No.");
        OrderMultiple := "Units per Parcel";

        //if multiple divides qty cleanly, exit
        if OrderQty mod OrderMultiple = 0 then
            exit;

        //otherwise, propose new qty
        ParcelOrderQty := ((OrderQty div OrderMultiple) + 1) * OrderMultiple;

        //exit if not confirmed
        if not CONFIRM(
            STRSUBSTNO(ConfirmTxt1 +
                     ConfirmTxt2 +
                       ConfirmTxt3,

                         Item."No.", OrderMultiple,
                              ParcelOrderQty, ParcelOrderQty div OrderMultiple,
                                 OrderQty, ParcelOrderQty, Item."Base Unit of Measure"))
               then
            exit;


        //if confirmed, pass back new quantity
        OrderQty := ParcelOrderQty;

        exit(true);
    end;

    procedure UpdateItemTrackingLines(PurchLine: Record 39);
    var
        TrackingSpecification: Record "Tracking Specification";
        TrackingSpecificationTmp: Record "Tracking Specification" temporary;
        Item: Record Item;
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        ItemTrackingForm: Page "Item Tracking Lines";
        ModifyRecord: Boolean;
        QtyToInvoice: Decimal;
        RemQtyToInvoice: Decimal;
        LastEntryNo: Integer;
    begin
        if PurchLine.Type <> PurchLine.Type::Item then
            exit;

        Item.GET("No.");
        if Item."Item Tracking Code" = '' then
            exit;

        CLEAR(ReservePurchLine);
        CLEAR(ItemTrackingForm);
        CLEAR(ModifyRecord);
        CLEAR(LastEntryNo);
        ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
        ItemTrackingForm.SetSourceSpec(
           TrackingSpecification, PurchLine."Expected Receipt Date");
        ItemTrackingForm.NVOpenForm;

        CLEAR(ReservePurchLine);
        CLEAR(ItemTrackingForm);
        ReservePurchLine.InitTrackingSpecification(PurchLine, TrackingSpecification);
        ItemTrackingForm.SetSourceSpec(TrackingSpecification, PurchLine."Expected Receipt Date");

        ItemTrackingForm.NVOpenForm;
        TrackingSpecificationTmp.RESET();
        TrackingSpecificationTmp.DELETEALL();
        TrackingSpecificationTmp := TrackingSpecification;
        ItemTrackingForm.NVGetRecords(TrackingSpecificationTmp);

        if not TrackingSpecificationTmp.FIND('-') then
            exit;

        RemQtyToInvoice := PurchLine."Qty. to Invoice (Base)";

        repeat
            if RemQtyToInvoice >
              (TrackingSpecificationTmp."Quantity (Base)" - TrackingSpecificationTmp."Quantity Invoiced (Base)") then begin
                QtyToInvoice := TrackingSpecificationTmp."Quantity (Base)";
                RemQtyToInvoice := RemQtyToInvoice -
                      (TrackingSpecificationTmp."Quantity (Base)" - TrackingSpecificationTmp."Quantity Invoiced (Base)");
            end
            else begin
                QtyToInvoice := RemQtyToInvoice;
                RemQtyToInvoice := 0;
            end;

            TrackingSpecificationTmp."Qty. to Invoice (Base)" := QtyToInvoice;
            TrackingSpecificationTmp."Qty. to Invoice" := QtyToInvoice;
            ItemTrackingForm.NVModifyRecord(TrackingSpecificationTmp);

        until (TrackingSpecificationTmp.NEXT() = 0);

        ItemTrackingForm.NVCloseForm;
    end;

    procedure UpdateUSDValue();
    var
        CurrExchRate: Record "Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        MXNValue: Decimal;
    begin
        //NF1.00:CIS.RAM FOREX
        PurchHeader.GET("Document Type", "Document No.");
        Vendor.GET(PurchHeader."Pay-to Vendor No.");
        if Vendor."3 Way Currency Adjmt." then begin
            "USD Value" := 0;
            PurchHeader.TESTFIELD("Currency Factor");
            MXNValue := 0;
            MXNValue := CurrExchRate.ExchangeAmtFCYToLCY(
                  GetDate(), "Currency Code",
                  "Amount Including VAT", PurchHeader."Currency Factor");
            "USD Value" := CurrExchRate.ExchangeAmtFCYToFCY(
                  GetDate(), '', 'USD',
                  MXNValue);
        end;
        //NF1.00:CIS.RAM FOREX
    end;

    procedure CheckIfLineComments(): Boolean;
    var
        CommentLine: Record "Comment Line";
    begin
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.", "No.");
        //CommentLine.SETRANGE("Include in Purchase Orders", TRUE); //TODO
        exit(not CommentLine.IsEmpty());
    end;

    procedure DeleteLineComments();
    begin
        //>> NF1.00:CIS.CM 09-29-15
        //PurchLineCommentLine.RESET;
        //PurchLineCommentLine.SETRANGE("Document Type","Document Type");
        //PurchLineCommentLine.SETRANGE("No.","Document No.");
        //PurchLineCommentLine.SETRANGE("Doc. Line No.","Line No.");
        //PurchLineCommentLine.DELETEALL;
        //>> NF1.00:CIS.CM 09-29-15
    end;

    procedure InsertLineComments();
    var
        CommentLine: Record 97;
    begin
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.", "No.");
        //CommentLine.SETRANGE("Include in Purchase Orders", true); //TODO
        if CommentLine.FIND('-') then
            repeat
            //>> NF1.00:CIS.CM 09-29-15
            //PurchLineCommentLine.INIT;
            //PurchLineCommentLine."Document Type" := "Document Type";
            //PurchLineCommentLine."No." := "Document No.";
            //PurchLineCommentLine."Doc. Line No." := "Line No.";
            //PurchLineCommentLine."Line No." := CommentLine."Line No.";
            //PurchLineCommentLine.Code := CommentLine.Code;
            //PurchLineCommentLine.Comment := CommentLine.Comment;
            //PurchLineCommentLine."Print On Order" := CommentLine."Print On Purch. Order";
            //PurchLineCommentLine."Print On Receipt" := CommentLine."Print On Receipt";
            //PurchLineCommentLine."Print On Invoice" := CommentLine."Print On Purch. Invoice";
            //PurchLineCommentLine.INSERT(TRUE);
            //>> NF1.00:CIS.CM 09-29-15
            until CommentLine.NEXT() = 0;
    end;

    var
        NVM: Codeunit 50021;
        SoftBlockError: Text[80];
}
