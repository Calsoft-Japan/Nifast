table 50100 "SharePoint Setup"
{
    Caption = 'SharePoint Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Client ID"; Text[250])
        {
            Caption = 'Client ID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(4; "Client Secret"; Text[250])
        {
            Caption = 'Client Secret';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(5; "Redirect URL"; Text[250])
        {
            Caption = 'Redirect URL';
        }
        field(7; Scope; Text[250])
        {
            Caption = 'Scope';
        }
        field(9; "Access Token URL"; Text[250])
        {
            Caption = 'Access Token URL';

            trigger OnValidate()
            var
                WebRequestHelper: Codeunit "Web Request Helper";
            begin
                if "Access Token URL" <> '' then
                    WebRequestHelper.IsSecureHttpUrl("Access Token URL");
            end;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Enabled,Disabled,Connected,Error';
            OptionMembers = " ",Enabled,Disabled,Connected,Error;
        }
        field(11; "Access Token"; Blob)
        {
            Caption = 'Access Token';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(12; "Refresh Token"; Blob)
        {
            Caption = 'Refresh Token';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13; "Authorization Time"; DateTime)
        {
            Caption = 'Authorization Time';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(14; "Expires In"; Integer)
        {
            Caption = 'Expires In';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(15; "Ext. Expires In"; Integer)
        {
            Caption = 'Ext. Expires In';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(16; "SharePoint Driver ID"; Text[250])
        {
            Caption = 'SharePoint Driver ID';
        }
        field(17; "SharePoint Main Folder ID"; Text[250])
        {
            Caption = 'SharePoint Main Folder ID';
        }
        field(18; "SharePoint Success Folder"; Text[250])
        {
            Caption = 'SharePoint Success Folder';
        }
        field(19; "SharePoint Error Folder"; Text[250])
        {
            Caption = 'SharePoint Error Folder';
        }
        field(20; "SharePoint Main Folder"; Text[250])
        {
            Caption = 'SharePoint Main Folder';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "SharePoint Main Folder" = '' then begin
                    "SharePoint Main Folder ID" := '';
                    exit;
                end;
                GetMainFolderID();
            end;
        }
        field(21; "Send Email on Error"; Boolean)
        {
            Caption = 'Send Email on Error';
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(22; "Email Title"; Text[30])
        {
            Caption = 'Email Title';
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
        field(23; "Email Subject"; Text[50])
        {
            Caption = 'Email Subject';
            Description = 'EDI.01 - NF1.00:CIS.NG 10/19/15';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    local procedure GetMainFolderID()
    var
        SharePointSetup: Record "SharePoint Setup";
        AccessToken: Text;
        SharePointIntMgt: Codeunit "Share Point Integration Mgt.";
        TempSharePointDriveItem: Record "SharePoint Drive Item" temporary;
    begin
        SharePointSetup.Get(); // assuming only one record for SharePoint Setup
        SharePointSetup.TestField("Client ID");
        SharePointSetup.TestField("Client Secret");
        SharePointSetup.TestField("SharePoint Driver ID");

        SharePointIntMgt.AcquireToken(SharePointSetup."Client ID", SharePointSetup."Client Secret", SharePointSetup.Scope, SharePointSetup."Access Token URL", AccessToken);
        SharePointIntMgt.FetchDrivesItems(AccessToken, SharePointSetup."SharePoint Driver ID", TempSharePointDriveItem);
        if not TempSharePointDriveItem.FindSet() then
            Error('No drive found with the provided SharePoint Driver ID.')
        else
            repeat
                if TempSharePointDriveItem.Name = Rec."SharePoint Main Folder" then begin
                    Rec."SharePoint Main Folder ID" := TempSharePointDriveItem.id;
                    exit;
                end;
            until TempSharePointDriveItem.Next() = 0;
    end;
}