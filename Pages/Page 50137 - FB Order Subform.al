page 50137 "FB Order Subform"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)
    // RTT 12-13-05 set AutoSplitKey to Yes
    //              code at OnNewRecord to copy down Replenishment method

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = Table50137;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Tag No.";"Tag No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("Customer Bin";"Customer Bin")
                {
                }
                field(Status;Status)
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Replenishment Method";"Replenishment Method")
                {
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
        IF xRec."Line No."=0 THEN
          IF FBHeader.GET("Document No.") THEN BEGIN
            "Order Date" := FBHeader."Order Date";
            "Sell-to Customer No." := FBHeader."Sell-to Customer No.";
            "Ship-To Code" := FBHeader."Ship-To Code";
            "Location Code" := FBHeader."Location Code";
            "FB Order Type" := FBHeader."FB Order Type";
            "External Document No." := FBHeader."External Document No.";
            "Salesperson Code" := FBHeader."Salesperson Code";
            "Inside Salesperson Code" := FBHeader."Inside Salesperson Code";
            "Selling Location" := FBHeader."Selling Location";
            "Shipping Location" := FBHeader."Shipping Location";
            "Contract No." := FBHeader."Contract No.";
          END;
        //<< NIF 010606 RTT
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF FBHeader.GET("Document No.") THEN BEGIN
          "Order Date" := FBHeader."Order Date";
          "Sell-to Customer No." := FBHeader."Sell-to Customer No.";
          "Ship-To Code" := FBHeader."Ship-To Code";
          "Location Code" := FBHeader."Location Code";
          "FB Order Type" := FBHeader."FB Order Type";
          "External Document No." := FBHeader."External Document No.";
          "Salesperson Code" := FBHeader."Salesperson Code";
          "Inside Salesperson Code" := FBHeader."Inside Salesperson Code";
          "Selling Location" := FBHeader."Selling Location";
          "Shipping Location" := FBHeader."Shipping Location";
          "Contract No." := FBHeader."Contract No.";
        //>> NIF
          "Replenishment Method" := xRec."Replenishment Method";
        //<< NIF
        END;
    end;

    var
        FBManagement: Codeunit "50133";
        FBHeader: Record "50136";
}

