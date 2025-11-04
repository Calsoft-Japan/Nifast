tableextension 70100 LAXEDISetup_NF extends "LAX EDI Setup"
{
    fields
    {
        field(50000; "General Message Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50001; "EDI Control Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50002; "XML Source Document Folder"; Text[150])
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50011; "XML Error Folder"; Text[150])
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50020; "XML Success Folder"; Text[150])
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50025; "XML Forecast Folder"; Text[150])
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50030; "Show Messages On Import"; Boolean)
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50040; "Delete XML on Success"; Boolean)
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50050; "NAS Timer"; Integer)
        {
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50051; "Email Title"; Text[30])
        {
            Caption = 'Email Title';
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50052; "Email Subject"; Text[50])
        {
            Caption = 'Email Subject';
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(50056; "Send Email on Error"; Boolean)
        {
            Caption = 'Send Email on Error';
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
    }
}
