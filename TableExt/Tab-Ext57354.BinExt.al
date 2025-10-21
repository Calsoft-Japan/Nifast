tableextension 57354 "Bin Ext" extends "Bin"
{
    fields
    {
        field(50001; "Location Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code")));
        }
        field(14017991; "Bin Size Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14017994; "Pick Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14017997; "Staging Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14018000; "License Plate Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14018070; "QC Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
    PROCEDURE GetLotBinContents(VAR TempLotBinContent: Record 50001 TEMPORARY);
    VAR
        LotNoInfo: Record 6505;
        WhseEntry: Record 7312;
        ItemUnitOfMeasure: Record 5404;
        BinContent: Record 7302;
    BEGIN
        TempLotBinContent.DELETEALL;

        //loop through whse. entry
        WhseEntry.SETCURRENTKEY("Item No.", Open, Positive, "Location Code", "Zone Code",
                                  "Bin Code", "Serial No.", "Lot No.", "Expiration Date", "Posting Date");

        WhseEntry.SETRANGE(Open, TRUE);
        WhseEntry.SETFILTER("Location Code", Rec."Location Code");
        WhseEntry.SETRANGE("Bin Code", Rec.Code);
        IF WhseEntry.FIND('-') THEN
            REPEAT
                WITH TempLotBinContent DO BEGIN
                    //get Lot Info record if exists
                    IF NOT LotNoInfo.GET(WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Lot No.") THEN
                        CLEAR(LotNoInfo);


                    IF NOT TempLotBinContent.GET(WhseEntry."Location Code", WhseEntry."Bin Code", WhseEntry."Item No.",
                         WhseEntry."Variant Code", WhseEntry."Unit of Measure Code", WhseEntry."Lot No.") THEN BEGIN
                        "Location Code" := WhseEntry."Location Code";
                        "Bin Code" := WhseEntry."Bin Code";
                        "Item No." := WhseEntry."Item No.";
                        "Variant Code" := WhseEntry."Variant Code";
                        "Unit of Measure Code" := WhseEntry."Unit of Measure Code";
                        "Lot No." := WhseEntry."Lot No.";
                        "Zone Code" := WhseEntry."Zone Code";
                        "Bin Type Code" := WhseEntry."Bin Type Code";
                        //"Expiration Date" := LotNoInfo."Expiration Date";
                        "Creation Date" := LotNoInfo."Lot Creation Date";
                        "External Lot No." := LotNoInfo."Mfg. Lot No.";

                        //get qty per unit of measure
                        ItemUnitOfMeasure.GET("Item No.", "Unit of Measure Code");
                        "Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";

                        //get bin fields
                        "Warehouse Class Code" := Rec."Warehouse Class Code";
                        "Bin Ranking" := Rec."Bin Ranking";
                        "Cross-Dock Bin" := Rec."Cross-Dock Bin";
                        Default := Rec.Default;
                        IF BinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") THEN
                            "Block Movement" := BinContent."Block Movement"
                        ELSE
                            "Block Movement" := Rec."Block Movement";
                        INSERT;
                    END;
                END;
            UNTIL WhseEntry.NEXT = 0;
    END;


}

