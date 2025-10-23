tableextension 57318 "Posted Whse Recepit Header_ext" extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(14017630; "Inbound Bill of Lading No."; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(14017631; "Carrier Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(14017632; "Carrier Trailer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}
