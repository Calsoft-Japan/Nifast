tableextension 50098 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Foreign Exchange Contract Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Bank Exchange Contract Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "SPS E-Mail"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'SPS E-mail';
        }
        field(50003; "SPS Error E-Mails Text Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text".Code;
        }
        field(50004; "SPS E-Mail Subject Text"; Text[100])
        {
            Caption = 'SPS Subject Text';
            DataClassification = CustomerContent;
        }
        field(50005; "SPS E-Mail Body Text"; Text[250])
        {
            Caption = 'SPS Body Text';
            DataClassification = CustomerContent;
        }
        field(50051; "Payee Match Export Shared Dir"; Text[100])
        {
            Caption = 'Payee Match Export File Shared Directory';
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50052; "FTP User ID"; Text[30])
        {
            Caption = 'FTP User ID';
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50053; "FTP Password"; Text[30])
        {
            Caption = 'FTP Password';
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50054; "FTP Use SSL"; Boolean)
        {
            Caption = 'FTP Use SSL';
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50055; "FTP Server Name with Directory"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
        field(50056; "Upload File To FTP"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
        }
    }
}
