tableextension 50044 SalesCommentLineExt extends "Sales Comment Line"
{
    // version NAVW17.00,NAVNA7.00,SE0.50.32,NV4.32,NIF.N15.C9IN.001
    fields
    {
        //TODO
        /*  field(14000901; "Include in E-Mail"; Boolean)
         {
             CaptionML = ENU = 'Include in E-Mail';
         } */
        //TODO
        field(14017650; "User ID"; Code[50])
        {
            Description = '20 --> 50 NF1.00:CIS.NG  10-10-15';
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit 418;
            begin
                LoginMgt.LookupUserID("User ID");
            end;

            trigger OnValidate();
            var
                LoginMgt: Codeunit 418;
            begin
                LoginMgt.ValidateUserID("User ID");
            end;
        }
        field(14017651; "Time Stamp"; Time)
        {
        }

        field(14017652; "Date Added"; Date)
        {
        }

    }
    keys
    {
        key(RPTSort; "Document Type", "No.", "Line No.", Date)
        { }
    }
    trigger OnInsert()
    BEGIN

        //>>NV
        Rec.VALIDATE("User ID", USERID);
        Rec."Time Stamp" := TIME;
        Rec."Date Added" := TODAY;
        //<<NV 

    END;

    trigger OnModify()
    BEGIN

        //>>NV
        Rec.VALIDATE("User ID", USERID);
        Rec."Time Stamp" := TIME;
        Rec."Date Added" := TODAY;
        //<<NV 

    END;

    trigger OnRename()
    BEGIN

        //>>NV
        Rec.VALIDATE("User ID", USERID);
        Rec."Time Stamp" := TIME;
        Rec."Date Added" := TODAY;
        //<<NV 

    END;
}
