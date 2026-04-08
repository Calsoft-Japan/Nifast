tableextension 57354 "Bin Ext" extends "Bin"
{
    fields
    {
        field(50001; "Location Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Location.Name WHERE(Code = FIELD("Location Code")));
        }
        field(70000; "Bin Size Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Pick Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Staging Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "License Plate Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "QC Bin"; Boolean)
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
                //get Lot Info record if exists
                IF NOT LotNoInfo.GET(WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Lot No.") THEN
                    CLEAR(LotNoInfo);


                IF NOT TempLotBinContent.GET(WhseEntry."Location Code", WhseEntry."Bin Code", WhseEntry."Item No.",
                     WhseEntry."Variant Code", WhseEntry."Unit of Measure Code", WhseEntry."Lot No.") THEN BEGIN
                    TempLotBinContent."Location Code" := WhseEntry."Location Code";
                    TempLotBinContent."Bin Code" := WhseEntry."Bin Code";
                    TempLotBinContent."Item No." := WhseEntry."Item No.";
                    TempLotBinContent."Variant Code" := WhseEntry."Variant Code";
                    TempLotBinContent."Unit of Measure Code" := WhseEntry."Unit of Measure Code";
                    TempLotBinContent."Lot No." := WhseEntry."Lot No.";
                    TempLotBinContent."Zone Code" := WhseEntry."Zone Code";
                    TempLotBinContent."Bin Type Code" := WhseEntry."Bin Type Code";
                    //"Expiration Date" := LotNoInfo."Expiration Date";
                    TempLotBinContent."Creation Date" := LotNoInfo."Lot Creation Date";
                    TempLotBinContent."External Lot No." := LotNoInfo."Mfg. Lot No.";

                    //get qty per unit of measure
                    ItemUnitOfMeasure.GET(TempLotBinContent."Item No.", TempLotBinContent."Unit of Measure Code");
                    TempLotBinContent."Qty. per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";

                    //get bin fields
                    TempLotBinContent."Warehouse Class Code" := Rec."Warehouse Class Code";
                    TempLotBinContent."Bin Ranking" := Rec."Bin Ranking";
                    TempLotBinContent."Cross-Dock Bin" := Rec."Cross-Dock Bin";
                    TempLotBinContent.Default := Rec.Default;
                    IF BinContent.GET(TempLotBinContent."Location Code", TempLotBinContent."Bin Code", TempLotBinContent."Item No.", TempLotBinContent."Variant Code", TempLotBinContent."Unit of Measure Code") THEN
                        TempLotBinContent."Block Movement" := BinContent."Block Movement"
                    ELSE
                        TempLotBinContent."Block Movement" := Rec."Block Movement";
                    TempLotBinContent.INSERT;
                END;
            UNTIL WhseEntry.NEXT = 0;
    END;


}

