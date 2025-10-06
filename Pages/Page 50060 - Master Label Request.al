page 50060 "Master Label Request"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;

    layout
    {
        area(content)
        {
            group()
            {
                Editable = false;
                field(PackageNo;PackageNo)
                {
                    Caption = 'Package No.';
                }
                field(PackageType;PackageType)
                {
                    Caption = 'Type';
                }
                field(PackageTypeNo;PackageTypeNo)
                {
                    Caption = 'No.';
                }
                field(PackageQty;PackageQty)
                {
                    Caption = 'Quantity';
                }
                field(PackageDesc;PackageDesc)
                {
                    Caption = 'Description';
                }
                field(;'')
                {
                    CaptionClass = Text19040410;
                    MultiLine = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
            field(NoOfCopies;NoOfCopies)
            {
                Caption = 'No. of Copies';
            }
            field(QtyToPrint;QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0:2;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        QtyToPrint: Decimal;
        NoOfCopies: Integer;
        PackingRule: Record "14000715";
        LabelMgmtNIF: Codeunit "50017";
        PackageNo: Code[20];
        PackageType: Text[30];
        PackageTypeNo: Code[20];
        PackageQty: Decimal;
        PackageDesc: Text[50];
        PkgShipToNo: Code[20];
        PkgShipToCode: Code[10];
        Text19040410: Label 'MASTER LABEL';

    procedure SetFormValues(NewPackageNo: Code[20];NewPackageType: Text[30];NewPackageTypeNo: Code[20];NewPackageQty: Decimal;NewPackageDesc: Text[50];NewPkgShipToNo: Code[20];NewPkgShipToCode: Code[10];NewNoOfCopies: Integer;NewQtyToPrint: Decimal)
    begin
        PackageNo := NewPackageNo;
        PackageType := NewPackageType;
        PackageTypeNo := NewPackageTypeNo;
        PackageQty := NewPackageQty;
        PackageDesc := NewPackageDesc;
        PkgShipToNo := NewPkgShipToNo;
        PkgShipToCode := NewPkgShipToCode;
        QtyToPrint := NewQtyToPrint;
        NoOfCopies := NewNoOfCopies;
    end;

    procedure GetFormValues(var NewQtyToPrint: Decimal;var NewNoOfCopies: Integer)
    begin
        NewQtyToPrint := QtyToPrint;
        NewNoOfCopies := NoOfCopies;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        IF QtyToPrint=0 THEN
          QtyToPrint := PackageQty;

        IF NoOfCopies=0 THEN
          NoOfCopies := 1;
    end;
}

