table 50017 "Customer Model Year"
{
    DrillDownPageID = 50009;
    LookupPageID = 50009;
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(2; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(5; Description; Text[30])
        {
            // cleaned
        }
        field(10; Default; Boolean)
        {
            trigger OnValidate()
            begin
                IF Default THEN BEGIN
                    ModelYear.SETRANGE("Customer No.", "Customer No.");
                    ModelYear.SETFILTER(Code, '<>%1', Code);
                    ModelYear.SETRANGE(Default, TRUE);
                    IF ModelYear.FIND('-') THEN
                        ERROR('You must first uncheck the %1 field for %2 %3.',
                            ModelYear.FieldCaption(Default), ModelYear.FieldCaption(Code), ModelYear.Code);
                END;
            end;
        }
    }
    keys
    {
        key(Key1; "Customer No.", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ModelYear: Record 50017;
}
