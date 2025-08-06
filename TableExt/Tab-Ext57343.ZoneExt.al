tableextension 57355 "Zone Ext" extends Zone
{
    // version NAVW18.00,NV4.35,NIF.N15.C9IN.001
    PROCEDURE "> NV"();
    BEGIN
    END;

    PROCEDURE SetBinTypeFilter(SetBinType: Option "All Zones",Receive,"Put-away",Pick,Ship,Other; VAR Zone: Record 7300);
    VAR
        ">> NV": Integer;
        BinType: Record 7303;
        BinTypeFilter: Text[250];
        Text14017990: Label 'The %1 filter expression is too long.\Please use less %1s or shorter %1 %2s.';
    BEGIN
        // >> NV - 08/26/03 MV
        CLEAR(BinTypeFilter);
        CASE SetBinType OF
            SetBinType::Receive:
                BinType.CreateBinTypeFilter(BinTypeFilter, 0);
            SetBinType::Ship:
                BinType.CreateBinTypeFilter(BinTypeFilter, 1);
            SetBinType::"Put-away":
                BinType.CreateBinTypeFilter(BinTypeFilter, 2);
            SetBinType::Pick:
                BinType.CreateBinTypeFilter(BinTypeFilter, 3);
            SetBinType::Other:
                BEGIN
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
                            THEN BEGIN
                                IF BinTypeFilter = '' THEN
                                    BinTypeFilter := BinType.Code
                                ELSE
                                    BinTypeFilter := BinTypeFilter + '|' + BinType.Code;
                            END ELSE
                                ERROR(Text14017990,
                                  BinType.TABLECAPTION, BinType.FIELDCAPTION(Code));
                        UNTIL BinType.NEXT = 0;
                END;
        END;
        // {Case}

        IF BinTypeFilter <> '' THEN
            Zone.SETFILTER("Bin Type Code", BinTypeFilter)
        ELSE
            Zone.SETRANGE("Bin Type Code");
        // << NV - 08/26/03 MV
    END;
}
