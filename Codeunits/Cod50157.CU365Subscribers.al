codeunit 50157 CU365Subscribers
{
    var
        FormatAddrCU: Codeunit "Format Address";

    procedure RespCenterPhoneFax(var AddrArray: array[8] of Text[50]; var RespCenter: Record 5714);
    var
        LastElementUsed: Integer;
        CurrElement: Integer;
    begin
        FormatAddrCU.FormatAddr(
    AddrArray, RespCenter.Name, RespCenter."Name 2", RespCenter.Contact, RespCenter.Address, RespCenter."Address 2",
    RespCenter.City, RespCenter."Post Code", RespCenter.County, RespCenter."Country/Region Code");

        //>>NIF MAK 061405
        for CurrElement := 1 to 8 do
            if STRLEN(FORMAT(AddrArray[CurrElement])) > 0 then
                LastElementUsed := CurrElement;

        LastElementUsed := LastElementUsed + 2;  //Inserts a "blank" line in the array

        //Check for a Resp Ctr Phone No...
        if STRLEN(FORMAT(RespCenter."Phone No.")) > 0 then
            if LastElementUsed <= 8 then begin
                AddrArray[LastElementUsed] := COPYSTR(FORMAT('Phone: ') + FORMAT(RespCenter."Phone No."), 1, 50);
                LastElementUsed := LastElementUsed + 1;
            end;

        //Check for a Resp Ctr Fax No...
        if STRLEN(FORMAT(RespCenter."Fax No.")) > 0 then
            if LastElementUsed <= 8 then
                AddrArray[LastElementUsed] := COPYSTR(FORMAT('Fax: ') + FORMAT(RespCenter."Fax No."), 1, 50);
        //LastElementUsed := LastElementUsed + 1;


        //<<NIF
    end;

    procedure NifastMexCompanySlsDocs(var AddrArray: array[8] of Text[50]; var CompanyInfo: Record 79);
    var
        LastElementUsed: Integer;
        CurrElement: Integer;
    begin
        FormatAddrCU.FormatAddr(
    AddrArray, CompanyInfo.Name, CompanyInfo."Name 2", '', CompanyInfo.Address, CompanyInfo."Address 2",
    CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.County, '');

        //>>NIF MAK 061405
        for CurrElement := 1 to 8 do
            if STRLEN(FORMAT(AddrArray[CurrElement])) > 0 then
                LastElementUsed := CurrElement;

        LastElementUsed := LastElementUsed + 2;  //Inserts a "blank" line in the array
                                                 //Check for a Phone No...
        if STRLEN(FORMAT(CompanyInfo."Phone No.")) > 0 then
            if LastElementUsed <= 8 then begin
                AddrArray[LastElementUsed] := COPYSTR(FORMAT('Phone: ') + FORMAT(CompanyInfo."Phone No."), 1, 50);
                LastElementUsed := LastElementUsed + 1;
            end;

        //Check for a Fax No...
        if STRLEN(FORMAT(CompanyInfo."Fax No.")) > 0 then
            if LastElementUsed <= 8 then begin
                AddrArray[LastElementUsed] := COPYSTR(FORMAT('Fax: ') + FORMAT(CompanyInfo."Fax No."), 1, 50);
                LastElementUsed := LastElementUsed + 1;
            end;

        //Get the RFC Number
        if STRLEN(FORMAT(CompanyInfo."RFC Number")) > 0 then
            if LastElementUsed <= 8 then
                AddrArray[LastElementUsed] := COPYSTR(FORMAT('RFC: ') + FORMAT(CompanyInfo."RFC Number"), 1, 50);
        //LastElementUsed := LastElementUsed + 1;

        //<<NIF
    end;

    // procedure BillOfLadingThirdParty(var AddrArray: array[8] of Text[50]; var BillOfLading: Record 14000822); //TODO
    // begin
    //     FormatAddr(
    // AddrArray, "Third Party Name", "Third Party Name 2", "Third Party Contact",
    // "Third Party Address", "Third Party Address 2", "Third Party City",
    // "Third Party ZIP Code", "Third Party State", "Third Party Country Code");
    // end;
}
