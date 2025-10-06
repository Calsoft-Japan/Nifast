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
    SourceTable = Table6505;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Item No.";"Item No.")
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Source Location";"Source Location")
                {
                }
                field("CVE Pedimento";"CVE Pedimento")
                {
                    Visible = "CVE PedimentoVisible";
                }
                field("Mfg. Lot No.";"Mfg. Lot No.")
                {
                }
                field("Vendor No.";"Vendor No.")
                {
                }
                field("Lot Creation Date";"Lot Creation Date")
                {
                }
                field("Passed Inspection";"Passed Inspection")
                {
                }
                field(Blocked;Blocked)
                {
                }
                field(Comment;Comment)
                {
                }
                field(Inventory;Inventory)
                {
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
                field("Revision No.";"Revision No.")
                {
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
        IF STRPOS(COMPANYNAME,'Mexi')=0 THEN
          "CVE PedimentoVisible" := FALSE;
        //<<NIF 051206 RTT #10775
    end;

    var
        [InDataSet]
        "CVE PedimentoVisible": Boolean;
}

