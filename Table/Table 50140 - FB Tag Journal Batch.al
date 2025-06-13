table 50140 "FB Tag Journal Batch"
{
    fields
    {
        field(1;Name;Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(10;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(20;"No. Series";Code[10])
        {
            Caption = 'No. Series';
        }
    }
}
