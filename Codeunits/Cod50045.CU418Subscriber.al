codeunit 50045 CU418Subscriber
{
    //Version NAVW18.00,NIF1.093;
    PROCEDURE ShortUserID(VAR UserID: Text[100]): Code[20];
    BEGIN
        //>>NV
        IF STRPOS(UserID, '\') IN [0, STRLEN(UserID)] THEN
            IF STRLEN(UserID) <= 20 THEN
                EXIT(UserID)
            ELSE
                EXIT('')
        ELSE
            EXIT(COPYSTR(UserID, STRPOS(UserID, '\') + 1));
        //<<NV
    END;
}