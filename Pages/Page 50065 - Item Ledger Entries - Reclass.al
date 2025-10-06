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
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = Table32;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Posting Date";"Posting Date")
                {
                }
                field("Entry Type";"Entry Type")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field(Item.Description;Item.Description)
                {
                    Caption = 'Description';
                }
                field("Lot No.";"Lot No.")
                {
                    Visible = true;
                }
                field("Remaining Quantity";"Remaining Quantity")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Mfg. Lot No.";"Mfg. Lot No.")
                {
                }
                field("Inspected Parts";"Inspected Parts")
                {
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
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date","Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Item.GET("Item No.") THEN
          CLEAR(Item);
    end;

    var
        Navigate: Page "344";
        Item: Record "27";

    procedure GetCaption(): Text[250]
    var
        GLSetup: Record "98";
        ObjTransl: Record "377";
        Item: Record "27";
        ProdOrder: Record "5405";
        Cust: Record "18";
        Vend: Record "23";
        Dimension: Record "348";
        DimValue: Record "349";
        SourceTableName: Text[100];
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        CASE TRUE OF
          GETFILTER("Item No.") <> '':
            BEGIN
              SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27);
              SourceFilter := GETFILTER("Item No.");
              IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
                IF Item.GET(SourceFilter) THEN
                  Description := Item.Description;
            END;
          (GETFILTER("Order No.") <> '') AND ("Order Type" = "Order Type"::Production):
            BEGIN
              SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5405);
              SourceFilter := GETFILTER("Order No.");
              IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
                IF ProdOrder.GET(ProdOrder.Status::Released,SourceFilter) OR
                   ProdOrder.GET(ProdOrder.Status::Finished,SourceFilter)
                THEN BEGIN
                  SourceTableName := STRSUBSTNO('%1 %2',ProdOrder.Status,SourceTableName);
                  Description := ProdOrder.Description;
                END;
            END;
          GETFILTER("Source No.") <> '':
            CASE "Source Type" OF
              "Source Type"::Customer:
                BEGIN
                  SourceTableName :=
                    ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,18);
                  SourceFilter := GETFILTER("Source No.");
                  IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                    IF Cust.GET(SourceFilter) THEN
                      Description := Cust.Name;
                END;
              "Source Type"::Vendor:
                BEGIN
                  SourceTableName :=
                    ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,23);
                  SourceFilter := GETFILTER("Source No.");
                  IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                    IF Vend.GET(SourceFilter) THEN
                      Description := Vend.Name;
                END;
            END;
          GETFILTER("Global Dimension 1 Code") <> '':
            BEGIN
              GLSetup.GET;
              Dimension.Code := GLSetup."Global Dimension 1 Code";
              SourceFilter := GETFILTER("Global Dimension 1 Code");
              SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
              IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                IF DimValue.GET(GLSetup."Global Dimension 1 Code",SourceFilter) THEN
                  Description := DimValue.Name;
            END;
          GETFILTER("Global Dimension 2 Code") <> '':
            BEGIN
              GLSetup.GET;
              Dimension.Code := GLSetup."Global Dimension 2 Code";
              SourceFilter := GETFILTER("Global Dimension 2 Code");
              SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
              IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                IF DimValue.GET(GLSetup."Global Dimension 2 Code",SourceFilter) THEN
                  Description := DimValue.Name;
            END;
          GETFILTER("Document Type") <> '':
            BEGIN
              SourceTableName := GETFILTER("Document Type");
              SourceFilter := GETFILTER("Document No.");
              Description := GETFILTER("Document Line No.");
            END;
        END;
        EXIT(STRSUBSTNO('%1 %2 %3',SourceTableName,SourceFilter,Description));
    end;
}

