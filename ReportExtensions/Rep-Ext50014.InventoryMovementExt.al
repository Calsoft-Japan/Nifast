reportextension 50014 "Inventory Movement Ext" extends "Inventory Movement"
{
    dataset
    {
        add("Item Journal Line")
        {
            column(LineNo_ItemJournalLine; "Line No.")
            {
            }
        }
        addlast("Item Journal Line")
        {
            dataitem("Reservation Entry"; "Reservation Entry")
            {
                DataItemLink = "Source ID" = FIELD("Journal Template Name"),
                                   "Source Batch Name" = FIELD("Journal Batch Name"),
                                   "Source Ref. No." = FIELD("Line No.");
                DataItemTableView = SORTING("Entry No.", Positive)
                                        ORDER(Ascending)
                                        WHERE("Source Type" = CONST(83),
                                              "Source Subtype" = CONST(4));
                column(ReservationEntryCaption; ReservationEntryCaptionLbl)
                {
                }
                column(EntryNo_ReservationEntry; "Reservation Entry"."Entry No.")
                {
                }
                column(LotNo_ReservationEntry; "Reservation Entry"."Lot No.")
                {
                    IncludeCaption = true;
                }
                column(Quantity_ReservationEntry; "Reservation Entry".Quantity)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    Quantity := -Quantity;  //NF1.00:CIS.CM  08/01/15
                end;

                trigger OnPreDataItem()
                begin
                    SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.", "Reservation Status"
                                 , "Expected Receipt Date");  //NF1.00:CIS.CM  08/01/15
                end;
            }
        }
    }
    var
        ReservationEntryCaptionLbl: TextConst ENU = 'Reservation Entry';
}
