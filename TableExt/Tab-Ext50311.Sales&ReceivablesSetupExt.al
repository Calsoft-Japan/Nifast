tableextension 50311 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    // version NAVW18.00,NAVNA8.00,SE0.53.15,NV4.29,NIF1.032,WCISN,NIF.N15.C9IN.001,AKK1612.01
    fields
    {
        field(50000; "Remit-To Description"; Text[30])
        {
            // cleaned
        }
        field(50010; "Remit-To Line 1"; Text[30])
        {
            // cleaned
        }
        field(50020; "Remit-To Line 2"; Text[30])
        {
            // cleaned
        }
        field(50030; "Remit-To Line 3"; Text[30])
        {
            // cleaned
        }
        field(50040; "Remit-To Line 4"; Text[30])
        {
            // cleaned
        }
        field(50050; "Enable Shipping - Picks"; Boolean)
        {
            // cleaned
        }
        field(50051; "Shipment Authorization Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50052; "Delivery Schedule Batch Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50053; "Delivery Schedule Nos."; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50100; "Inbound PPS Directory"; Text[250])
        {
            // cleaned
            trigger OnValidate();
            begin
                CheckPath("Inbound PPS Directory");
            end;
        }
        field(50102; "Archive PPS Directory"; Text[250])
        {
            // cleaned
            trigger OnValidate();
            begin
                CheckPath("Archive PPS Directory");
            end;
        }
        field(50104; "Use PPS XML format"; Boolean)
        {
            // cleaned
        }
        field(50105; "Planning Schedule Nos."; Code[10])
        {
            Description = 'CIS.001 - Added to resolve the conflict on table 14017885';
        }
        field(50150; "Export Sales Inv/Cr/Memo Path"; Text[250])
        {
            Caption = 'Export Sales Inv/Cr/Memo Path';
            Description = 'AKK1612.01';
        }
        field(50151; "Create Pack & Enable Ship"; Boolean)
        {
            Description = 'NF2.00:CIS.RAM 09-28-2017';
        }
        field(50152; "EDI Control Nos."; Code[10])
        {
            Caption = 'EDI Control Nos.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the code for the number series that will be used to assign numbers to EDI Control Nos.';
        }
    }

    procedure ">>NIF_fcn"();
    begin

    end;

    procedure CheckPath(var CheckString: Text[100]);
    var
        DirLength: Integer;
    begin
        DirLength := StrLen(CheckString);
        if (DirLength <> 0) then
            if (CopyStr(CheckString, DirLength, 1) <> '\') then
                CheckString := CheckString + '\';

        if StrPos(CheckString, '.') <> 0 then
            ERROR('You should not enter a period in this field.');
    end;
}
