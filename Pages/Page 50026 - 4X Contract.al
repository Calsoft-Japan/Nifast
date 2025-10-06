page 50026 "4X Contract"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Caption = 'Contract Note/4X Request';
    PageType = Document;
    SourceTable = Table50011;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Editable = true;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                field("Contract Note No.";"Contract Note No.")
                {
                }
                field("Division Code";"Division Code")
                {
                    Caption = 'Division Code';
                }
                field(Total;Total)
                {
                    Editable = false;
                }
                field("Date Created";"Date Created")
                {
                    Editable = false;
                }
                field("Requested By";"Requested By")
                {
                }
                field("Authorized By";"Authorized By")
                {
                }
                field("Foreign Exchange Requested";"Foreign Exchange Requested")
                {
                    Caption = 'Date Requested';
                }
                field("Window From";"Window From")
                {
                }
                field("Window To";"Window To")
                {
                }
            }
            part(subform;50027)
            {
                Editable = subformEditable;
                Enabled = subformEnable;
                SubPageLink = Contract Note No.=FIELD(Contract Note No.);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(but1)
            {
                Caption = '&Contract Note/4X Request';
                Visible = but1Visible;
                action("S&elect Purchase Orders")
                {
                    Caption = 'S&elect Purchase Orders';

                    trigger OnAction()
                    var
                        GetPOs: Page "50045";
                    begin

                        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Released);

                        CLEAR(POLookup);
                        POLookup.SETTABLEVIEW(PurchaseHeader);
                        POLookup.LOOKUPMODE := TRUE;

                        IF POLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
                          POLookup.GetSeleted(PurchaseHeader);
                          IF PurchaseHeader.FIND('-') THEN
                            REPEAT
                              PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                              PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                              PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                              PurchLine.SETFILTER("Outstanding Quantity",'>0');
                              PurchLine.SETFILTER("Contract Note No.", '=%1', '');
                              IF PurchLine.FIND('-') THEN
                                REPEAT
                                  "4X PurchaseHeader".INIT;
                                  "4X PurchaseHeader"."Document Type" := PurchLine."Document Type";
                                  "4X PurchaseHeader"."Document No." := PurchLine."Document No.";
                                  "4X PurchaseHeader"."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                  "4X PurchaseHeader"."Location Code" := PurchLine."Location Code";
                                  "4X PurchaseHeader"."Contract Note No." := "Contract Note No.";
                                  "4X PurchaseHeader"."Division No." := PurchLine."Shortcut Dimension 1 Code";
                                  "4X PurchaseHeader"."Item No." := PurchLine."No.";
                                  "4X PurchaseHeader"."Item Description" := PurchLine.Description;
                                  "4X PurchaseHeader".Quantity := PurchLine."Outstanding Quantity";
                                  "4X PurchaseHeader"."Document Line No." := PurchLine."Line No.";
                                  "4X PurchaseHeader"."Direct Unit Cost" := PurchLine."Direct Unit Cost";
                                  "4X PurchaseHeader"."Ext. Cost" := ROUND(PurchLine."Outstanding Quantity" * PurchLine."Direct Unit Cost", 0.01);
                                  "4X PurchaseHeader".INSERT;
                                UNTIL PurchLine.NEXT = 0;
                              //"4X PurchaseHeader".INIT;
                              //"4X PurchaseHeader"."Document Type" := PurchaseHeader."Document Type";
                              //"4X PurchaseHeader"."Document No." := PurchaseHeader."No.";
                              //"4X PurchaseHeader"."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                              //PurchaseHeader.CALCFIELDS(Amount);
                              //"4X PurchaseHeader".Amount := PurchaseHeader.Amount;
                              //"4X PurchaseHeader"."Location Code" := PurchaseHeader."Location Code";
                              //"4X PurchaseHeader"."Contract Note No." := "Contract Note No.";
                              //"4X PurchaseHeader"."Division No." := PurchaseHeader."Shortcut Dimension 1 Code";
                              //"4X PurchaseHeader".INSERT;
                            UNTIL PurchaseHeader.NEXT = 0;
                        END;

                        CLEAR(PurchaseHeader);
                    end;
                }
                action("&Update PO with Contract Note No.")
                {
                    Caption = '&Update PO with Contract Note No.';

                    trigger OnAction()
                    begin
                        TESTFIELD("Authorized By");
                        VALIDATE("Authorized By");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50008,TRUE,FALSE,Rec);
                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 66;
                RunPageLink = Document Type=CONST(4X Contract),
                              No.=FIELD(No.);
                ToolTip = 'Comment';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Closed THEN BEGIN
          CurrPage.EDITABLE := FALSE;
          but1Visible := FALSE;
        END;

        //IST MAK 082705
        IF "Authorized By" <> '' THEN
          subformEnable := FALSE
          ELSE BEGIN

            subformEnable := TRUE;
            subformEditable := TRUE;
          END;
    end;

    trigger OnInit()
    begin
        but1Visible := TRUE;
        subformEnable := TRUE;
        subformEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF Closed THEN BEGIN
          CurrPage.EDITABLE := FALSE;
          but1Visible := FALSE;
        END;
    end;

    var
        PurchaseHeader: Record "38";
        PurchLine: Record "39";
        BatchRelease: Codeunit "50012";
        Pic: Integer;
        POLookup: Page "50045";
        "4X PurchaseHeader": Record "50008";
        "Temp 4X PurchaseHeader": Record "50008" temporary;
        [InDataSet]
        subformEditable: Boolean;
        [InDataSet]
        subformEnable: Boolean;
        [InDataSet]
        but1Visible: Boolean;
}

