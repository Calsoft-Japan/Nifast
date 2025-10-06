page 50067 "Ship Authorization"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    InsertAllowed = false;
    PageType = Document;
    SourceTable = Table50015;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                }
                field("No.";"No.")
                {
                }
                field("Reference No.";"Reference No.")
                {
                }
                field("Document Date";"Document Date")
                {
                }
                field("Horizon Start Date";"Horizon Start Date")
                {
                }
                field("Horizon End Date";"Horizon End Date")
                {
                }
                field("Planning Schedule Party ID";"Planning Schedule Party ID")
                {
                }
                field("Ship From Party ID";"Ship From Party ID")
                {
                }
                field("Ship To Party ID";"Ship To Party ID")
                {
                }
                field("Supplier Party ID";"Supplier Party ID")
                {
                }
                field("Planning Schedule No.";"Planning Schedule No.")
                {
                }
            }
            part(SubShipAuthorizationLine;50068)
            {
                SubPageLink = Sell-to Customer No.=FIELD(Sell-to Customer No.),
                              Document No.=FIELD(No.);
            }
            group(EDI)
            {
                Caption = 'EDI';
                field("EDI Trade Partner";"EDI Trade Partner")
                {
                }
                field("EDI Internal Doc. No.";"EDI Internal Doc. No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(MakeOrder)
            {
                Caption = 'Make &Order';
                Enabled = MakeOrderEnable;
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "36";
                begin
                    SalesShipAuthtoOrder.RUN(Rec);
                    SalesShipAuthtoOrder.GetSalesOrderHeader(SalesHeader);

                    COMMIT;

                    MESSAGE('Sales Order ' + SalesHeader."No." + ' created.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MakeOrderEnable := NOT Archive;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE();
    end;

    trigger OnInit()
    begin
        MakeOrderEnable := TRUE;
    end;

    var
        SalesShipAuthtoOrder: Codeunit "50019";
        [InDataSet]
        MakeOrderEnable: Boolean;
}

