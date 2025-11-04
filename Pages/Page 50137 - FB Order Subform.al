page 50137 "FB Order Subform"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // RTT 12-13-05 set AutoSplitKey to Yes
    //              code at OnNewRecord to copy down Replenishment method

    AutoSplitKey = true;
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = none;
    SourceTable = "FB Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tag No."; Rec."Tag No.")
                {
                    ToolTip = 'Specifies the value of the Tag No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Customer Bin"; Rec."Customer Bin")
                {
                    ToolTip = 'Specifies the value of the Customer Bin field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Replenishment Method"; Rec."Replenishment Method")
                {
                    ToolTip = 'Specifies the value of the Replenishment Method field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //>> NIF 010606 RTT
        IF xRec."Line No." = 0 THEN
            IF FBHeader.GET(Rec."Document No.") THEN BEGIN
                Rec."Order Date" := FBHeader."Order Date";
                Rec."Sell-to Customer No." := FBHeader."Sell-to Customer No.";
                Rec."Ship-To Code" := FBHeader."Ship-To Code";
                Rec."Location Code" := FBHeader."Location Code";
                Rec."FB Order Type" := FBHeader."FB Order Type";
                Rec."External Document No." := FBHeader."External Document No.";
                Rec."Salesperson Code" := FBHeader."Salesperson Code";
                Rec."Inside Salesperson Code" := FBHeader."Inside Salesperson Code";
                Rec."Selling Location" := FBHeader."Selling Location";
                Rec."Shipping Location" := FBHeader."Shipping Location";
                Rec."Contract No." := FBHeader."Contract No.";
            END;
        //<< NIF 010606 RTT
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF FBHeader.GET(Rec."Document No.") THEN BEGIN
            Rec."Order Date" := FBHeader."Order Date";
            Rec."Sell-to Customer No." := FBHeader."Sell-to Customer No.";
            Rec."Ship-To Code" := FBHeader."Ship-To Code";
            Rec."Location Code" := FBHeader."Location Code";
            Rec."FB Order Type" := FBHeader."FB Order Type";
            Rec."External Document No." := FBHeader."External Document No.";
            Rec."Salesperson Code" := FBHeader."Salesperson Code";
            Rec."Inside Salesperson Code" := FBHeader."Inside Salesperson Code";
            Rec."Selling Location" := FBHeader."Selling Location";
            Rec."Shipping Location" := FBHeader."Shipping Location";
            Rec."Contract No." := FBHeader."Contract No.";
            //>> NIF
            Rec."Replenishment Method" := xRec."Replenishment Method";
            //<< NIF
        END;
    end;

    var
        FBHeader: Record "FB Header";
}

