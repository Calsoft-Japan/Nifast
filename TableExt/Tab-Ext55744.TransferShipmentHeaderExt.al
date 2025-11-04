tableextension 55744 "Transfer Shipment Header Ext" extends "Transfer Shipment Header"
{
    // version NAVW18.00,SE0.60,NV4.32,NIF1.050,NIF.N15.C9IN.001
    fields
    {
        field(50000; "Vessel Name"; Code[50])
        {
            Editable = false;
            TableRelation = "Shipping Vessels";
        }
        field(50009; "Posted Assembly Order No."; Code[20])
        {
            Description = 'NF1.00:CIS.NG  10/06/15';
            Editable = false;
            TableRelation = "Posted Assembly Header"."No.";
        }
        field(50010; "Sail-On Date"; Date)
        {
            Editable = false;
        }
        //TODO
        /* field(14000351; "EDI Order"; Boolean)
        {
            CaptionML = ENU = 'EDI Order';
            Editable = true;
        }

        field(14000352; "EDI Internal Doc. No."; Code[10])
        {
            TableRelation = "E.D.I. Receive Document Hdr." WHERE("Internal Doc. No." = FIELD("EDI Internal Doc. No."));
            CaptionML = ENU = 'EDI Internal Doc. No.';
            Editable = false;
        }

        field(14000353; "EDI Trade Partner"; Code[20])
        {
            TableRelation = "E.D.I. Trade Partner";
            CaptionML = ENU = 'EDI Trade Partner';
            Editable = true;
        }

        field(14000354; "EDI Transfer Order Generated"; Boolean)
        {
            CaptionML = ENU = 'EDI Transfer Order Generated';
            Editable = false;
        }

        field(14000355; "EDI Transfer Order Gen. Date"; Date)
        {
            CaptionML = ENU = 'EDI Transfer Order Gen. Date';
            Editable = false;
        }

        field(14000356; "EDI Transfer-from Code"; Code[20])
        {
            CaptionML = ENU = 'EDI Transfer-from Code';
            Editable = false;
        }

        field(14000357; "EDI Transfer-to Code"; Code[20])
        {
            CaptionML = ENU = 'EDI Transfer-to Code';
            Editable = false;
        }

        field(14000358; "EDI In-Transit Code"; Code[20])
        {
            CaptionML = ENU = 'EDI In-Transit Code';
            Editable = false;
        }

        field(14000359; "EDI Transfer Shipment Gen."; Boolean)
        {
            CaptionML = ENU = 'EDI Transfer Shipment Generated';
            Editable = false;
        }

        field(14000360; "EDI Transfer Shipment Gen Date"; Date)
        {
            CaptionML = ENU = 'EDI Transfer Shipment Generated Date';
            Editable = false;
        }

        field(14000705; "E-Ship Agent Service"; Code[30])
        {
            TableRelation = "LAX EShip Agent Service".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"),
                                                      "World Wide Service" = FIELD("World Wide Service"));
            CaptionML = ENU = 'E-Ship Agent Service';
        }

        field(14000706; "World Wide Service"; Boolean)
        {
            CaptionML = ENU = 'World Wide Service';
            Editable = false;
        }

        field(14000707; "Residential Delivery"; Boolean)
        {
            CaptionML = ENU = 'Residential Delivery';
        }

        field(14000708; "Shipping Payment Type"; Option)
        {
            CaptionML = ENU = 'Shipping Payment Type';
            OptionCaptionML = ENU = 'Prepaid,Third Party,Freight Collect,Consignee';
            OptionMembers = Prepaid,"Third Party","Freight Collect",Consignee;
        }

        field(14000709; "Third Party Ship. Account No."; Code[20])
        {
            CaptionML = ENU = 'Third Party Ship. Account No.';
        }

        field(14000710; "Shipping Insurance"; Option)
        {
            CaptionML = ENU = 'Shipping Insurance';
            OptionCaptionML = ENU = ' ,Never,Always';
            OptionMembers = " ",Never,Always;
        }

        field(14000821; "Bill of Lading No."; Code[20])
        {
            TableRelation = "LAX Bill of Lading" WHERE(Posted = CONST(false));
            CaptionML = ENU = 'Bill of Lading No.';
            Editable = false;
            trigger OnLookup()
            var
                BillOfLadingMgt: Codeunit 14000821;
            BEGIN
                BillOfLadingMgt.LookupFromDocument("Bill of Lading No.");
            END;


        }

        field(14000822; "Package used on Bill of Lading"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Posted Package" WHERE("Source Type" = CONST(38),
                                                "Source Subtype" = CONST(3),
                                                "Posted Source ID" = FIELD("No."),
                                                "Bill of Lading No." = FILTER(<> '')));
            CaptionML = ENU = 'Package used on Bill of Lading';
            Editable = false;
        }
 */
        //TODO
        field(14017621; "Reason Code"; Code[10])
        {
        }

        field(14017790; "Container No."; Code[20])
        {
            Editable = false;
        }

        field(14017930; "Rework No."; Code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }

        field(14017931; "Rework Line No."; Integer)
        {
        }

        field(37015330; "FB Order No."; Code[20])
        {
            Description = 'NV-FB';
        }

    }

}
