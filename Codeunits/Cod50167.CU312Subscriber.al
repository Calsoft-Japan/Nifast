codeunit 50167 CU312Subscriber
{
    //Version List=NAVW17.00,NIF0.006,NIF.N15.C9IN.001;
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
        CustCheckCrLimit: Codeunit "Cust-Check Cr. Limit";
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        CustCheckCreditLimit: Page "Check Credit Limit";
        Text000: Label 'The update has been interrupted to respect the warning.';
        CreditLimitNotificationMsg: Label 'The customer''s credit limit has been exceeded.';
        OverdueBalanceNotificationMsg: Label 'This customer has an overdue balance.';
        GetDetailsTxt: Label 'Show details';
        // ">>NIF_GV": Integer;
        CalledFromRelease: Boolean;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust-Check Cr. Limit", OnBeforeSalesHeaderCheck, '', false, false)]
    local procedure OnBeforeSalesHeaderCheck(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var CreditLimitExceeded: Boolean);
    var
        AdditionalContextId: Guid;
    begin
        IsHandled := true;

        if GuiAllowed then begin

            //>> NIF #10053 RTT 05-23-05
            //TODO
            if CalledFromRelease then
                CustCheckCreditLimit.SetCalledFromRelease();
            //TODO
            CustCheckCreditLimit.EDITABLE(true);  //NF1.00:CIS.NG  05/27/16

            //<< NIF #10053 RTT 05-23-05 

            if not CustCheckCreditLimit.SalesHeaderShowWarningAndGetCause(SalesHeader, AdditionalContextId) then
                SalesHeader.CustomerCreditLimitNotExceeded()
            else begin
                CreditLimitExceeded := true;

                if InstructionMgt.IsEnabled(CustCheckCrLimit.GetInstructionType(Format(SalesHeader."Document Type"), SalesHeader."No.")) then
                    CreateAndSendNotification(SalesHeader.RecordId, AdditionalContextId, '');

                SalesHeader.CustomerCreditLimitExceeded(CustCheckCreditLimit.GetNotificationId());

                //TODO
                //>> NF1.00:CIS.NG  05/27/16
                IF NOT CustCheckCreditLimit.GetPasswordValue() THEN
                    ERROR(Text000);
                //<< NF1.00:CIS.NG  05/27/16 
                //TODO
            end;
        end;
    end;


    local procedure CreateAndSendNotification(RecordId: RecordID; AdditionalContextId: Guid; Heading: Text[250])
    var
        NotificationToSend: Notification;
    begin
        if AdditionalContextId = CustCheckCrLimit.GetBothNotificationsId() then begin
            CreateAndSendNotification(RecordId, CustCheckCrLimit.GetCreditLimitNotificationId(), CustCheckCreditLimit.GetHeading());
            CreateAndSendNotification(RecordId, CustCheckCrLimit.GetOverdueBalanceNotificationId(), CustCheckCreditLimit.GetSecondHeading());
            exit;
        end;

        if Heading = '' then
            Heading := CustCheckCreditLimit.GetHeading();

        case Heading of
            CreditLimitNotificationMsg:
                NotificationToSend.Id(CustCheckCrLimit.GetCreditLimitNotificationId());
            OverdueBalanceNotificationMsg:
                NotificationToSend.Id(CustCheckCrLimit.GetOverdueBalanceNotificationId());
            else
                NotificationToSend.Id(CreateGuid());
        end;

        NotificationToSend.Message(Heading);
        NotificationToSend.Scope(NOTIFICATIONSCOPE::LocalScope);
        NotificationToSend.AddAction(GetDetailsTxt, CODEUNIT::"Cust-Check Cr. Limit", 'ShowNotificationDetails');
        CustCheckCreditLimit.PopulateDataOnNotification(NotificationToSend);
        NotificationLifecycleMgt.SendNotificationWithAdditionalContext(NotificationToSend, RecordId, AdditionalContextId);
    end;

    procedure ">>NIF_fcn"();
    begin

    end;

    procedure SetCalledFromRelease();
    begin
        CalledFromRelease := true;
    end;
}