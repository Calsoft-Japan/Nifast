page 50028 "Exchange Contract Card"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // 07-25-05 RTT code at Update PO with Foreign Exchange-OnPush to check for existing contract no.

    PageType = Document;
    SourceTable = Table50010;
    SourceTableView = WHERE(No.=FILTER(<>SPOT));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;

                    trigger OnValidate()
                    begin
                        "Date Created" := WORKDATE;
                        //>>
                        //CurrForm.UPDATE(TRUE);
                        //<<
                    end;
                }
                field(Bank;Bank)
                {
                    Caption = 'Bank Account No.';
                }
                field(BankName;BankName)
                {
                    Caption = 'Bank Name';
                    Editable = false;
                }
                field(AmountYen;AmountYen)
                {
                    Caption = 'Amount JPY';

                    trigger OnValidate()
                    begin
                        IF Approved <> '' THEN
                          ERROR('This Contract is already approved');
                    end;
                }
                field(ExchangeRate;ExchangeRate)
                {
                    Caption = 'Exchange Rate';

                    trigger OnValidate()
                    begin
                        IF Approved <> '' THEN
                          ERROR('This Contract is already approved');
                    end;
                }
                field("Current Assigned Amount";"Current Assigned Amount")
                {
                    MultiLine = true;
                }
                field("Amount $";"Amount $")
                {
                    Editable = false;
                }
                field(Expired;Expired)
                {
                    Editable = false;
                }
                field(Approved;Approved)
                {

                    trigger OnValidate()
                    begin
                        ApprovedOnAfterValidate;
                    end;
                }
                field("Date Created";"Date Created")
                {
                    Editable = false;
                }
                field(PeriodStart;PeriodStart)
                {
                    Caption = 'Window from';

                    trigger OnValidate()
                    begin
                        IF Approved <> '' THEN
                          ERROR('This Contract is already approved');
                    end;
                }
                field(PeriodEnd;PeriodEnd)
                {
                    Caption = 'Window To';

                    trigger OnValidate()
                    begin
                        IF Approved <> '' THEN
                          ERROR('This Contract is already approved');
                    end;
                }
                field("Bank Contract No.";"Bank Contract No.")
                {
                }
                field("Posted Amount";"Posted Amount")
                {
                    Editable = false;
                }
                field(RemainingAmount;RemainingAmount)
                {
                    Editable = false;
                }
                field("Sell Back Rate";"Sell Back Rate")
                {
                    Editable = true;
                }
                field("Sell Back Amount";"Sell Back Amount")
                {
                    Editable = false;
                }
            }
            part(Subform;50027)
            {
                SubPageLink = Exchange Contract No.=FIELD(No.);
            }
            group()
            {
                field("Current AssignedAmount";"Current Assigned Amount")
                {
                    Caption = 'Current Assigned Amount';
                    Editable = false;
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

                    trigger OnAction()
                    var
                        Get4XPOLines: Report "50005";
                    begin
                        Get4XPOLines."SetExchange Contract No."("No.");
                        Get4XPOLines.RUN;
                        //CurrPage.Subform.PAGE.UPDATECONTROLS;
                    end;
                }
                action("&Update PO with Foreign Exchange No.")
                {
                    Caption = '&Update PO with Foreign Exchange No.';

                    trigger OnAction()
                    var
                        PurchInvHdr: Record "122";
                        PurchInvLine: Record "123";
                        OtherInvFound: Boolean;
                    begin
                        IF NOT CONFIRM('Do you want to update the PO lines ?', FALSE) THEN
                          EXIT;
                        "4X Purchase Header".SETRANGE("Exchange Contract No.", "No.");
                        IF "4X Purchase Header".FIND('-') THEN
                          REPEAT
                            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "4X Purchase Header"."Document No.") THEN BEGIN
                        //>> RTT 07-25-05
                              //filter on purch lines for this order that have a different non-blank Exchange Contract No.
                              PurchaseLine.RESET;
                              PurchaseLine.SETRANGE("Document Type",PurchaseHeader."Document Type");
                              PurchaseLine.SETRANGE("Document No.",PurchaseHeader."No.");
                              PurchaseLine.SETFILTER("Exchange Contract No.",'<>%1&<>%2','',"No.");
                              IF PurchaseLine.FIND('-') THEN
                                REPEAT
                                  OtherInvFound := FALSE;

                                  //look for purchase invoices for this order and contract no.
                                  PurchInvHdr.SETCURRENTKEY("Order No.");
                                  PurchInvHdr.SETRANGE("Order No.",PurchaseLine."Document No.");
                                  PurchInvHdr.SETRANGE("Exchange Contract No.",PurchaseLine."Exchange Contract No.");
                                  IF PurchInvHdr.FIND('-') THEN
                                    REPEAT
                                       PurchInvLine.SETRANGE("Document No.",PurchInvHdr."No.");
                                       PurchInvLine.SETRANGE(Type,PurchaseLine.Type);
                                       PurchInvLine.SETRANGE("No.",PurchaseLine."No.");
                                       PurchInvLine.SETFILTER(Quantity,'<>%1',0);
                                       OtherInvFound := PurchInvLine.FIND('-');
                                    UNTIL (PurchInvHdr.NEXT=0) OR (OtherInvFound);

                                  //if no invoices were found, give warning
                                  IF (NOT OtherInvFound) THEN
                                    IF NOT CONFIRM(
                                       STRSUBSTNO('%1 %2, line %3 has %4 %5 without an invoice. Do you want to continue?',
                                                    PurchaseLine."Document Type",PurchaseLine."Document No.",PurchaseLine."Line No.",
                                                       PurchaseLine.FIELDNAME("Exchange Contract No."),PurchaseLine."Exchange Contract No.")) THEN
                                       ERROR('Operation Canceled.');

                                UNTIL PurchaseLine.NEXT=0;
                        //<< RTT 07-25-05
                              PurchaseHeader.VALIDATE("Exchange Contract No.", "No.");
                              PurchaseHeader.MODIFY;
                        //>> RTT 07-25-05
                              //MESSAGE('PO Lines Updated');
                              MESSAGE('%1 %2 Lines Updated',PurchaseHeader."Document Type",PurchaseHeader."No.");
                        //<< RTT 07-25-05
                            END
                            ELSE
                        //>> RTT 07-25-05
                              //MESSAGE('Nothing to Update');
                              MESSAGE('Nothing to Update: %1 %2.',PurchaseHeader."Document Type",PurchaseHeader."No.");
                        //<< RTT 07-25-05
                          UNTIL "4X Purchase Header".NEXT = 0;
                    end;
                }
                action("&Close Contract")
                {
                    Caption = '&Close Contract';

                    trigger OnAction()
                    var
                        LText50000: Label 'You still have %1 JPY left on this contract\Do you want to close the contract';
                        LText50001: Label 'Do you want to close this contract ?';
                    begin
                        IF AmountYen <> "Posted Amount" THEN BEGIN
                         IF CONFIRM(LText50000, FALSE,(AmountYen - "Posted Amount")) THEN
                           CloseContract(Rec);
                        END ELSE
                          IF CONFIRM(LText50001,FALSE) THEN
                            CloseContract(Rec);
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

                    trigger OnAction()
                    var
                        "4XBankReport": Report "50012";
                        TempRec: Record "50010";
                    begin
                        TempRec.COPY(Rec);
                        SETRANGE("No.", "No.");
                        "4XBankReport".SETTABLEVIEW(Rec);
                        "4XBankReport".RUN;
                        Rec.COPY(TempRec);
                    end;
                }
                action("Contract Detail")
                {
                    Caption = 'Contract Detail';

                    trigger OnAction()
                    var
                        t4XContract: Record "50010";
                        tDetailReport: Report "50013";
                    begin
                        t4XContract.SETRANGE("No.", "No.");
                        tDetailReport.SETTABLEVIEW(t4XContract);
                        tDetailReport.RUN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Posted Amount");
        RemainingAmount := AmountYen - "Posted Amount";
        VALIDATE("Sell Back Rate");

        IF "Contract Complete" THEN
          CurrPage.EDITABLE := FALSE
        ELSE
          CurrPage.EDITABLE := TRUE;
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        TempRec: Record "50010";
    begin
        TempRec.COPY(Rec);
        CheckExpiration;
        Rec.COPY(TempRec);
    end;

    var
        BankContract: Record "270";
        TEXT001: Label 'Can''t update Amount JPY\This Contract is already Approved';
        "4X Purchase Header": Record "50008";
        PurchaseLine: Record "39";
        PurchaseHeader: Record "38";

    local procedure ApprovedOnAfterValidate()
    begin
        IF Approved = '' THEN
          ERROR('You must enter an UserID');

        "4X Purchase Header".SETRANGE("Exchange Contract No.", "No.");
        IF "4X Purchase Header".FIND('-') THEN
          IF NOT CONFIRM('Do you want to update the PO lines ?', FALSE) THEN
            EXIT;
        CLEAR("4X Purchase Header");
        "4X Purchase Header".SETRANGE("Exchange Contract No.", "No.");
        IF "4X Purchase Header".FIND('-') THEN
          REPEAT
            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "4X Purchase Header"."Document No.") THEN BEGIN
              PurchaseHeader.VALIDATE("Exchange Contract No.", "No.");
              PurchaseHeader.MODIFY;
              MESSAGE('PO Lines Updated');
            END
            ELSE
              MESSAGE('Nothing to Update');
          UNTIL "4X Purchase Header".NEXT = 0;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF AmountYen > 0 THEN
          IF RemainingAmount = 0 THEN
            MESSAGE('Remaing Amount = 0\Please close this Contract');
    end;
}

