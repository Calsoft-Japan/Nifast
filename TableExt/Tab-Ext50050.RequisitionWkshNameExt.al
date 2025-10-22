tableextension 50050 "Requisition Wksh. Name Ext" extends "Requisition Wksh. Name"
{
    fields
    {
        field(14017730; "User ID"; Code[50])
        {
            Description = '20-->50 NF1.00:CIS.NG  10-10-15';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit 418;
            begin
                //LoginMgt.LookupUserID("User ID");
                LoginMgt.DisplayUserInformation("User ID");
            end;

            trigger OnValidate();
            var
                LoginMgt: Codeunit 418;
            begin
                //LoginMgt.ValidateUserID("User ID");
                LoginMgt.DisplayUserInformation("User ID");
            end;
        }

    }

    keys
    {
        key(Key2; "User ID")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}