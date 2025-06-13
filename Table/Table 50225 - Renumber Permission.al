table 50225 "Renumber Permission"
{
    fields
    {
        field(3;"Object Type";Option)
        {
            Caption = 'Object Type';
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
        }
        field(4;"Object ID";Integer)
        {
            Caption = 'Object ID';
        }
        field(50001;"New Object ID";Integer)
        {
            Caption = 'New Object ID';
        }
    }
}
