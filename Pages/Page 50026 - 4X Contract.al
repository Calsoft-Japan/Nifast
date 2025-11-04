page 50026 "4X Contract"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    Caption = 'Contract Note/4X Request';
    PageType = Document;
    SourceTable = "4X Contract";
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
                    Editable = true;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                field("Contract Note No."; Rec."Contract Note No.")
                {
                    ToolTip = 'Specifies the value of the Contract Note No. field.';
                }
                field("Division Code"; Rec."Division Code")
                {
                    Caption = 'Division Code';
                    ToolTip = 'Specifies the value of the Division Code field.';
                }
                field(Total; Rec.Total)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field("Authorized By"; Rec."Authorized By")
                {
                    ToolTip = 'Specifies the value of the Authorized By field.';
                }
                field("Foreign Exchange Requested"; Rec."Foreign Exchange Requested")
                {
                    Caption = 'Date Requested';
                    ToolTip = 'Specifies the value of the Date Requested field.';
                }
                field("Window From"; Rec."Window From")
                {
                    ToolTip = 'Specifies the value of the Window From field.';
                }
                field("Window To"; Rec."Window To")
                {
                    ToolTip = 'Specifies the value of the Window To field.';
                }
            }
            part(subform; "4X Contract Subform")
            {
                Editable = subformEditable;
                Enabled = subformEnable;
                SubPageLink = "Contract Note No." = FIELD("Contract Note No.");
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
                    Image = Select;
                    ToolTip = 'Executes the S&elect Purchase Orders action.';

                    trigger OnAction()
                    begin
                        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SETRANGE(Status, PurchaseHeader.Status::Released);

                        CLEAR(POLookup);
                        POLookup.SETTABLEVIEW(PurchaseHeader);
                        POLookup.LOOKUPMODE := TRUE;

                        IF POLookup.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            POLookup.GetSeleted(PurchaseHeader);
                            IF PurchaseHeader.FIND('-') THEN
                                REPEAT
                                    PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                                    PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                                    PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                                    PurchLine.SETFILTER("Outstanding Quantity", '>0');
                                    PurchLine.SETFILTER("Contract Note No.", '=%1', '');
                                    IF PurchLine.FIND('-') THEN
                                        REPEAT
                                            "4X PurchaseHeader".INIT();
                                            "4X PurchaseHeader"."Document Type" := PurchLine."Document Type";
                                            "4X PurchaseHeader"."Document No." := PurchLine."Document No.";
                                            "4X PurchaseHeader"."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                            "4X PurchaseHeader"."Location Code" := PurchLine."Location Code";
                                            "4X PurchaseHeader"."Contract Note No." := Rec."Contract Note No.";
                                            "4X PurchaseHeader"."Division No." := PurchLine."Shortcut Dimension 1 Code";
                                            "4X PurchaseHeader"."Item No." := PurchLine."No.";
                                            "4X PurchaseHeader"."Item Description" := PurchLine.Description;
                                            "4X PurchaseHeader".Quantity := PurchLine."Outstanding Quantity";
                                            "4X PurchaseHeader"."Document Line No." := PurchLine."Line No.";
                                            "4X PurchaseHeader"."Direct Unit Cost" := PurchLine."Direct Unit Cost";
                                            "4X PurchaseHeader"."Ext. Cost" := ROUND(PurchLine."Outstanding Quantity" * PurchLine."Direct Unit Cost", 0.01);
                                            "4X PurchaseHeader".INSERT();
                                        UNTIL PurchLine.NEXT() = 0;
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
                                UNTIL PurchaseHeader.NEXT() = 0;
                        END;

                        CLEAR(PurchaseHeader);
                    end;
                }
                action("&Update PO with Contract Note No.")
                {
                    Caption = '&Update PO with Contract Note No.';
                    Image = UpdateDescription;
                    ToolTip = 'Executes the &Update PO with Contract Note No. action.';

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Authorized By");
                        Rec.VALIDATE("Authorized By");
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
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50008, TRUE, FALSE, Rec);
                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Promoted = true;
                Image = Comment;
                PromotedCategory = Process;
                RunObject = Page 66;
                RunPageLink = "Document Type" = CONST("4X Contract"),
                              "No." = FIELD("No.");
                ToolTip = 'Comment';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Closed THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            but1Visible := FALSE;
        END;

        //IST MAK 082705
        IF Rec."Authorized By" <> '' THEN
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
        IF Rec.Closed THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            but1Visible := FALSE;
        END;
    end;

    var
        "4X PurchaseHeader": Record "4X Purchase Header";
        PurchaseHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        POLookup: Page "Get PO Headers";
        but1Visible: Boolean;
        subformEditable: Boolean;
        subformEnable: Boolean;
}

