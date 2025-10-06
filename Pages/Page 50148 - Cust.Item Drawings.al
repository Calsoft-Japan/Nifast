page 50148 "Cust./Item Drawings"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Lot Entry Functionality Renumber)
    // NF1.00:CIS.CM    10/26/15 Update for New Vision Removal Task (Update the link)
    // >> NIF
    // Fields Modified:
    //   Revision No. (HorzGlue=Both)
    //   Drawing No. (HorzGlue=Left)
    // << NIF

    DataCaptionFields = "Item No.","Customer No.";
    PageType = Card;
    SourceTable = Table50142;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Revision No.";"Revision No.")
                {
                }
                field("Drawing No.";"Drawing No.")
                {
                }
                field("Revision Date";"Revision Date")
                {
                }
                field(Active;Active)
                {
                }
                field("Drawing Type";"Drawing Type")
                {
                }
                field("First Article Approval";"First Article Approval")
                {
                }
                field("First Article Waiver";"First Article Waiver")
                {
                }
                field("PPAP Approval";"PPAP Approval")
                {
                }
                field(Components;Components)
                {
                }
            }
        }
    }

    actions
    {
    }
}

