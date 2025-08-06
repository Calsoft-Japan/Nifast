pageextension 50050 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        modify("Buy-from Vendor Name")
        {
            Editable = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Buy-from Vendor Name 2"; Rec."Buy-from Vendor Name 2")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Buy-from Post Code"; "Buy-from Country/Region Code", "Buy-from Contact No.")
        modify("Currency Code")
        {
            StyleExpr = StyeExpr;
        }
        moveafter("Document Date"; "Order Address Code", "Requested Receipt Date", "Promised Receipt Date", "Responsibility Center", "Shortcut Dimension 1 Code", "Location Code", "Currency Code")
        moveafter("Purchaser Code"; "Your Reference", "On Hold", Status)
        addafter(Status)
        {
            field("Contract Note No."; Rec."Contract Note No.")
            {
                ApplicationArea = All;
                Editable = FALSE;
            }
        }
        moveafter("Contract Note No."; "Quote No.", "Vendor Order No.", "Vendor Shipment No.")
        addafter("Vendor Shipment No.")
        {
            field("Assembly Order No."; Rec."Assembly Order No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Job Queue Status"; "No. of Archived Versions")
        addafter("Pay-to Name")
        {
            field("Pay-to Name 2"; Rec."Pay-to Name 2")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Pay-to Post Code"; "Pay-to Country/Region Code", "Pay-to Contact No.")
        moveafter("Pay-to Contact"; "Vendor Order No.")
        moveafter("Tax Exemption No."; "Responsibility Center")
        moveafter("Creditor No."; "IRS 1099 Code")
        movefirst("Shipping and Payment"; "Sell-to Customer No.", "Ship-to Code")
        moveafter("Ship-to Post Code"; "Ship-to Country/Region Code")
        moveafter("Location Code"; "Shipment Method Code")
        addafter("Promised Receipt Date")
        {
            field("Sail-on Date"; Rec."Sail-on Date")
            {
                ApplicationArea = All;
            }
            field("Vessel Name"; Rec."Vessel Name")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Expected Receipt Date"; "Ship-to UPS Zone")
        addafter("Currency Code")
        {
            field("Ship by Date"; Rec."Ship by Date")
            {
                ApplicationArea = All;
            }
            field("Patente Orignal"; rec."Patente Orignal")
            {
                ApplicationArea = All;
                Visible = "Patente OrignalVisible";
            }
            field("Aduana E/S"; Rec."Aduana E/S")
            {
                ApplicationArea = All;
                Visible = "Aduana E/SVisible";
            }
            field("Pediment No."; Rec."Pediment No.")
            {
                ApplicationArea = All;
                Visible = "Pediment No.Visible";
            }
            field("CVE Pedimento"; Rec."CVE Pedimento")
            {
                ApplicationArea = All;
                Visible = "CVE PedimentoVisible";
            }
            field("Fecha de entrada"; Rec."Fecha de entrada")
            {
                ApplicationArea = All;
                Visible = "Fecha de entradaVisible";
            }
            field("Tipo Cambio (USD)"; Rec."Tipo Cambio (USD)")
            {
                ApplicationArea = All;
                Visible = "Tipo Cambio (USD)Visible";
                Editable = "Tipo Cambio (USD)Editable";
            }
            field("Tipo Cambio (JPY)"; rec."Tipo Cambio (JPY)")
            {
                ApplicationArea = All;
                Visible = "Tipo Cambio (JPY)Visible";
                Editable = "Tipo Cambio (JPY)Editable";
            }
            field("Currency Factor"; rec."Currency Factor")
            {
                ApplicationArea = All;
                DecimalPlaces = 0 : 5;
                Visible = "Currency FactorVisible";
            }
        }
        moveafter("Area"; "Entry Point")
        addafter("Entry Point")
        {
            field("Entry/Exit No."; rec."Entry/Exit No.")
            {
                ApplicationArea = All;
            }
            field("Entry/Exit Date"; rec."Entry/Exit Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("F&unctions")
        {
            action("&Lot Entry")
            {
                CaptionML = ENU = '&Lot Entry';
                trigger OnAction()
                VAR
                    LotEntry: Record 50002;
                BEGIN
                    LotEntry.GetPurchLines(LotEntry."Document Type"::"Purchase Order", Rec."No.");
                    COMMIT;
                    LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Purchase Order");
                    LotEntry.SETRANGE("Document No.", Rec."No.");
                    PAGE.RUNMODAL(0, LotEntry);
                    CLEAR(LotEntry);
                end;
            }
        }
        addbefore(Approval)
        {
            action("PO Comment Import")
            {
                CaptionML = ENU = 'PO Comment Import';
                RunObject = XMLport 50016;
            }
            action("PO Import")
            {
                CaptionML = ENU = 'PO Import';
                RunObject = XMLport 50015
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wPedido := Rec."No.";
                wTipoDoc := Rec."Document Type";
                fValida;
                //+AKK1606.01++
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wPedido := Rec."No.";
                wTipoDoc := Rec."Document Type";
                fValida;
                //+AKK1606.01++
            end;
        }
    }
    var
        "//AKK1606.01--": Integer;
        wPedido: Code[20];
        //wTipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        wTipoDoc: Enum "Purchase Document Type";
        "//AKK1606.01++": Integer;
        StyeExpr: Text;
        ReopenButtonVsible: Boolean;
        "Patente OrignalVisible": Boolean;
        "Aduana E/SVisible": Boolean;
        "Pediment No.Visible": Boolean;
        "CVE PedimentoVisible": Boolean;
        "Fecha de entradaVisible": Boolean;
        "Tipo Cambio (USD)Visible": Boolean;
        "Tipo Cambio (JPY)Visible": Boolean;
        "Currency FactorVisible": Boolean;
        "Tipo Cambio (USD)Editable": Boolean;
        "Tipo Cambio (JPY)Editable": Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        "Currency FactorVisible" := TRUE;
        "Tipo Cambio (JPY)Visible" := TRUE;
        "Tipo Cambio (USD)Visible" := TRUE;
        "Fecha de entradaVisible" := TRUE;
        "CVE PedimentoVisible" := TRUE;
        "Pediment No.Visible" := TRUE;
        "Aduana E/SVisible" := TRUE;
        "Patente OrignalVisible" := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord_;
        //>> NIF 03-23-06 RTT
        IF Rec."Currency Code" <> 'USD' THEN
            StyeExpr := 'StrongAccent'
        ELSE
            StyeExpr := '';
        //<< NIF 03-23-06 RTT
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord_
    end;

    LOCAL PROCEDURE OnAfterGetCurrRecord_();
    VAR
        NIF_LV: Integer;
        GLSetup: Record 98;
    BEGIN
        xRec := Rec;
        //>>NIF 040406 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN BEGIN
            "Patente OrignalVisible" := FALSE;
            "Aduana E/SVisible" := FALSE;
            "Pediment No.Visible" := FALSE;
            "CVE PedimentoVisible" := FALSE;
            "Fecha de entradaVisible" := FALSE;
            //CurrForm."Tipo Cambio (1 day before)".VISIBLE(FALSE);
            "Tipo Cambio (USD)Visible" := FALSE;
            "Tipo Cambio (JPY)Visible" := FALSE;
            "Currency FactorVisible" := FALSE;
        END ELSE BEGIN
            GLSetup.GET;
            "Tipo Cambio (USD)Editable" := Rec."Currency Code" <> GLSetup."LCY Code";
            "Tipo Cambio (JPY)Editable" := (rec."Currency Code" <> GLSetup."LCY Code") AND (rec."Currency Code" <> GLSetup."Additional Reporting Currency");
        END;
        //<<NIF 040406 RTT #10775
    END;

    PROCEDURE fValida();
    VAR
        rLineas: Record 39;
    BEGIN
        //   //-AKK1606.01--
        //   {
        //   rLineas.RESET;
        //     rLineas.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        //     rLineas.SETRANGE("Document Type", wTipoDoc);
        //     rLineas.SETRANGE("Document No.", wPedido);
        //     rLineas.SETRANGE(Type, rLineas.Type::Item);
        //     rLineas.SETRANGE(National, FALSE);
        //     IF rLineas.FINDSET THEN BEGIN
        //         REPEAT
        //             rLineas.TESTFIELD("Entry Point");
        //             rLineas.TESTFIELD("Entry/Exit No.");
        //             rLineas.TESTFIELD("Entry/Exit Date");
        //         UNTIL rLineas.NEXT = 0;
        //     END;
        //   //+AKK1606.01++
        //   }
    END;
}