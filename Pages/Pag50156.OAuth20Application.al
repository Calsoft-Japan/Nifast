page 50156 "OAuth 2.0 Application"
{
    Caption = 'OAuth 2.0 Application';
    LinksAllowed = false;
    ShowFilter = false;
    SourceTable = "OAuth 2.0 Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description.';
                }
                field("Client ID"; Rec."Client ID")
                {
                    Caption = 'Application / Client ID';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the client id.';
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDataType = Masked;
                    ToolTip = 'Specifies the client secret.';
                }
                field("Access Token URL"; Rec."Access Token URL")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the access token url.';
                }
                field("Redirect URL"; Rec."Redirect URL")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the redirect url.';
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the scope.';
                }
            }
            group(Sharepoint)
            {
                Caption = 'SharePoint';
                field("SharePoint Driver ID"; Rec."SharePoint Driver ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the SharePoint driver ID.';
                }
                field("SharePoint Main Folder ID"; Rec."SharePoint Main Folder ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SharePoint Main Folder ID field.', Comment = '%';
                }
                field("SharePoint Success Folder"; Rec."SharePoint Success Folder")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SharePoint Success Folder field.', Comment = '%';
                }
                field("SharePoint Error Folder"; Rec."SharePoint Error Folder")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SharePoint Error Folder field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(processing)
        {
            action(RequestAccessToken)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Request Access Token';
                Image = EncryptionKeys;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Open the service authorization web page. Login credentials will be prompted. The authorization code must be copied into the Enter Authorization Code field.';

                trigger OnAction()
                var
                    MessageTxt: Text;
                begin
                    if not OAuth20AppHelper.RequestAccessToken(Rec, MessageTxt) then begin
                        Commit(); // save new "Status" value
                        Error(MessageTxt);
                    end else
                        Message(SuccessfulMsg);
                end;
            }
            action(RefreshAccessToken)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Access Token';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Refresh the access and refresh tokens.';

                trigger OnAction()
                var
                    MessageText: Text;
                begin
                    if OAuth20AppHelper.GetRefreshToken(Rec) = '' then
                        Error(NoRefreshTokenErr);

                    if not OAuth20AppHelper.RefreshAccessToken(Rec, MessageText) then begin
                        Commit(); // save new "Status" value
                        Error(MessageText);
                    end else
                        Message(SuccessfulMsg);
                end;
            }
        }
    }

    var
        OAuth20AppHelper: Codeunit "OAuth 2.0 App. Helper";
        SuccessfulMsg: Label 'Access Token updated successfully.';
        NoRefreshTokenErr: Label 'No Refresh Token avaiable';
}

