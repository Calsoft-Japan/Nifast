page 50040 "Lot Qty. Inquiry"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field(ItemNoFilter; ItemNoFilter)
                {
                    Caption = 'Item Filter';
                    ToolTip = 'Specifies the value of the Item Filter field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(0, Item) = ACTION::LookupOK THEN
                            ItemNoFilter := Item."No."
                        ELSE
                            ItemNoFilter := '';

                        SetItemFilter();
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoFilterOnAfterValidate();
                    end;
                }
                field("Location Filter"; Rec."Location Filter")
                {
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field(InventoryOnly; InventoryOnly)
                {
                    Caption = 'Onhand Only';
                    ToolTip = 'Specifies the value of the Onhand Only field.';

                    trigger OnValidate()
                    begin
                        InventoryOnlyOnPush();
                    end;
                }
            }
            group(General)
            {
                Editable = false;
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Item.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(InLocationBinGross; Rec.InLocationBinGross())
                {
                    Caption = 'Location-Bin';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location-Bin field.';

                    trigger OnDrillDown()
                    begin
                        Rec.ShowBinContentBufferGross();
                    end;
                }
                field("Mfg. Lot No."; Rec."Mfg. Lot No.")
                {
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                }
                field("Lot Creation Date"; Rec."Lot Creation Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Lot Creation Date field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.';
                }
                field("Passed Inspection"; Rec."Passed Inspection")
                {
                    ToolTip = 'Specifies the value of the Passed Inspection field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lot &No.")
            {
                Caption = 'Lot &No.';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Lot No. Information Card";
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code"),
                                  "Lot No." = FIELD("Lot No.");
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Item &Tracking Entries action.';

                    trigger OnAction()
                    var
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                    begin
                        //TODO
                        //ItemTrackingMgt.CallItemTrackingEntryForm(0, '', Rec."Item No.", Rec."Variant Code", '', Rec."Lot No.", Rec."Location Filter");
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comment';
                    Image = Comment;
                    RunObject = Page "Item Tracking Comments";
                    RunPageLink = Type = CONST("Lot No."),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code"),
                                  "Serial/Lot No." = FIELD("Lot No.");
                    ToolTip = 'Executes the Comment action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Item.GET(Rec."Item No.") THEN
            CLEAR(Item);
    end;

    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID) THEN
            Rec.SETRANGE("Location Filter", UserSetup."Default Location Code")
        ELSE
            Rec.SETRANGE("Location Filter");

        Rec.SETRANGE(Inventory); //take filter off of onhand
        ItemNoFilter := Rec.GETFILTER("Item No.");
        MfgLotNoFilter := Rec.GETFILTER("Mfg. Lot No.");
        SetItemFilter();
        SetMfgLotNoFilter();
        GetQtyFilters();
    end;

    var
        Item: Record Item;
        UserSetup: Record "User Setup";
        InventoryFilter: Boolean;
        InventoryOnly: Boolean;
        ItemNoFilter: Code[100];
        MfgLotNoFilter: Code[100];

    procedure SetQtyFilters()
    begin
        IF NOT InventoryOnly THEN
            Rec.SETRANGE(Inventory)
        ELSE
            Rec.SETFILTER(Inventory, '<>0');
    end;

    procedure SetItemFilter()
    begin

        IF ItemNoFilter = '' THEN
            Rec.SETRANGE("Item No.")
        ELSE
            Rec.SETRANGE("Item No.", ItemNoFilter);

        CurrPage.UPDATE(FALSE);
    end;

    procedure SetMfgLotNoFilter()
    begin

        IF MfgLotNoFilter = '' THEN
            Rec.SETRANGE("Mfg. Lot No.")
        ELSE
            Rec.SETRANGE("Mfg. Lot No.", MfgLotNoFilter);

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetQtyFilters()
    begin

        InventoryFilter := (Rec.GETFILTER(Inventory) <> '');
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        IF ItemNoFilter <> '' THEN
            IF NOT Item.GET(ItemNoFilter) THEN
                ERROR('Invalid Item No. %1', ItemNoFilter);

        SetItemFilter();
    end;

    local procedure InventoryOnlyOnPush()
    begin
        SetQtyFilters();
    end;
}

