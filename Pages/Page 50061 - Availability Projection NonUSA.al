page 50061 "Availability Projection NonUSA"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade
    // NF1.00:CIS.NG  02-17-16 Correct the page type to show releated action of page
    // NF1.00:CIS.NG  05-19-16 Save the Page of 50016 to 50083 and Change the Type of page: ListPart --> List
    // JR recompile

    PageType = List;
    SourceTable = Table50027;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Entry No.";"Entry No.")
                {
                }
                field("Item No.";"Item No.")
                {
                    BlankNumbers = DontBlank;
                    BlankZero = true;
                }
                field("Customer No.";"Customer No.")
                {
                    BlankNumbers = BlankZero;
                    BlankZero = true;
                }
                field("Shipping Date";"Shipping Date")
                {
                    BlankNumbers = DontBlank;
                    BlankZero = true;
                }
                field("Forecast Quantity";"Forecast Quantity")
                {
                    BlankNumbers = DontBlank;
                    DecimalPlaces = 0:0;
                }
                field("Nifast Forecast";"Nifast Forecast")
                {
                    Caption = 'Nif. Forecast';
                }
                field("Flow Item";"Flow Item")
                {
                }
                field("Flow Forecast on/off";"Flow Forecast on/off")
                {
                }
                field("Enter Date";"Enter Date")
                {
                }
                field("Division Code";"Division Code")
                {
                    Caption = 'Div Code';
                }
                field("Flow MPD Item";"Flow MPD Item")
                {
                    Caption = 'Item(M)';
                }
                field("Flow MPD Forecast";"Flow MPD Forecast")
                {
                    Caption = 'Forecast(M)';
                }
                field(Description;Description)
                {
                }
                field("Cross Ref. No.";"Cross Ref. No.")
                {
                }
                field(Remark;Remark)
                {
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
                    RunObject = Report 50120;
                }
                action("Shortage Report")
                {
                    RunObject = Report 50089;
                }
            }
            group(Import)
            {
                Caption = 'Import';
                action(Import)
                {
                    Caption = 'Import';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = XMLport 50017;
                }
            }
        }
    }
}

