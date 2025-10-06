page 50012 "Create Transfer Orders"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Document;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group()
            {
                field(VendNo;VendNo)
                {
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(FromLocationCode;FromLocationCode)
                {
                    Caption = 'From Location Code';
                    TableRelation = Location;

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(ToLocationCode;ToLocationCode)
                {
                    Caption = 'To Location Code';
                    TableRelation = Location;

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(VesselName;VesselName)
                {
                    Caption = 'Vessel Name';
                    TableRelation = "Shipping Vessels";

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
                field(SailOnDate;SailOnDate)
                {
                    Caption = 'Sail On Date';

                    trigger OnValidate()
                    begin
                        SetFormFilter;
                    end;
                }
            }
            part(RcptLines;50013)
            {
                Editable = RcptLinesEditable;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Deselect All")
            {
                Caption = 'Deselect All';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.RcptLines.PAGE.DeselectAll;
                end;
            }
            action("Select All")
            {
                Caption = 'Select All';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.RcptLines.PAGE.SelectAll;
                end;
            }
            action("Create Transfers")
            {
                Caption = 'Create Transfers';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //CurrForm.RcptLines.FORM.PopulateTempTable;
                    //CLEAR(VendNo);
                    //CLEAR(FromLocationCode);
                    //CLEAR(VesselName);
                    //CLEAR(SailOnDate);
                    //SetFormFilter;
                    CurrPage.RcptLines.PAGE.CreateTransfers;

                    MESSAGE('Processing Complete');

                    //CurrForm.CLOSE;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        RcptLinesEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //CurrForm.RcptLines.EDITABLE(FALSE);

        SetFormFilter;
    end;

    var
        Vend: Record "23";
        VendNo: Code[20];
        FromLocation: Record "14";
        FromLocationCode: Code[10];
        FromBin: Record "7354";
        ToLocation: Record "14";
        ToLocationCode: Code[10];
        ReceiptLines: Record "121";
        VesselName: Code[50];
        SailOnDate: Date;
        RecsReturned: Integer;
        [InDataSet]
        RcptLinesEditable: Boolean;

    procedure SetFormFilter()
    begin
        RecsReturned := CurrPage.RcptLines.PAGE.SetSubFormFilter(VendNo, FromLocationCode, VesselName, SailOnDate, ToLocationCode);

        //MESSAGE('Records %1', FORMAT(RecsReturned));

        IF RecsReturned > 0 THEN
          RcptLinesEditable := TRUE
          ELSE RcptLinesEditable := FALSE;

        CurrPage.UPDATE(FALSE);  //NF1.00:CIS.NG  09-05-15
        //CLEAR(Rec);
        //SETRANGE("Buy-from Vendor No.", VendNo);
        //SETRANGE("Location Code", FromLocationCode);
        //SETRANGE("Vessel Name", VesselName);
        //SETRANGE("Sail-on Date", SailOnDate);
        //SETRANGE("Transfer Order Created", FALSE);
    end;
}

