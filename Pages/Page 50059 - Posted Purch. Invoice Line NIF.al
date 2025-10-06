page 50059 "Posted Purch. Invoice Line NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Posted Purch. Invoice Line NIF';
    Editable = false;
    PageType = List;
    SourceTable = Table123;
    SourceTableView = SORTING(Posting Date,Type,No.,Buy-from Vendor No.);

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Posting Date";"Posting Date")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field(GetOrderNo;GetOrderNo)
                {
                    Caption = 'Order No.';
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Variant Code";"Variant Code")
                {
                    Visible = false;
                }
                field(Description;Description)
                {
                }
                field("Return Reason Code";"Return Reason Code")
                {
                    Visible = false;
                }
                field(Quantity;Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Visible = false;
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                    BlankZero = true;
                }
                field("Indirect Cost %";"Indirect Cost %")
                {
                    Visible = false;
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Unit Price (LCY)";"Unit Price (LCY)")
                {
                    Visible = false;
                }
                field("Line Amount";"Line Amount")
                {
                    BlankZero = true;
                }
                field("Line Discount %";"Line Discount %")
                {
                    BlankZero = true;
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Job No.";"Job No.")
                {
                    Visible = false;
                }
                field("Insurance No.";"Insurance No.")
                {
                    Visible = false;
                }
                field("Budgeted FA No.";"Budgeted FA No.")
                {
                    Visible = false;
                }
                field("FA Posting Type";"FA Posting Type")
                {
                    Visible = false;
                }
                field("Depr. until FA Posting Date";"Depr. until FA Posting Date")
                {
                    Visible = false;
                }
                field("Depreciation Book Code";"Depreciation Book Code")
                {
                    Visible = false;
                }
                field("Alt. Quantity";"Alt. Quantity")
                {
                }
                field("Alt. Qty. UOM";"Alt. Qty. UOM")
                {
                }
                field("Alt. Price";"Alt. Price")
                {
                }
                field("Alt. Price UOM";"Alt. Price UOM")
                {
                }
                field("Depr. Acquisition Cost";"Depr. Acquisition Cost")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry";"Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Units per Parcel";"Units per Parcel")
                {
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(GetSourceName;GetSourceName)
                {
                    Caption = 'Vendor';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        PurchInvHdr.GET("Document No.");
                        PurchInvHdrForm.SETRECORD(PurchInvHdr);
                        PurchInvHdrForm.RUN;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        IF "Tax Area Code" = '' THEN
                          PAGE.RUNMODAL(PAGE::"Purchase Invoice Statistics",Rec,"No.")
                        ELSE
                          PAGE.RUNMODAL(PAGE::"Purchase Invoice Stats.",Rec,"No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = Document Type=CONST(Posted Invoice),
                                  No.=FIELD(No.);
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("E-&Mail List")
                {
                    Caption = 'E-&Mail List';

                    trigger OnAction()
                    var
                        EMailListEntry: Record "14000908";
                    begin
                        EMailListEntry.RESET;
                        EMailListEntry.SETRANGE("Table ID",DATABASE::"Purch. Inv. Header");
                        EMailListEntry.SETRANGE(Code,"No.");
                        PAGE.RUNMODAL(PAGE::"E-Mail List Entries",EMailListEntry);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PurchInvHdr.GET("Document No.");
                    PurchInvHdr.Navigate;
                end;
            }
        }
    }

    var
        PurchInvHdr: Record "122";
        PurchInvHdrForm: Page "138";

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;

    procedure ShowLineComments(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Posted Invoice","Posted Credit Memo","Posted Return Shipment")
    begin
        Rec.ShowLineComments;
    end;

    procedure GetOrderNo(): Code[20]
    begin
        IF NOT PurchInvHdr.GET("Document No.") THEN
          EXIT('')
        ELSE
          EXIT(PurchInvHdr."Order No.");
    end;

    procedure GetSourceName(): Text[50]
    begin
        IF NOT PurchInvHdr.GET("Document No.") THEN
          EXIT('')
        ELSE
          EXIT(PurchInvHdr."Buy-from Vendor Name");
    end;
}

