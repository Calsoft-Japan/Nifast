codeunit 50026 "JRR Test"
{
    Permissions = TableData 14=rimd,
                  TableData 38=rimd,
                  TableData 121=rimd,
                  TableData 7312=rimd;

    trigger OnRun()
    var
        WHE: Record "7312";
        PH: Record "38";
        prl: Record "121";
        Loc: Record "14";
    begin
        IF Loc.GET('ROMECON') THEN BEGIN
        Loc."Use As In-Transit" := TRUE;
        Loc.MODIFY();
        END;
        EXIT;
        /*
          prl.SETRANGE("Document No.",'PREC81025');
          IF prl.FINDFIRST THEN  BEGIN
             prl."Pay-to Vendor No." := '08900';
             prl.MODIFY;
        
        
           END;
        
        
        
         PH.SETRANGE("No.",'PO18663');
         IF PH.FINDFIRST THEN BEGIN
          PH."Pay-to Vendor No.":=  PH."Buy-from Vendor No.";
          PH."Pay-to Name":=  PH."Buy-from Vendor Name";
          PH."Pay-to Name 2":=   PH."Buy-from Vendor Name 2";
          PH."Pay-to Address":=   PH."Buy-from Address";
          PH."Pay-to Address 2":=   PH."Buy-from Address 2";
          PH."Pay-to City":=   PH."Buy-from City";
          PH."Pay-to Contact":=   PH."Buy-from Contact";
          PH."Pay-to Post Code":=   PH."Buy-from Post Code";
          PH."Pay-to County":=   PH."Buy-from County";
          PH."Pay-to Country/Region Code":=   PH."Buy-from Country/Region Code";
          PH.MODIFY();
        END;
        */
        
        EXIT;
        
        
        
         /*
          IF WHE.GET(147349) THEN  BEGIN     //-1000
            WHE.Quantity :=-1000;
           WHE."Qty. (Base)"  :=-1000;
           WHE.MODIFY;
         END;
         IF WHE.GET(147350) THEN  BEGIN     //-6k
            WHE.Quantity :=-6000;
           WHE."Qty. (Base)"  :=-6000;
           WHE.MODIFY;
         END;
         IF WHE.GET(147351) THEN  BEGIN   //-2k
            WHE.Quantity :=-2000;
           WHE."Qty. (Base)"  :=-2000;
           WHE.MODIFY;
         END;
         IF WHE.GET(147352) THEN  BEGIN    //-2k
            WHE.Quantity :=-2000;
           WHE."Qty. (Base)"  :=-2000;
           WHE.MODIFY;
         END;
        */
        EXIT;

    end;
}

