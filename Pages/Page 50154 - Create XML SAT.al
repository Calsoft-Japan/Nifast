page 50154 "Create XML SAT"
{
    SourceTable = Table85;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StartingDate;StartingDate)
                {
                    Caption = 'Starting Date Period';
                    TableRelation = "Accounting Period"."Starting Date";

                    trigger OnValidate()
                    begin
                        SetDateFilter;
                    end;
                }
                field(DateFilter;DateFilter)
                {
                    Caption = 'Date Filter';
                    Editable = false;
                }
            }
            group(BalanceChartOfAcc)
            {
                Caption = 'Balance / Chart of Accounts';
                field("Schedule Name";ScheduleName)
                {
                    Caption = 'Schedule Name';
                    HideValue = false;
                    TableRelation = "Acc. Schedule Name".Name;
                    Visible = true;
                }
                field(DeliveryType;DeliveryType)
                {
                }
                field(UpdateDate;UpdateDate)
                {
                    Caption = 'Update Date';
                }
            }
            group(Poliza_AuxAcc)
            {
                Caption = 'Poliza - Aux. Accounts';
                field(RequestType;RequestType)
                {
                    Caption = 'Request Type';
                    OptionCaption = 'AF,FC,CO,DE';
                }
                field(ProcessNumber;ProcessNumber)
                {
                    Caption = 'Request No.';
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

                trigger OnAction()
                begin
                    ElectronicAccounting.ExportChartOfAccounts(DATE2DMY(StartingDate,3),DATE2DMY(StartingDate,2),ScheduleName);
                end;
            }
            action(CreateBalance)
            {
                Caption = 'Create XML Balance';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF DeliveryType = DeliveryType::Complementary THEN
                      IF UpdateDate = 0D THEN
                        ERROR(eText000);

                    ElectronicAccounting.ExportBalanceSheet(DATE2DMY(StartingDate,3),DATE2DMY(StartingDate,2),DeliveryType,UpdateDate,ScheduleName);
                end;
            }
            action(CreateXMLPoliza)
            {
                Caption = 'Create XML Poliza';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ElectronicAccounting.ConfirmValidateExport(StartingDate,RequestType,ProcessNumber,TRUE);
                end;
            }
            action(CreateXMLAuxAccounts)
            {
                Caption = 'Create XML Aux. Accounts';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ElectronicAccounting.ConfirmValidateExport(StartingDate,RequestType,ProcessNumber,FALSE);
                end;
            }
        }
    }

    var
        DeliveryType: Option Normal,Complementary;
        ProcessNumber: Code[13];
        RequestType: Option AF,FC,CO,DE;
        StartingDate: Date;
        Month: Integer;
        Year: Integer;
        ElectronicAccounting: Codeunit "50020";
        DateFilter: Text[50];
        ScheduleName: Code[10];
        UpdateDate: Date;
        eText000: Label 'Update date is required.';

    procedure SetParam(PA_StartingDate: Date;PA_ScheduleName: Code[10])
    begin
        StartingDate := PA_StartingDate;
        ScheduleName := PA_ScheduleName;
        SetDateFilter;
    end;

    procedure SetDateFilter()
    begin
        DateFilter := FORMAT(StartingDate) + '..' + FORMAT(CALCDATE('<CM>',StartingDate));
    end;
}

