codeunit 50099 "Init Report Selection"
{

    trigger OnRun()
    begin
        CASE COMPANYNAME OF
          'BQG North America': BaseInitReportSelection;
          'NIFAST Canada': CanadaInitReportSelection;
          'NIFAST Mexicana': MexicanaInitReportSelection;
          'NIFAST MEXICO USD': BaseInitReportSelection;
          'NIFAST CORPORATION': CorporateInitReportSelection;
          ELSE
            ERROR('%1 - Company Not fonund',COMPANYNAME);
        END;
        MESSAGE('DONE');
    end;

    local procedure BaseInitReportSelection()
    var
        ReportSelections: Record "77";
    begin
        WITH ReportSelections DO BEGIN
          RESET;
          DELETEALL;
          InsertRepSelection(Usage::"S.Quote",'1',REPORT::"Sales Quote");
          // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
          InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Sales Blanket Order");
          InsertRepSelection(Usage::"S.Order",'1',REPORT::"Sales Order NV");
          InsertRepSelection(Usage::"S.Work Order",'1',REPORT::"Work Order");
          InsertRepSelection(Usage::"S.Invoice",'1',REPORT::"Sales Invoice");
          // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
          InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Authorization");
          InsertRepSelection(Usage::"S.Cr.Memo",'1',REPORT::"Sales Credit Memo");
          InsertRepSelection(Usage::"S.Shipment",'1',REPORT::"Sales Shipment");
          InsertRepSelection(Usage::"S.Ret.Rcpt.",'1',REPORT::"Return Receipt");
          InsertRepSelection(Usage::"S.Test",'1',REPORT::"Sales Document - Test");
          InsertRepSelection(Usage::"P.Quote",'1',REPORT::"Purchase Quote");
          // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
          InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Purchase Blanket Order");
          InsertRepSelection(Usage::"P.Order",'1',REPORT::"Purchase Order");
          InsertRepSelection(Usage::"P.Invoice",'1',REPORT::"Purchase Invoice");
          InsertRepSelection(Usage::"P.Return",'1',REPORT::"Return Order");
          InsertRepSelection(Usage::"P.Cr.Memo",'1',REPORT::"Purchase Credit Memo");
          InsertRepSelection(Usage::"P.Receipt",'1',REPORT::"Purchase Receipt");
          InsertRepSelection(Usage::"P.Ret.Shpt.",'1',REPORT::"Return Shipment");
          InsertRepSelection(Usage::"P.Test",'1',REPORT::"Purchase Document - Test");
          InsertRepSelection(Usage::"B.Check",'1',REPORT::Check);
          InsertRepSelection(Usage::Reminder,'1',REPORT::Reminder);
          InsertRepSelection(Usage::"Fin.Charge",'1',REPORT::"Finance Charge Memo");
          InsertRepSelection(Usage::"Rem.Test",'1',REPORT::"Reminder - Test");
          InsertRepSelection(Usage::"F.C.Test",'1',REPORT::"Finance Charge Memo - Test");
          InsertRepSelection(Usage::Inv1,'1',REPORT::"Transfer Order");
          InsertRepSelection(Usage::Inv2,'1',REPORT::"Transfer Shipment");
          InsertRepSelection(Usage::Inv3,'1',REPORT::"Transfer Receipt");
          InsertRepSelection(Usage::"Invt. Period Test",'1',REPORT::"Close Inventory Period - Test");
          // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
          InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Account Statement");
          // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
          InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Acc. Recon. - Test");
          InsertRepSelection(Usage::"Prod. Order",'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M1,'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M2,'1',REPORT::"Prod. Order - Mat. Requisition");
          InsertRepSelection(Usage::M3,'1',REPORT::"Prod. Order - Shortage List");
          InsertRepSelection(Usage::"SM.Quote",'1',REPORT::"Service Quote");
          InsertRepSelection(Usage::"SM.Order",'1',REPORT::"Service Order");
          InsertRepSelection(Usage::"SM.Invoice",'1',REPORT::"Service Invoice-Sales Tax");
          InsertRepSelection(Usage::"SM.Credit Memo",'1',REPORT::"Service Credit Memo-Sales Tax");
          InsertRepSelection(Usage::"SM.Shipment",'1',REPORT::"Service - Shipment");
          InsertRepSelection(Usage::"SM.Contract Quote",'1',REPORT::"Service Contract Quote");
          InsertRepSelection(Usage::"SM.Contract",'1',REPORT::"Service Contract");
          InsertRepSelection(Usage::"SM.Test",'1',REPORT::"Service Document - Test");
          InsertRepSelection(Usage::"Asm. Order",'1',REPORT::"Assembly Order");
          InsertRepSelection(Usage::"P.Assembly Order",'1',REPORT::"Posted Assembly Order");
          InsertRepSelection(Usage::"S.Test Prepmt.",'1',REPORT::"Sales Prepmt. Document Test");
          InsertRepSelection(Usage::"P.Test Prepmt.",'1',REPORT::"Purchase Prepmt. Doc. - Test");
          InsertRepSelection(Usage::"S.Arch. Quote",'1',REPORT::"Archived Sales Quote");
          InsertRepSelection(Usage::"S.Arch. Order",'1',REPORT::"Archived Sales Order");
          InsertRepSelection(Usage::"P.Arch. Quote",'1',REPORT::"Archived Purchase Quote");
          InsertRepSelection(Usage::"P.Arch. Order",'1',REPORT::"Archived Purchase Order");
          InsertRepSelection(Usage::"P. Arch. Return Order",'1',REPORT::"Arch.Purch. Return Order");
          InsertRepSelection(Usage::"S. Arch. Return Order",'1',REPORT::"Arch. Sales Return Order");
          InsertRepSelection(Usage::"S.Order Pick Instruction",'1',REPORT::"Pick Instruction");
        END;
    end;

    local procedure CanadaInitReportSelection()
    var
        ReportSelections: Record "77";
    begin
        WITH ReportSelections DO BEGIN
          RESET;
          DELETEALL;
          InsertRepSelection(Usage::"S.Quote",'1',REPORT::"Sales Quote");
          // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
          InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Sales Blanket Order");
          InsertRepSelection(Usage::"S.Order",'1',REPORT::"Sales Order NV");
          InsertRepSelection(Usage::"S.Work Order",'1',REPORT::"Work Order");
          InsertRepSelection(Usage::"S.Invoice",'1',REPORT::"Sales Invoice CNF");
          // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
          InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation NV");
          InsertRepSelection(Usage::"S.Cr.Memo",'1',REPORT::"Sales Credit Memo");
          InsertRepSelection(Usage::"S.Shipment",'1',REPORT::"Sales Shpt. Packing List - CNF");
          InsertRepSelection(Usage::"S.Ret.Rcpt.",'1',REPORT::"Return Receipt");
          InsertRepSelection(Usage::"S.Test",'1',REPORT::"Sales Document - Test");
          InsertRepSelection(Usage::"P.Quote",'1',REPORT::"Purchase Quote");
          // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
          InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Purchase Blanket Order");
          InsertRepSelection(Usage::"P.Order",'1',REPORT::"Purchase Order CNF");
          InsertRepSelection(Usage::"P.Invoice",'1',REPORT::"Purchase Invoice");
          InsertRepSelection(Usage::"P.Return",'1',REPORT::"Return Order");
          InsertRepSelection(Usage::"P.Cr.Memo",'1',REPORT::"Purchase Credit Memo");
          InsertRepSelection(Usage::"P.Receipt",'1',REPORT::"Receiving Report");
          InsertRepSelection(Usage::"P.Ret.Shpt.",'1',REPORT::"Return Shipment");
          InsertRepSelection(Usage::"P.Test",'1',REPORT::"Purchase Document - Test");
          InsertRepSelection(Usage::"B.Check",'1',REPORT::Check);
          InsertRepSelection(Usage::Reminder,'1',REPORT::Reminder);
          InsertRepSelection(Usage::"Fin.Charge",'1',REPORT::"Finance Charge Memo");
          InsertRepSelection(Usage::"Rem.Test",'1',REPORT::"Reminder - Test");
          InsertRepSelection(Usage::"F.C.Test",'1',REPORT::"Finance Charge Memo - Test");
          InsertRepSelection(Usage::Inv1,'1',REPORT::"Transfer Order");
          InsertRepSelection(Usage::Inv2,'1',REPORT::"Transfer Shipment");
          InsertRepSelection(Usage::Inv3,'1',REPORT::"Transfer Receipt");
          InsertRepSelection(Usage::"Invt. Period Test",'1',REPORT::"Close Inventory Period - Test");
          // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
          InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Account Statement");
          // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
          InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Acc. Recon. - Test");
          InsertRepSelection(Usage::"Prod. Order",'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M1,'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M2,'1',REPORT::"Prod. Order - Mat. Requisition");
          InsertRepSelection(Usage::M3,'1',REPORT::"Prod. Order - Shortage List");
          InsertRepSelection(Usage::"SM.Quote",'1',REPORT::"Service Quote");
          InsertRepSelection(Usage::"SM.Order",'1',REPORT::"Service Order");
          InsertRepSelection(Usage::"SM.Invoice",'1',REPORT::"Service Invoice-Sales Tax");
          InsertRepSelection(Usage::"SM.Credit Memo",'1',REPORT::"Service Credit Memo-Sales Tax");
          InsertRepSelection(Usage::"SM.Shipment",'1',REPORT::"Service - Shipment");
          InsertRepSelection(Usage::"SM.Contract Quote",'1',REPORT::"Service Contract Quote");
          InsertRepSelection(Usage::"SM.Contract",'1',REPORT::"Service Contract");
          InsertRepSelection(Usage::"SM.Test",'1',REPORT::"Service Document - Test");
          InsertRepSelection(Usage::"Asm. Order",'1',REPORT::"Assembly Order");
          InsertRepSelection(Usage::"P.Assembly Order",'1',REPORT::"Posted Assembly Order");
          InsertRepSelection(Usage::"S.Test Prepmt.",'1',REPORT::"Sales Prepmt. Document Test");
          InsertRepSelection(Usage::"P.Test Prepmt.",'1',REPORT::"Purchase Prepmt. Doc. - Test");
          InsertRepSelection(Usage::"S.Arch. Quote",'1',REPORT::"Archived Sales Quote");
          InsertRepSelection(Usage::"S.Arch. Order",'1',REPORT::"Archived Sales Order");
          InsertRepSelection(Usage::"P.Arch. Quote",'1',REPORT::"Archived Purchase Quote");
          InsertRepSelection(Usage::"P.Arch. Order",'1',REPORT::"Archived Purchase Order");
          InsertRepSelection(Usage::"P. Arch. Return Order",'1',REPORT::"Arch.Purch. Return Order");
          InsertRepSelection(Usage::"S. Arch. Return Order",'1',REPORT::"Arch. Sales Return Order");
          InsertRepSelection(Usage::"S.Order Pick Instruction",'1',REPORT::"Pick Instruction");
        END;
    end;

    local procedure MexicanaInitReportSelection()
    var
        ReportSelections: Record "77";
    begin
        WITH ReportSelections DO BEGIN
          RESET;
          DELETEALL;
          InsertRepSelection(Usage::"S.Quote",'1',REPORT::"Sales Quote");
          // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
          InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Sales Blanket Order");
          InsertRepSelection(Usage::"S.Order",'1',REPORT::"Sales Order NV");
          InsertRepSelection(Usage::"S.Work Order",'1',REPORT::"Work Order");
          InsertRepSelection(Usage::"S.Invoice",'1',REPORT::"MEX Sales Invoice");
          // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
          InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Authorization");
          InsertRepSelection(Usage::"S.Cr.Memo",'1',REPORT::"Sales Credit Memo");
          InsertRepSelection(Usage::"S.Shipment",'1',REPORT::"MEX Sales Shipment");
          InsertRepSelection(Usage::"S.Ret.Rcpt.",'1',REPORT::"Return Receipt");
          InsertRepSelection(Usage::"S.Test",'1',REPORT::"Sales Document - Test");
          InsertRepSelection(Usage::"P.Quote",'1',REPORT::"Purchase Quote");
          // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
          InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Purchase Blanket Order");
          InsertRepSelection(Usage::"P.Order",'1',REPORT::"Purchase Order");
          InsertRepSelection(Usage::"P.Invoice",'1',REPORT::"Purchase Invoice");
          InsertRepSelection(Usage::"P.Return",'1',REPORT::"Return Order");
          InsertRepSelection(Usage::"P.Cr.Memo",'1',REPORT::"Purchase Credit Memo");
          InsertRepSelection(Usage::"P.Receipt",'1',REPORT::"Purchase Receipt");
          InsertRepSelection(Usage::"P.Ret.Shpt.",'1',REPORT::"Return Shipment");
          InsertRepSelection(Usage::"P.Test",'1',REPORT::"Purchase Document - Test");
          InsertRepSelection(Usage::"B.Check",'1',REPORT::Check);
          InsertRepSelection(Usage::Reminder,'1',REPORT::Reminder);
          InsertRepSelection(Usage::"Fin.Charge",'1',REPORT::"Finance Charge Memo");
          InsertRepSelection(Usage::"Rem.Test",'1',REPORT::"Reminder - Test");
          InsertRepSelection(Usage::"F.C.Test",'1',REPORT::"Finance Charge Memo - Test");
          InsertRepSelection(Usage::Inv1,'1',REPORT::"Transfer Order");
          InsertRepSelection(Usage::Inv2,'1',REPORT::"Transfer Shipment");
          InsertRepSelection(Usage::Inv3,'1',REPORT::"Transfer Receipt");
          InsertRepSelection(Usage::"Invt. Period Test",'1',REPORT::"Close Inventory Period - Test");
          // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
          InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Account Statement");
          // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
          InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Acc. Recon. - Test");
          InsertRepSelection(Usage::"Prod. Order",'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M1,'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M2,'1',REPORT::"Prod. Order - Mat. Requisition");
          InsertRepSelection(Usage::M3,'1',REPORT::"Prod. Order - Shortage List");
          InsertRepSelection(Usage::"SM.Quote",'1',REPORT::"Service Quote");
          InsertRepSelection(Usage::"SM.Order",'1',REPORT::"Service Order");
          InsertRepSelection(Usage::"SM.Invoice",'1',REPORT::"Service Invoice-Sales Tax");
          InsertRepSelection(Usage::"SM.Credit Memo",'1',REPORT::"Service Credit Memo-Sales Tax");
          InsertRepSelection(Usage::"SM.Shipment",'1',REPORT::"Service - Shipment");
          InsertRepSelection(Usage::"SM.Contract Quote",'1',REPORT::"Service Contract Quote");
          InsertRepSelection(Usage::"SM.Contract",'1',REPORT::"Service Contract");
          InsertRepSelection(Usage::"SM.Test",'1',REPORT::"Service Document - Test");
          InsertRepSelection(Usage::"Asm. Order",'1',REPORT::"Assembly Order");
          InsertRepSelection(Usage::"P.Assembly Order",'1',REPORT::"Posted Assembly Order");
          InsertRepSelection(Usage::"S.Test Prepmt.",'1',REPORT::"Sales Prepmt. Document Test");
          InsertRepSelection(Usage::"P.Test Prepmt.",'1',REPORT::"Purchase Prepmt. Doc. - Test");
          InsertRepSelection(Usage::"S.Arch. Quote",'1',REPORT::"Archived Sales Quote");
          InsertRepSelection(Usage::"S.Arch. Order",'1',REPORT::"Archived Sales Order");
          InsertRepSelection(Usage::"P.Arch. Quote",'1',REPORT::"Archived Purchase Quote");
          InsertRepSelection(Usage::"P.Arch. Order",'1',REPORT::"Archived Purchase Order");
          InsertRepSelection(Usage::"P. Arch. Return Order",'1',REPORT::"Arch.Purch. Return Order");
          InsertRepSelection(Usage::"S. Arch. Return Order",'1',REPORT::"Arch. Sales Return Order");
          InsertRepSelection(Usage::"S.Order Pick Instruction",'1',REPORT::"Pick Instruction");
        END;
    end;

    local procedure CorporateInitReportSelection()
    var
        ReportSelections: Record "77";
    begin
        WITH ReportSelections DO BEGIN
          RESET;
          DELETEALL;
          InsertRepSelection(Usage::"S.Quote",'1',REPORT::"Sales Quote");
          // InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Blanket Sales Order");
          InsertRepSelection(Usage::"S.Blanket",'1',REPORT::"Sales Blanket Order");
          InsertRepSelection(Usage::"S.Order",'1',REPORT::"Sales Order NV");
          InsertRepSelection(Usage::"S.Work Order",'1',REPORT::"Work Order");
          InsertRepSelection(Usage::"S.Invoice",'1',REPORT::"Nifast-Sales Invoice NV");
          // InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation");
          InsertRepSelection(Usage::"S.Return",'1',REPORT::"Return Order Confirmation NV");
          InsertRepSelection(Usage::"S.Cr.Memo",'1',REPORT::"Sales Credit Memo");
          InsertRepSelection(Usage::"S.Shipment",'1',REPORT::"Sales Shipment");
          InsertRepSelection(Usage::"S.Ret.Rcpt.",'1',REPORT::"Return Receipt");
          InsertRepSelection(Usage::"S.Test",'1',REPORT::"Sales Document - Test");
          InsertRepSelection(Usage::"P.Quote",'1',REPORT::"Purchase Quote");
          // InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Blanket Purchase Order");
          InsertRepSelection(Usage::"P.Blanket",'1',REPORT::"Purchase Blanket Order");
          InsertRepSelection(Usage::"P.Order",'1',REPORT::"Purchase Order");
          InsertRepSelection(Usage::"P.Invoice",'1',REPORT::"Purchase Invoice");
          InsertRepSelection(Usage::"P.Return",'1',REPORT::"Return Order");
          InsertRepSelection(Usage::"P.Cr.Memo",'1',REPORT::"Purchase Credit Memo");
          InsertRepSelection(Usage::"P.Receipt",'1',REPORT::"Receiving Report");
          InsertRepSelection(Usage::"P.Ret.Shpt.",'1',REPORT::"Return Shipment");
          InsertRepSelection(Usage::"P.Test",'1',REPORT::"Purchase Document - Test");
          InsertRepSelection(Usage::"B.Check",'1',REPORT::Check);
          InsertRepSelection(Usage::Reminder,'1',REPORT::Reminder);
          InsertRepSelection(Usage::"Fin.Charge",'1',REPORT::"Finance Charge Memo");
          InsertRepSelection(Usage::"Rem.Test",'1',REPORT::"Reminder - Test");
          InsertRepSelection(Usage::"F.C.Test",'1',REPORT::"Finance Charge Memo - Test");
          InsertRepSelection(Usage::Inv1,'1',REPORT::"Transfer Order");
          InsertRepSelection(Usage::Inv2,'1',REPORT::"Transfer Shipment");
          InsertRepSelection(Usage::Inv3,'1',REPORT::"Transfer Receipt");
          InsertRepSelection(Usage::"Invt. Period Test",'1',REPORT::"Close Inventory Period - Test");
          // InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Reconciliation");
          InsertRepSelection(Usage::"B.Stmt",'1',REPORT::"Bank Account Statement");
          // InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Rec. Test Report");
          InsertRepSelection(Usage::"B.Recon.Test",'1',REPORT::"Bank Acc. Recon. - Test");
          InsertRepSelection(Usage::"Prod. Order",'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M1,'1',REPORT::"Prod. Order - Job Card");
          InsertRepSelection(Usage::M2,'1',REPORT::"Prod. Order - Mat. Requisition");
          InsertRepSelection(Usage::M3,'1',REPORT::"Prod. Order - Shortage List");
          InsertRepSelection(Usage::"SM.Quote",'1',REPORT::"Service Quote");
          InsertRepSelection(Usage::"SM.Order",'1',REPORT::"Service Order");
          InsertRepSelection(Usage::"SM.Invoice",'1',REPORT::"Service Invoice-Sales Tax");
          InsertRepSelection(Usage::"SM.Credit Memo",'1',REPORT::"Service Credit Memo-Sales Tax");
          InsertRepSelection(Usage::"SM.Shipment",'1',REPORT::"Service - Shipment");
          InsertRepSelection(Usage::"SM.Contract Quote",'1',REPORT::"Service Contract Quote");
          InsertRepSelection(Usage::"SM.Contract",'1',REPORT::"Service Contract");
          InsertRepSelection(Usage::"SM.Test",'1',REPORT::"Service Document - Test");
          InsertRepSelection(Usage::"Asm. Order",'1',REPORT::"Assembly Order");
          InsertRepSelection(Usage::"P.Assembly Order",'1',REPORT::"Posted Assembly Order");
          InsertRepSelection(Usage::"S.Test Prepmt.",'1',REPORT::"Sales Prepmt. Document Test");
          InsertRepSelection(Usage::"P.Test Prepmt.",'1',REPORT::"Purchase Prepmt. Doc. - Test");
          InsertRepSelection(Usage::"S.Arch. Quote",'1',REPORT::"Archived Sales Quote");
          InsertRepSelection(Usage::"S.Arch. Order",'1',REPORT::"Archived Sales Order");
          InsertRepSelection(Usage::"P.Arch. Quote",'1',REPORT::"Archived Purchase Quote");
          InsertRepSelection(Usage::"P.Arch. Order",'1',REPORT::"Archived Purchase Order");
          InsertRepSelection(Usage::"P. Arch. Return Order",'1',REPORT::"Arch.Purch. Return Order");
          InsertRepSelection(Usage::"S. Arch. Return Order",'1',REPORT::"Arch. Sales Return Order");
          InsertRepSelection(Usage::"S.Order Pick Instruction",'1',REPORT::"Pick Instruction");
        END;
    end;

    local procedure InsertRepSelection(ReportUsage: Integer;Sequence: Code[10];ReportID: Integer)
    var
        ReportSelections: Record "77";
    begin
        ReportSelections.INIT;
        ReportSelections.Usage := ReportUsage;
        ReportSelections.Sequence := Sequence;
        ReportSelections."Report ID" := ReportID;
        ReportSelections.INSERT;
    end;
}

