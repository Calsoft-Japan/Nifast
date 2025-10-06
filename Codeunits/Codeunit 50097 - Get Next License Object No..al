codeunit 50097 "Get Next License Object No."
{

    trigger OnRun()
    var
        LicPermission_lRec: Record "2000000043";
        LastFieldNo_lInt: Integer;
        StrMenu_lInt: Integer;
    begin
        StrMenu_lInt := STRMENU(Text000,6);
        IF StrMenu_lInt = 0 THEN
          EXIT;

        CASE StrMenu_lInt OF
          1: TypeLicPermission_gRec."Object Type" := TypeLicPermission_gRec."Object Type"::TableData;
          2: TypeLicPermission_gRec."Object Type" := TypeLicPermission_gRec."Object Type"::Page;
          3: TypeLicPermission_gRec."Object Type" := TypeLicPermission_gRec."Object Type"::Report;
          4: TypeLicPermission_gRec."Object Type" := TypeLicPermission_gRec."Object Type"::Codeunit;
          5: TypeLicPermission_gRec."Object Type" := TypeLicPermission_gRec."Object Type"::XMLport;
          ELSE
            ERROR('Case Not Found');
        END;

        LicPermission_lRec.RESET;
        LicPermission_lRec.SETRANGE("Object Type",TypeLicPermission_gRec."Object Type");
        LicPermission_lRec.SETFILTER("Object Number",'>=%1&<=%2',50000,99999);
        LicPermission_lRec.SETRANGE("Read Permission",LicPermission_lRec."Read Permission"::Yes);
        IF LicPermission_lRec.FINDSET THEN BEGIN
          REPEAT
            IF NOT ObjectExists_lFnc(LicPermission_lRec."Object Number") THEN BEGIN
              MESSAGE('New Object No. = %1',LicPermission_lRec."Object Number");
              EXIT;
            END;
          UNTIL LicPermission_lRec.NEXT = 0;
        END ELSE BEGIN
          MESSAGE('New Object No. = %1',50000);
          EXIT;
        END;

        MESSAGE('New Object No. = %1',50000);
        EXIT;
    end;

    var
        Text000: Label 'Table,Page,Report,Codeunit,XMLport';
        TypeLicPermission_gRec: Record "2000000043";

    procedure ObjectExists_lFnc(No_iInt: Integer): Boolean
    var
        Object_lRec: Record "2000000001";
    begin
        Object_lRec.RESET;
        Object_lRec.SETRANGE(Type,TypeLicPermission_gRec."Object Type");
        Object_lRec.SETRANGE(ID,No_iInt);
        EXIT(Object_lRec.FINDFIRST);
    end;
}

