page 50053 "Label Card NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    SourceTable = Table14000841;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code;Code)
                {
                }
                field(Description;Description)
                {
                }
                field("Label Usage";"Label Usage")
                {
                }
                field("No. of Fields";"No. of Fields")
                {
                }
                field("Format Path";"Format Path")
                {
                }
                field(NewLable;NewLable)
                {
                    Caption = 'New Lable';
                }
                field("Label Type";"Label Type")
                {
                }
                field("Label Constant";"Label Constant")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Copy")
                {
                    Caption = '&Copy';
                    Image = Copy;

                    trigger OnAction()
                    begin
                        //>> NF1.00:CIS.NG 09-04-15
                        IF NewLable = '' THEN
                          ERROR(Text000);
                        //<< NF1.00:CIS.NG 09-04-15
                        CopyLabel(Text000);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Test Label")
                {
                    Caption = 'Test Label';

                    trigger OnAction()
                    begin
                        //>>
                        //LabelMgt.TestPrintPackageLabel(Code);
                        LabelMgtNIF.TestPrintPackageLabel(Code);
                        //<<
                    end;
                }
                action("Print Label Layout")
                {
                    Caption = 'Print Label Layout';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        LabelHeader.RESET;
                        LabelHeader := Rec;
                        LabelHeader.SETRECFILTER;
                        REPORT.RUN(REPORT::"Label Layout - NIF",TRUE,TRUE,LabelHeader);
                    end;
                }
            }
        }
    }

    var
        LabelHeader: Record "14000841";
        ItemLabel: Report "14000841";
        CustomerLabel: Report "14000842";
        ResourceLabel: Report "14000845";
        ReceiveLineLabel: Report "14000847";
        LabelMgt: Codeunit "14000841";
        "<<NIF_GV>>": Integer;
        PackageLineLabel: Report "50041";
        LabelMgtNIF: Codeunit "50017";
        NewLable: Code[10];
        Text000: Label 'Please enter the value of New Label';
}

