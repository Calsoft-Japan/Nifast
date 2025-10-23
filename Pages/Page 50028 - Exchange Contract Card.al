page 50028 "Exchange Contract Card"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // 07-25-05 RTT code at Update PO with Foreign Exchange-OnPush to check for existing contract no.

    PageType = Document;
    SourceTable = "4X Bank Exchange Contract";
    SourceTableView = WHERE("No." = FILTER(<> 'SPOT'));
    UsageCategory = None;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;

                    trigger OnValidate()
                    begin
                        Rec."Date Created" := WORKDATE();
                        //>>
                        //CurrForm.UPDATE(TRUE);
                        //<<
                    end;
                }
                field(Bank; Rec.Bank)
                {
                    Caption = 'Bank Account No.';
                    ToolTip = 'Specifies the value of the Bank Account No. field.';
                }
                field(BankName; Rec.BankName)
                {
                    Caption = 'Bank Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(AmountYen; Rec.AmountYen)
                {
                    Caption = 'Amount JPY';
                    ToolTip = 'Specifies the value of the Amount JPY field.';

                    trigger OnValidate()
                    begin
                        IF Rec.Approved <> '' THEN
                            ERROR('This Contract is already approved');
                    end;
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    Caption = 'Exchange Rate';
                    ToolTip = 'Specifies the value of the Exchange Rate field.';

                    trigger OnValidate()
                    begin
                        IF Rec.Approved <> '' THEN
                            ERROR('This Contract is already approved');
                    end;
                }
                field("Current Assigned Amount"; Rec."Current Assigned Amount")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Current Assigned Amount field.';
                }
                field("Amount $"; Rec."Amount $")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount $ field.';
                }
                field(Expired; Rec.Expired)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Expired field.';
                }
                field(Approved; Rec.Approved)
                {
                    ToolTip = 'Specifies the value of the Approved field.';

                    trigger OnValidate()
                    begin
                        ApprovedOnAfterValidate();
                    end;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(PeriodStart; Rec.PeriodStart)
                {
                    Caption = 'Window from';
                    ToolTip = 'Specifies the value of the Window from field.';

                    trigger OnValidate()
                    begin
                        IF Rec.Approved <> '' THEN
                            ERROR('This Contract is already approved');
                    end;
                }
                field(PeriodEnd; Rec.PeriodEnd)
                {
                    Caption = 'Window To';
                    ToolTip = 'Specifies the value of the Window To field.';

                    trigger OnValidate()
                    begin
                        IF Rec.Approved <> '' THEN
                            ERROR('This Contract is already approved');
                    end;
                }
                field("Bank Contract No."; Rec."Bank Contract No.")
                {
                    ToolTip = 'Specifies the value of the Bank Contract No. field.';
                }
                field("Posted Amount"; Rec."Posted Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Amount field.';
                }
                field(RemainingAmount; Rec.RemainingAmount)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the RemainingAmount field.';
                }
                field("Sell Back Rate"; Rec."Sell Back Rate")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Sell Back Rate field.';
                }
                field("Sell Back Amount"; Rec."Sell Back Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sell Back Amount field.';
                }
            }
            part(Subform; "4X Contract Subform")
            {
                SubPageLink = "Exchange Contract No." = FIELD("No.");
            }
            group(General2)
            {
                field("Current AssignedAmount"; Rec."Current Assigned Amount")
                {
                    Caption = 'Current Assigned Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Assigned Amount field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Contract")
            {
                Caption = '&Contract';
                action("&Get Purchase Orders")
                {
                    Caption = '&Get Purchase Orders';
                    Image = GetOrder;
                    ToolTip = 'Executes the &Get Purchase Orders action.';

                    // trigger OnAction()//TODO
                    // var
                    //     Get4XPOLines: Report 50005;
                    // begin
                    //     Get4XPOLines."SetExchange Contract No."(Rec."No.");
                    //     Get4XPOLines.RUN;
                    //     //CurrPage.Subform.PAGE.UPDATECONTROLS;
                    // end;
                }
                action("&Update PO with Foreign Exchange No.")
                {
                    Caption = '&Update PO with Foreign Exchange No.';
                    Image = UpdateDescription;
                    ToolTip = 'Executes the &Update PO with Foreign Exchange No. action.';

                    trigger OnAction()
                    var
                        PurchInvHdr: Record "Purch. Inv. Header";
                        PurchInvLine: Record "Purch. Inv. Line";
                        OtherInvFound: Boolean;
                        TextLbl: Label '%1 %2, line %3 has %4 %5 without an invoice. Do you want to continue?', Comment = '%1%2%3%4%5';
                    begin
                        IF NOT CONFIRM('Do you want to update the PO lines ?', FALSE) THEN
                            EXIT;
                        "4X Purchase Header".SETRANGE("Exchange Contract No.", Rec."No.");
                        IF "4X Purchase Header".FIND('-') THEN
                            REPEAT
                                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "4X Purchase Header"."Document No.") THEN BEGIN
                                    //>> RTT 07-25-05
                                    //filter on purch lines for this order that have a different non-blank Exchange Contract No.
                                    PurchaseLine.RESET();
                                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                                    PurchaseLine.SETFILTER("Exchange Contract No.", '<>%1&<>%2', '', Rec."No.");
                                    IF PurchaseLine.FIND('-') THEN
                                        REPEAT
                                            OtherInvFound := FALSE;

                                            //look for purchase invoices for this order and contract no.
                                            PurchInvHdr.SETCURRENTKEY("Order No.");
                                            PurchInvHdr.SETRANGE("Order No.", PurchaseLine."Document No.");
                                            PurchInvHdr.SETRANGE("Exchange Contract No.", PurchaseLine."Exchange Contract No.");
                                            IF PurchInvHdr.FIND('-') THEN
                                                REPEAT
                                                    PurchInvLine.SETRANGE("Document No.", PurchInvHdr."No.");
                                                    PurchInvLine.SETRANGE(Type, PurchaseLine.Type);
                                                    PurchInvLine.SETRANGE("No.", PurchaseLine."No.");
                                                    PurchInvLine.SETFILTER(Quantity, '<>%1', 0);
                                                    //OtherInvFound := PurchInvLine.FIND('-');
                                                    OtherInvFound := NOT PurchInvLine.IsEmpty;
                                                UNTIL (PurchInvHdr.NEXT() = 0) OR (OtherInvFound);

                                            //if no invoices were found, give warning
                                            IF (NOT OtherInvFound) THEN
                                                IF NOT CONFIRM(
                                                   STRSUBSTNO(TextLbl,
                                                                PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.",
                                                                   PurchaseLine.FIELDNAME("Exchange Contract No."), PurchaseLine."Exchange Contract No.")) THEN
                                                    ERROR('Operation Canceled.');

                                        UNTIL PurchaseLine.NEXT() = 0;
                                    //<< RTT 07-25-05
                                    PurchaseHeader.VALIDATE("Exchange Contract No.", Rec."No.");
                                    PurchaseHeader.MODIFY();
                                    //>> RTT 07-25-05
                                    //MESSAGE('PO Lines Updated');
                                    MESSAGE('%1 %2 Lines Updated', PurchaseHeader."Document Type", PurchaseHeader."No.");
                                    //<< RTT 07-25-05
                                END
                                ELSE
                                    //>> RTT 07-25-05
                                    //MESSAGE('Nothing to Update');
                                    MESSAGE('Nothing to Update: %1 %2.', PurchaseHeader."Document Type", PurchaseHeader."No.");
                            //<< RTT 07-25-05
                            UNTIL "4X Purchase Header".NEXT() = 0;
                    end;
                }
                action("&Close Contract")
                {
                    Caption = '&Close Contract';
                    Image = CloseDocument;
                    ToolTip = 'Executes the &Close Contract action.';

                    trigger OnAction()
                    var
                        LText50000Lbl: Label 'You still have %1 JPY left on this contract\Do you want to close the contract', Comment = '%1';
                        LText50001Lbl: Label 'Do you want to close this contract ?';
                    begin
                        IF Rec.AmountYen <> Rec."Posted Amount" THEN BEGIN
                            IF CONFIRM(LText50000Lbl, FALSE, (Rec.AmountYen - Rec."Posted Amount")) THEN
                                Rec.CloseContract(Rec);
                        END ELSE
                            IF CONFIRM(LText50001Lbl, FALSE) THEN
                                Rec.CloseContract(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Bank Instruction Page")
                {
                    Caption = 'Bank Instruction Page';
                    Image = Bank;
                    ToolTip = 'Executes the Bank Instruction Page action.';

                    trigger OnAction()
                    var
                        BankExchangeRec: Record "4X Bank Exchange Contract";
                        //"4XBankReport": Report 50012;//TODO
                    begin
                        BankExchangeRec.COPY(Rec);
                        Rec.SETRANGE("No.", Rec."No.");
                        // "4XBankReport".SETTABLEVIEW(Rec);
                        // "4XBankReport".RUN;
                        Rec.COPY(BankExchangeRec);
                    end;
                }
                action("Contract Detail")
                {
                    Caption = 'Contract Detail';
                    Image = ViewDetails;
                    ToolTip = 'Executes the Contract Detail action.';

                    trigger OnAction()
                    var
                        t4XContract: Record "4X Bank Exchange Contract";
                        //tDetailReport: Report 50013;//TODO
                    begin
                        t4XContract.SETRANGE("No.", Rec."No.");
                        // tDetailReport.SETTABLEVIEW(t4XContract);
                        // tDetailReport.RUN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Posted Amount");
        Rec.RemainingAmount := Rec.AmountYen - Rec."Posted Amount";
        Rec.VALIDATE("Sell Back Rate");

        IF Rec."Contract Complete" THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    var
        BankExchangeContract: Record "4X Bank Exchange Contract";
    begin
        BankExchangeContract.COPY(Rec);
        Rec.CheckExpiration();
        Rec.COPY(BankExchangeContract);
    end;

    var
        "4X Purchase Header": Record "4X Purchase Header";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";

    local procedure ApprovedOnAfterValidate()
    begin
        IF Rec.Approved = '' THEN
            ERROR('You must enter an UserID');

        "4X Purchase Header".SETRANGE("Exchange Contract No.", Rec."No.");
        IF "4X Purchase Header".FIND('-') THEN
            IF NOT CONFIRM('Do you want to update the PO lines ?', FALSE) THEN
                EXIT;
        CLEAR("4X Purchase Header");
        "4X Purchase Header".SETRANGE("Exchange Contract No.", Rec."No.");
        IF "4X Purchase Header".FIND('-') THEN
            REPEAT
                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "4X Purchase Header"."Document No.") THEN BEGIN
                    PurchaseHeader.VALIDATE("Exchange Contract No.", Rec."No.");
                    PurchaseHeader.MODIFY();
                    MESSAGE('PO Lines Updated');
                END
                ELSE
                    MESSAGE('Nothing to Update');
            UNTIL "4X Purchase Header".NEXT() = 0;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF Rec.AmountYen > 0 THEN
            IF Rec.RemainingAmount = 0 THEN
                MESSAGE('Remaing Amount = 0\Please close this Contract');
    end;
}

