table 50006 "Label Field Content"
{
    // NF1.00:CIS.RAM   06/10/15 Merged during upgrade
    //  # Item Tracking Form Vs. Page conflict

    DrillDownPageID = 50051;
    LookupPageID = 50051;
    fields
    {
        field(1; "Label Code"; Code[10])
        {
            // cleaned
            TableRelation = "Label Header";
        }
        field(2; "Field Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Label Fields";

            trigger OnLookup()
            begin
                //TODO
                /*   LabelHeader.GET("Label Code");
                  LabelField.RESET();
                  CASE LabelHeader."Label Usage" OF
                      LabelHeader."Label Usage"::Package:
                          LabelField.SETRANGE(Package, TRUE);
                      LabelHeader."Label Usage"::"Package Line":
                          LabelField.SETRANGE("Package Line", TRUE);
                      LabelHeader."Label Usage"::Receive:
                          LabelField.SETRANGE(Receive, TRUE);
                      LabelHeader."Label Usage"::"Receive Line":
                          LabelField.SETRANGE("Receive Line", TRUE);
                      LabelHeader."Label Usage"::"Contract Line":
                          LabelField.SETRANGE("Contract Line", TRUE);
                  END; */
                //TODO

                IF PAGE.RUNMODAL(0, LabelField) = ACTION::LookupOK THEN
                    VALIDATE("Field Code", LabelField.Code);
            end;

            trigger OnValidate()
            var
            //TODO
            // ShippingSetup: Record 14000707;
            //TODO
            begin
                IF ("Field Code" <> xRec."Field Code") AND ("Field Code" <> '') THEN BEGIN
                    LabelField.GET("Field Code");

                    //TODO
                    //make sure usage is valid
                    /*  LabelHeader.GET("Label Code");
                     CASE LabelHeader."Label Usage" OF
                         LabelHeader."Label Usage"::Package:
                             LabelField.TESTFIELD(Package, TRUE);
                         LabelHeader."Label Usage"::"Package Line":
                             LabelField.TESTFIELD("Package Line", TRUE);
                         LabelHeader."Label Usage"::Receive:
                             LabelField.TESTFIELD(Receive, TRUE);
                         LabelHeader."Label Usage"::"Receive Line":
                             LabelField.TESTFIELD("Receive Line", TRUE);
                         LabelHeader."Label Usage"::"Contract Line":
                             LabelField.TESTFIELD("Contract Line", TRUE);
                     END; */
                    //TODO

                    //TODO
                    /*  IF "Field Code" = 'SERIAL_NO' THEN BEGIN
                         ShippingSetup.GET;
                         "No. Series" := ShippingSetup."Serial No. Nos.";
                     END
                     ELSE
                         "No. Series" := ''; */
                    //TODO
                    Description := LabelField.Description;
                    "Test Print Value" := LabelField."Test Print Value";
                END
                ELSE
                    IF ("Field Code" = '') THEN BEGIN
                        Description := '';
                        "Test Print Value" := '';
                        "No. Series" := '';
                    END;
            end;

        }
        field(7; Description; Text[50])
        {
            // cleaned
        }
        field(15; "Test Print Value"; Text[50])
        {
            // cleaned
        }
        field(20; "No. Series"; Code[10])
        {
            // cleaned
            TableRelation = "No. Series";
        }
        field(50; "Print Value"; Text[50])
        {
            Description = 'used internally';
        }
    }
    keys
    {
        key(Key1; "Label Code", "Field Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LabelField: Record 50005;
    //TODO
    // LabelHeader: Record 14000841;
    //TODO
}
