page 50085 "Warehouse Entry Import"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    Permissions = TableData "Warehouse Entry" = rim;
    SourceTable = "Warehouse Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Caption = 'Entry No.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                    Caption = 'Journal Batch Name';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Caption = 'Line No.';
                }
                field("Registering Date"; Rec."Registering Date")
                {
                    ToolTip = 'Specifies the value of the Registering Date field.';
                    Caption = 'Registering Date';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Caption = 'Location Code';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                    Caption = 'Zone Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                    Caption = 'Bin Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Caption = 'Description';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    Caption = 'Item No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Caption = 'Quantity';
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. (Base) field.';
                    Caption = 'Qty. (Base)';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.';
                    Caption = 'Source Type';
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ToolTip = 'Specifies the value of the Source Subtype field.';
                    Caption = 'Source Subtype';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.';
                    Caption = 'Source No.';
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ToolTip = 'Specifies the value of the Source Line No. field.';
                    Caption = 'Source Line No.';
                }
                field("Source Subline No."; Rec."Source Subline No.")
                {
                    ToolTip = 'Specifies the value of the Source Subline No. field.';
                    Caption = 'Source Subline No.';
                }
                field("Source Document"; Rec."Source Document")
                {
                    ToolTip = 'Specifies the value of the Source Document field.';
                    Caption = 'Source Document';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.';
                    Caption = 'Source Code';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.';
                    Caption = 'Reason Code';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                    Caption = 'No. Series';
                }
                field("Bin Type Code"; Rec."Bin Type Code")
                {
                    ToolTip = 'Specifies the value of the Bin Type Code field.';
                    Caption = 'Bin Type Code';
                }
                field(Cubage; Rec.Cubage)
                {
                    ToolTip = 'Specifies the value of the Cubage field.';
                    Caption = 'Cubage';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    Caption = 'Weight';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Journal Template Name field.';
                    Caption = 'Journal Template Name';
                }
                field("Whse. Document No."; Rec."Whse. Document No.")
                {
                    ToolTip = 'Specifies the value of the Whse. Document No. field.';
                    Caption = 'Whse. Document No.';
                }
                field("Whse. Document Type"; Rec."Whse. Document Type")
                {
                    ToolTip = 'Specifies the value of the Whse. Document Type field.';
                    Caption = 'Whse. Document Type';
                }
                field("Whse. Document Line No."; Rec."Whse. Document Line No.")
                {
                    ToolTip = 'Specifies the value of the Whse. Document Line No. field.';
                    Caption = 'Whse. Document Line No.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.';
                    Caption = 'Entry Type';
                }
                field("Reference Document"; Rec."Reference Document")
                {
                    ToolTip = 'Specifies the value of the Reference Document field.';
                    Caption = 'Reference Document';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                    Caption = 'Reference No.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    Caption = 'User ID';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Caption = 'Variant Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                    Caption = 'Qty. per Unit of Measure';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Caption = 'Unit of Measure Code';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                    Caption = 'Serial No.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    Caption = 'Lot No.';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ToolTip = 'Specifies the value of the Warranty Date field.';
                    Caption = 'Warranty Date';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                    Caption = 'Expiration Date';
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    ToolTip = 'Specifies the value of the Phys Invt Counting Period Code field.';
                    Caption = 'Phys Invt Counting Period Code';
                }
                field("Phys Invt Counting Period Type"; Rec."Phys Invt Counting Period Type")
                {
                    ToolTip = 'Specifies the value of the Phys Invt Counting Period Type field.';
                    Caption = 'Phys Invt Counting Period Type';
                }
                field(Dedicated; Rec.Dedicated)
                {
                    ToolTip = 'Specifies the value of the Dedicated field.';
                    Caption = 'Dedicated';
                }
                field("Special Order Sales No."; Rec."Special Order Sales No.")
                {
                    ToolTip = 'Specifies the value of the Special Order Sales No. field.';
                    Caption = 'Special Order Sales No.';
                }
                field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
                {
                    ToolTip = 'Specifies the value of the Special Order Sales Line No. field.';
                    Caption = 'Special Order Sales Line No.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Caption = 'Posting Date';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                    Caption = 'External Document No.';
                }
                field("Remaining Qty. (Base)"; Rec."Remaining Qty. (Base)")
                {
                    ToolTip = 'Specifies the value of the Remaining Qty. (Base) field.';
                    Caption = 'Remaining Qty. (Base)';
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Specifies the value of the Open field.';
                    Caption = 'Open';
                }
                field(Positive; Rec.Positive)
                {
                    ToolTip = 'Specifies the value of the Positive field.';
                    Caption = 'Positive';
                }
                field("Applies-to Entry No."; Rec."Applies-to Entry No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Entry No. field.';
                    Caption = 'Applies-to Entry No.';
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ToolTip = 'Specifies the value of the Closed by Entry No. field.';
                    Caption = 'Closed by Entry No.';
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ToolTip = 'Specifies the value of the Closed at Date field.';
                    Caption = 'Closed at Date';
                }
                field("Closed by Qty. (Base)"; Rec."Closed by Qty. (Base)")
                {
                    ToolTip = 'Specifies the value of the Closed by Qty. (Base) field.';
                    Caption = 'Closed by Qty. (Base)';
                }
                field("Prod. Kit Order No."; Rec."Prod. Kit Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Kit Order No. field.';
                    Caption = 'Prod. Kit Order No.';
                }
                field("Prod. Kit Order Line No."; Rec."Prod. Kit Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Kit Order Line No. field.';
                    Caption = 'Prod. Kit Order Line No.';
                }
                field("License Plate No."; Rec."License Plate No.")
                {
                    ToolTip = 'Specifies the value of the License Plate No. field.';
                    Caption = 'License Plate No.';
                }
                field("License Bin"; Rec."License Bin")
                {
                    ToolTip = 'Specifies the value of the License Bin field.';
                    Caption = 'License Bin';
                }
            }
        }
    }

    actions
    {
    }
}

