page 50052 "Labels NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Label Card NIF";
    Editable = true;
    PageType = List;
    SourceTable = 14000841;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code; Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Label Usage"; "Label Usage")
                {
                    ToolTip = 'Specifies the value of the Label Usage field.';
                }
                field("No. of Fields"; "No. of Fields")
                {
                    ToolTip = 'Specifies the value of the No. of Fields field.';
                }
                field("Format Path"; "Format Path")
                {
                    LookupPageID = "Filed Service Contract";
                    ToolTip = 'Specifies the value of the Format Path field.';
                }
                field("Label Type"; "Label Type")
                {
                    ToolTip = 'Specifies the value of the Label Type field.';
                }
                field("Label Constant"; "Label Constant")
                {
                    ToolTip = 'Specifies the value of the Label Constant field.';
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
                    RunObject = Page 50053;
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
                    ToolTip = 'Executes the Test Label action.';

                    trigger OnAction()
                    var
                        LabelMgtNIF: Codeunit "50017";
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
                    ToolTip = 'Executes the Print Label Layout action.';

                    trigger OnAction()
                    var
                        LabelHeader: Record "14000841";
                    begin
                        LabelHeader.RESET;
                        LabelHeader := Rec;
                        LabelHeader.SETRECFILTER;
                        REPORT.RUN(REPORT::"Label Layout - NIF", TRUE, TRUE, LabelHeader);
                    end;
                }
            }
        }
    }
}

