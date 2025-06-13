table 50135 "FB Message"
{
    fields
    {
        field(10;"Entry No.";Integer)
        {
            AutoIncrement = true;
        }
        field(20;"Current Date";Date)
        {
            // cleaned
        }
        field(30;"Current Time";Time)
        {
            // cleaned
        }
        field(34;"Import Data Log No.";Code[20])
        {
            // cleaned
        }
        field(35;"File Name";Code[200])
        {
            // cleaned
        }
        field(36;"Line No.";Integer)
        {
            // cleaned
        }
        field(40;"FB Order No.";Code[20])
        {
            // cleaned
        }
        field(50;"Sales Order No.";Code[20])
        {
            // cleaned
        }
        field(60;Message;Text[250])
        {
            // cleaned
        }
        field(80;Status;Option)
        {
            OptionCaption = 'New,Errors,Processed';
            OptionMembers = New,Errors,Processed;
        }
        field(90;Source;Code[10])
        {
            // cleaned
        }
    }
}
