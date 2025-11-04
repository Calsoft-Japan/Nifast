codeunit 50029 CU378Subscriber
{
    //Version NAVW17.00,NV4.00,NIF.N15.C9IN.001;

    PROCEDURE ProdKitCheckIfAnyExtText(Unconditionally: Boolean): Boolean;
    VAR
    //ExtTextHeader: Record 279;
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //MakeUpdateRequired := FALSE;
        //IF ProdKitLine."Line No." <> 0 THEN
        //  MakeUpdateRequired := DeleteProdKitLines(ProdKitLine);

        //AutoText := FALSE;

        //IF Unconditionally THEN
        //  AutoText := TRUE
        //ELSE
        //  CASE ProdKitLine.Type OF
        //    ProdKitLine.Type::"0":
        //      AutoText := TRUE;
        //    ProdKitLine.Type::"1":
        //      BEGIN
        //        IF Item.GET(ProdKitLine."No.") THEN
        //          AutoText := Item."Automatic Ext. Texts";
        //      END;
        //    ProdKitLine.Type::"2":
        //      BEGIN
        //        IF Res.GET(ProdKitLine."No.") THEN
        //          AutoText := Res."Automatic Ext. Texts";
        //      END;
        //  END;

        //IF AutoText THEN BEGIN
        //  ProdKitLine.TESTFIELD("Production Kit No.");
        //  ProdKitHeader.GET(ProdKitLine."Production Kit No.");
        //  CASE ProdKitLine.Type OF
        //    ProdKitLine.Type::"0": ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::"Standard Text");
        //    ProdKitLine.Type::"1": ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::Item);
        //    ProdKitLine.Type::"2": ExtTextHeader.SETRANGE("Table Name",ExtTextHeader."Table Name"::Resource);
        //  END;
        //  ExtTextHeader.SETRANGE("No.",ProdKitLine."No.");
        //  ExtTextHeader.SETRANGE("Production Kit",TRUE);
        //  EXIT(ReadLines(ExtTextHeader,ProdKitHeader."Document Date",''));
        //END;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE InsertProdKitExtText();
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //ToProdKitLine.RESET;
        //ToProdKitLine.SETRANGE("Production Kit No.",ProdKitLine."Production Kit No.");
        //ToProdKitLine := ProdKitLine;
        //IF ToProdKitLine.FIND('>') THEN BEGIN
        //  LineSpacing :=
        //    (ToProdKitLine."Line No." - ProdKitLine."Line No.") DIV
        //    (1 + TmpExtTextLine.COUNT);
        //  IF LineSpacing = 0 THEN
        //    ERROR(Text000);
        //END ELSE
        //  LineSpacing := 10000;

        //NextLineNo := ProdKitLine."Line No." + LineSpacing;

        //TmpExtTextLine.RESET;
        //IF TmpExtTextLine.FIND('-') THEN BEGIN
        //  REPEAT
        //    ToProdKitLine.INIT;
        //    ToProdKitLine."Production Kit No." := ProdKitLine."Production Kit No.";
        //    ToProdKitLine."Line No." := NextLineNo;
        //    NextLineNo := NextLineNo + LineSpacing;
        //    ToProdKitLine.Description := TmpExtTextLine.Text;
        //    ToProdKitLine."Attached to Line No." := ProdKitLine."Line No.";
        //    ToProdKitLine.INSERT;
        //  UNTIL TmpExtTextLine.NEXT = 0;
        //  MakeUpdateRequired := TRUE;
        //END;
        //TmpExtTextLine.DELETEALL;
        //<< NF1.00:CIS.CM 09-29-15
    END;

    PROCEDURE DeleteProdKitLines(): Boolean;
    BEGIN
        //>> NF1.00:CIS.CM 09-29-15
        //ProdKitLine2.SETRANGE("Production Kit No.",ProdKitLine."Production Kit No.");
        //ProdKitLine2.SETRANGE("Attached to Line No.",ProdKitLine."Line No.");
        //ProdKitLine2 := ProdKitLine;
        //IF ProdKitLine2.FIND('>') THEN BEGIN
        //  REPEAT
        //    ProdKitLine2.DELETE;
        //  UNTIL ProdKitLine2.NEXT = 0;
        //  EXIT(TRUE);
        //END;
        //<< NF1.00:CIS.CM 09-29-15
    END;
}