tableextension 57343 "Zone Ext" extends Zone
{
    // version NAVW18.00,NV4.35,NIF.N15.C9IN.001
    fields
    {
        field(70000; "Zone Pick Type"; Code[10])
        {
        }
        field(70001; "Bin Size Code"; Code[20])
        {
            Description = 'NV - NF1.00:CIS.CM 09-29-15';
        }
        field(70002; "QC Bin Zone"; Boolean)
        {
        }

    }

    procedure SetBinTypeFilter(SetBinType: Option "All Zones",Receive,"Put-away",Pick,Ship,Other; var Zone: Record 7300);
    var
        // ">> NV": Integer;
        BinType: Record 7303;
        BinTypeFilter: Text[250];
        Text14017990: Label 'The %1 filter expression is too long.\Please use less %1s or shorter %1 %2s.', Comment = '%1 = BinType.TABLECAPTION ; %2 = Parent XML node name';
    begin
        // >> NV - 08/26/03 MV
        CLEAR(BinTypeFilter);
        CASE SetBinType OF
            SetBinType::Receive:
                BinType.MakeBinTypeFilter(BinTypeFilter, 0);
            SetBinType::Ship:
                BinType.MakeBinTypeFilter(BinTypeFilter, 1);
            SetBinType::"Put-away":
                BinType.MakeBinTypeFilter(BinTypeFilter, 2);
            SetBinType::Pick:
                BinType.MakeBinTypeFilter(BinTypeFilter, 3);
            SetBinType::Other:
                begin
                    BinTypeFilter := '';
                    CLEAR(BinType);
                    BinType.SETRANGE(Receive, FALSE);
                    BinType.SETRANGE(Ship, FALSE);
                    BinType.SETRANGE("Put Away", FALSE);
                    BinType.SETRANGE(Pick, FALSE);
                    IF BinType.FIND('-') THEN
                        REPEAT
                            IF STRLEN(BinTypeFilter) + STRLEN(BinType.Code) + 1 <=
                              MAXSTRLEN(BinTypeFilter)
                            THEN begin
                                IF BinTypeFilter = '' THEN
                                    BinTypeFilter := BinType.Code
                                ELSE
                                    BinTypeFilter := BinTypeFilter + '|' + BinType.Code;
                            end ELSE
                                ERROR(Text14017990,
                                  BinType.TABLECAPTION, BinType.FIELDCAPTION(Code));
                        UNTIL BinType.NEXT() = 0;
                end;
        end;
        // {Case}

        IF BinTypeFilter <> '' THEN
            Zone.SETFILTER("Bin Type Code", BinTypeFilter)
        ELSE
            Zone.SETRANGE("Bin Type Code");
        // << NV - 08/26/03 MV
    end;
}
