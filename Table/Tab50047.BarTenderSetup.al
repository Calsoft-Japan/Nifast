table 50047 "Bar Tender Setup"
{
    Caption = 'Bar Tender Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
        }
        field(2; client_id; Text[250])
        {
            Caption = 'client_id';
        }
        field(3; client_secret; Text[250])
        {
            Caption = 'client_secret';
        }
        field(4; grant_type; Text[100])
        {
            Caption = 'grant_type';
        }
        field(5; audience; Text[150])
        {
            Caption = 'audience';
        }
        field(6; username; Text[150])
        {
            Caption = 'username';
        }
        field(7; password; Text[150])
        {
            Caption = 'password';
        }
        field(8; scope; Text[150])
        {
            Caption = 'scope';
        }
        field(9; "Access Token URL"; Text[250])
        {
            Caption = 'Access Token URL';
        }
        field(10; Token; Text[2048])
        {
        }
        field(11; "Token Expires On"; DateTime)
        {
        }
        field(12; "Bar Tender Print URL"; Text[250])
        {
            Caption = 'Bar Tender Print URL';
        }
        field(13; OrganizationDnsName; Text[100])
        {
            Caption = 'OrganizationDnsName';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
