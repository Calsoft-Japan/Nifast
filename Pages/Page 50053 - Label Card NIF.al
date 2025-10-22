page 50053 "Label Card NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    ApplicationArea = All;
    UsageCategory = None;
    PageType = Card;
    SourceTable = "LAX Label Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Label Usage"; Rec."Label Usage")
                {
                    ToolTip = 'Specifies the value of the Label Usage field.';
                    Caption = 'Label Usage';
                }
                field("No. of Fields"; Rec."No. of Fields")
                {
                    ToolTip = 'Specifies the value of the No. of Fields field.';
                    Caption = 'No. of Fields';
                }
                field("Format Path"; Rec."Format Path")
                {
                    ToolTip = 'Specifies the value of the Format Path field.';
                    Caption = 'Format Path';
                }
                field(NewLable; NewLable)
                {
                    Caption = 'New Lable';
                    ToolTip = 'Specifies the value of the New Lable field.';
                }
                field("Label Type"; Rec."Label Type")
                {
                    ToolTip = 'Specifies the value of the Label Type field.';
                    Caption = 'Label Type';
                }
                field("Label Constant"; Rec."Label Constant")
                {
                    ToolTip = 'Specifies the value of the Label Constant field.';
                    Caption = 'Label Constant';
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
                    ToolTip = 'Executes the &Copy action.';

                    trigger OnAction()
                    begin
                        //>> NF1.00:CIS.NG 09-04-15
                        IF NewLable = '' THEN
                            ERROR(Text000);
                        //<< NF1.00:CIS.NG 09-04-15
                        Rec.CopyLabel(Text000);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Test Label")
                {
                    Caption = 'Test Label';
                    Image = TestFile;
                    ToolTip = 'Executes the Test Label action.';

                    trigger OnAction()
                    begin
                        //>>
                        //LabelMgt.TestPrintPackageLabel(Code);
                        LabelMgtNIF.TestPrintPackageLabel(Rec.Code);
                        //<<
                    end;
                }
                action("Print Label Layout")
                {
                    Caption = 'Print Label Layout';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Executes the Print Label Layout action.';

                    trigger OnAction()
                    begin
                        LabelHeader.RESET();
                        LabelHeader := Rec;
                        LabelHeader.SETRECFILTER();
                        REPORT.RUN(REPORT::"Label Layout - NIF", TRUE, TRUE, LabelHeader);
                    end;
                }
            }
        }
    }

    var
        LabelHeader: Record "LAX Label Header";
        LabelMgtNIF: Codeunit "Label Mgmt NIF";
        NewLable: Code[10];
        Text000: Label 'Please enter the value of New Label';
}

