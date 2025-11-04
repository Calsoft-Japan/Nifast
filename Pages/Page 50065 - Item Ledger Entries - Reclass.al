page 50065 "Item Ledger Entries - Reclass"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // Fields Added:
    //   NV4.33 06-01-04 RTT
    //     QC Hold (visible=Yes)
    //     QC Hold Reason Code (visible=No)
    // 
    // >> NIF
    // Fields Added:
    //   "Inspected Parts" (#10045)
    //   "Mfg Lot No."
    // << NIF

    Caption = 'Item Ledger Entries - Reclass';
    DataCaptionExpression = GetCaption();
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Descriptions; ItemGRec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Item field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ToolTip = 'Specifies the value of the Remaining Quantity field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Mfg. Lot No."; Rec."Mfg. Lot No.")
                {
                    ToolTip = 'Specifies the value of the Mfg. Lot No. field.';
                }
                field("Inspected Parts"; Rec."Inspected Parts")
                {
                    ToolTip = 'Specifies the value of the Inspected Parts field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Navigate action.';

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT ItemGRec.GET(Rec."Item No.") THEN
            CLEAR(ItemGRec);
    end;

    var
        ItemGRec: Record Item;
        Navigate: Page Navigate;

    procedure GetCaption(): Text[250]
    var
        Cust: Record Customer;
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        ObjTransl: Record "Object Translation";
        ProdOrder: Record "Production Order";
        Vend: Record Vendor;
        Description: Text[100];
        SourceTableName: Text[100];
        SourceFilter: Text[200];
    begin
        Description := '';

        CASE TRUE OF
            Rec.GETFILTER("Item No.") <> '':
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    SourceFilter := Rec.GETFILTER("Item No.");
                    IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
                        IF Item.GET(SourceFilter) THEN
                            Description := Item.Description;
                END;
            (Rec.GETFILTER("Order No.") <> '') AND (Rec."Order Type" = Rec."Order Type"::Production):
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
                    SourceFilter := Rec.GETFILTER("Order No.");
                    IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
                        IF ProdOrder.GET(ProdOrder.Status::Released, SourceFilter) OR
                           ProdOrder.GET(ProdOrder.Status::Finished, SourceFilter)
                        THEN BEGIN
                            SourceTableName := STRSUBSTNO('%1 %2', ProdOrder.Status, SourceTableName);
                            Description := ProdOrder.Description;
                        END;
                END;
            Rec.GETFILTER("Source No.") <> '':
                CASE Rec."Source Type" OF
                    Rec."Source Type"::Customer:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                            SourceFilter := Rec.GETFILTER("Source No.");
                            IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                                IF Cust.GET(SourceFilter) THEN
                                    Description := Cust.Name;
                        END;
                    Rec."Source Type"::Vendor:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                            SourceFilter := Rec.GETFILTER("Source No.");
                            IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                                IF Vend.GET(SourceFilter) THEN
                                    Description := Vend.Name;
                        END;
                END;
            Rec.GETFILTER("Global Dimension 1 Code") <> '':
                BEGIN
                    GLSetup.GET();
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := Rec.GETFILTER("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 1 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            Rec.GETFILTER("Global Dimension 2 Code") <> '':
                BEGIN
                    GLSetup.GET();
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := Rec.GETFILTER("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 2 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            Rec.GETFILTER("Document Type") <> '':
                BEGIN
                    SourceTableName := Rec.GETFILTER("Document Type");
                    SourceFilter := Rec.GETFILTER("Document No.");
                    Description := Rec.GETFILTER("Document Line No.");
                END;
        END;
        EXIT(STRSUBSTNO('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}

