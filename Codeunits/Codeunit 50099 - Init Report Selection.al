codeunit 50099 "Init Report Selection"
{

    trigger OnRun()
    begin
        CASE COMPANYNAME OF
            'BQG North America':
                BaseInitReportSelection();
            'NIFAST Canada':
                CanadaInitReportSelection();
            'NIFAST Mexicana':
                MexicanaInitReportSelection();
            'NIFAST MEXICO USD':
                BaseInitReportSelection();
            'NIFAST CORPORATION':
                CorporateInitReportSelection();
            ELSE
                ERROR('%1 - Company Not fonund', COMPANYNAME);
        END;
        MESSAGE('DONE');
    end;

    local procedure BaseInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote", '1', REPORT::"Sales Quote");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket", '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order", '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order", '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice", '1', REPORT::"Sales Invoice");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return", '1', REPORT::"Return Authorization");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo", '1', REPORT::"Sales Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment", '1', REPORT::"Sales Shipment");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.", '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test", '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote", '1', REPORT::"Purchase Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket", '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order", '1', REPORT::"Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice", '1', REPORT::"Purchase Invoice");
        InsertRepSelection(ReportSelections.Usage::"P.Return", '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo", '1', REPORT::"Purchase Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt", '1', REPORT::"Purchase Receipt");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.", '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test", '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check", '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder, '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge", '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test", '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test", '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1, '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2, '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3, '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt. Period Test", '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt", '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test", '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod. Order", '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1, '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2, '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3, '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote", '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order", '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice", '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo", '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment", '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote", '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract", '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test", '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm. Order", '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Assembly Order", '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.", '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.", '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Quote", '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Order", '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Quote", '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Order", '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P. Arch. Return Order", '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S. Arch. Return Order", '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction", '1', REPORT::"Pick Instruction");
    end;

    local procedure CanadaInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote", '1', REPORT::"Sales Quote");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket", '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order", '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order", '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice", '1', REPORT::"Sales Invoice CNF");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return", '1', REPORT::"Return Order Confirmation NV");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo", '1', REPORT::"Sales Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment", '1', REPORT::"Sales Shpt. Packing List - CNF");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.", '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test", '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote", '1', REPORT::"Purchase Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket", '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order", '1', REPORT::"Purchase Order CNF");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice", '1', REPORT::"Purchase Invoice");
        InsertRepSelection(ReportSelections.Usage::"P.Return", '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo", '1', REPORT::"Purchase Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt", '1', REPORT::"Receiving Report");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.", '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test", '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check", '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder, '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge", '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test", '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test", '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1, '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2, '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3, '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt. Period Test", '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt", '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test", '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod. Order", '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1, '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2, '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3, '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote", '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order", '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice", '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo", '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment", '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote", '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract", '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test", '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm. Order", '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Assembly Order", '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.", '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.", '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Quote", '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Order", '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Quote", '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Order", '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P. Arch. Return Order", '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S. Arch. Return Order", '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction", '1', REPORT::"Pick Instruction");
    end;

    local procedure MexicanaInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote", '1', REPORT::"Sales Quote");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket", '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order", '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order", '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice", '1', REPORT::"MEX Sales Invoice");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return", '1', REPORT::"Return Authorization");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo", '1', REPORT::"Sales Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment", '1', REPORT::"MEX Sales Shipment");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.", '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test", '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote", '1', REPORT::"Purchase Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket", '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order", '1', REPORT::"Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice", '1', REPORT::"Purchase Invoice");
        InsertRepSelection(ReportSelections.Usage::"P.Return", '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo", '1', REPORT::"Purchase Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt", '1', REPORT::"Purchase Receipt");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.", '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test", '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check", '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder, '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge", '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test", '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test", '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1, '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2, '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3, '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt. Period Test", '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt", '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test", '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod. Order", '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1, '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2, '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3, '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote", '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order", '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice", '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo", '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment", '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote", '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract", '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test", '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm. Order", '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Assembly Order", '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.", '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.", '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Quote", '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Order", '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Quote", '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Order", '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P. Arch. Return Order", '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S. Arch. Return Order", '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction", '1', REPORT::"Pick Instruction");
    end;

    local procedure CorporateInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote", '1', REPORT::"Sales Quote");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket", '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order", '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order", '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice", '1', REPORT::"Nifast-Sales Invoice NV");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return", '1', REPORT::"Return Order Confirmation NV");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo", '1', REPORT::"Sales Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment", '1', REPORT::"Sales Shipment");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.", '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test", '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote", '1', REPORT::"Purchase Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket", '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order", '1', REPORT::"Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice", '1', REPORT::"Purchase Invoice");
        InsertRepSelection(ReportSelections.Usage::"P.Return", '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo", '1', REPORT::"Purchase Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt", '1', REPORT::"Receiving Report");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.", '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test", '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check", '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder, '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge", '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test", '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test", '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1, '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2, '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3, '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt. Period Test", '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt", '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test", '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod. Order", '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1, '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2, '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3, '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote", '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order", '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice", '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo", '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment", '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote", '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract", '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test", '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm. Order", '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Assembly Order", '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.", '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.", '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Quote", '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch. Order", '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Quote", '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch. Order", '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P. Arch. Return Order", '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S. Arch. Return Order", '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction", '1', REPORT::"Pick Instruction");
    end;

    local procedure InsertRepSelection(ReportUsage: Integer; Sequence: Code[10]; ReportID: Integer)
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.INIT();
        ReportSelections.Usage := ReportUsage;
        ReportSelections.Sequence := Sequence;
        ReportSelections."Report ID" := ReportID;
        ReportSelections.INSERT();
    end;
}

