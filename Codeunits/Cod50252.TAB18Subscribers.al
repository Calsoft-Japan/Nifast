codeunit 50252 "Tab18Sub"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterDeleteRelatedData', '', True, false)]
    local procedure OnAfterDeleteRelatedData(Customer: Record Customer)
    begin
        //>>NIF 06-13-06  RTT      #11033
        Cust.RESET;
        Cust.SETCURRENTKEY("Master Customer No.");
        Cust.SETRANGE("Master Customer No.", Customer."No.");
        Cust.SETFILTER("No.", '<>%1', Customer."No.");
        IF NOT Cust.ISEMPTY THEN BEGIN
            Cust.FIND('-');

            ERROR('Customer %1 is a Master Customer for %2 and cannot be deleted.', Customer."No.", Cust."No.");
        END;
        // Cust.RESET;
        //<<NIF 06-13-06  RTT      #11033
        //<<NIF 03-18-05  RTT     #9752
        //>> NV 4.32 05.21.04 JWW: Added for Cr. Mgmt
        //>> NF1.00:CIS.CM 09-29-15
        //IF NVM.TestPermission(14018050) THEN
        //  CreditManagement.DeleteDocComments(10,"No.");
        //<< NF1.00:CIS.CM 09-29-15
        //<< NV 4.32 05.21.04 JWW: Added for Cr. Mgmt

    end;

    var
        Cust: Record Customer;
}