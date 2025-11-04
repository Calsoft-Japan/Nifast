tableextension 50270 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(50000; "Bank Code SAT"; Code[20])
        {
            Caption = 'Bank Code';
            DataClassification = ToBeClassified;
            Numeric = true;
            TableRelation = "SAT Bank Code".Code;
        }
        field(50001; "Client Number Payee Match"; Code[9])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
            trigger OnValidate();
            begin
                //>> NF1.00:CIS.NG    06/18/16
                if "Client Number Payee Match" <> '' then
                    if STRLEN("Client Number Payee Match") <> 9 then
                        ERROR('Client Number should be contain 9 Character');
                //<< NF1.00:CIS.NG    06/18/16
            end;
        }
        field(50002; "Transit/Branch Number"; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
            trigger OnValidate();
            begin
                //>> NF1.00:CIS.NG    06/18/16
                if "Transit/Branch Number" <> '' then
                    if STRLEN("Transit/Branch Number") <> 5 then
                        ERROR('Transit/Branch Number should be contain 5 Character');

                //<< NF1.00:CIS.NG    06/18/16
            end;
        }
        field(50003; "SRF Number"; Code[9])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
            trigger OnValidate();
            begin
                //>> NF1.00:CIS.NG    06/18/16
                if "SRF Number" <> '' then
                    if STRLEN("SRF Number") <> 9 then
                        ERROR('SRF Number should be contain 9 Character');

                //<< NF1.00:CIS.NG    06/18/16
            end;
        }
        field(50005; "File Number Payee Match"; Code[4])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.NG    06/18/16';
            trigger OnValidate();
            var
                Text500000Lbl: Label 'The string %1 contains no number and cannot be incremented.', Comment = '%1';
            begin
                //>> NF1.00:CIS.NG    06/18/16
                if "File Number Payee Match" <> '' then begin
                    if INCSTR("File Number Payee Match") = '' then
                        ERROR(Text500000Lbl, "File Number Payee Match");

                    if STRLEN("File Number Payee Match") <> 4 then
                        ERROR('File Number must be contain 4 digit');
                end;
                //<< NF1.00:CIS.NG    06/18/16
            end;
        }
        field(70000; "MICR Layout Picture"; Text[50])
        {
        }
        field(70001; "Leading Zeros"; Boolean)
        {
        }
        field(70002; "Check No. Width"; Integer)
        {
        }
        field(70003; "Company Address 1"; Text[50])
        {
        }
        field(70004; "Company Address 2"; Text[50])
        {
        }
        field(70005; "Company Address 3"; Text[50])
        {
        }
        field(70006; "Company Address 4"; Text[50])
        {
        }
        field(70007; "Company Address 5"; Text[50])
        {
        }
        field(70008; "Bank Address 1"; Text[50])
        {
        }
        field(70009; "Bank Address 2"; Text[50])
        {
        }
        field(70010; "Bank Address 3"; Text[50])
        {
        }
        field(70011; "Bank Address 4"; Text[50])
        {
        }
        field(70012; "Bank Address 5"; Text[50])
        {
        }
        field(70013; "Currency Name"; Text[20])
        {
        }
        field(70014; "Currency Symbole"; Text[10])
        {
        }
        field(70015; "Signature Line 1"; Boolean)
        {
            trigger OnValidate()
            begin
                IF NOT "Signature Line 1" AND "Signature Line 2" THEN
                    ERROR(NV001);
            end;
        }
        field(70016; "Signature Line 2"; Boolean)
        {
            trigger OnValidate()
            begin
                IF NOT "Signature Line 1" AND "Signature Line 2" THEN
                    ERROR(NV001);
            end;
        }
        field(70017; "Check Format"; Option)
        {
            OptionCaptionML = ENU = 'Preprinted, Blank';
            OptionMembers = Preprinted,Blank;
        }
        field(70018; "Check Layout"; Option)
        {
            OptionCaptionML = ENU = 'Stub Stub Check, Stub Check Stub, Check Stub Stub, Long Stub Check';
            OptionMembers = "Stub Stub Check","Stub Check Stub","Check Stub Stub","Long Stub Check";
        }
        field(70019; "Copy Check"; Option)
        {
            OptionCaptionML = ENU = '" ,Stub 1,Stub 2"';
            OptionMembers = " ","Stub 1","Stub 2";
        }
    }
    var
        NV001: TextConst ENU = 'Signature Line 2 can not be selected without Signature Line 2';
}
