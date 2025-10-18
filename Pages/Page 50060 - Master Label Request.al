page 50060 "Master Label Request"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    UsageCategory = None;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field(PackageNo; PackageNo)
                {
                    Caption = 'Package No.';
                    ToolTip = 'Specifies the value of the Package No. field.';
                }
                field(PackageType; PackageType)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(PackageTypeNo; PackageTypeNo)
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(PackageQty; PackageQty)
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(PackageDesc; PackageDesc)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(" "; '')
                {
                    CaptionClass = Text19040410;
                    MultiLine = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the '''' field.';
                }
            }
            field(NoOfCopies; NoOfCopies)
            {
                Caption = 'No. of Copies';
                ToolTip = 'Specifies the value of the No. of Copies field.';
            }
            field(QtyToPrint; QtyToPrint)
            {
                Caption = 'Quantity To Print';
                DecimalPlaces = 0 : 2;
                ToolTip = 'Specifies the value of the Quantity To Print field.';
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        PkgShipToCode: Code[10];
        PackageNo: Code[20];
        PackageTypeNo: Code[20];
        PkgShipToNo: Code[20];
        PackageQty: Decimal;
        QtyToPrint: Decimal;
        NoOfCopies: Integer;
        Text19040410: Label 'MASTER LABEL';
        PackageType: Text[30];
        PackageDesc: Text[50];

    procedure SetFormValues(NewPackageNo: Code[20]; NewPackageType: Text[30]; NewPackageTypeNo: Code[20]; NewPackageQty: Decimal; NewPackageDesc: Text[50]; NewPkgShipToNo: Code[20]; NewPkgShipToCode: Code[10]; NewNoOfCopies: Integer; NewQtyToPrint: Decimal)
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

    procedure GetFormValues(var NewQtyToPrint: Decimal; var NewNoOfCopies: Integer)
    begin
        NewQtyToPrint := QtyToPrint;
        NewNoOfCopies := NoOfCopies;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        IF QtyToPrint = 0 THEN
            QtyToPrint := PackageQty;

        IF NoOfCopies = 0 THEN
            NoOfCopies := 1;
    end;
}

