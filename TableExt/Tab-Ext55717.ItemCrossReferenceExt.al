tableextension 55717 "Item Cross Reference Ext" extends "Item Reference"//"Item Cross Reference" BC Upgrade
{
    fields
    {
        field(50001; OEM; Code[20])
        {
            // cleaned
        }
        field(50002; Model; Code[20])
        {
            // cleaned
        }
        field(50003; EMU; Decimal)
        {
            // cleaned
        }
        field(50004; "Pieces/Vehicle"; Decimal)
        {
            // cleaned
        }
        field(50005; SOP; Date)
        {
            // cleaned
        }
        field(50006; EOP; Date)
        {
            // cleaned
        }
        field(50007; Remarks; Text[30])
        {
            // cleaned
        }
        field(50008; Division; Code[10])
        {
            // cleaned
        }
        field(50010; "Packaging Instructions"; Text[100])
        {
            // cleaned
        }
        field(50011; "AFC Stam"; Text[30])
        {
            // cleaned
        }
        field(50012; "ECI No."; Code[20])
        {
            // cleaned
        }
        field(50013; Application; Text[50])
        {
            // cleaned
        }
        field(50014; Manter; Decimal)
        {
            // cleaned
        }
        field(50015; "Customer Name"; Text[100])
        {
            // cleaned
            CalcFormula = lookup(Customer.Name where("No." = field("Reference Type No.")));
            FieldClass = FlowField;
            TableRelation = Customer.Name where("No." = field("Reference Type No."));
        }
        field(50016; "Div Code"; Code[20])
        {
            // cleaned
            CalcFormula = lookup(Customer."Global Dimension 1 Code" where("No." = field("Reference Type No.")));
            FieldClass = FlowField;
        }
        field(50017; Manufacturer; Code[50])
        {
            // cleaned
            CalcFormula = lookup(Item."Manufacturer Code" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50018; SNP; Decimal)
        {
            // cleaned
            CalcFormula = lookup(Item."Units per Parcel" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50019; "Unit Cost"; Decimal)
        {
            // cleaned
            CalcFormula = lookup(Item."Unit Cost" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50020; "Unit Price"; Decimal)
        {
            // cleaned
            CalcFormula = lookup(Item."Unit Price" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(70000; "Active Drawing No."; code[30])
        {
            CalcFormula = Lookup("Cust./Item Drawing2"."Drawing No." WHERE("Item No." = FIELD("Item No."),
                                                                                                            "Customer No." = FIELD("Reference Type No."),
                                                                                                            Active = CONST(true)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(70001; "Active Revision No."; code[20])
        {
            CalcFormula = Lookup("Cust./Item Drawing2"."Revision No." WHERE("Item No." = FIELD("Item No."),
                                                                                                            "Customer No." = FIELD("Reference Type No."),
                                                                                                            Active = CONST(true)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(70002; "Active Revision Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Cust./Item Drawing2"."Revision Date" WHERE("Item No." = FIELD("Item No."),
                                                                                                            "Customer No." = FIELD("Reference Type No."),
                                                                                                            Active = CONST(true)));
            Editable = false;
        }
        field(70003; "Certificate No."; code[30])
        {
        }
    }

    procedure CrossRefName(): Text[100];
    var
        Item: Record 27;
        Customer: Record 18;
        Vendor: Record 23;
    begin
        case "Reference Type" of
            "Reference Type"::Customer:
                begin
                    if not Customer.GET("Reference Type No.") then
                        Clear(Customer);
                    exit(Customer.Name);
                end;

            "Reference Type"::Vendor:
                begin
                    if not Vendor.GET("Reference Type No.") then
                        Clear(Vendor);
                    exit(Vendor.Name);
                end;

            else begin
                if not Item.GET("Item No.") then
                    Clear(Item);
                exit(Item.Description);
            end;
        end;
    end;
}
