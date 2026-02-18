namespace Nifast.Nifast;

using Microsoft.Finance.RoleCenters;

pageextension 59022 BusinessManagerRoleCenterExt extends "Business Manager Role Center"
{
    actions
    {
        addafter("Issued Finance Charge Memos")
        {
            action("GM Contract Price Import")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'GM Contract Price Import';
                Image = Import;
                RunObject = xmlport 50032;
                ToolTip = 'Offer items or services to a customer.';
            }
        }
    }
}
