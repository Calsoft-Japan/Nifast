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
        field(50004; "SPS Serial E-Mail Subject Text"; Text[100])
        {
            Caption = 'SPS Serial Subject Text';
            DataClassification = CustomerContent;
        }
        field(50005; "SPS Serial E-Mail Body Text"; Text[250])
        {
            Caption = 'SPS Serial E-Mail Body Text';
            DataClassification = CustomerContent;
        }
        field(50006; "SPS Partial E-Mail Body Text"; Text[250])
        {
            Caption = 'SPS Partial E-Mail Body Text';
            DataClassification = CustomerContent;
        }
        field(50007; "SPS Partial E-Mail Subject Text"; Text[100])
        {
            Caption = 'SPS Partial Subject Text';
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
