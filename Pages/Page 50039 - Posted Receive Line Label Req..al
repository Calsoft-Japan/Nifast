page 50039 "Posted Receive Line Label Req."
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Document;
    SourceTable = Table14000604;

    layout
    {
        area(content)
        {
            group()
            {
                Editable = false;
                field("Receive No.";"Receive No.")
                {
                }
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field(Description;Description)
                {
                }
                field("Lot No.";"Lot No.")
                {
                }
                field("Mfg. Lot No.";"Mfg. Lot No.")
                {
                }
                field("QC Hold";"QC Hold")
                {
                }
                field(IsComponent;IsComponent)
                {
                    Caption = 'Component';

                    trigger OnValidate()
                    begin
                        IsComponentOnPush;
                    end;
                }
            }
            part(;50008)
            {
                Editable = false;
                SubPageLink = Item No.=FIELD(No.);
            }
            field(NoOfCopies;NoOfCopies)
            {
                Caption = 'No. of Copies';
            }
            field(QtyToPrint;QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0:2;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                action("Shipment History")
                {
                    Caption = 'Shipment History';
                    RunObject = Page 38;
                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Entry Type,Item No.,Variant Code,Source Type,Source No.,Posting Date)
                                  WHERE(Entry Type=FILTER(Sale),
                                        Quantity=FILTER(<>0));
                }
                action("Sales Order Lines")
                {
                    Caption = 'Sales Order Lines';
                    RunObject = Page 516;
                    RunPageLink = Type=FILTER(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Document No.,Type,No.,Variant Code,Drop Shipment,Pack)
                                  WHERE(Document Type=FILTER(Order));
                }
            }
        }
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ReceiveRule.GetReceiveRule("No.");

                    IF ReceiveRule."Item Label Code" <> '' THEN BEGIN
                      CLEAR(ReceiveLineLabel);
                      ReceiveLine.COPYFILTERS(Rec);
                      //determine whether qc
                      IF "QC Hold" THEN
                        ReceiveLineLabel.InitializeRequest(ReceiveRule."QC Label Code",NoOfCopies)
                      ELSE
                        ReceiveLineLabel.InitializeRequest(ReceiveRule."Item Label Code",NoOfCopies);
                      ReceiveLineLabel.InitializeRequest2(QtyToPrint);
                      ReceiveLineLabel.SETTABLEVIEW(ReceiveLine);
                      //ReceiveLineLabel.USEREQUESTFORM(TRUE);
                      ReceiveLineLabel.USEREQUESTPAGE(FALSE);
                      ReceiveLineLabel.RUNMODAL;
                      CLEAR(ReceiveLineLabel);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        QtyToPrint: Decimal;
        NoOfCopies: Integer;
        ReceiveRule: Record "14000612";
        ReceiveLineLabel: Report "14000847";
        ReceiveLine: Record "14000604";
        BOMComponent: Record "90";
        WhereUsedList: Page "37";

    procedure IsComponent(): Boolean
    begin
        CASE Type OF
         Type::Item : BOMComponent.SETRANGE(Type,BOMComponent.Type::Item);
         ELSE EXIT(FALSE);
        END;

        BOMComponent.SETRANGE("No.","No.");
        BOMComponent.SETFILTER("Quantity per",'<>%1',0);
        EXIT(BOMComponent.FIND('-'));
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF QtyToPrint=0 THEN
          QtyToPrint := Quantity;

        IF NoOfCopies=0 THEN
          NoOfCopies := 1;
    end;

    local procedure IsComponentOnPush()
    begin
        CLEAR(WhereUsedList);
        WhereUsedList.SETTABLEVIEW(BOMComponent);
        WhereUsedList.EDITABLE(FALSE);
        WhereUsedList.RUNMODAL;
    end;
}

