namespace Nifast.Nifast;

using Microsoft.Inventory.Tracking;
using Microsoft.Foundation.NoSeries;

pageextension 56505 "Lot Information Ext" extends "Lot No. Information Card"
{
    layout
    {
        addafter(Blocked)
        {
            // field("Mfg. Lot No."; Rec."Mfg. Lot No.")
            // {
            //     ApplicationArea = All;
            // }
            field("Multiple Certifications"; Rec."Multiple Certifications")
            {
                ApplicationArea = All;
            }
            field("Certification Number"; Rec."Certification Number")
            {
                ApplicationArea = All;
            }
            field("Certification Scope"; Rec."Certification Scope")
            {
                ApplicationArea = All;
            }
            field("Certification Type"; Rec."Certification Type")
            {
                ApplicationArea = All;
            }
            field("Quantity Tested"; Rec."Quantity Tested")
            {
                ApplicationArea = All;
            }
            field("Tested By"; Rec."Tested By")
            {
                ApplicationArea = All;
            }
            field("Tested Date"; Rec."Tested Date")
            {
                ApplicationArea = All;
            }
            field("Tested time"; Rec."Tested time")
            {
                ApplicationArea = All;

            }
            field("Passed Inspection"; Rec."Passed Inspection")
            {
                ApplicationArea = All;
            }
            field("Inspection Comments"; Rec."Inspection Comments")
            {
                ApplicationArea = All;
                MultiLine = true;
            }

        }
        addafter("Expired Inventory")
        {
            field("QC Inventory"; Rec."QC Inventory")
            {
                ApplicationArea = All;
            }
            group(Reference)
            {
                field("Mfg. Lot No."; Rec."Mfg. Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Mfg. Date"; Rec."Mfg. Date")
                {
                    ApplicationArea = All;
                }
                field("Mfg. Name"; Rec."Mfg. Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = All;
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ApplicationArea = All;
                }
                field("Lot Creation Date"; Rec."Lot Creation Date")
                {
                    ApplicationArea = All;
                }
                field("PO Number"; Rec."PO Number")
                {
                    ApplicationArea = All;
                }
                field("Revision No."; Rec."Revision No.")
                {
                    ApplicationArea = All;
                }
                field("Patente Original"; Rec."Patente Original")
                {
                    ApplicationArea = All;
                    Visible = "Patente OriginalVisible";
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
                    Editable = false;
                    Visible = "Tipo Cambio (USD)Visible";
                }
                field("Tipo Cambio (JPY)"; Rec."Tipo Cambio (JPY)")
                {
                    ApplicationArea = All;
                    Visible = "Tipo Cambio (JPY)Visible";
                    Editable = false;
                }
            }

        }

    }
    actions
    {
        addafter("&Item Tracing")
        {
            action("Lot Certifications")
            {
                CaptionML = ENU = '&Lot Certifications';
                RunObject = Page 50010;
                RunPageLink = "Lot No." = FIELD("Lot No."),
                                  "Item No." = FIELD("Item No.");
            }
            action("Print Receiving Label")
            {
                CaptionML = ENU = '&Print Receiving Label';
                trigger OnAction()
                BEGIN
                    PrintReceivingLabel;
                END;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //>>NIF 040406 RTT #10775
        "Tipo Cambio (JPY)Visible" := TRUE;
        "Tipo Cambio (USD)Visible" := TRUE;
        "Fecha de entradaVisible" := TRUE;
        "CVE PedimentoVisible" := TRUE;
        "Pediment No.Visible" := TRUE;
        "Aduana E/SVisible" := TRUE;
        "Patente OriginalVisible" := TRUE;
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN BEGIN
            "Patente OriginalVisible" := FALSE;
            "Aduana E/SVisible" := FALSE;
            "Pediment No.Visible" := FALSE;
            "CVE PedimentoVisible" := FALSE;
            "Fecha de entradaVisible" := FALSE;
            //CurrForm."Tipo Cambio (1 day before)".VISIBLE(FALSE);
            "Tipo Cambio (USD)Visible" := FALSE;
            "Tipo Cambio (JPY)Visible" := FALSE;

        END;
        //<<NIF 040406 RTT #10775
    end;

    PROCEDURE PrintReceivingLabel();
    VAR
        Receive: Record 14000601;
        ReceiveLine: Record 14000602;
        UseReceiveNo: Code[60];
        Item: Record 27;
        NoSeriesMgt: Codeunit "No. Series";
        LabelMgt: Codeunit 50017;
    BEGIN
        Item.GET(rec."Item No.");

        UseReceiveNo := USERID + 'RRPT';
        IF Receive.GET(UseReceiveNo) THEN
            Receive.DELETE(TRUE);

        Receive.INIT;
        Receive."No." := UseReceiveNo;
        //>>IST 032309 CCL $12797 #12797
        //Receive."Purchase Order No." := "PO Number";
        Receive."Source ID" := Rec."PO Number";
        //<<IST 032309 CCL $12797 #12797
        Receive.INSERT;

        rec.CALCFIELDS(Inventory);

        ReceiveLine.INIT;
        ReceiveLine."Receive No." := Receive."No.";
        ReceiveLine.Type := ReceiveLine.Type::Item;
        ReceiveLine."No." := rec."Item No.";
        ReceiveLine.Description := Item.Description;
        ReceiveLine.Quantity := rec.Inventory;
        ReceiveLine."Quantity (Base)" := rec.Inventory;
        ReceiveLine."Lot No." := rec."Lot No.";
        //>>IST 032309 CCL $12797 #12797
        //ReceiveLine."Purchase Order No." := "PO Number";
        ReceiveLine."Source ID" := rec."PO Number";
        //<<IST 032309 CCL $12797 #12797
        ReceiveLine."Mfg. Lot No." := rec."Mfg. Lot No.";
        ReceiveLine.INSERT;

        LabelMgt.PromptReceiveLineLabel(ReceiveLine, rec.Inventory, rec.Inventory, TRUE);

        Receive.DELETE(TRUE);
    END;

    var
        "Patente OriginalVisible": Boolean;
        "Aduana E/SVisible": Boolean;
        "Pediment No.Visible": Boolean;
        "CVE PedimentoVisible": Boolean;
        "Fecha de entradaVisible": Boolean;
        "Tipo Cambio (USD)Visible": Boolean;
        "Tipo Cambio (JPY)Visible": Boolean;
}
