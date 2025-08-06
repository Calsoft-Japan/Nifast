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
    }
}
