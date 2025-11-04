page 50101 "Item Information"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = CardPart;
    UsageCategory = None;
    SourceTable = "FB Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Item No."; Rec."Item No.")
            {
                ToolTip = 'Specifies the value of the Item No. field.';

                trigger OnDrillDown()
                begin
                    FBManagement.LookupItem(Rec."Item No.");
                end;
            }
            field(Availability; STRSUBSTNO('(%1)', FBManagement.CalcAvailabilityLine(Rec, FALSE)))
            {
                Caption = 'Availability';
                //DecimalPlaces = 2 : 0;
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the value of the Availability field.';

                trigger OnDrillDown()
                begin
                    //ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec,ItemAvailFormsMgt.ByEvent);
                    Rec.ItemAvailability(0);
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field(CalcAvailabilityLine; STRSUBSTNO('(%1)', FBManagement.CalcAvailabilityLine(Rec, TRUE)))
            {
                Caption = 'All Locations';
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the value of the All Locations field.';

                trigger OnDrillDown()
                begin
                    //ShowPrices;
                    Rec.ItemAvailability(2);
                    CurrPage.UPDATE();
                end;
            }
        }
    }

    actions
    {
    }

    var
        FBManagement: Codeunit "FB Management";
}

