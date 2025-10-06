page 50015 "Receive Control"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    //   STRSUBSTNO(
    //    '%1 %2 %3\Mfg. Batch Cure Number  %4',
    //    InputType,InputNo,
    //    InputDesc,'#1##################'));

    PageType = Card;

    layout
    {
        area(content)
        {
            group()
            {
                field(;'')
                {
                    CaptionClass = FORMAT (InputPrompt);
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(;'')
                {
                    CaptionClass = FORMAT (InputDesc);
                    Editable = false;
                    MultiLine = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(BatchCure;MfgLotNo)
                {
                    Caption = 'Mfg. Lot No.';
                }
                field(BatchCure1;EnteredQuantity)
                {
                    BlankZero = true;
                    Caption = 'Quantity';
                    DecimalPlaces = 0:5;
                }
            }
        }
    }

    actions
    {
    }

    var
        MfgLotNo: Code[30];
        EnteredQuantity: Decimal;
        InputPrompt: Text[250];
        InputDesc: Text[250];

    procedure ReturnValues(var NewMfgLotNo: Code[30];var NewQuantityEntered: Decimal)
    begin
        NewMfgLotNo := MfgLotNo;
        NewQuantityEntered := EnteredQuantity;
    end;

    procedure SetCaption(NewInputPrompt: Text[250];NewInputDesc: Text[250])
    begin
        InputPrompt := NewInputPrompt;
        InputDesc := NewInputDesc;
    end;
}

