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
        InsertRepSelection(ReportSelections.Usage::"S.Quote".AsInteger(), '1', REPORT::"Sales Quote NA");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket".AsInteger(), '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order".AsInteger(),'1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order".AsInteger(), '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice".AsInteger(), '1', REPORT::"Sales Invoice NA");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return".AsInteger(), '1', REPORT::"Return Authorization");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo".AsInteger(), '1', REPORT::"Sales Credit Memo NA");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment".AsInteger(), '1', REPORT::"Sales Shipment NA");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.".AsInteger(), '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test".AsInteger(), '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote".AsInteger(), '1', REPORT::"Purchase - Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket".AsInteger(), '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order".AsInteger(), '1', REPORT::"Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Purchase - Invoice");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo".AsInteger(), '1', REPORT::"Purchase Credit Memo NA");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt".AsInteger(), '1', REPORT::"Purchase Receipt NA");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.".AsInteger(), '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test".AsInteger(), '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check".AsInteger(), '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder.AsInteger(), '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge".AsInteger(), '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test".AsInteger(), '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test".AsInteger(), '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1.AsInteger(), '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2.AsInteger(), '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3.AsInteger(), '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt.Period Test".AsInteger(), '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt".AsInteger(), '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test".AsInteger(), '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod.Order".AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1.AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2.AsInteger(), '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3.AsInteger(), '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote".AsInteger(), '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order".AsInteger(), '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice".AsInteger(), '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo".AsInteger(), '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment".AsInteger(), '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote".AsInteger(), '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract".AsInteger(), '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test".AsInteger(), '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm.Order".AsInteger(), '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Asm.Order".AsInteger(), '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.".AsInteger(), '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.".AsInteger(), '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Quote".AsInteger(), '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Order".AsInteger(), '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Quote".AsInteger(), '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Order".AsInteger(), '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Return".AsInteger(), '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Return".AsInteger(), '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction".AsInteger(), '1', REPORT::"Pick Instruction");
    end;

    local procedure CanadaInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote".AsInteger(), '1', REPORT::"Sales Quote NA");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket".AsInteger(), '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order".AsInteger(), '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order".AsInteger(), '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice".AsInteger(), '1', REPORT::"Sales Invoice CNF");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return".AsInteger(), '1', REPORT::"Return Order Confirmation NV");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo".AsInteger(), '1', REPORT::"SALES CREDIT MEMO NA");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment".AsInteger(), '1', REPORT::"Sales Shpt. Packing List - CNF");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.".AsInteger(), '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test".AsInteger(), '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote".AsInteger(), '1', REPORT::"Purchase - Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket".AsInteger(), '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order".AsInteger(), '1', REPORT::"Purchase Order CNF");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Purchase - Invoice");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo".AsInteger(), '1', REPORT::"Purchase Credit Memo NA");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt".AsInteger(), '1', REPORT::"Receiving Report");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.".AsInteger(), '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test".AsInteger(), '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check".AsInteger(), '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder.AsInteger(), '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge".AsInteger(), '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test".AsInteger(), '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test".AsInteger(), '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1.AsInteger(), '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2.AsInteger(), '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3.AsInteger(), '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Phys.Invt.Order".AsInteger(), '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt".AsInteger(), '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test".AsInteger(), '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod.Order".AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1.AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2.AsInteger(), '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3.AsInteger(), '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote".AsInteger(), '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order".AsInteger(), '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice".AsInteger(), '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo".AsInteger(), '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment".AsInteger(), '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote".AsInteger(), '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract".AsInteger(), '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test".AsInteger(), '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm.Order".AsInteger(), '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Asm.Order".AsInteger(), '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.".AsInteger(), '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.".AsInteger(), '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Quote".AsInteger(), '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Order".AsInteger(), '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Quote".AsInteger(), '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Order".AsInteger(), '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Return".AsInteger(), '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Return".AsInteger(), '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction".AsInteger(), '1', REPORT::"Pick Instruction");
    end;

    local procedure MexicanaInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote".AsInteger(), '1', REPORT::"Sales Quote NA");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket".AsInteger(), '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order".AsInteger(), '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order".AsInteger(), '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice".AsInteger(), '1', REPORT::"MEX Sales Invoice");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return".AsInteger(), '1', REPORT::"Return Authorization");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo".AsInteger(), '1', REPORT::"Sales Credit Memo NA");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment".AsInteger(), '1', REPORT::"MEX Sales Shipment");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.".AsInteger(), '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test".AsInteger(), '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote".AsInteger(), '1', REPORT::"Purchase - Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket".AsInteger(), '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order".AsInteger(), '1', REPORT::"Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Purchase Invoice NA");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo".AsInteger(), '1', REPORT::"Purchase Credit Memo NA");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt".AsInteger(), '1', REPORT::"Purchase Receipt NA");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.".AsInteger(), '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test".AsInteger(), '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check".AsInteger(), '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder.AsInteger(), '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge".AsInteger(), '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test".AsInteger(), '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test".AsInteger(), '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1.AsInteger(), '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2.AsInteger(), '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3.AsInteger(), '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt.Period Test".AsInteger(), '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt".AsInteger(), '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test".AsInteger(), '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod.Order".AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1.AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2.AsInteger(), '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3.AsInteger(), '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote".AsInteger(), '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order".AsInteger(), '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice".AsInteger(), '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo".AsInteger(), '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment".AsInteger(), '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote".AsInteger(), '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract".AsInteger(), '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test".AsInteger(), '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm.Order".AsInteger(), '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Asm.Order".AsInteger(), '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.".AsInteger(), '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.".AsInteger(), '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Quote".AsInteger(), '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Order".AsInteger(), '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Quote".AsInteger(), '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Order".AsInteger(), '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Return".AsInteger(), '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Return".AsInteger(), '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction".AsInteger(), '1', REPORT::"Pick Instruction");
    end;

    local procedure CorporateInitReportSelection()
    var
        ReportSelections: Record 77;
    begin
        ReportSelections.RESET();
        ReportSelections.DELETEALL();
        InsertRepSelection(ReportSelections.Usage::"S.Quote".AsInteger(), '1', REPORT::"Sales Quote NA");
        // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
        InsertRepSelection(ReportSelections.Usage::"S.Blanket".AsInteger(), '1', REPORT::"Sales Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order".AsInteger(), '1', REPORT::"Sales Order NV");
        InsertRepSelection(ReportSelections.Usage::"S.Work Order".AsInteger(), '1', REPORT::"Work Order");
        InsertRepSelection(ReportSelections.Usage::"S.Invoice".AsInteger(), '1', REPORT::"Nifast-Sales Invoice NV");
        // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
        InsertRepSelection(ReportSelections.Usage::"S.Return".AsInteger(), '1', REPORT::"Return Order Confirmation NV");
        InsertRepSelection(ReportSelections.Usage::"S.Cr.Memo".AsInteger(), '1', REPORT::"Sales Credit Memo NA");
        InsertRepSelection(ReportSelections.Usage::"S.Shipment".AsInteger(), '1', REPORT::"Sales - Shipment");
        InsertRepSelection(ReportSelections.Usage::"S.Ret.Rcpt.".AsInteger(), '1', REPORT::"Return Receipt");
        InsertRepSelection(ReportSelections.Usage::"S.Test".AsInteger(), '1', REPORT::"Sales Document - Test");
        InsertRepSelection(ReportSelections.Usage::"P.Quote".AsInteger(), '1', REPORT::"Purchase - Quote");
        // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Blanket".AsInteger(), '1', REPORT::"Purchase Blanket Order");
        InsertRepSelection(ReportSelections.Usage::"P.Order".AsInteger(), '1', REPORT::"Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Purchase Invoice NA");
        InsertRepSelection(ReportSelections.Usage::"P.Invoice".AsInteger(), '1', REPORT::"Return Order");
        InsertRepSelection(ReportSelections.Usage::"P.Cr.Memo".AsInteger(), '1', REPORT::"Purchase - Credit Memo");
        InsertRepSelection(ReportSelections.Usage::"P.Receipt".AsInteger(), '1', REPORT::"Receiving Report");
        InsertRepSelection(ReportSelections.Usage::"P.Ret.Shpt.".AsInteger(), '1', REPORT::"Return Shipment");
        InsertRepSelection(ReportSelections.Usage::"P.Test".AsInteger(), '1', REPORT::"Purchase Document - Test");
        InsertRepSelection(ReportSelections.Usage::"B.Check".AsInteger(), '1', REPORT::Check);
        InsertRepSelection(ReportSelections.Usage::Reminder.AsInteger(), '1', REPORT::Reminder);
        InsertRepSelection(ReportSelections.Usage::"Fin.Charge".AsInteger(), '1', REPORT::"Finance Charge Memo");
        InsertRepSelection(ReportSelections.Usage::"Rem.Test".AsInteger(), '1', REPORT::"Reminder - Test");
        InsertRepSelection(ReportSelections.Usage::"F.C.Test".AsInteger(), '1', REPORT::"Finance Charge Memo - Test");
        InsertRepSelection(ReportSelections.Usage::Inv1.AsInteger(), '1', REPORT::"Transfer Order");
        InsertRepSelection(ReportSelections.Usage::Inv2.AsInteger(), '1', REPORT::"Transfer Shipment");
        InsertRepSelection(ReportSelections.Usage::Inv3.AsInteger(), '1', REPORT::"Transfer Receipt");
        InsertRepSelection(ReportSelections.Usage::"Invt.Period Test".AsInteger(), '1', REPORT::"Close Inventory Period - Test");
        // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
        InsertRepSelection(ReportSelections.Usage::"B.Stmt".AsInteger(), '1', REPORT::"Bank Account Statement");
        // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
        InsertRepSelection(ReportSelections.Usage::"B.Recon.Test".AsInteger(), '1', REPORT::"Bank Acc. Recon. - Test");
        InsertRepSelection(ReportSelections.Usage::"Prod.Order".AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M1.AsInteger(), '1', REPORT::"Prod. Order - Job Card");
        InsertRepSelection(ReportSelections.Usage::M2.AsInteger(), '1', REPORT::"Prod. Order - Mat. Requisition");
        InsertRepSelection(ReportSelections.Usage::M3.AsInteger(), '1', REPORT::"Prod. Order - Shortage List");
        InsertRepSelection(ReportSelections.Usage::"SM.Quote".AsInteger(), '1', REPORT::"Service Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Order".AsInteger(), '1', REPORT::"Service Order");
        InsertRepSelection(ReportSelections.Usage::"SM.Invoice".AsInteger(), '1', REPORT::"Service Invoice-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Credit Memo".AsInteger(), '1', REPORT::"Service Credit Memo-Sales Tax");
        InsertRepSelection(ReportSelections.Usage::"SM.Shipment".AsInteger(), '1', REPORT::"Service - Shipment");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract Quote".AsInteger(), '1', REPORT::"Service Contract Quote");
        InsertRepSelection(ReportSelections.Usage::"SM.Contract".AsInteger(), '1', REPORT::"Service Contract");
        InsertRepSelection(ReportSelections.Usage::"SM.Test".AsInteger(), '1', REPORT::"Service Document - Test");
        InsertRepSelection(ReportSelections.Usage::"Asm.Order".AsInteger(), '1', REPORT::"Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"P.Asm.Order".AsInteger(), '1', REPORT::"Posted Assembly Order");
        InsertRepSelection(ReportSelections.Usage::"S.Test Prepmt.".AsInteger(), '1', REPORT::"Sales Prepmt. Document Test");
        InsertRepSelection(ReportSelections.Usage::"P.Test Prepmt.".AsInteger(), '1', REPORT::"Purchase Prepmt. Doc. - Test");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Quote".AsInteger(), '1', REPORT::"Archived Sales Quote");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Order".AsInteger(), '1', REPORT::"Archived Sales Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Quote".AsInteger(), '1', REPORT::"Archived Purchase Quote");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Order".AsInteger(), '1', REPORT::"Archived Purchase Order");
        InsertRepSelection(ReportSelections.Usage::"P.Arch.Return".AsInteger(), '1', REPORT::"Arch.Purch. Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Arch.Return".AsInteger(), '1', REPORT::"Arch. Sales Return Order");
        InsertRepSelection(ReportSelections.Usage::"S.Order Pick Instruction".AsInteger(), '1', REPORT::"Pick Instruction");
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

