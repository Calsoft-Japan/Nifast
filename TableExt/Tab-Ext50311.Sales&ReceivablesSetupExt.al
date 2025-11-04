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
      
        field(70000; "Review Days"; Decimal)
        {
            Caption = 'Review Days';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(70001; "Call Days"; Decimal)
        {
            Caption = 'Call Days';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(70002; "Hold Days"; Decimal)
        {
            Caption = 'Hold Days';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(70003; "Auto Credit Hold"; Boolean)
        {
            Caption = 'Auto Credit Hold';
        }

        field(70004; "Freight Account Type"; Option)
        {
            Caption = 'Freight Account Type';
            OptionMembers = "G/L Account",Resource;
            OptionCaption = 'G/L Account,Resource';
        }

        field(70005; "Price Contract Nos."; Code[10])
        {
            Caption = 'Price Contract Nos.';
            TableRelation = "No. Series".Code;
        }

        field(70006; "Quote Expiration Calculation"; Code[20])
        {
            Caption = 'Quote Expiration Calculation';
            DateFormula = true;
        }

        field(70007; "Multiple Contacts"; Boolean)
        {
            Caption = 'Multiple Contacts';
        }

        field(70008; "Sales Desk Worksheet Nos."; Code[10])
        {
            Caption = 'Sales Desk Worksheet Nos.';
            TableRelation = "No. Series".Code;
        }

        field(70009; "Sales Counter Invoice Nos."; Code[10])
        {
            Caption = 'Sales Counter Invoice Nos.';
            TableRelation = "No. Series".Code;
        }

        field(70010; "Tool Repair Ticket Nos."; Code[10])
        {
            Caption = 'Tool Repair Ticket Nos.';
            TableRelation = "No. Series".Code;
        }
    }
    var
        ShippingSetup: Record 14000707;
        EMailSetup: Record 14000905;
        Text001: Label 'Job Queue Priority must be zero or positive.';
        Text14000701: Label 'Are you sure you want to turn receiving off.';
        Text14000702: Label 'Are you sure you want to turn shipping off.';
        Text14000703: Label 'Are you sure you want to turn E-Mail off.';

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
