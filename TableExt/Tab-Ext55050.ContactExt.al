tableextension 55050 Contact_Ext extends Contact
{
    fields
    {
        field(70000; "Customer No."; Code[20])
        {
            //Caption = '';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Lookup("Contact Business Relation"."No." WHERE("Link to Table" = CONST(Customer),
                                                                                                             "Contact No." = FIELD("Company No.")));
            Editable = false;
        }
    }
}
