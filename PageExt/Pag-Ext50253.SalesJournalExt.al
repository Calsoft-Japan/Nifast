pageextension 50253 SalesJournalExt extends "Sales Journal"
{
    // version NAVW18.00,NAVNA8.00,NV4.00,NIF1.086,NIF.N15.C9IN.001

    layout
    {
        modify("Amount (LCY)")
        {
            Visible = false;
        }
    }

}

