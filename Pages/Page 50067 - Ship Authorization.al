page 50067 "Ship Authorization"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    InsertAllowed = false;
    PageType = Document;
    UsageCategory = None;
    SourceTable = "Ship Authorization";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                    Caption = 'Sell-to Customer No.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    Caption = 'Reference No.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                    Caption = 'Document Date';
                }
                field("Horizon Start Date"; Rec."Horizon Start Date")
                {
                    ToolTip = 'Specifies the value of the Horizon Start Date field.';
                    Caption = 'Horizon Start Date';
                }
                field("Horizon End Date"; Rec."Horizon End Date")
                {
                    ToolTip = 'Specifies the value of the Horizon End Date field.';
                    Caption = 'Horizon End Date';
                }
                field("Planning Schedule Party ID"; Rec."Planning Schedule Party ID")
                {
                    ToolTip = 'Specifies the value of the Planning Schedule Party ID field.';
                    Caption = 'Planning Schedule Party ID';
                }
                field("Ship From Party ID"; Rec."Ship From Party ID")
                {
                    ToolTip = 'Specifies the value of the Ship From Party ID field.';
                    Caption = 'Ship From Party ID';
                }
                field("Ship To Party ID"; Rec."Ship To Party ID")
                {
                    ToolTip = 'Specifies the value of the Ship To Party ID field.';
                    Caption = 'Ship To Party ID';
                }
                field("Supplier Party ID"; Rec."Supplier Party ID")
                {
                    ToolTip = 'Specifies the value of the Supplier Party ID field.';
                    Caption = 'Supplier Party ID';
                }
                field("Planning Schedule No."; Rec."Planning Schedule No.")
                {
                    ToolTip = 'Specifies the value of the Planning Schedule No. field.';
                    Caption = 'Planning Schedule No.';
                }
            }
            part(SubShipAuthorizationLine; "Ship Authorization Line")
            {
                SubPageLink = "Sell-to Customer No." = FIELD("Sell-to Customer No."),
                             "Document No." = FIELD("No.");
                ToolTip = 'Specifies the value of the - field.';
                Caption = '-';
            }
            group(EDI)
            {
                Caption = 'EDI';
                field("EDI Trade Partner"; Rec."EDI Trade Partner")
                {
                    ToolTip = 'Specifies the value of the EDI Trade Partner field.';
                    Caption = 'EDI Trade Partner';
                }
                field("EDI Internal Doc. No."; Rec."EDI Internal Doc. No.")
                {
                    ToolTip = 'Specifies the value of the EDI Internal Doc. No. field.';
                    Caption = 'EDI Internal Doc. No.';
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
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Make &Order action.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesShipAuthtoOrder.RUN(Rec);
                    SalesShipAuthtoOrder.GetSalesOrderHeader(SalesHeader);

                    COMMIT();

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
        SalesShipAuthtoOrder: Codeunit "Sales-ShipAuth to Order";
        MakeOrderEnable: Boolean;
}

