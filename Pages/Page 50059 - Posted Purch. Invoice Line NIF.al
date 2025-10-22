page 50059 "Posted Purch. Invoice Line NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    Caption = 'Posted Purch. Invoice Line NIF';
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purch. Inv. Line";
    SourceTableView = SORTING("Posting Date", Type, "No.", "Buy-from Vendor No.");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(GetOrderNo; GetOrderNos())
                {
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Visible = false;
                    Caption = 'Cross-Reference No.';
                    ToolTip = 'Specifies the value of the Cross-Reference No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    Caption = 'Variant Code';
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    Caption = 'Return Reason Code';
                    ToolTip = 'Specifies the value of the Return Reason Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    Caption = 'Unit of Measure';
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    Caption = 'Direct Unit Cost';
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    Caption = 'Indirect Cost %';
                    ToolTip = 'Specifies the value of the Indirect Cost % field.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    Caption = 'Unit Cost (LCY)';
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field.';
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    Visible = false;
                    Caption = 'Unit Price (LCY)';
                    ToolTip = 'Specifies the value of the Unit Price (LCY) field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Caption = 'Line Amount';
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Caption = 'Line Discount %';
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    Caption = 'Line Discount Amount';
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    Caption = 'Allow Invoice Disc.';
                    ToolTip = 'Specifies the value of the Allow Invoice Disc. field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    Caption = 'Project No.';
                    ToolTip = 'Specifies the value of the Project No. field.';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    Visible = false;
                    Caption = 'Insurance No.';
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    Visible = false;
                    Caption = 'Budgeted FA No.';
                    ToolTip = 'Specifies the value of the Budgeted FA No. field.';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    Visible = false;
                    Caption = 'FA Posting Type';
                    ToolTip = 'Specifies the value of the FA Posting Type field.';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Visible = false;
                    Caption = 'Depr. until FA Posting Date';
                    ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Visible = false;
                    Caption = 'Depreciation Book Code';
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                }
                field("Alt. Quantity"; Rec."Alt. Quantity")
                {
                    Caption = 'Alt. Quantity';
                    ToolTip = 'Specifies the value of the Alt. Quantity field.';
                }
                field("Alt. Qty. UOM"; Rec."Alt. Qty. UOM")
                {
                    Caption = 'Alt. Qty. UOM';
                    ToolTip = 'Specifies the value of the Alt. Qty. UOM field.';
                }
                field("Alt. Price"; Rec."Alt. Price")
                {
                    Caption = 'Alt. Price';
                    ToolTip = 'Specifies the value of the Alt. Price field.';
                }
                field("Alt. Price UOM"; Rec."Alt. Price UOM")
                {
                    Caption = 'Alt. Price UOM';
                    ToolTip = 'Specifies the value of the Alt. Price UOM field.';
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    Visible = false;
                    Caption = 'Depr. Acquisition Cost';
                    ToolTip = 'Specifies the value of the Depr. Acquisition Cost field.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    Caption = 'Appl.-to Item Entry';
                    ToolTip = 'Specifies the value of the Appl.-to Item Entry field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    Caption = 'Units per Parcel';
                    ToolTip = 'Specifies the value of the Units per Parcel field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(GetSourceName; GetSourceNames())
                {
                    Caption = 'Vendor';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Vendor field.';
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
                    ToolTip = 'Executes the Card action.';

                    trigger OnAction()
                    begin
                        PurchInvHdr.GET(Rec."Document No.");
                        PurchInvHdrForm.SETRECORD(PurchInvHdr);
                        PurchInvHdrForm.RUN();
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction()
                    begin
                        IF Rec."Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Purchase Invoice Statistics", Rec, Rec."No.")
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Purchase Invoice Stats.", Rec, Rec."No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';

                }
                action(Dimensionss)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action("E-&Mail List")
                {
                    Caption = 'E-&Mail List';
                    Image = Email;
                    ToolTip = 'Executes the E-&Mail List action.';

                    trigger OnAction()
                    var
                        EMailListEntry: Record "LAX E-Mail List Entry";
                    begin
                        EMailListEntry.RESET();
                        EMailListEntry.SETRANGE("Table ID", DATABASE::"Purch. Inv. Header");
                        EMailListEntry.SETRANGE(Code, Rec."No.");
                        PAGE.RUNMODAL(PAGE::"E-Mail List Entries", EMailListEntry);
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
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'Executes the Item &Tracking Entries action.';

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines();
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
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Navigate action.';

                trigger OnAction()
                begin
                    PurchInvHdr.GET(Rec."Document No.");
                    PurchInvHdr.Navigate();
                end;
            }
        }
    }

    var
        PurchInvHdr: Record "Purch. Inv. Header";
        PurchInvHdrForm: Page "Posted Purchase Invoice";

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;

    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines();
    end;

    procedure ShowLineComments(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Posted Invoice","Posted Credit Memo","Posted Return Shipment")
    begin
        Rec.ShowLineComments();
    end;

    procedure GetOrderNos(): Code[20]
    begin
        IF NOT PurchInvHdr.GET(Rec."Document No.") THEN
            EXIT('')
        ELSE
            EXIT(PurchInvHdr."Order No.");
    end;

    procedure GetSourceNames(): Text[50]
    begin
        IF NOT PurchInvHdr.GET(Rec."Document No.") THEN
            EXIT('')
        ELSE
            EXIT(PurchInvHdr."Buy-from Vendor Name");
    end;
}

