reportextension 50000 "Outstanding SO Status Ext" extends "Outstanding Sales Order Status"
{
    //Version List=NAVNA8.00,NIF.N15.C9IN.001;
    dataset
    {
        modify(Customer)
        {
            RequestFilterFields = "No.", "Search Name", Priority, "Global Dimension 1 Code";
        }

        addafter("Sales Line")
        {
            dataitem("Lot Entry"; "Lot Entry")
            {
                DataItemLinkReference = "Sales Line";
                DataItemLink = "Document No." = FIELD("Document No."),
                            "Line No." = FIELD("Line No."),
                            "Item No." = FIELD("No.");

                column(DocumentType_LotEntry; "Lot Entry"."Document Type")
                {
                }
                column(DocumentNo_LotEntry; "Lot Entry"."Document No.")
                {
                }
                column(OrderLineNo_LotEntry; "Lot Entry"."Order Line No.")
                {
                }
                column(LineNo_LotEntry; "Lot Entry"."Line No.")
                {
                }
                column(LotNo_LotEntry; "Lot Entry"."Lot No.")
                {
                }
            }
        }
    }
    rendering
    {
        layout(MyRDLCLayout)
        {
            Type = RDLC;
            Caption = 'Outstanding Sales Order Status';
            LayoutFile = '.\RDLC\OutstandingSalesOrderStatus.rdl';
        }
    }
    labels
    {
        AppliedLotNoLbl = 'Applied Lot No.';
    }
}
