pageextension 71003 LAXReceiveStation_NF extends "LAX Receive Station"
{
    layout
    {
        addlast(Printing)
        {
            field("Print Server"; Rec."Print Server")
            {
                ApplicationArea = All;
            }
            field("FTP Command File"; Rec."FTP Command File")
            {
                ApplicationArea = All;
            }
            field("Printer Server IP"; Rec."Printer Server IP")
            {
                ApplicationArea = All;
            }
            field("Printer Name"; Rec."Printer Name")
            {
                ApplicationArea = All;
            }
            field("Default Item Receive Rule Code"; Rec."Default Item Receive Rule Code")
            {
                ApplicationArea = All;
            }
        }

    }
}
