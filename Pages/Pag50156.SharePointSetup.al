page 50156 "SharePoint Setup"
{
    Caption = 'SharePoint Setup';
    SourceTable = "SharePoint Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("SharePoint Main Folder"; Rec."SharePoint Main Folder")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SharePoint Main Folder field.', Comment = '%';
                }
                field("SharePoint Main Folder ID"; Rec."SharePoint Main Folder ID")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Email Subject"; Rec."Email Subject")
                {
                    ToolTip = 'Specifies the value of the Email Subject field.', Comment = '%';
                }
                field("Email Title"; Rec."Email Title")
                {
                    ToolTip = 'Specifies the value of the Email Title field.', Comment = '%';
                }
                field("Send Email on Error"; Rec."Send Email on Error")
                {
                    ToolTip = 'Specifies the value of the Send Email on Error field.', Comment = '%';
                }

            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

