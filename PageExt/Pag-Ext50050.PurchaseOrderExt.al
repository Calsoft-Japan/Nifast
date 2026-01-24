pageextension 50050 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Buy-from County")
        {
            Caption = 'Buy-from State / ZIP Code';
        }
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from ZIP Code';
        }
        modify("Pay-to County")
        {
            Caption = 'State / ZIP Code';
        }
        modify("Pay-to Post Code")
        {
            Caption = 'ZIP Code';
        }
        modify("Buy-from Vendor Name")
        {
            Editable = false;
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
                ToolTip = 'Specifies the value of the Contract Note No. field.';
            }
        }
        moveafter("Contract Note No."; "Quote No.", "Vendor Order No.", "Vendor Shipment No.")
        addafter("Vendor Shipment No.")
        {
            field("Assembly Order No."; Rec."Assembly Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assembly Order No. field.';
            }
        }
        moveafter("Job Queue Status"; "No. of Archived Versions")
        moveafter("Pay-to Post Code"; "Pay-to Country/Region Code", "Pay-to Contact No.")
        moveafter("Pay-to Contact"; "Vendor Order No.")
        moveafter("Tax Exemption No."; "Responsibility Center")
        moveafter("Creditor No."; "IRS 1099 Code")
        movefirst("Shipping and Payment"; "Sell-to Customer No.", "Ship-to Code")
        moveafter("Ship-to Post Code"; "Ship-to Country/Region Code")
        //moveafter("Location Code"; "Shipment Method Code")
        addafter("Promised Receipt Date")
        {
            field("Sail-on Date"; Rec."Sail-on Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sail-on Date field.';
            }
            field("Vessel Name"; Rec."Vessel Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vessel Name field.';
            }
        }
        moveafter("Expected Receipt Date"; "Ship-to UPS Zone")
        addafter("Currency Code")
        {
            field("Ship by Date"; Rec."Ship by Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ship by Date field.';
            }
            field("Patente Orignal"; rec."Patente Orignal")
            {
                ApplicationArea = All;
                Visible = "Patente OrignalVisible";
                ToolTip = 'Specifies the value of the Patente Orignal field.';
            }
            field("Aduana E/S"; Rec."Aduana E/S")
            {
                ApplicationArea = All;
                Visible = "Aduana E/SVisible";
                ToolTip = 'Specifies the value of the Aduana E/S field.';
            }
            field("Pediment No."; Rec."Pediment No.")
            {
                ApplicationArea = All;
                Visible = "Pediment No.Visible";
                ToolTip = 'Specifies the value of the Pediment No. field.';
            }
            field("CVE Pedimento"; Rec."CVE Pedimento")
            {
                ApplicationArea = All;
                Visible = "CVE PedimentoVisible";
                ToolTip = 'Specifies the value of the CVE Pedimento field.';
            }
            field("Fecha de entrada"; Rec."Fecha de entrada")
            {
                ApplicationArea = All;
                Visible = "Fecha de entradaVisible";
                ToolTip = 'Specifies the value of the Fecha de entrada field.';
            }
            field("Tipo Cambio (USD)"; Rec."Tipo Cambio (USD)")
            {
                ApplicationArea = All;
                Visible = "Tipo Cambio (USD)Visible";
                Editable = "Tipo Cambio (USD)Editable";
                ToolTip = 'Specifies the value of the Tipo Cambio (USD) field.';
            }
            field("Tipo Cambio (JPY)"; rec."Tipo Cambio (JPY)")
            {
                ApplicationArea = All;
                Visible = "Tipo Cambio (JPY)Visible";
                Editable = "Tipo Cambio (JPY)Editable";
                ToolTip = 'Specifies the value of the Tipo Cambio (JPY) field.';
            }
            field("Currency Factor"; rec."Currency Factor")
            {
                ApplicationArea = All;
                DecimalPlaces = 0 : 5;
                Visible = "Currency FactorVisible";
                ToolTip = 'Specifies the value of the Currency Factor field.';
            }
        }
        moveafter("Area"; "Entry Point")
        addafter("Entry Point")
        {
            field("Entry/Exit No."; rec."Entry/Exit No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry/Exit No. field.';
            }
            field("Entry/Exit Date"; rec."Entry/Exit Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry/Exit Date field.';
            }
        }
        addafter(Prepayment)
        {
            group(EDI_)
            {
                Caption = 'EDI';
                /* field("EDI Order"; Rec."EDI Order")
                {
                    ToolTip = 'Specifies the value of the EDI Order field.';
                    ApplicationArea = All;
                }
                field("EDI Internal Doc. No."; Rec."EDI Internal Doc. No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the EDI Internal Doc. No. field.';
                    ApplicationArea = All;
                }
                field("EDI PO Generated"; Rec."EDI PO Generated")
                {
                    ToolTip = 'Specifies the value of the EDI PO Generated field.';
                    ApplicationArea = All;
                }
                field("EDI PO Gen. Date"; Rec."EDI PO Gen. Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the EDI PO Gen. Date field.';
                    ApplicationArea = All;
                }
                field("EDI Released"; Rec."EDI Released")
                {
                    ToolTip = 'Specifies the value of the EDI Released field.';
                    ApplicationArea = All;
                }
                field("EDI Ship Adv. Gen."; Rec."EDI Ship Adv. Gen.")
                {
                    ToolTip = 'Specifies the value of the EDI Ship Adv. Gen. field.';
                    ApplicationArea = All;
                }
                field("EDI Ship Adv. Gen Date"; Rec."EDI Ship Adv. Gen Date")
                {
                    ToolTip = 'Specifies the value of the EDI Ship Adv. Gen Date field.';
                    ApplicationArea = All;
                }
                field("E-Mail Confirmation Handled"; Rec."E-Mail Confirmation Handled")
                {
                    ToolTip = 'Specifies the value of the E-Mail Confirmation Handled field.';
                    ApplicationArea = All;
                }
                field("EDI Trade Partner"; Rec."EDI Trade Partner")
                {
                    ToolTip = 'Specifies the value of the EDI Trade Partner field.';
                    ApplicationArea = All;
                }
                field("EDI Buy-from Code"; Rec."EDI Buy-from Code")
                {
                    ToolTip = 'Specifies the value of the EDI Buy-from Code field.';
                    ApplicationArea = All;
                }*/
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            /*  action("E-&Mail List")
             {
                 Caption = 'E-&Mail List';

                 trigger OnAction();
                 var
                     EMailListEntry: Record 14000908;
                 begin
                     EMailListEntry.RESET;
                     EMailListEntry.SETRANGE("Table ID", DATABASE::"Purchase Header");
                     EMailListEntry.SETRANGE(Type, "Document Type");
                     EMailListEntry.SETRANGE(Code, "No.");
                     PAGE.RUNMODAL(PAGE::"E-Mail List Entries", EMailListEntry);
                 end;
             } */
        }
        addafter("O&rder")
        {
            group(EDI)
            {
                Caption = 'EDI';
                /*  action("EDI Receive Elements")
                 {
                     Caption = 'EDI Receive Elements';
                     ToolTip = 'Executes the EDI Receive Elements action.';

                     trigger OnAction();
                     var
                         EDIIntegration: Codeunit 14000363;
                     begin
                         TESTFIELD("EDI Order");

                         EDIIntegration.ViewRecElements("EDI Internal Doc. No.");
                     end;
                 }
                 action("EDI Associated Receive Documents")
                 {
                     Caption = 'EDI Associated Receive Documents';
                     ToolTip = 'Executes the EDI Associated Receive Documents action.';

                     trigger OnAction();
                     var
                         EDIDocumentStatus: Codeunit 14000379;
                     begin
                         CLEAR(EDIDocumentStatus);
                         EDIDocumentStatus.PurchOrderAssocChangeDoc(Rec);
                     end;
                 }
             }
             group("E-Ship")
             {
                 Caption = 'E-Ship';
                 action(Receives)
                 {
                     Caption = 'Receives';
                     RunObject = Page 14000608;
                     RunPageLink = "Source Type" = CONST(38),
                                   "Source Subtype" = FIELD("Document Type"),
                                   "Source ID" = FIELD("No.");
                     RunPageView = SORTING("Source Type", "Source Subtype", "Source ID");
                     ToolTip = 'Executes the Receives action.';
                 }*/
            }
        }
        addfirst("F&unctions")
        {
            action("&Lot Entry")
            {
                Image = List;
                CaptionML = ENU = '&Lot Entry';
                ApplicationArea = All;
                ToolTip = 'Executes the &Lot Entry action.';
                trigger OnAction()
                VAR
                    LotEntry: Record 50002;
                BEGIN
                    LotEntry.GetPurchLines(LotEntry."Document Type"::"Purchase Order", Rec."No.");
                    COMMIT();
                    LotEntry.SETRANGE("Document Type", LotEntry."Document Type"::"Purchase Order");
                    LotEntry.SETRANGE("Document No.", Rec."No.");
                    PAGE.RUNMODAL(0, LotEntry);
                    CLEAR(LotEntry);
                end;
            }
        }
        addafter("Send Intercompany Purchase Order")
        {
            /*   action("E-Mail Confirmation")
              {
                  Caption = 'E-Mail Confirmation';
                  ToolTip = 'Executes the E-Mail Confirmation action.';

                  trigger OnAction();
                  var
                      EMailMgt: Codeunit 14000903;
                  begin
                      TESTFIELD("E-Mail Confirmation Handled", FALSE);

                      EMailMgt.SendPurchaseConfirmation(Rec, TRUE, FALSE);
                  end;
              } */
        }
        addafter(Action186)
        {
            /*
            group("E-Ship")
            {
                Caption = 'E-Ship';
                action("Fast Receive")
                {
                    Caption = 'Fast Receive';
                    ShortCutKey = 'Alt+F11';
                    ToolTip = 'Executes the Fast Receive action.';

                    trigger OnAction();
                    var
                        FastReceiveLine: Record 14000609;
                    begin
                        FastReceiveLine.RESET;
                        FastReceiveLine.SETRANGE("Source Type", DATABASE::"Purchase Header");
                        FastReceiveLine.SETRANGE("Source Subtype", "Document Type");
                        FastReceiveLine.SETRANGE("Source ID", "No.");
                        PAGE.RUNMODAL(PAGE::"Fast Receive Order", FastReceiveLine);
                    end;
                }
            }
             group(EDI_)
            {
                Caption = 'EDI';
                action("Send EDI Purchase Order")
                {
                    Caption = 'Send EDI Purchase Order';
                    Image = SendElectronicDocument;
                    ToolTip = 'Executes the Send EDI Purchase Order action.';

                    trigger OnAction();
                    var
                        EDIIntegration: Codeunit 14000363;
                    begin
                        EDIIntegration.SendPurchaseOrder(Rec);
                    end;
                }
                action(Trace)
                {
                    Caption = 'Trace';
                    Image = Trace;
                    ToolTip = 'Executes the Trace action.';

                    trigger OnAction();
                    var
                        EDITrace: Page 14002386;
                    begin

                        CLEAR(EDITrace);
                        EDITrace.SetDoc("EDI Internal Doc. No.");
                        EDITrace.RUNMODAL;
                    end;
                }
            }*/
        }

        addbefore(Approval)
        {
            action("PO Comment Import")
            {
                Image = Import;
                CaptionML = ENU = 'PO Comment Import';
                RunObject = XMLport 50016;
                ApplicationArea = All;
                ToolTip = 'Executes the PO Comment Import action.';
            }
            action("PO Import")
            {
                Image = Import;
                CaptionML = ENU = 'PO Import';
                RunObject = XMLport 50015;
                ApplicationArea = All;
                ToolTip = 'Executes the PO Import action.';
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wPedido := Rec."No.";
                wTipoDoc := Rec."Document Type";
                fValida();
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
                fValida();
                //+AKK1606.01++
            end;
        }
    }
    var
        // "//AKK1606.01--": Integer;
        wPedido: Code[20];
        //wTipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        wTipoDoc: Enum "Purchase Document Type";
        // "//AKK1606.01++": Integer;
        StyeExpr: Text;
        //ReopenButtonVsible: Boolean;
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
        OnAfterGetCurrRecord_();
        //>> NIF 03-23-06 RTT
        IF Rec."Currency Code" <> 'USD' THEN
            StyeExpr := 'StrongAccent'
        ELSE
            StyeExpr := '';
        //<< NIF 03-23-06 RTT
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord_();
    end;

    LOCAL PROCEDURE OnAfterGetCurrRecord_();
    VAR
        GLSetup: Record 98;
    //NIF_LV: Integer;
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
            GLSetup.GET();
            "Tipo Cambio (USD)Editable" := Rec."Currency Code" <> GLSetup."LCY Code";
            "Tipo Cambio (JPY)Editable" := (rec."Currency Code" <> GLSetup."LCY Code") AND (rec."Currency Code" <> GLSetup."Additional Reporting Currency");
        END;
        //<<NIF 040406 RTT #10775
    END;

    PROCEDURE fValida();
    VAR
    // rLineas: Record 39;
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