page 50037 "Receive Line Label Request"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // >>IST
    // Date   Init GranID SCRID  Description
    //                           Properties Modified:
    //                           Fields Added:
    //                           Fields Modified:
    //                           Globals Added:
    //                           Globals Modified:
    //                           TextConstant Added:
    //                           TextConstant Modified:
    //                           Functions Added:
    //                           Functions Modified:
    //                           Keys Added:
    //                           Keys Modified:
    //                           Other:
    // 032309 CCL $12797 #12797    Changed Textbox from "Purchase Order No." to "Source ID"
    // <<IST

    PageType = Document;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "LAX Receive Line";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("Receive No."; Rec."Receive No.")
                {
                    ToolTip = 'Specifies the value of the Receive No. field.';
                    Caption = 'Receive No.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    Caption = 'Lot No.';
                }
                field("Source ID"; Rec."Source ID")
                {
                    ToolTip = 'Specifies the value of the Source ID field.';
                    Caption = 'Source ID';
                }
                field("Mfg. Lot No."; Rec."Mfg. Lot No.")
                {
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                    Caption = 'Mfg. Lot No.';
                }
            }
            part(Crossreferencesubform; "Cross Reference Subform")
            {
                Editable = false;
                SubPageLink = "Item No." = FIELD("No.");
            }
            field(NoOfCopies; NoOfCopies)
            {
                Caption = 'No. of Copies';
                ToolTip = 'Specifies the value of the No. of Copies field.';
            }
            field(QtyToPrint; QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0 : 2;
                ToolTip = 'Specifies the value of the Quantity To Print field.';
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
                    Image = Shipment;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date")
                                  WHERE("Entry Type" = FILTER(Sale),
                                        Quantity = FILTER(<> 0));
                    ToolTip = 'Executes the Shipment History action.';
                }
                action("Sales Order Lines")
                {
                    Caption = 'Sales Order Lines';
                    RunObject = Page "Sales Lines";
                    Image = Sales;
                    RunPageLink = Type = FILTER(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Document No.", Type, "No.", "Variant Code", "Drop Shipment", "LAX Pack")
                                  WHERE("Document Type" = FILTER(Order));
                    ToolTip = 'Executes the Sales Order Lines action.';
                }
            }
        }
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Image = "1099Form";
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the OK action.';

                trigger OnAction()
                begin
                    ReceiveRule.GetReceiveRule(Rec."No.");

                    IF ReceiveRule."Item Label Code" <> '' THEN BEGIN
                        CLEAR(ReceiveLineLabel);
                        ReceiveLine.COPYFILTERS(Rec);
                        //XReceiveLine.SETRECFILTER;
                        ReceiveLineLabel.SETTABLEVIEW(ReceiveLine);
                        //determine whether qc
                        // IF "QC Hold" THEN//TODO
                        //     ReceiveLineLabel.InitializeRequest(ReceiveRule."QC Label Code", NoOfCopies)
                        // ELSE
                        //     ReceiveLineLabel.InitializeRequest(ReceiveRule."Item Label Code", NoOfCopies);
                            //TODO
                        //ReceiveLineLabel.InitializeRequest2(QtyToPrint);
                        //ReceiveLineLabel.USEREQUESTFORM(TRUE);
                        ReceiveLineLabel.USEREQUESTPAGE(FALSE);
                        ReceiveLineLabel.RUNMODAL();
                        CLEAR(ReceiveLineLabel);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        BOMComponent: Record "BOM Component";
        ReceiveLine: Record "LAX Receive Line";
        ReceiveRule: Record "LAX Receive Rule";
        ReceiveLineLabel: Report "LAX Receive Line Label";
        QtyToPrint: Decimal;
        NoOfCopies: Integer;

    procedure IsComponent(): Boolean
    begin
        CASE Rec.Type OF
            Rec.Type::Item:
                BOMComponent.SETRANGE(Type, BOMComponent.Type::Item);
            ELSE
                EXIT(FALSE);
        END;

        BOMComponent.SETRANGE("No.", Rec."No.");
        BOMComponent.SETFILTER("Quantity per", '<>%1', 0);
        EXIT(BOMComponent.FIND('-'));
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF QtyToPrint = 0 THEN
            QtyToPrint := Rec.Quantity;

        IF NoOfCopies = 0 THEN
            NoOfCopies := 1;
    end;
}

