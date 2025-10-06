page 50040 "Lot Qty. Inquiry"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Table6505;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field(ItemNoFilter;ItemNoFilter)
                {
                    Caption = 'Item Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(0,Item)= ACTION::LookupOK THEN
                          ItemNoFilter := Item."No."
                        ELSE
                          ItemNoFilter := '';

                        SetItemFilter;
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoFilterOnAfterValidate;
                    end;
                }
                field("Location Filter";"Location Filter")
                {
                }
                field(InventoryOnly;InventoryOnly)
                {
                    Caption = 'Onhand Only';

                    trigger OnValidate()
                    begin
                        InventoryOnlyOnPush;
                    end;
                }
            }
            repeater()
            {
                Editable = false;
                field("Lot No.";"Lot No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field(Item.Description;Item.Description)
                {
                    Caption = 'Description';
                }
                field(InLocationBinGross;InLocationBinGross)
                {
                    Caption = 'Location-Bin';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ShowBinContentBufferGross;
                    end;
                }
                field("Mfg. Lot No.";"Mfg. Lot No.")
                {
                }
                field("Lot Creation Date";"Lot Creation Date")
                {
                    Visible = false;
                }
                field(Inventory;Inventory)
                {
                }
                field("Passed Inspection";"Passed Inspection")
                {
                }
                field(Blocked;Blocked)
                {
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
                    RunObject = Page 6505;
                    RunPageLink = Item No.=FIELD(Item No.),
                                  Variant Code=FIELD(Variant Code),
                                  Lot No.=FIELD(Lot No.);
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                }
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    var
                        ItemTrackingMgt: Codeunit "6500";
                    begin
                        ItemTrackingMgt.CallItemTrackingEntryForm(0,'',"Item No.","Variant Code",'',"Lot No.","Location Filter");
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comment';
                    RunObject = Page 6506;
                    RunPageLink = Type=CONST(Lot No.),
                                  Item No.=FIELD(Item No.),
                                  Variant Code=FIELD(Variant Code),
                                  Serial/Lot No.=FIELD(Lot No.);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Item.GET("Item No.") THEN
         CLEAR(Item);
    end;

    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID) THEN
          SETRANGE("Location Filter",UserSetup."Default Location Code")
        ELSE
          SETRANGE("Location Filter");

        SETRANGE(Inventory); //take filter off of onhand
        ItemNoFilter := GETFILTER("Item No.");
        MfgLotNoFilter := GETFILTER("Mfg. Lot No.");
        SetItemFilter;
        SetMfgLotNoFilter;
        GetQtyFilters;
    end;

    var
        InventoryFilter: Boolean;
        PendingFilter: Boolean;
        InventoryOnly: Boolean;
        Item: Record "27";
        ItemNoFilter: Code[100];
        MfgLotNoFilter: Code[100];
        UserSetup: Record "91";

    procedure SetQtyFilters()
    begin
        IF NOT InventoryOnly THEN
           SETRANGE(Inventory)
        ELSE
           SETFILTER(Inventory,'<>0');
    end;

    procedure SetItemFilter()
    begin

        IF ItemNoFilter='' THEN
         SETRANGE("Item No.")
        ELSE
         SETRANGE("Item No.",ItemNoFilter);

        CurrPage.UPDATE(FALSE);
    end;

    procedure SetMfgLotNoFilter()
    begin

        IF MfgLotNoFilter='' THEN
         SETRANGE("Mfg. Lot No.")
        ELSE
         SETRANGE("Mfg. Lot No.",MfgLotNoFilter);

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetQtyFilters()
    begin

        InventoryFilter := (GETFILTER(Inventory)<>'');
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        IF ItemNoFilter<>'' THEN
         IF NOT Item.GET(ItemNoFilter) THEN
           ERROR('Invalid Item No. %1',ItemNoFilter);

        SetItemFilter;
    end;

    local procedure InventoryOnlyOnPush()
    begin
        SetQtyFilters;
    end;
}

