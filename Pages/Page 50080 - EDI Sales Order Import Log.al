page 50080 "EDI Sales Order Import Log"
{
    // NF1.00:CIS.NG    10/14/15 XMLport Development - EDI Sales Order Import

    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50031;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No.";"Entry No.")
                {
                }
                field("File Name";"File Name")
                {
                }
                field("Import Date";"Import Date")
                {
                }
                field(FORMAT("Import Time");FORMAT("Import Time"))
                {
                    Caption = 'Import Time';
                }
                field("Import By";"Import By")
                {
                }
                field(Status;Status)
                {
                }
                field("Sales Orders";"Sales Orders")
                {
                }
                field("Error Detail";"Error Detail")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Process Files")
            {
                Image = ImportChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProcessEDIXML: Codeunit "50000";
                begin
                    CLEAR(ProcessEDIXML);
                    ProcessEDIXML.ProcessAll(TRUE);
                end;
            }
            action("Process Files Forcast")
            {
                Caption = 'Process Files Forcast';
                Image = ImportChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    JobQueueEntry: Record "472";
                    ProcessEDIXML: Codeunit "50001";
                begin
                    CLEAR(ProcessEDIXML);
                    JobQueueEntry.INIT;
                    JobQueueEntry."Parameter String" := 'FORECAST';
                    ProcessEDIXML.RUN(JobQueueEntry);
                end;
            }
            action("Show Error Message")
            {
                Caption = 'Show Error Message';
                Image = PrevErrorMessage;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TESTFIELD("Error Detail");
                    MESSAGE("Error Detail");
                end;
            }
            action("View Orders")
            {
                Image = BlanketOrder;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesHeader: Record "36";
                    SalesOrderList: Page "9305";
                begin
                    TESTFIELD("Sales Orders");
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
                    SalesHeader.SETFILTER("No.","Sales Orders");
                    CLEAR(SalesOrderList);
                    SalesOrderList.SETTABLEVIEW(SalesHeader);
                    SalesOrderList.LOOKUPMODE := TRUE;
                    SalesOrderList.EDITABLE(FALSE);
                    SalesOrderList.RUNMODAL;
                end;
            }
        }
    }
}

