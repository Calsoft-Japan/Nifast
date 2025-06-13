table 50031 "EDI Sales Order Import Log"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            Editable = false;
        }
        field(21;"File Name";Text[250])
        {
            Editable = false;
        }
        field(22;"Import Date";Date)
        {
            Editable = false;
        }
        field(23;"Import Time";Time)
        {
            Editable = false;
        }
        field(24;"Import By";Code[50])
        {
            Editable = false;
            //This property is currently not supported
            //TestTableRelation = false;
            
            
        }
        field(25;"Sales Orders";Code[250])
        {
            Editable = false;
        }
        field(32;Status;Option)
        {
            Editable = false;
            OptionCaption = ' ,Success,Error';
            OptionMembers = " ",Success,Error;
        }
        field(33;"Error Detail";Text[250])
        {
            Editable = false;
        }
    }
}
