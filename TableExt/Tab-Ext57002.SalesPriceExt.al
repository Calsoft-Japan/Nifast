tableextension 57002 "Sales Price Ext" extends "Sales Price"
{
    // version NAVW18.00,NV4.507,NIF1.104,CSI.001,NIF.N15.C9IN.001
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                //>>NV 091905 DRS  $09966 #10100
                IF "Contract No." <> '' THEN BEGIN
                    Contract.GET("Contract No.");
                    Contract.TESTFIELD("Customer No.");
                    Contract.TESTFIELD("Starting Date");
                    Contract.TESTFIELD("Ending Date");
                    VALIDATE("Sales Code", Contract."Customer No.");
                    "Starting Date" := Contract."Starting Date";
                    "Ending Date" := Contract."Ending Date";
                    "Minimum Quantity" := 1;
                    "Contract Customer No." := Contract."Customer No.";
                    "Contract Ship-to Code" := Contract."Ship-to Code";
                    "Contract Location Code" := Contract."Location Code";
                    "Contract Ship Location Code" := Contract."Shipping Location Code";
                    "ContractSelling Location Code" := Contract."Selling Location Code";
                    IF Contract."External Document No." <> '' THEN
                        "External Document No." := Contract."External Document No.";
                    VALIDATE("Unit of Measure Code", Item."Sales Unit of Measure");
                    "Allow Invoice Disc." := FALSE;
                    "Allow Line Disc." := FALSE;
                END;
                IF "Item No." <> '' THEN
                    CALCFIELDS("Item Description");
                //<<NV 011206 RTT  $10571 #10571
                "FB Order Type" := Contract."FB Order Type";
                "Replenishment Method" := Contract."Default Repl. Method";
                "Method of Fullfillment" := Contract."Def. Method of Fullfillment";
                //<<NV 011206 RTT  $10571 #10571
            end;
        }
        field(50000; "Customer Cross Ref No."; Code[30])
        {
            CalcFormula = Lookup("Item Reference"."Reference No." WHERE("Item No." = FIELD("Item No."),
                                                                                     "Reference Type" = CONST(Customer),
                                                                                     "Reference Type No." = FIELD("Sales Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Customer Cross Ref. Desc."; Text[50])
        {
            CalcFormula = Lookup("Item Reference".Description WHERE("Item No." = FIELD("Item No."),
                                                                                     "Reference Type" = CONST(Customer),
                                                                                     "Reference Type No." = FIELD("Sales Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Flow Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Lookup(Item."Unit Cost" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50003; "Flow Vendor No."; Code[10])
        {
            // cleaned
            CalcFormula = Lookup(Item."Vendor No." WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50005; "Revision No."; Code[10])
        {
            // cleaned
        }
        field(50010; "No. of Customer Bins"; Integer)
        {
            // cleaned
        }
        field(50011; "Default Customer Bin Code"; Code[20])
        {
            Description = 'Added on 07/30/15 by CIS.RAM';
        }

        /*   field(50004; "Contract No."; Code[20])//NV 14017645->50004 BC Upgrade
          { }
          field(50006; "Customer Bin"; Code[20])//NV 14017662->50006 BC Upgrade
          { } */
        field(14017614; "Alt. Price"; Decimal)
        {
            Description = 'NV';
            Editable = false;
        }
        field(14017615; "Alt. Price UOM"; Code[10])
        {
            Description = 'NV';
            Editable = false;
        }
        field(14017618; "External Document No."; Code[20])
        {
            Description = 'NV';
        }
        field(14017645; "Contract No."; Code[20])
        {
            Description = 'NV';
            TableRelation = "Price Contract";
        }
        field(14017646; "Item Description"; Text[50])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017647; "Est. Usage"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017648; Comments; Boolean)
        {
            CalcFormula = Exist("Sales Price Comment Line" WHERE("Item No." = FIELD("Item No."),
                                                                    "Sales Type" = FIELD("Sales Type"),
                                                                    "Sales Code" = FIELD("Sales Code"),
                                                                    "Starting Date" = FIELD("Starting Date"),
                                                                    "Currency Code" = FIELD("Currency Code"),
                                                                    "Variant Code" = FIELD("Variant Code"),
                                                                    "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                                   "Minimum Quantity" = FIELD("Minimum Quantity"),
                                                                    "Contract No." = FIELD("Contract No.")));
            Description = 'NV';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(14017649; "Contract Customer No."; Code[20])
        {
            Description = 'NV';
        }
        field(14017650; "Contract Ship-to Code"; Code[10])
        {
            Description = 'NV';
        }
        field(14017651; "Contract Location Code"; Code[10])
        {
            Description = 'NV';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                              "Rework Location" = CONST(false));
        }
        field(14017652; "Actual Usage"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Contract No." = FIELD("Contract No."),
                                                                     "Item No." = FIELD("Item No."),
                                                                     "Entry Type" = CONST(Sale)));
            DecimalPlaces = 0 : 5;
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017653; "Method of Fullfillment"; Option)
        {
            Description = 'NV';
            OptionCaption = 'Standard,FillBill';
            OptionMembers = Standard,FillBill;
        }
        field(14017654; "Min. Qty. on Hand"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017655; "Initial Stocking Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017656; "Blanket Orders"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = CONST("Blanket Order"),
                                                      "Contract No." = FIELD("Contract No."),
                                                      Type = CONST(Item),
                                                      "No." = FIELD("Item No.")));
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14017657; "Contract Ship Location Code"; Code[10])
        {
            Description = 'NV';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                              "Rework Location" = CONST(false));
        }
        field(14017658; "Replenishment Method"; Option)
        {
            Caption = 'Replenishment Method';
            Description = 'NV';
            OptionCaption = '" ,Automatic,Manual"';
            OptionMembers = " ",Automatic,Manual;
        }
        field(14017659; "Reorder Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017660; "Max. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017661; "Min. Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'NV';
        }
        field(14017662; "Customer Bin"; Code[20])
        {
            Description = 'NV';
        }
        field(14017663; "ContractSelling Location Code"; Code[10])
        {
            Description = 'NV';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                              "Rework Location" = CONST(false));
        }
        field(37015330; "FB Tags"; Boolean)
        {
            CalcFormula = Exist("FB Tag" WHERE("Customer No." = FIELD("Contract Customer No."),
                                                  "Ship-to Code" = FIELD("Contract Ship-to Code"),
                                                  "Item No." = FIELD("Item No."),
                                                  "Variant Code" = FIELD("Variant Code"),
                                                  "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                                  "Contract No." = FIELD("Contract No.")));
            Description = 'NV';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37015331; "FB Order Type"; Option)
        {
            Description = 'NV';
            OptionCaption = '" ,Consigned,Non-Consigned"';
            OptionMembers = " ",Consigned,"Non-Consigned";
        }
    }
    var
        Contract: Record 50110;
    //">>GV_NV": Integer;
    trigger OnDelete()
    begin
        //>>NV 092805 DRS  $09966 #10100
        //>>NF1.00:CIS.CM 09-29-15
        //PriceComments.SETRANGE("Item No.","Item No.");
        //PriceComments.SETRANGE("Sales Type","Sales Type");
        //PriceComments.SETRANGE("Sales Code","Sales Code");
        //PriceComments.SETRANGE("Starting Date","Starting Date");
        //PriceComments.SETRANGE("Currency Code","Currency Code");
        //PriceComments.SETRANGE("Variant Code","Variant Code");
        //PriceComments.SETRANGE("Unit of Measure Code","Unit of Measure Code");
        //PriceComments.SETRANGE("Minimum Quantity","Minimum Quantity");
        //PriceComments.SETRANGE("Contract No.","Contract No.");
        //PriceComments.DELETEALL;
        //<<NF1.00:CIS.CM 09-29-15
        //<<NV 092805 DRS  $09966 #10100
    end;

    PROCEDURE ">>FN_NV"();
    BEGIN
    END;

    PROCEDURE GetAltUOM();
    VAR
        ItemUOM: Record 5404;
    BEGIN
        ItemUOM.RESET();
        ItemUOM.SETRANGE("Item No.", "Item No.");
        ItemUOM.SETRANGE("Sales Qty Alt.", TRUE);
        IF ItemUOM.FIND('-') THEN BEGIN
            "Alt. Price UOM" := ItemUOM."Sales Price Per Alt.";
            IF ItemUOM."Sales Price Per Alt." <> '' THEN BEGIN
                ItemUOM.RESET;
                ItemUOM.GET("Item No.", ItemUOM."Sales Price Per Alt.");
                "Alt. Price" := "Unit Price" * ItemUOM."Qty. per Unit of Measure";

            END;
        END;
    END;

    PROCEDURE ShowLineComments();
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //LineCommentLine.SETRANGE("Item No.","Item No.");
        //LineCommentLine.SETRANGE("Sales Type","Sales Type");
        //LineCommentLine.SETRANGE("Sales Code","Sales Code");
        //LineCommentLine.SETRANGE("Starting Date","Starting Date");
        //LineCommentLine.SETRANGE("Currency Code","Currency Code");
        //LineCommentLine.SETRANGE("Variant Code","Variant Code");
        //LineCommentLine.SETRANGE("Unit of Measure Code","Unit of Measure Code");
        //LineCommentLine.SETRANGE("Minimum Quantity","Minimum Quantity");
        //LineCommentLine.SETRANGE("Contract No.","Contract No.");
        //CLEAR(LineCommentSheet);
        //LineCommentSheet.SETTABLEVIEW(LineCommentLine);
        //LineCommentSheet.RUNMODAL;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE ShowBlanketOrders();
    VAR
        SalesLine: Record 37;
        SalesLines: Page "Sales Lines";
    BEGIN
        CALCFIELDS("Blanket Orders");
        IF NOT "Blanket Orders" THEN
            EXIT;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Blanket Order");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", "Item No.");
        SalesLine.SETRANGE("Contract No.", "Contract No.");

        CLEAR(SalesLines);
        SalesLines.SETTABLEVIEW(SalesLine);
        SalesLines.RUNMODAL();
    END;
}
