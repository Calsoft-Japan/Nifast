tableextension 50044 SalesCommentLineExt extends "Sales Comment Line"
{
    // version NAVW17.00,NAVNA7.00,SE0.50.32,NV4.32,NIF.N15.C9IN.001
    fields
    {
        //TODO
        /*  
         field(14017650; "User ID"; Code[50])
         {
             Description = '20 --> 50 NF1.00:CIS.NG  10-10-15';
             TableRelation = User."User Name";
             ValidateTableRelation = false;

             trigger OnLookup();
             var
                 LoginMgt: Codeunit "418";
             begin
                 LoginMgt.LookupUserID("User ID");
             end;

             trigger OnValidate();
             var
                 LoginMgt: Codeunit "418";
             begin
                 LoginMgt.ValidateUserID("User ID");
             end;
         }
     */
        //TODO
    }
    keys
    {
        key(RPTSort; "Document Type", "No.", "Line No.", Date)
        { }
    }
    trigger OnInsert()
    BEGIN
        //TODO
        /*   //>>NV
          Rec.VALIDATE("User ID", USERID);
          Rec."Time Stamp" := TIME;
          Rec."Date Added" := TODAY;
          //<<NV */
        //TODO
    END;

    trigger OnModify()
    BEGIN
        //TODO
        /* //>>NV
        Rec.VALIDATE("User ID", USERID);
        Rec."Time Stamp" := TIME;
        Rec."Date Added" := TODAY;
        //<<NV */
        //TODO
    END;

    trigger OnRename()
    BEGIN
        //TODO
        /*  //>>NV
         Rec.VALIDATE("User ID", USERID);
         Rec."Time Stamp" := TIME;
         Rec."Date Added" := TODAY;
         //<<NV */
        //TODO
    END;
}
