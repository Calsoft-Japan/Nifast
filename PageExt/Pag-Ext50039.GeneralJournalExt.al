pageextension 50039 GeneralJournalExt extends "General Journal"
{
    // version NAVW18.00,NAVNA8.00,NV4.00,NIF1.033,NIF.N15.C9IN.001

    layout
    {
        modify("Amount (LCY)")
        {
            Visible = false;
        }
    }
    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            // action("Import Gen Journal Lines")
            // {
            //     Caption = 'Import Gen Journal Lines';
            //     //RunObject = XMLport 50078; //TODO
            // }
            // action("Import Demensions")
            // {
            //     Caption = 'Import Demensions';
            //     //RunObject = XMLport 50079; //TODO
            // }
        }
    }
}

