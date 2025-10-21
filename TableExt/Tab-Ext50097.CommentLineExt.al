tableextension 50097 "Comment Line Ext" extends "Comment Line"
{
    fields
    {
        field(50000; "Print On Sales Quote"; Boolean)
        {
            Description = '#10088';
        }
        field(50001; "Print On Pick Ticket"; Boolean)
        {
            Description = '#10088';
        }
        field(50002; "Print On Order Confirmation"; Boolean)
        {
            Description = '#10088';
        }
        field(50003; "Print On Shipment"; Boolean)
        {
            Description = '#10088';
        }
        field(50004; "Print On Sales Invoice"; Boolean)
        {
            Description = '#10088';
        }
        field(50010; "Print On Purch. Quote"; Boolean)
        {
            Description = '#10088';
        }
        field(50012; "Print On Purch. Order"; Boolean)
        {
            Description = '#10088';
        }
        field(50013; "Print On Receipt"; Boolean)
        {
            Description = '#10088';
        }
        field(50014; "Print On Purch. Invoice"; Boolean)
        {
            Description = '#10088';
        }
        field(50015; "Print on Prod. Pick"; Boolean)
        {
            Description = '#10088';
        }
        field(50016; "Customer Name"; Text[50])
        {
            // cleaned
        }
        field(50100; "Country Type"; Option)
        {
            OptionMembers = "Foreign&Domestic",Foreign,Domestic;
        }
        field(14017650; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = user."User Name";
            
            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.ValidateUserID("User ID");
            end;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("User ID");
            end;
        }
        field(14017651; "Time Stamp"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(14017652;"Include in Sales Orders";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14017653; "Include in Purchase Orders"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }


}

