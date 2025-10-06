page 50095 LabelTest
{

    layout
    {
        area(content)
        {
            field(DATABASE::"Company Information";DATABASE::"Company Information")
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(RUn)
            {

                trigger OnAction()
                begin
                    MESSAGE('%1',FORMAT(1)+'-'+'DONE'+'-'+DELCHR(FORMAT(CURRENTDATETIME),'=','/\:')+'.txt');
                end;
            }
        }
    }
}

