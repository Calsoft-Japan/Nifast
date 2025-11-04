page 50154 "Create XML SAT"
{
    SourceTable = "Acc. Schedule Line";
    ApplicationArea = All;
    UsageCategory = None;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StartingDate; StartingDate)
                {
                    Caption = 'Starting Date Period';
                    TableRelation = "Accounting Period"."Starting Date";
                    ToolTip = 'Specifies the value of the Starting Date Period field.';

                    trigger OnValidate()
                    begin
                        SetDateFilter();
                    end;
                }
                field(DateFilter; DateFilter)
                {
                    Caption = 'Date Filter';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Filter field.';
                }
            }
            group(BalanceChartOfAcc)
            {
                Caption = 'Balance / Chart of Accounts';
                field("Schedule Name"; ScheduleName)
                {
                    Caption = 'Schedule Name';
                    HideValue = false;
                    TableRelation = "Acc. Schedule Name".Name;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Schedule Name field.';
                }
                field(DeliveryType; DeliveryType)
                {
                    OptionCaption = 'Normal,Complementary';
                    ToolTip = 'Specifies the value of the DeliveryType field.';
                    Caption = 'DeliveryType';
                }
                field(UpdateDate; UpdateDate)
                {
                    Caption = 'Update Date';
                    ToolTip = 'Specifies the value of the Update Date field.';
                }
            }
            group(Poliza_AuxAcc)
            {
                Caption = 'Poliza - Aux. Accounts';
                field(RequestType; RequestType)
                {
                    Caption = 'Request Type';
                    OptionCaption = 'AF,FC,CO,DE';
                    ToolTip = 'Specifies the value of the Request Type field.';
                }
                field(ProcessNumber; ProcessNumber)
                {
                    Caption = 'Request No.';
                    ToolTip = 'Specifies the value of the Request No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateChartAcc)
            {
                Caption = 'Create XML Chart of Accounts';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create XML Chart of Accounts action.';

                trigger OnAction()
                begin
                    ElectronicAccounting.ExportChartOfAccounts(DATE2DMY(StartingDate, 3), DATE2DMY(StartingDate, 2), ScheduleName);
                end;
            }
            action(CreateBalance)
            {
                Caption = 'Create XML Balance';
                Image = Export;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create XML Balance action.';

                trigger OnAction()
                begin
                    IF DeliveryType = DeliveryType::Complementary THEN
                        IF UpdateDate = 0D THEN
                            ERROR(eText000);

                    ElectronicAccounting.ExportBalanceSheet(DATE2DMY(StartingDate, 3), DATE2DMY(StartingDate, 2), DeliveryType, UpdateDate, ScheduleName);
                end;
            }
            action(CreateXMLPoliza)
            {
                Caption = 'Create XML Poliza';
                Image = Export;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create XML Poliza action.';

                trigger OnAction()
                begin
                    ElectronicAccounting.ConfirmValidateExport(StartingDate, RequestType, ProcessNumber, TRUE);
                end;
            }
            action(CreateXMLAuxAccounts)
            {
                Caption = 'Create XML Aux. Accounts';
                Image = Export;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create XML Aux. Accounts action.';

                trigger OnAction()
                begin
                    ElectronicAccounting.ConfirmValidateExport(StartingDate, RequestType, ProcessNumber, FALSE);
                end;
            }
        }
    }

    var
        ElectronicAccounting: Codeunit "Electronic Accounting";
        ScheduleName: Code[10];
        ProcessNumber: Code[13];
        StartingDate: Date;
        UpdateDate: Date;
        eText000: Label 'Update date is required.';
        RequestType: Option AF,FC,CO,DE;
        DeliveryType: Option Normal,Complementary;
        DateFilter: Text[50];

    procedure SetParam(PA_StartingDate: Date; PA_ScheduleName: Code[10])
    begin
        StartingDate := PA_StartingDate;
        ScheduleName := PA_ScheduleName;
        SetDateFilter();
    end;

    procedure SetDateFilter()
    begin
        DateFilter := FORMAT(StartingDate) + '..' + FORMAT(CALCDATE('<CM>', StartingDate));
    end;
}

