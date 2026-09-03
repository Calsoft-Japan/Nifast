page 50100 "Bar Tender Setup"
{
    ApplicationArea = All;
    Caption = 'Bar Tender Setup';
    PageType = Card;
    SourceTable = "Bar Tender Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Access Token URL"; Rec."Access Token URL")
                {
                    ToolTip = 'Specifies the value of the Access Token URL field.', Comment = '%';
                }
                field(client_id; Rec.client_id)
                {
                    ToolTip = 'Specifies the value of the client_id field.', Comment = '%';
                }
                field(client_secret; Rec.client_secret)
                {
                    ToolTip = 'Specifies the value of the client_secret field.', Comment = '%';
                }
                field(grant_type; Rec.grant_type)
                {
                    ToolTip = 'Specifies the value of the grant_type field.', Comment = '%';
                }
                field(scope; Rec.scope)
                {
                    ToolTip = 'Specifies the value of the scope field.', Comment = '%';
                }
                field(username; Rec.username)
                {
                    ToolTip = 'Specifies the value of the username field.', Comment = '%';
                }
                field(password; Rec.password)
                {
                    ToolTip = 'Specifies the value of the password field.', Comment = '%';
                }
                field(audience; Rec.audience)
                {
                    ToolTip = 'Specifies the value of the audience field.', Comment = '%';
                }
                field("Bar Tender Print URL"; Rec."Bar Tender Print URL")
                {
                    ToolTip = 'Specifies the value of the Bar Tender Print URL field.', Comment = '%';
                }
                field(OrganizationDnsName; Rec.OrganizationDnsName)
                {
                    ToolTip = 'Specifies the value of the OrganizationDnsName field.', Comment = '%';
                }
                field(Token; Rec.Token)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Token field.', Comment = '%';
                }
            }
        }
    }
}
