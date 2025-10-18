page 50080 "EDI Sales Order Import Log"
{
    // NF1.00:CIS.NG    10/14/15 XMLport Development - EDI Sales Order Import

    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EDI Sales Order Import Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Caption = 'Entry No.';
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.';
                    Caption = 'File Name';
                }
                field("Import Date"; Rec."Import Date")
                {
                    ToolTip = 'Specifies the value of the Import Date field.';
                    Caption = 'Import Date';
                }
                field("Import Time"; FORMAT(Rec."Import Time"))
                {
                    Caption = 'Import Time';
                    ToolTip = 'Specifies the value of the (Import Time) field.';
                }
                field("Import By"; Rec."Import By")
                {
                    ToolTip = 'Specifies the value of the Import By field.';
                    Caption = 'Import By';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Caption = 'Status';
                }
                field("Sales Orders"; Rec."Sales Orders")
                {
                    ToolTip = 'Specifies the value of the Sales Orders field.';
                    Caption = 'Sales Orders';
                }
                field("Error Detail"; Rec."Error Detail")
                {
                    ToolTip = 'Specifies the value of the Error Detail field.';
                    Caption = 'Error Detail';
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
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Process Files action.';

                trigger OnAction()
                var
                    ProcessEDIXML: Codeunit "Not used";
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
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Process Files Forcast action.';

                trigger OnAction()
                var
                    JobQueueEntry: Record "Job Queue Entry";
                    ProcessEDIXML: Codeunit "Process EDI XML File JRR";
                begin
                    CLEAR(ProcessEDIXML);
                    JobQueueEntry.INIT();
                    JobQueueEntry."Parameter String" := 'FORECAST';
                    ProcessEDIXML.RUN(JobQueueEntry);
                end;
            }
            action("Show Error Message")
            {
                Caption = 'Show Error Message';
                Image = PrevErrorMessage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Executes the Show Error Message action.';

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Error Detail");
                    MESSAGE(Rec."Error Detail");
                end;
            }
            action("View Orders")
            {
                Image = BlanketOrder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Executes the View Orders action.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesOrderList: Page "Sales Order List";
                begin
                    Rec.TESTFIELD("Sales Orders");
                    SalesHeader.RESET();
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SETFILTER("No.", Rec."Sales Orders");
                    CLEAR(SalesOrderList);
                    SalesOrderList.SETTABLEVIEW(SalesHeader);
                    SalesOrderList.LOOKUPMODE := TRUE;
                    SalesOrderList.EDITABLE(FALSE);
                    SalesOrderList.RUNMODAL();
                end;
            }
        }
    }
}

