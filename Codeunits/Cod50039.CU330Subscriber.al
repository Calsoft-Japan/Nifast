codeunit 50039 CU330Subscriber
{
    //Version NAVW17.00,NV4.00;
    var
        ReqJnlManagementCU: Codeunit ReqJnlManagement;

    PROCEDURE LookupNameNV(VAR CurrentJnlBatchName: Code[10]; VAR ReqLine: Record 246): Boolean;
    VAR
        ReqWkshName: Record 245;
    BEGIN
        //TODO
        //>>NV
        COMMIT();
        ReqWkshName."Worksheet Template Name" := ReqLine.GETRANGEMAX("Worksheet Template Name");
        ReqWkshName.Name := ReqLine.GETRANGEMAX("Journal Batch Name");
        ReqWkshName.FILTERGROUP := 2;
        ReqWkshName.SETRANGE("Worksheet Template Name", ReqWkshName."Worksheet Template Name");
        //-> istdrs 20020220
        ReqWkshName.SETFILTER("User ID", '%1|%2', USERID, '');
        //<- istdrs 20020220
        ReqWkshName.FILTERGROUP := 0;
        IF PAGE.RUNMODAL(0, ReqWkshName) = ACTION::LookupOK THEN BEGIN
            CurrentJnlBatchName := ReqWkshName.Name;
            ReqJnlManagementCU.SetName(CurrentJnlBatchName, ReqLine);
        END;
        //<<NV 
        //TODO
    END;
}

