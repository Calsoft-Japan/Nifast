codeunit 50013 "Bank Exchange Contract Mgt."
{
    // NF1.00:CIS.NG  11-04-15 Fix the Compilation Issue
    // >> IST
    // Date     Init  SCR    Description
    // 04-11-05 DPC   #9806  New Codeunit to handle "4X Contracts"
    // << IST


    trigger OnRun()
    begin
    end;

    var
        TEXT001: Label 'No Associated Orders found';

    procedure SuggestTotalJPY("Contract No.": Code[20]) TotalAmount: Decimal
    var
        PurchHeader: Record 38;
        MasterHeader: Record 50011;
    begin
        //MasterHeader.SETRANGE(Total, "Contract No."); //NF1.00:CIS.NG  11-04-15
        MasterHeader.SETRANGE("Contract Note No.", "Contract No."); //NF1.00:CIS.NG  11-04-15
        IF MasterHeader.FIND('-') THEN
            REPEAT
                PurchHeader.SETRANGE("Contract Note No.", MasterHeader."No.");
                IF PurchHeader.FIND('-') THEN
                    REPEAT
                        PurchHeader.CALCFIELDS(Amount);
                        TotalAmount := TotalAmount + PurchHeader.Amount;
                    UNTIL PurchHeader.NEXT() = 0;
            UNTIL MasterHeader.NEXT() = 0
        ELSE
            MESSAGE(TEXT001);
    end;
}

