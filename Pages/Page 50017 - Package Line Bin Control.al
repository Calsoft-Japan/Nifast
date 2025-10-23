page 50017 "Package Line Bin Control"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
            }
            field("1"; BinSelectionBln[1])
            {
                CaptionClass = GetCaption(1);
                Visible = BinSel1Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[1] field.';

                trigger OnValidate()
                begin
                    UncheckOther(1);
                end;
            }
            field("2"; BinSelectionBln[2])
            {
                CaptionClass = GetCaption(2);
                Visible = BinSel2Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[2] field.';

                trigger OnValidate()
                begin
                    UncheckOther(2);
                end;
            }
            field("3"; BinSelectionBln[3])
            {
                CaptionClass = GetCaption(3);
                Visible = BinSel3Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[3] field.';

                trigger OnValidate()
                begin
                    UncheckOther(3);
                end;
            }
            field("4"; BinSelectionBln[4])
            {
                CaptionClass = GetCaption(4);
                Visible = BinSel4Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[4] field.';

                trigger OnValidate()
                begin
                    UncheckOther(4);
                end;
            }
            field("5"; BinSelectionBln[5])
            {
                CaptionClass = GetCaption(5);
                Visible = BinSel5Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[5] field.';

                trigger OnValidate()
                begin
                    UncheckOther(5);
                end;
            }
            field("6"; BinSelectionBln[6])
            {
                CaptionClass = GetCaption(6);
                Visible = BinSel6Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[6] field.';

                trigger OnValidate()
                begin
                    UncheckOther(6);
                end;
            }
            field("7"; BinSelectionBln[7])
            {
                CaptionClass = GetCaption(7);
                Visible = BinSel7Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[7] field.';

                trigger OnValidate()
                begin
                    UncheckOther(7);
                end;
            }
            field("8"; BinSelectionBln[8])
            {
                CaptionClass = GetCaption(8);
                Visible = BinSel8Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[8] field.';

                trigger OnValidate()
                begin
                    UncheckOther(8);
                end;
            }
            field("9"; BinSelectionBln[9])
            {
                CaptionClass = GetCaption(9);
                Visible = BinSel9Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[9] field.';

                trigger OnValidate()
                begin
                    UncheckOther(9);
                end;
            }
            field("10"; BinSelectionBln[10])
            {
                CaptionClass = GetCaption(10);
                Visible = BinSel10Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[10] field.';

                trigger OnValidate()
                begin
                    UncheckOther(10);
                end;
            }
            field("11"; BinSelectionBln[11])
            {
                CaptionClass = GetCaption(11);
                Visible = BinSel11Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[11] field.';

                trigger OnValidate()
                begin
                    UncheckOther(11);
                end;
            }
            field("12"; BinSelectionBln[12])
            {
                CaptionClass = GetCaption(12);
                Visible = BinSel12Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[12] field.';

                trigger OnValidate()
                begin
                    UncheckOther(12);
                end;
            }
            field("13"; BinSelectionBln[13])
            {
                CaptionClass = GetCaption(13);
                Visible = BinSel13Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[13] field.';

                trigger OnValidate()
                begin
                    UncheckOther(13);
                end;
            }
            field("14"; BinSelectionBln[14])
            {
                CaptionClass = GetCaption(14);
                Visible = BinSel14Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[14] field.';

                trigger OnValidate()
                begin
                    UncheckOther(14);
                end;
            }
            field("15"; BinSelectionBln[15])
            {
                CaptionClass = GetCaption(15);
                Visible = BinSel15Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[15] field.';

                trigger OnValidate()
                begin
                    UncheckOther(15);
                end;
            }
            field("16"; BinSelectionBln[16])
            {
                CaptionClass = GetCaption(16);
                Visible = BinSel16Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[16] field.';

                trigger OnValidate()
                begin
                    UncheckOther(16);
                end;
            }
            field("17"; BinSelectionBln[17])
            {
                CaptionClass = GetCaption(17);
                Visible = BinSel17Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[17] field.';

                trigger OnValidate()
                begin
                    UncheckOther(17);
                end;
            }
            field("18"; BinSelectionBln[18])
            {
                CaptionClass = GetCaption(18);
                Visible = BinSel18Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[18] field.';

                trigger OnValidate()
                begin
                    UncheckOther(18);
                end;
            }
            field("19"; BinSelectionBln[19])
            {
                CaptionClass = GetCaption(19);
                Visible = BinSel19Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[19] field.';

                trigger OnValidate()
                begin
                    UncheckOther(19);
                end;
            }
            field("20"; BinSelectionBln[20])
            {
                CaptionClass = GetCaption(20);
                Visible = BinSel20Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[20] field.';

                trigger OnValidate()
                begin
                    UncheckOther(20);
                end;
            }
            field("21"; BinSelectionBln[21])
            {
                CaptionClass = GetCaption(21);
                Visible = BinSel21Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[21] field.';

                trigger OnValidate()
                begin
                    UncheckOther(21);
                end;
            }
            field("22"; BinSelectionBln[22])
            {
                CaptionClass = GetCaption(22);
                Visible = BinSel22Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[22] field.';

                trigger OnValidate()
                begin
                    UncheckOther(22);
                end;
            }
            field("23"; BinSelectionBln[23])
            {
                CaptionClass = GetCaption(23);
                Visible = BinSel23Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[23] field.';

                trigger OnValidate()
                begin
                    UncheckOther(23);
                end;
            }
            field("24"; BinSelectionBln[24])
            {
                CaptionClass = GetCaption(24);
                Visible = BinSel24Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[24] field.';

                trigger OnValidate()
                begin
                    UncheckOther(24);
                end;
            }
            field("25"; BinSelectionBln[25])
            {
                CaptionClass = GetCaption(25);
                Visible = BinSel25Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[25] field.';

                trigger OnValidate()
                begin
                    UncheckOther(25);
                end;
            }
            field("26"; BinSelectionBln[26])
            {
                CaptionClass = GetCaption(26);
                Visible = BinSel26Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[26] field.';

                trigger OnValidate()
                begin
                    UncheckOther(26);
                end;
            }
            field("27"; BinSelectionBln[27])
            {
                CaptionClass = GetCaption(27);
                Visible = BinSel27Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[27] field.';

                trigger OnValidate()
                begin
                    UncheckOther(27);
                end;
            }
            field("28"; BinSelectionBln[28])
            {
                CaptionClass = GetCaption(28);
                Visible = BinSel28Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[28] field.';

                trigger OnValidate()
                begin
                    UncheckOther(28);
                end;
            }
            field("29"; BinSelectionBln[29])
            {
                CaptionClass = GetCaption(29);
                Visible = BinSel29Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[29] field.';

                trigger OnValidate()
                begin
                    UncheckOther(29);
                end;
            }
            field("30"; BinSelectionBln[30])
            {
                CaptionClass = GetCaption(30);
                Visible = BinSel30Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[30] field.';

                trigger OnValidate()
                begin
                    UncheckOther(30);
                end;
            }
            field("31"; BinSelectionBln[31])
            {
                CaptionClass = GetCaption(31);
                Visible = BinSel31Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[31] field.';

                trigger OnValidate()
                begin
                    UncheckOther(31);
                end;
            }
            field("32"; BinSelectionBln[32])
            {
                CaptionClass = GetCaption(32);
                Visible = BinSel32Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[32] field.';

                trigger OnValidate()
                begin
                    UncheckOther(32);
                end;
            }
            field("33"; BinSelectionBln[33])
            {
                CaptionClass = GetCaption(33);
                Visible = BinSel33Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[33] field.';

                trigger OnValidate()
                begin
                    UncheckOther(33);
                end;
            }
            field("34"; BinSelectionBln[34])
            {
                CaptionClass = GetCaption(34);
                Visible = BinSel34Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[34] field.';

                trigger OnValidate()
                begin
                    UncheckOther(34);
                end;
            }
            field("35"; BinSelectionBln[35])
            {
                CaptionClass = GetCaption(35);
                Visible = BinSel35Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[35] field.';

                trigger OnValidate()
                begin
                    UncheckOther(35);
                end;
            }
            field("36"; BinSelectionBln[36])
            {
                CaptionClass = GetCaption(36);
                Visible = BinSel36Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[36] field.';

                trigger OnValidate()
                begin
                    UncheckOther(36);
                end;
            }
            field("37"; BinSelectionBln[37])
            {
                CaptionClass = GetCaption(37);
                Visible = BinSel37Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[37] field.';

                trigger OnValidate()
                begin
                    UncheckOther(37);
                end;
            }
            field("38"; BinSelectionBln[38])
            {
                CaptionClass = GetCaption(38);
                Visible = BinSel38Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[38] field.';

                trigger OnValidate()
                begin
                    UncheckOther(38);
                end;
            }
            field("39"; BinSelectionBln[39])
            {
                CaptionClass = GetCaption(39);
                Visible = BinSel39Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[39] field.';

                trigger OnValidate()
                begin
                    UncheckOther(39);
                end;
            }
            field("40"; BinSelectionBln[40])
            {
                CaptionClass = GetCaption(40);
                Visible = BinSel40Visible;
                ToolTip = 'Specifies the value of the BinSelectionBln[40] field.';

                trigger OnValidate()
                begin
                    UncheckOther(40);
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        BinSel40Visible := TRUE;
        BinSel39Visible := TRUE;
        BinSel38Visible := TRUE;
        BinSel37Visible := TRUE;
        BinSel36Visible := TRUE;
        BinSel35Visible := TRUE;
        BinSel34Visible := TRUE;
        BinSel33Visible := TRUE;
        BinSel32Visible := TRUE;
        BinSel31Visible := TRUE;
        BinSel30Visible := TRUE;
        BinSel29Visible := TRUE;
        BinSel28Visible := TRUE;
        BinSel27Visible := TRUE;
        BinSel26Visible := TRUE;
        BinSel25Visible := TRUE;
        BinSel24Visible := TRUE;
        BinSel23Visible := TRUE;
        BinSel22Visible := TRUE;
        BinSel21Visible := TRUE;
        BinSel20Visible := TRUE;
        BinSel19Visible := TRUE;
        BinSel18Visible := TRUE;
        BinSel17Visible := TRUE;
        BinSel16Visible := TRUE;
        BinSel15Visible := TRUE;
        BinSel14Visible := TRUE;
        BinSel13Visible := TRUE;
        BinSel12Visible := TRUE;
        BinSel11Visible := TRUE;
        BinSel10Visible := TRUE;
        BinSel9Visible := TRUE;
        BinSel8Visible := TRUE;
        BinSel7Visible := TRUE;
        BinSel6Visible := TRUE;
        BinSel5Visible := TRUE;
        BinSel4Visible := TRUE;
        BinSel3Visible := TRUE;
        BinSel2Visible := TRUE;
        BinSel1Visible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        BinSelectionBln[1] := TRUE;  //NF1.00:CIS.NG 09-05-15
    end;

    var
        BinSel1Visible: Boolean;
        BinSel2Visible: Boolean;
        BinSel3Visible: Boolean;
        BinSel4Visible: Boolean;
        BinSel5Visible: Boolean;
        BinSel6Visible: Boolean;
        BinSel7Visible: Boolean;
        BinSel8Visible: Boolean;
        BinSel9Visible: Boolean;
        BinSel10Visible: Boolean;
        BinSel11Visible: Boolean;
        BinSel12Visible: Boolean;
        BinSel13Visible: Boolean;
        BinSel14Visible: Boolean;
        BinSel15Visible: Boolean;
        BinSel16Visible: Boolean;
        BinSel17Visible: Boolean;
        BinSel18Visible: Boolean;
        BinSel19Visible: Boolean;
        BinSel20Visible: Boolean;
        BinSel21Visible: Boolean;
        BinSel22Visible: Boolean;
        BinSel23Visible: Boolean;
        BinSel24Visible: Boolean;
        BinSel25Visible: Boolean;
        BinSel26Visible: Boolean;
        BinSel27Visible: Boolean;
        BinSel28Visible: Boolean;
        BinSel29Visible: Boolean;
        BinSel30Visible: Boolean;
        BinSel31Visible: Boolean;
        BinSel32Visible: Boolean;
        BinSel33Visible: Boolean;
        BinSel34Visible: Boolean;
        BinSel35Visible: Boolean;
        BinSel36Visible: Boolean;
        BinSel37Visible: Boolean;
        BinSel38Visible: Boolean;
        BinSel39Visible: Boolean;
        BinSel40Visible: Boolean;
        BinSelectionBln: array[40] of Boolean;
        BinSelectionText: array[100] of Code[50];
        Text000: Label 'Please select the any one checkbox.';

    procedure SetCaptions(LocationBin: array[100, 100] of Code[20])
    var
        i: Integer;
    begin
        FOR i := 1 TO 40 DO
            BinSelectionText[i] := LocationBin[i, 1] + ' ' + LocationBin[i, 2];

        BinSel1Visible := (BinSelectionText[1] <> '');
        BinSel2Visible := (BinSelectionText[2] <> '');
        BinSel3Visible := (BinSelectionText[3] <> '');
        BinSel4Visible := (BinSelectionText[4] <> '');
        BinSel5Visible := (BinSelectionText[5] <> '');
        BinSel6Visible := (BinSelectionText[6] <> '');
        BinSel7Visible := (BinSelectionText[7] <> '');
        BinSel8Visible := (BinSelectionText[8] <> '');
        BinSel9Visible := (BinSelectionText[9] <> '');
        BinSel10Visible := (BinSelectionText[10] <> '');
        BinSel11Visible := (BinSelectionText[11] <> '');
        BinSel12Visible := (BinSelectionText[12] <> '');
        BinSel13Visible := (BinSelectionText[13] <> '');
        BinSel14Visible := (BinSelectionText[14] <> '');
        BinSel15Visible := (BinSelectionText[15] <> '');
        BinSel16Visible := (BinSelectionText[16] <> '');
        BinSel17Visible := (BinSelectionText[17] <> '');
        BinSel18Visible := (BinSelectionText[18] <> '');
        BinSel19Visible := (BinSelectionText[19] <> '');
        BinSel20Visible := (BinSelectionText[20] <> '');
        BinSel21Visible := (BinSelectionText[21] <> '');
        BinSel22Visible := (BinSelectionText[22] <> '');
        BinSel23Visible := (BinSelectionText[23] <> '');
        BinSel24Visible := (BinSelectionText[24] <> '');
        BinSel25Visible := (BinSelectionText[25] <> '');
        BinSel26Visible := (BinSelectionText[26] <> '');
        BinSel27Visible := (BinSelectionText[27] <> '');
        BinSel28Visible := (BinSelectionText[28] <> '');
        BinSel29Visible := (BinSelectionText[29] <> '');
        BinSel30Visible := (BinSelectionText[30] <> '');
        BinSel31Visible := (BinSelectionText[31] <> '');
        BinSel32Visible := (BinSelectionText[32] <> '');
        BinSel33Visible := (BinSelectionText[33] <> '');
        BinSel34Visible := (BinSelectionText[34] <> '');
        BinSel35Visible := (BinSelectionText[35] <> '');
        BinSel36Visible := (BinSelectionText[36] <> '');
        BinSel37Visible := (BinSelectionText[37] <> '');
        BinSel38Visible := (BinSelectionText[38] <> '');
        BinSel39Visible := (BinSelectionText[39] <> '');
        BinSel40Visible := (BinSelectionText[40] <> '');
    end;

    procedure ReturnSelection(var SelNo: Integer)
    var
        i: Integer;
    begin
        //>> NF1.00:CIS.NG 09-05-15
        //SelNo := BinSelection+1;
        FOR i := 1 TO 40 DO
            IF BinSelectionBln[i] THEN BEGIN
                SelNo := i;
                EXIT;
            END;
        ERROR(Text000);
        //<< NF1.00:CIS.NG 09-05-15
    end;

    local procedure GetCaption(Index: Integer): Text
    begin
        //>> NF1.00:CIS.NG 09-05-15
        EXIT(BinSelectionText[Index]);
        //<< NF1.00:CIS.NG 09-05-15
    end;

    local procedure UncheckOther(Index: Integer)
    var
        i: Integer;
    begin
        //>> NF1.00:CIS.NG 09-05-15
        FOR i := 1 TO 40 DO
            IF i <> Index THEN
                BinSelectionBln[i] := FALSE;
        //<< NF1.00:CIS.NG 09-05-15
    end;
}

