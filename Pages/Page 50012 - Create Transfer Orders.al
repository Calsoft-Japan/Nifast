page 50012 "Create Transfer Orders"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Document;
    UsageCategory = None;
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(VendNo; VendNo)
                {
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;
                    ToolTip = 'Specifies the value of the Vendor No. field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(FromLocationCode; FromLocationCode)
                {
                    Caption = 'From Location Code';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the From Location Code field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(ToLocationCode; ToLocationCode)
                {
                    Caption = 'To Location Code';
                    TableRelation = Location;
                    ToolTip = 'Specifies the value of the To Location Code field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(VesselName; VesselName)
                {
                    Caption = 'Vessel Name';
                    TableRelation = "Shipping Vessels";
                    ToolTip = 'Specifies the value of the Vessel Name field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
                field(SailOnDate; SailOnDate)
                {
                    Caption = 'Sail On Date';
                    ToolTip = 'Specifies the value of the Sail On Date field.';

                    trigger OnValidate()
                    begin
                        SetFormFilter();
                    end;
                }
            }
            part(RcptLines; "Create Trans.Ord. Subform")
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
                Image = Select;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Deselect All action.';

                trigger OnAction()
                begin
                    CurrPage.RcptLines.PAGE.DeselectAll();
                end;
            }
            action("Select All")
            {
                Caption = 'Select All';
                Promoted = true;
                image = Select;
                PromotedCategory = Process;
                ToolTip = 'Executes the Select All action.';

                trigger OnAction()
                begin
                    CurrPage.RcptLines.PAGE.SelectAll();
                end;
            }
            action("Create Transfers")
            {
                Caption = 'Create Transfers';
                Promoted = true;
                Image = Create;
                PromotedCategory = Process;
                ToolTip = 'Executes the Create Transfers action.';

                trigger OnAction()
                begin
                    //CurrForm.RcptLines.FORM.PopulateTempTable;
                    //CLEAR(VendNo);
                    //CLEAR(FromLocationCode);
                    //CLEAR(VesselName);
                    //CLEAR(SailOnDate);
                    //SetFormFilter;
                    CurrPage.RcptLines.PAGE.CreateTransfers();

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

        SetFormFilter();
    end;

    var
        [InDataSet]
        RcptLinesEditable: Boolean;
        FromLocationCode: Code[10];
        ToLocationCode: Code[10];
        VendNo: Code[20];
        VesselName: Code[50];
        SailOnDate: Date;
        RecsReturned: Integer;

    procedure SetFormFilter()
    begin
        RecsReturned := CurrPage.RcptLines.PAGE.SetSubFormFilter(VendNo, FromLocationCode, VesselName, SailOnDate, ToLocationCode);

        //MESSAGE('Records %1', FORMAT(RecsReturned));

        IF RecsReturned > 0 THEN
            RcptLinesEditable := TRUE
        ELSE
            RcptLinesEditable := FALSE;

        CurrPage.UPDATE(FALSE);  //NF1.00:CIS.NG  09-05-15
        //CLEAR(Rec);
        //SETRANGE("Buy-from Vendor No.", VendNo);
        //SETRANGE("Location Code", FromLocationCode);
        //SETRANGE("Vessel Name", VesselName);
        //SETRANGE("Sail-on Date", SailOnDate);
        //SETRANGE("Transfer Order Created", FALSE);
    end;
}

