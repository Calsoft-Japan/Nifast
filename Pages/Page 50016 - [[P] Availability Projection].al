page 50016 "[[P] Availability Projection]"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  02-17-16 Correct the page type to show releated action of page

    PageType = ListPart;
    SourceTable = "Forecast Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    // BlankNumbers = DontBlank;
                    // BlankZero = true;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    // BlankNumbers = BlankZero;
                    // BlankZero = true;
                }
                field("Shipping Date"; Rec."Shipping Date")
                {
                    ToolTip = 'Specifies the value of the Shipping Date field.';
                    //     BlankNumbers = DontBlank;
                    //     BlankZero = true;
                }
                field("Forecast Quantity"; Rec."Forecast Quantity")
                {
                    BlankNumbers = DontBlank;
                    DecimalPlaces = 0 : 0;
                    ToolTip = 'Specifies the value of the Forecast Quantity field.';
                }
                field("Nifast Forecast"; Rec."Nifast Forecast")
                {
                    Caption = 'Nif. Forecast';
                    ToolTip = 'Specifies the value of the Nif. Forecast field.';
                }
                field("Flow Item"; Rec."Flow Item")
                {
                    ToolTip = 'Specifies the value of the Flow Item field.';
                }
                field("Flow Forecast on/off"; Rec."Flow Forecast on/off")
                {
                    ToolTip = 'Specifies the value of the Flow Forecast on/off field.';
                }
                field("Enter Date"; Rec."Enter Date")
                {
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
                    ToolTip = 'Specifies the value of the Description field.';
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
                action("Run Forecast Module")
                {
                    Caption = 'Run Forecast Module';
                    Image = Forecast;
                    RunObject = Report "Forecast Module";
                    ToolTip = 'Executes the Run Forecast Module action.';
                }
            }
            group(Imports)
            {
                Caption = 'Import';
                action(Import)
                {
                    Caption = 'Import';
                    Image = Import;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = XMLport "Forecast Import wo Remark";
                    ToolTip = 'Executes the Import action.';
                }
                action("Import w/Description")
                {
                    Caption = 'Import w/Description';
                    Image = Import;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = XMLport "Import Forecast w Description";
                    ToolTip = 'Executes the Import w/Description action.';
                }
            }
        }
    }
}

