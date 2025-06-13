table 70782 "Conv. SE0.54.17 Data"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            // cleaned
        }
        field(11;"Endicia Non-Expedited Svc. Fee";Decimal)
        {
            Caption = 'Endicia Non-Expedited Svc. Fee';
        }
        field(12;"Default Insured Mail Type";Option)
        {
            Caption = 'Default Insured Mail Type';
            OptionCaption = 'None,USPS,USPS Online,Endicia';
            OptionMembers = "None",USPS,"USPS Online",Endicia;
        }
        field(13;"Endicia Insurance Fee per $100";Decimal)
        {
            Caption = 'Endicia Insurance Fee per $100';
        }
    }
}
