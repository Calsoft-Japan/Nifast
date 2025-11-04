pageextension 50051 "Purchase Invoice Ext" extends "Purchase Invoice"
{
    layout
    {
        modify("Currency Code")
        {
            StyleExpr = StyeExpr;
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wPedido := rec."No.";
                wTipoDoc := rec."Document Type";
                fValida();
                //+AKK1606.01++

            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wPedido := rec."No.";
                wTipoDoc := rec."Document Type";
                fValida();
                //+AKK1606.01++
            end;
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Currency FactorVisible" := TRUE;
        "Tipo Cambio (JPY)Visible" := TRUE;
        "Tipo Cambio (USD)Visible" := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecordFun();
        //>> NIF 03-23-06 RTT
        IF Rec."Currency Code" <> 'USD' THEN
            StyeExpr := 'StrongAccent'
        ELSE
            StyeExpr := '';
        //<< NIF 03-23-06 RTT
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecordFun();
    end;

    LOCAL PROCEDURE OnAfterGetCurrRecordFun();
    VAR
        GLSetup: Record 98;
    // ">>NIF_LV": Integer;
    BEGIN
        xRec := Rec;
        //>>NIF 032807 RTT #10775
        IF STRPOS(COMPANYNAME, 'Mexi') = 0 THEN BEGIN
            "Tipo Cambio (USD)Visible" := FALSE;
            "Tipo Cambio (JPY)Visible" := FALSE;
            "Currency FactorVisible" := FALSE;
        END ELSE BEGIN
            GLSetup.GET();
            "Tipo Cambio (USD)Editable" := Rec."Currency Code" <> GLSetup."LCY Code";
            "Tipo Cambio (JPY)Editable" := (REc."Currency Code" <> GLSetup."LCY Code") AND (Rec."Currency Code" <> GLSetup."Additional Reporting Currency");
        END;
        //<<NIF 032807 RTT #10775
    END;

    PROCEDURE fValida();
    VAR
        rLineas: Record 39;
    BEGIN
        //-AKK1606.01--
        rLineas.RESET();
        rLineas.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        rLineas.SETRANGE("Document Type", wTipoDoc);
        rLineas.SETRANGE("Document No.", wPedido);
        rLineas.SETRANGE(Type, rLineas.Type::Item);
        rLineas.SETRANGE(National, FALSE);
        IF rLineas.FINDSET() THEN
            REPEAT
                rLineas.TESTFIELD("Entry Point");
                rLineas.TESTFIELD("Entry/Exit No.");
                rLineas.TESTFIELD("Entry/Exit Date");
            UNTIL rLineas.NEXT() = 0;
        //+AKK1606.01++
    END;


    var
        "Currency FactorVisible": boolean;
        "Tipo Cambio (JPY)Editable": Boolean;
        "Tipo Cambio (JPY)Visible": boolean;

        "Tipo Cambio (USD)Editable": Boolean;
        "Tipo Cambio (USD)Visible": boolean;
        wPedido: Code[20];
        wTipoDoc: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        StyeExpr: Text;


}
