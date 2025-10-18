page 50024 "Lot No. Information List_1"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  09-28-15 Update for New Vision Removal Task (Lot Entry Functionality)
    // >> ISD
    // Columns added:
    //   50050 Slab Block No.
    // 
    // Date     Init  SCR    Description
    // 01-17-04 MV    #9443  Added column 50050 "Slab Block No."
    // << ISD

    Caption = 'Lot No. Information List';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Source Location"; Rec."Source Location")
                {
                    ToolTip = 'Specifies the value of the Source Location field.';
                }
                field("CVE Pedimento"; Rec."CVE Pedimento")
                {
                    Visible = "CVE PedimentoVisible";
                    ToolTip = 'Specifies the value of the CVE Pedimento field.';
                }
                field("Mfg. Lot No."; Rec."Mfg. Lot No.")
                {
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Lot Creation Date"; Rec."Lot Creation Date")
                {
                    ToolTip = 'Specifies the value of the Lot Creation Date field.';
                }
                field("Passed Inspection"; Rec."Passed Inspection")
                {
                    ToolTip = 'Specifies the value of the Passed Inspection field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the value of the Inventory field.';
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
                field("Revision No."; Rec."Revision No.")
                {
                    ToolTip = 'Specifies the value of the Revision No. field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lot No. Info")
            {
                Caption = 'Lot No. Info';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 6505;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        "CVE PedimentoVisible" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //>>NIF 051206 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN
            "CVE PedimentoVisible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    var
        [InDataSet]
        "CVE PedimentoVisible": Boolean;
}

