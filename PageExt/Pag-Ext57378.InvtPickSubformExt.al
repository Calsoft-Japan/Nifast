
pageextension 57378 InvtPickSubformExt extends "Invt. Pick Subform"
{
    actions
    {
        addafter(Lot)
        {
            action("Print Line Label")
            {
                ApplicationArea = all;
                Caption = 'Print Line Label';
                Image = Print;
                trigger OnAction()
                begin
                    _PrintLabelLine;
                end;
            }
        }
    }
    PROCEDURE _PrintLabelLine();
    VAR
        LabelMgtNIF: Codeunit 50017;
    BEGIN
        LabelMgtNIF.PrintLabelsFromPickLine(Rec);
    END;

}
