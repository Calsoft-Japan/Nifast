tableextension 50015 "G/L Account Ext" extends "G/L Account"
{
    fields
    {
        field(50001;"Income Tax Withholding Group";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
        }
        field(50002;"VAT Tax Withholding Group";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
        }
    }
}
