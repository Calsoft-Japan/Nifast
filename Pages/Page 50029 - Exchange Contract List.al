page 50029 "Exchange Contract List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Exchange Contract Card";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "4X Bank Exchange Contract";
    SourceTableView = SORTING("No.")
                      WHERE("Contract Complete" = CONST(false),
                            Expired = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(BankName; Rec.BankName)
                {
                    ToolTip = 'Specifies the value of the BankName field.';
                }
                field(Bank; Rec.Bank)
                {
                    ToolTip = 'Specifies the value of the Bank field.';
                }
                field("Amount $"; Rec."Amount $")
                {
                    ToolTip = 'Specifies the value of the Amount $ field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ToolTip = 'Specifies the value of the ExchangeRate field.';
                }
                field(JournalAmount; Rec.JournalAmount)
                {
                    ToolTip = 'Specifies the value of the JournalAmount field.';
                }
                field(AmountYen; Rec.AmountYen)
                {
                    ToolTip = 'Specifies the value of the AmountYen field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(PeriodStart; Rec.PeriodStart)
                {
                    ToolTip = 'Specifies the value of the PeriodStart field.';
                }
                field(PeriodEnd; Rec.PeriodEnd)
                {
                    ToolTip = 'Specifies the value of the PeriodEnd field.';
                }
                field(Approved; Rec.Approved)
                {
                    ToolTip = 'Specifies the value of the Approved field.';
                }
                field(RemainingAmount; Rec.RemainingAmount)
                {
                    ToolTip = 'Specifies the value of the RemainingAmount field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.CheckExpiration();
    end;
}

