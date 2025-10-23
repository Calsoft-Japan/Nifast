codeunit 50041 CU5815Subscriber
{
    //Version NAVW18.00,NIF1.063,NIF.N15.C9IN.001;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", OnPostItemJnlLineOnAfterInsertTempWhseJnlLine, '', false, false)]
    local procedure OnPostItemJnlLineOnAfterInsertTempWhseJnlLine(SalesShptLine: Record "Sales Shipment Line"; var ItemJnlLine: Record "Item Journal Line"; var TempWhseJnlLine: Record "Warehouse Journal Line" temporary; var NextLineNo: Integer)
    var
        SalesLine: Record 37;
        WhseUndoQty: Codeunit CU_7320;
    //  HideDialog: Boolean;
    begin
        //>> NF1.00:CIS.NG    09/12/16
        WhseUndoQty.InsertTempWhseJnlLine_gFNc(ItemJnlLine,
          DATABASE::"Sales Line",
          SalesLine."Document Type"::Order,
          SalesShptLine."Order No.",
          SalesShptLine."Order Line No.",
          TempWhseJnlLine."Reference Document"::"Posted Shipment",
          TempWhseJnlLine,
          NextLineNo,
          SalesShptLine);
        //<< NF1.00:CIS.NG    09/12/16

        //>>NIF 051506 RTT
        //  {
        //  WhseUndoQty.CreateWhseJnlLine(ItemJnlLine,
        //    DATABASE::"Sales Line",
        //    1,
        //    SalesShptLine."Order No.",
        //    SalesShptLine."Order Line No.",
        //    5,
        //    TempWhseJnlLine,
        //    NextLineNo);
        //  }
        //>> NF1.00:CIS.NG    09/12/16
        //WhseUndoQty.CreateWhseJnlLine2(ItemJnlLine,
        //  DATABASE::"Sales Line",
        //  1,
        //  SalesShptLine."Order No.",
        //  SalesShptLine."Order Line No.",
        //  SalesShptLine."Document No.",
        //  TempWhseJnlLine,
        //  NextLineNo);
        //<< NF1.00:CIS.NG    09/12/16
        //<<NIF 051506 RTT
    end;
}