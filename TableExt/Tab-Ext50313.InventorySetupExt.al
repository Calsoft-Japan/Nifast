tableextension 50313 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Def. Item Tracking Code"; Code[10])
        {
            // cleaned
            TableRelation = "Item Tracking Code";
        }
        field(50001; "Def. E-ship Tracking Code"; Code[10])
        {
            // cleaned

        }
        field(50002; "Def. Lot Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50010; "Auto. Transfer Order Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50020; "Default In-Transit Location"; Code[10])
        {
            // cleaned
            TableRelation = Location;
        }
        field(50021; "IoT Admin. Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50022; "IoT Admin. CC Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50023; "Invt. Pick File Path"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50024; "Tras. Rcpt. File Path"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50025; "Sales Ship. File Path"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50026; "Delete IoT File on Success"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(50027; "Send Email Notifications"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(50028; "IoT Trans. Order Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50029; "IoT Trans Order CC Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50030; "IoT Sales Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50031; "IoT Sales CC Email"; Text[80])
        {
            Description = 'CIS.IoT';
        }
        field(50032; "Send Email CC to Admin"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(50033; "IoT Create Invt. Pick"; Boolean)
        {
            Description = 'CIS.IoT';
        }
        field(70000; "Incl ReservQty on Prod Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Incl PurchReq Receipt (Qty.)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Incl Res. Qty on Req. Line"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70003; "Incl Qty. on Purch. Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70004; "Incl ReservQty on PurchOrders"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70005; "Incl TransOrd Receipt (Qty.)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70006; "Incl Res.Qty Inbound Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70007; "Incl Qty. in Transit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70008; "Incl Qty on Sales Return"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70009; "Auto Create SKU"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70010; "Outbound Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
            CaptionML = ENU = 'Outbound Bin Code';
        }
        field(70011; "Inbound Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
            CaptionML = ENU = 'Inbound Bin Code';
        }
        field(70012; "Rework Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70013; "Production Kit Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70014; "Rework Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70015; "Rework In-Transit Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70016; "Rework Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
            CaptionML = ENU = 'Rework Journal Template Name';
        }
        field(70017; "Rework Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Rework Journal Template Name"));
            CaptionML = ENU = 'Rework Journal Batch Name';
        }
        field(70018; "ReWk Charge-Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(70019; "ReWk Charge-Item Offset Acct."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(70020; "ReWk Charge-Item Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(70021; "QC Order Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70022; "New Item QC Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(70023; "New Item QC Task Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(70024; "QC Request Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(70025; "Last Task Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70026; "Default New Item QC Hold"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70027; "QC Hold On Sales Return"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70028; "QC Hold On Purch. Receipts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70029; "QC Hold On Prod. Kits"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}