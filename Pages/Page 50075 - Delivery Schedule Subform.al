page 50075 "Delivery Schedule Subform"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    AutoSplitKey = true;
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Delivery Schedule Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field("Forecast Quantity"; Rec."Forecast Quantity")
                {
                    ToolTip = 'Specifies the value of the Forecast Quantity field.';
                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Expected Delivery Date field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Type Code"; Rec."Type Code")
                {
                    ToolTip = 'Specifies the value of the Type Code field.';
                }
                field("Frequency Code"; Rec."Frequency Code")
                {
                    ToolTip = 'Specifies the value of the Frequency Code field.';
                }
                field("Forecast Unit of Measure"; Rec."Forecast Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Forecast Unit of Measure field.';
                }
            }
        }
    }

    actions
    {
    }
}

