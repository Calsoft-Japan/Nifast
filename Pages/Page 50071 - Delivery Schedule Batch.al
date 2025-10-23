page 50071 "Delivery Schedule Batch"
{
    // NF1.00:CIS.NG  09-05-15 Merged during upgrade

    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Delivery Schedule Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Release No."; Rec."Release No.")
                {
                    ToolTip = 'Specifies the value of the Release No. field.';
                }
                field("Document Function"; Rec."Document Function")
                {
                    ToolTip = 'Specifies the value of the Document Function field.';
                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ToolTip = 'Specifies the value of the Expected Delivery Date field.';
                }
                field("Horizon Start Date"; Rec."Horizon Start Date")
                {
                    ToolTip = 'Specifies the value of the Horizon Start Date field.';
                }
                field("Horizon End Date"; Rec."Horizon End Date")
                {
                    ToolTip = 'Specifies the value of the Horizon End Date field.';
                }
            }
            group("Material Issuer")
            {
                Caption = 'Material Issuer';
                field("Material Issuer No."; Rec."Material Issuer No.")
                {
                    ToolTip = 'Specifies the value of the Material Issuer No. field.';
                }
                field("Material Issuer Name"; Rec."Material Issuer Name")
                {
                    ToolTip = 'Specifies the value of the Material Issuer Name field.';
                }
                field("Material Issuer Name 2"; Rec."Material Issuer Name 2")
                {
                    ToolTip = 'Specifies the value of the Material Issuer Name 2 field.';
                }
                field("Material Issuer Address"; Rec."Material Issuer Address")
                {
                    ToolTip = 'Specifies the value of the Material Issuer Address field.';
                }
                field("Material Issuer Address 2"; Rec."Material Issuer Address 2")
                {
                    ToolTip = 'Specifies the value of the Material Issuer Address 2 field.';
                }
                field("Material Issuer City"; Rec."Material Issuer City")
                {
                    ToolTip = 'Specifies the value of the Material Issuer City field.';
                }
                field("Material Issuer State"; Rec."Material Issuer State")
                {
                    Caption = 'Material Issuer State / Sip Code';
                    ToolTip = 'Specifies the value of the Material Issuer State / Sip Code field.';
                }
                field("Material Issuer Postal Code"; Rec."Material Issuer Postal Code")
                {
                    ToolTip = 'Specifies the value of the Material Issuer Postal Code field.';
                }
                field("Material Issuer Country Code"; Rec."Material Issuer Country Code")
                {
                    ToolTip = 'Specifies the value of the Material Issuer Country Code field.';
                }
            }
            group(Supplier)
            {
                Caption = 'Supplier';
                field("Supplier No."; Rec."Supplier No.")
                {
                    ToolTip = 'Specifies the value of the Supplier No. field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                }
                field("Supplier Name 2"; Rec."Supplier Name 2")
                {
                    ToolTip = 'Specifies the value of the Supplier Name 2 field.';
                }
                field("Supplier Address"; Rec."Supplier Address")
                {
                    ToolTip = 'Specifies the value of the Supplier Address field.';
                }
                field("Supplier Address 2"; Rec."Supplier Address 2")
                {
                    ToolTip = 'Specifies the value of the Supplier Address 2 field.';
                }
                field("Supplier City"; Rec."Supplier City")
                {
                    ToolTip = 'Specifies the value of the Supplier City field.';
                }
                field("Supplier State"; Rec."Supplier State")
                {
                    Caption = 'Supplier State / ZIP Code';
                    ToolTip = 'Specifies the value of the Supplier State / ZIP Code field.';
                }
                field("Supplier Postal Code"; Rec."Supplier Postal Code")
                {
                    ToolTip = 'Specifies the value of the Supplier Postal Code field.';
                }
                field("Supplier Country Code"; Rec."Supplier Country Code")
                {
                    ToolTip = 'Specifies the value of the Supplier Country Code field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Schedule Batch")
            {
                Caption = 'Schedule Batch';
                separator(" ")
                {
                }
                action("Delivery Schedules")
                {
                    Caption = 'Delivery Schedules';
                    Image = Delivery;
                    RunObject = Page "Delivery Schedule";
                    RunPageLink = "Delivery Schedule Batch No." = FIELD("No."), "Customer No." = FIELD("Customer No.");
                    ToolTip = 'Executes the Delivery Schedules action.';
                }
            }
        }
    }
}

