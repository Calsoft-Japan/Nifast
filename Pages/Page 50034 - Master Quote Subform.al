page 50034 "Master Quote Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Contract Quote Subform';
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Lookup = true;
                    TableRelation = "Purchase Header"."No.";
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PurchHeader.SETRANGE("No.", Rec."No.");
                        PAGE.RUNMODAL(Page::"Purchase Quote", PurchHeader);
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location where the items are to be placed when they are received. This field acts as the default location for new lines. You can update the location code for individual lines as needed.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
            }
        }
    }

    actions
    {
    }

    var
        PurchHeader: Record "Purchase Header";

    procedure ApproveCalcInvDisc()
    begin
    end;

    procedure CalcInvDisc()
    begin
    end;

    procedure ExplodeBOM()
    begin
    end;

    procedure GetPhaseTaskStep()
    begin
    end;

    procedure OpenSalesOrderForm()
    begin
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
    end;

    procedure ShowReservation()
    begin
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
    end;

    procedure ShowReservationEntries()
    begin
    end;

    procedure ShowTracking()
    begin
    end;

    procedure ShowDimensions()
    begin
    end;

    procedure ItemChargeAssgnt()
    begin
    end;

    procedure OpenItemTrackingLines()
    begin
    end;

    procedure OpenSpecOrderSalesOrderForm()
    begin
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
    end;

    procedure ShowItemVendors()
    begin
    end;

    procedure ShowLineItemAvail()
    begin
    end;

    procedure ShowLocationItemAvail()
    begin
    end;

    procedure ShowLineComments(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Posted Invoice","Posted Credit Memo","Posted Return Shipment")
    begin
    end;
}

