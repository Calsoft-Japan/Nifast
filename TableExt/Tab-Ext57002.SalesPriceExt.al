tableextension 57002 "Sales Price Ext" extends "Sales Price"
{
    // version NAVW18.00,NV4.507,NIF1.104,CSI.001,NIF.N15.C9IN.001
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
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
                    VALIDATE("Unit of Measure Code", Item."Sales Unit of Measure");
                    "Allow Invoice Disc." := FALSE;
                    "Allow Line Disc." := FALSE;
                END;
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

        field(50004; "Contract No."; Code[20])//NV 14017645->50004 BC Upgrade
        { }
        field(50006; "Customer Bin"; Code[20])//NV 14017662->50006 BC Upgrade
        { }
    }
    var
        ">>GV_NV": Integer;
        Contract: Record 50110;

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
}
