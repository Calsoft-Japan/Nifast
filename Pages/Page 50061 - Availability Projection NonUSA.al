page 50061 "Availability Projection NonUSA"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  02-17-16 Correct the page type to show releated action of page
    // NF1.00:CIS.NG  05-19-16 Save the Page of 50016 to 50083 and Change the Type of page: ListPart --> List
    // JR recompile

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Forecast Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    // BlankNumbers = DontBlank;
                    // BlankZero = true;
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    // BlankNumbers = BlankZero;
                    // BlankZero = true;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Shipping Date"; Rec."Shipping Date")
                {
                    BlankNumbers = DontBlank;
                    //BlankZero = true;
                    Caption = 'Shipping Date';
                    ToolTip = 'Specifies the value of the Shipping Date field.';
                }
                field("Forecast Quantity"; Rec."Forecast Quantity")
                {
                    BlankNumbers = DontBlank;
                    DecimalPlaces = 0 : 0;
                    Caption = 'Forecast Quantity';
                    ToolTip = 'Specifies the value of the Forecast Quantity field.';
                }
                field("Nifast Forecast"; Rec."Nifast Forecast")
                {
                    Caption = 'Nif. Forecast';
                    ToolTip = 'Specifies the value of the Nif. Forecast field.';
                }
                field("Flow Item"; Rec."Flow Item")
                {
                    Caption = 'Flow Item';
                    ToolTip = 'Specifies the value of the Flow Item field.';
                }
                field("Flow Forecast on/off"; Rec."Flow Forecast on/off")
                {
                    Caption = 'Flow Forecast on/off';
                    ToolTip = 'Specifies the value of the Flow Forecast on/off field.';
                }
                field("Enter Date"; Rec."Enter Date")
                {
                    Caption = 'Enter Date';
                    ToolTip = 'Specifies the value of the Enter Date field.';
                }
                field("Division Code"; Rec."Division Code")
                {
                    Caption = 'Div Code';
                    ToolTip = 'Specifies the value of the Div Code field.';
                }
                field("Flow MPD Item"; Rec."Flow MPD Item")
                {
                    Caption = 'Item(M)';
                    ToolTip = 'Specifies the value of the Item(M) field.';
                }
                field("Flow MPD Forecast"; Rec."Flow MPD Forecast")
                {
                    Caption = 'Forecast(M)';
                    ToolTip = 'Specifies the value of the Forecast(M) field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Cross Ref. No."; Rec."Cross Ref. No.")
                {
                    Caption = 'Cross Ref. No.';
                    ToolTip = 'Specifies the value of the Cross Ref. No. field.';
                }
                field(Remark; Rec.Remark)
                {
                    Caption = 'Remark';
                    ToolTip = 'Specifies the value of the Remark field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action("Forecast Module")
                {
                    Caption = 'Forecast Module';
                    Image = Forecast;
                    RunObject = Report "Forecast Module";
                    ToolTip = 'Executes the Forecast Module action.';
                }
                action("Shortage Report")
                {
                    RunObject = Report 50089;
                    Image = Report;
                    ToolTip = 'Executes the Shortage Report action.';
                }
            }
            group(Imports)
            {
                Caption = 'Import';
                action(Import)
                {
                    Caption = 'Import';
                    Promoted = true;
                    Image = Import;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = XMLport 50017;
                    ToolTip = 'Executes the Import action.';
                }
            }
        }
    }
}

