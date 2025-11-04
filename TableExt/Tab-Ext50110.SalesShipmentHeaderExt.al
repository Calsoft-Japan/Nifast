tableextension 50110 "Sales Shipment Header Ext" extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Freight Code"; Code[10])
        {
            // cleaned
            TableRelation = "Freight Code";
        }
        field(50003; "ASN Ship-to Code"; Code[30])
        {
            // cleaned
        }
        field(50005; "Model Year"; Code[10])
        {
            // cleaned
            TableRelation = "Customer Model Year".Code where("Customer No." = field("Sell-to Customer No."));
        }
        field(50006; "SCAC Code"; Code[10])
        {
            // cleaned
        }
        field(50007; "Mode of Transport"; Code[10])
        {
            // cleaned
        }
        field(50200; "PPS Order"; Boolean)
        {
            // cleaned
        }
        field(50205; "PPS File Name"; Text[100])
        {
            // cleaned
        }
        field(51000; "Blanket Order No."; Code[20])
        {
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const("Blanket Order"));
        }
        field(52000; "Mex. Factura No."; Code[20])
        {
            // cleaned
        }
        field(60000; "EDI Control No."; Code[20])
        {
            // cleaned
        }
        field(60101; "Plant Code"; Code[10])
        {
            // cleaned
        }
        field(60102; "Dock Code"; Code[10])
        {
            // cleaned
        }

        field(50001; "Inside Salesperson Code"; Code[10])//NV-FB BC Upgarde 14017617->50001
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(true), Sales = CONST(true));
            Description = 'NV-FB';
        }
        field(14017610; "Entered User ID"; code[50])
        {
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            TestTableRelation = false;
            Description = '20-->50 NF1.00:CIS.NG  10-10-15';
            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(14017611; "Entered Date"; Date)
        {
        }
        field(14017612; "Entered Time"; Time)
        {
        }
        field(14017614; "Tool Repair Tech"; code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("Repair Tech" = CONST(true));
        }
        field(14017618; "Phone No."; text[30])
        {
            Description = 'NV-FB';
        }
        field(14017619; "Fax No."; text[30])
        {
        }
        field(14017620; "E-Mail"; text[80])
        {
        }
        field(14017640; "Ship-to PO No."; code[20])
        {
        }
        field(14017645; "Contract No."; code[20])
        {
            TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
            Description = 'NV-FB';
        }
        field(14017650; "Broker/Agent Code"; code[10])
        {
            Description = 'NV-FB';
        }
        field(14017801; "Tool Repair Priority"; Boolean)
        {
        }
        field(14017803; "Manufacturer Code"; code[5])
        {
            TableRelation = Manufacturer.Code;
        }
        field(14017804; "Serial No."; code[20])
        {
            Description = 'NF1.00:CIS.CM 09-29-15';
        }
        field(14017805; "Tool Model No."; code[20])
        {
        }
        field(14017806; "Tool Item No."; code[20])
        {
            TableRelation = Item."No.";
        }
        field(14017807; "Tool Description"; text[50])
        {
        }
        field(14017808; "Tool Repair Ticket"; Boolean)
        {
        }
        field(14017809; "No;Tool Repair Status"; code[10])
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(14017810; "Tool Repair Parts Warranty"; DateFormula)
        {
        }
        field(14017811; "Tool Repair Labor Warranty"; DateFormula)
        {
        }
        field(14018050; "No;Cr. Mgmt. Comment"; Boolean)
        {
            FieldClass = FlowField;
            Description = 'NF1.00:CIS.CM 09-29-15';
            Editable = false;
        }
        field(37015330; "FB Order No."; code[20])
        {
            Description = 'NV-FB';
        }
        field(37015680; "Delivery Route"; code[10])
        {
        }
        field(37015681; "Delivery Stop"; code[10])
        {
        }
    }
}
