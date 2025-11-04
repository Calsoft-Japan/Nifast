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
        //TODO
        /* field(14000350; "EDI Software Version"; Option)
        {
            Caption = 'EDI Software Version';
            OptionMembers = "Generation 1","Generation 2";
            OptionCaption = 'Generation 1,Generation 2';
        }

        field(14000601; "Enable Receive"; Boolean)
        {
            Caption = 'Enable Receive';
            trigger OnValidate()
            begin
                if xRec."Enable Receive" and not "Enable Receive" then
                    if not Confirm(Text14000701, false) then
                        "Enable Receive" := true;
            end;
        }

        field(14000701; "Enable Shipping"; Boolean)
        {
            Caption = 'Enable Shipping';
            trigger OnValidate()
            begin
                if xRec."Enable Shipping" and not "Enable Shipping" then
                    if not Confirm(Text14000702, false) then
                        "Enable Shipping" := true;
            end;
        }

        field(14000702; "Blank Drop Shipm. Qty. to Ship"; Boolean)
        {
            Caption = 'Blank Drop Shipm. Qty. to Ship';
        }

        field(14000703; "Allow External Doc. No. Reuse"; Boolean)
        {
            Caption = 'Allow External Doc. No. Reuse';
        }

        field(14000704; "E-Ship Locking Optimization"; Option)
        {
            Caption = 'E-Ship Locking Optimization';
            OptionMembers = Base,Packing;
            OptionCaption = 'Base,Packing';
            InitValue = Packing;
        }

        field(14000901; "Enable E-Mail"; Boolean)
        {
            Caption = 'Enable E-Mail';
            trigger OnValidate()
            begin
                if xRec."Enable E-Mail" and not "Enable E-Mail" then
                    if not Confirm(Text14000703, false) then
                        "Enable E-Mail" := true;
            end;
        }
 */
        //TODO
        field(14017610; "Review Days"; Decimal)
        {
            Caption = 'Review Days';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(14017611; "Call Days"; Decimal)
        {
            Caption = 'Call Days';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(14017612; "Hold Days"; Decimal)
        {
            Caption = 'Hold Days';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(14017613; "Auto Credit Hold"; Boolean)
        {
            Caption = 'Auto Credit Hold';
        }

        field(14017620; "Freight Account Type"; Option)
        {
            Caption = 'Freight Account Type';
            OptionMembers = "G/L Account",Resource;
            OptionCaption = 'G/L Account,Resource';
        }

        field(14017645; "Price Contract Nos."; Code[10])
        {
            Caption = 'Price Contract Nos.';
            TableRelation = "No. Series".Code;
        }

        field(14017647; "Quote Expiration Calculation"; Code[20])
        {
            Caption = 'Quote Expiration Calculation';
            DateFormula = true;
        }

        field(14017650; "Multiple Contacts"; Boolean)
        {
            Caption = 'Multiple Contacts';
        }

        field(14017710; "Sales Desk Worksheet Nos."; Code[10])
        {
            Caption = 'Sales Desk Worksheet Nos.';
            TableRelation = "No. Series".Code;
        }

        field(14017752; "Sales Counter Invoice Nos."; Code[10])
        {
            Caption = 'Sales Counter Invoice Nos.';
            TableRelation = "No. Series".Code;
        }

        field(14017812; "Tool Repair Ticket Nos."; Code[10])
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
