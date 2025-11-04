tableextension 50013 "Salesperson/Purchaser Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "Navision User ID"; Code[50])
        {
            Caption = 'Navision User ID';
            DataClassification = ToBeClassified;
            Description = 'NIF - created during merge (20 --> 50 NF1.00:CIS.NG  10-10-15)';
            TableRelation = User."User Name";
            //This property is currently not supported
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                Salesperson: Record 13;
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.DisplayUserInformation(Salesperson."Navision User ID");
                if (Salesperson."Navision User ID" <> '') then
                    Rec.VALIDATE("Navision User ID", Salesperson."Navision User ID");
            end;

            trigger OnValidate();
            var
                Salesperson: Record "Salesperson/Purchaser";
            begin
                Rec.ValidateUserID("Navision User ID");

                if ("Navision User ID" <> '') then begin
                    Salesperson.SETRANGE(Salesperson."Navision User ID", "Navision User ID");
                    if not Salesperson.IsEmpty() then begin
                        "Navision User ID" := '';
                        ERROR('User is Not Unique');
                    end;
                end;
            end;
        }
        field(60000; "COL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60005; "MPD Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60010; "LEN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60015; "SAL Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60020; "TN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60025; "MICH Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(60030; "IBN Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NIF';
        }
        field(14017610; "Inside Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017612; "Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017613; "Purchase"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017614; "Repair Tech"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017615; "Resource No."; code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
            TableRelation = Resource;
        }
        field(14017616; "Fax No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017617; "QC Tech"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
        field(14017620; "Purchase Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'NV';
        }
    }
    procedure ValidateUserID(UserName: Code[50]);
    var
        User: Record User;
        Text000Lbl: label 'The user name %1 does not exist.', Comment = '%1';
    begin
        if UserName <> '' then begin
            User.setcurrentkey("User Name");
            User.setrange("User Name", UserName);
            if not User.findfirst() then begin
                User.reset();
                if not User.isempty then
                    error(Text000Lbl, UserName);
            end;
        end;
    end;
}
