page 50047 "Commercial Invoice Mex Form"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Commercial Invoice MEX";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Virtural Operation No."; Rec."Virtural Operation No.")
                {
                    ToolTip = 'Specifies the value of the Virtural Operation No. field.';
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                    ToolTip = 'Specifies the value of the Country of Origin field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Custom Agent License No."; Rec."Custom Agent License No.")
                {
                    ToolTip = 'Specifies the value of the Custom Agent License No. field.';
                }
                field("Customer Agent E/S"; Rec."Customer Agent E/S")
                {
                    ToolTip = 'Specifies the value of the Customer Agent E/S field.';
                }
                field("Date of Entry"; Rec."Date of Entry")
                {
                    ToolTip = 'Specifies the value of the Date of Entry field.';
                }
                field("Summary Entry No."; Rec."Summary Entry No.")
                {
                    ToolTip = 'Specifies the value of the Summary Entry No. field.';
                }
                field("Summary Entry Code"; Rec."Summary Entry Code")
                {
                    ToolTip = 'Specifies the value of the Summary Entry Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Tax Amount field.';
                }
                field("Amount Incl Tax"; Rec."Amount Incl Tax")
                {
                    ToolTip = 'Specifies the value of the Amount Incl Tax field.';
                }
                field("Doc No"; Rec."Doc No")
                {
                    ToolTip = 'Specifies the value of the Doc No field.';
                }
                field("Doc Line No"; Rec."Doc Line No")
                {
                    ToolTip = 'Specifies the value of the Doc Line No field.';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
            }
        }
    }

    actions
    {
    }
}

