page 50029 "Exchange Contract List"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Exchange Contract Card";
    Editable = false;
    PageType = List;
    SourceTable = Table50010;
    SourceTableView = SORTING(No.)
                      WHERE(Contract Complete=CONST(No),
                            Expired=CONST(No));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No.";"No.")
                {
                }
                field(BankName;BankName)
                {
                }
                field(Bank;Bank)
                {
                }
                field("Amount $";"Amount $")
                {
                }
                field(ExchangeRate;ExchangeRate)
                {
                }
                field(JournalAmount;JournalAmount)
                {
                }
                field(AmountYen;AmountYen)
                {
                }
                field("Date Created";"Date Created")
                {
                }
                field(PeriodStart;PeriodStart)
                {
                }
                field(PeriodEnd;PeriodEnd)
                {
                }
                field(Approved;Approved)
                {
                }
                field(RemainingAmount;RemainingAmount)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CheckExpiration;
    end;
}

