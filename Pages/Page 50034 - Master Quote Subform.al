page 50034 "Master Quote Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Contract Quote Subform';
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = Table38;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                    Lookup = true;
                    TableRelation = "Purchase Header".No.;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PurchHeader.SETRANGE("No.", "No.");
                        PAGE.RUNMODAL(49, PurchHeader);
                    end;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("Order Date";"Order Date")
                {
                }
                field("Document Date";"Document Date")
                {
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field(Status;Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        TransferExtendedText: Codeunit "378";
        ShortcutDimCode: array [8] of Code[20];
        LDec: array [20] of Decimal;
        LDate: array [10] of Date;
        LocationItem: Record "27";
        LineItem: Record "27";
        PurchHeader: Record "38";

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
    var
        SalesHeader: Record "36";
        SalesOrder: Page "42";
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
    var
        TrackingForm: Page "99000822";
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
    var
        SalesHeader: Record "36";
        SalesOrder: Page "42";
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

