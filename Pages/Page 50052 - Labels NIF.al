page 50052 "Labels NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Label Card NIF";
    Editable = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "LAX Label Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                    LookupPageID = "Filed Service Contract";
                    ToolTip = 'Specifies the value of the Format Path field.';
                    Caption = 'Format Path';
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
        area(navigation)
        {
            group("&Label")
            {
                Caption = '&Label';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Label Card NIF";
                    RunPageLink = Code = FIELD(Code);
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
            }
        }
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Test Label")
                {
                    Caption = 'Test Label';
                    Image = TestFile;
                    ToolTip = 'Executes the Test Label action.';

                    trigger OnAction()
                    var
                        LabelMgtNIF: Codeunit "Label Mgmt NIF";
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
                    var
                        LabelHeader: Record "LAX Label Header";
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
}

