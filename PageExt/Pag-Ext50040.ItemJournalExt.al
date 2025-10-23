pageextension 50040 ItemJournalExt extends "Item Journal"
{
    // version NAVW18.00,NV4.29,NIF1.012,NIF.N15.C9IN.001,AKK1606.01,CIS.IoT

    layout
    {
        addafter("Variant Code")
        {
            field("Revision No."; Rec."Revision No.")
            {
                Visible = false;
                ToolTip = 'Specifies the value of the Revision No. field.';
                ApplicationArea = All;
            }
        }
        modify("Lot No.")
        {
            Visible = true;
        }
        addafter("Reason Code")
        {
            field("Entry/Exit Point"; Rec."Entry/Exit Point")
            {
                Caption = 'Entry/Exit Point';
                ToolTip = 'Specifies the value of the Entry/Exit Point field.';
                ApplicationArea = All;
            }
            field("Entry/Exit No."; Rec."Entry/Exit No.")
            {
                CaptionML = ENU = 'Entry Point No.',
                            ENG = 'Entry/Exit No.';
                ToolTip = 'Specifies the value of the Entry/Exit No. field.';
                ApplicationArea = All;
            }
            field("Entry/Exit Date"; Rec."Entry/Exit Date")
            {
                CaptionML = ENU = 'Entry Point Date',
                            ENG = 'Entry/Exit Date';
                ToolTip = 'Specifies the value of the Entry/Exit Date field.';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wLibro := Rec."Journal Template Name";
                wSeccion := Rec."Journal Batch Name";
                this.fValida();
                //+AKK1606.01++
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                //-AKK1606.01--
                wLibro := Rec."Journal Template Name";
                wSeccion := Rec."Journal Batch Name";
                this.fValida();
                //+AKK1606.01++
            end;
        }
    }

    var
        wLibro: Code[10];
        wSeccion: Code[10];

    procedure fValida();
    var
        rItemJnlLine: Record 83;
    begin
        //-AKK1606.01--
        rItemJnlLine.RESET();
        rItemJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        rItemJnlLine.SETRANGE("Journal Template Name", wLibro);
        rItemJnlLine.SETRANGE("Journal Batch Name", wSeccion);
        rItemJnlLine.SETFILTER("Entry Type", '%1|%2', rItemJnlLine."Entry Type"::"Positive Adjmt.",
        rItemJnlLine."Entry Type"::Purchase);
        rItemJnlLine.SETRANGE(National, false);
        if rItemJnlLine.FINDSET() then
            repeat
                rItemJnlLine.TESTFIELD("Entry/Exit Point");
                rItemJnlLine.TESTFIELD("Entry/Exit No.");
                rItemJnlLine.TESTFIELD("Entry/Exit Date");
            until rItemJnlLine.NEXT() = 0;
        //+AKK1606.01++
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

