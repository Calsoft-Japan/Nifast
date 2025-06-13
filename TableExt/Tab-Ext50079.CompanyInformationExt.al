tableextension 50079 "Company Information Ext" extends "Company Information"
{
    fields
    {
        field(50000; "Port of Loading"; Text[50])
        {
            Description = 'Puerto de Embarque';
        }
        field(50005; "Maquila Registration No."; Code[20])
        {
            // cleaned
        }
        // field(50010;"RFC Number";Code[30])
        // {
        //     // cleaned
        // }
    }
}
