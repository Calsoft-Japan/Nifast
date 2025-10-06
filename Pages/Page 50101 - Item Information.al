page 50101 "Item Information"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    PageType = CardPart;
    SourceTable = Table50137;

    layout
    {
        area(content)
        {
            field("Item No.";"Item No.")
            {

                trigger OnDrillDown()
                begin
                    FBManagement.LookupItem("Item No.");
                end;
            }
            field(Availability;STRSUBSTNO('(%1)',FBManagement.CalcAvailabilityLine(Rec,FALSE)))
            {
                Caption = 'Availability';
                DecimalPlaces = 2:0;
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                begin
                    //ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec,ItemAvailFormsMgt.ByEvent);
                    ItemAvailability(0);
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field(STRSUBSTNO('(%1)',FBManagement.CalcAvailabilityLine(Rec,TRUE));STRSUBSTNO('(%1)',FBManagement.CalcAvailabilityLine(Rec,TRUE)))
            {
                Caption = 'All Locations';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                begin
                    //ShowPrices;
                    ItemAvailability(2);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    actions
    {
    }

    var
        FBManagement: Codeunit "50133";
}

