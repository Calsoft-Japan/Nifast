tableextension 50015 "G/L Account Ext" extends "G/L Account"
{
    fields
    {
        field(50001; "Income Tax Withholding Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
            TableRelation = "Withholding Groups"."Withholding Group" where("Income Tax" = filter(true));
        }
        field(50002; "VAT Tax Withholding Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'RET1.0';
            TableRelation = "Withholding Groups"."Withholding Group" where("VAT Tax" = filter(true));
        }
    }
}
