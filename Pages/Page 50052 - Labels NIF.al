page 50052 "Labels NIF"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    CardPageID = "Label Card NIF";
    Editable = true;
    PageType = List;
    SourceTable = Table14000841;

    layout
    {
        area(content)
        {
            repeater()
            {
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
                    LookupPageID = "Filed Service Contract";
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
                    RunPageLink = Code=FIELD(Code);
                    ShortCutKey = 'Shift+F7';
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

                    trigger OnAction()
                    var
                        LabelHeader: Record "14000841";
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
}

