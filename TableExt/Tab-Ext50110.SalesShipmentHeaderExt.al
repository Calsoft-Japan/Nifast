tableextension 50110 "Sales Shipment Header Ext" extends "Sales Shipment Header"
{
    fields
    {
        field(50000;"Freight Code";Code[10])
        {
            // cleaned
        }
        field(50003;"ASN Ship-to Code";Code[30])
        {
            // cleaned
        }
        field(50005;"Model Year";Code[10])
        {
            // cleaned
        }
        field(50006;"SCAC Code";Code[10])
        {
            // cleaned
        }
        field(50007;"Mode of Transport";Code[10])
        {
            // cleaned
        }
        field(50200;"PPS Order";Boolean)
        {
            // cleaned
        }
        field(50205;"PPS File Name";Text[100])
        {
            // cleaned
        }
        field(51000;"Blanket Order No.";Code[20])
        {
            Editable = false;
        }
        field(52000;"Mex. Factura No.";Code[20])
        {
            // cleaned
        }
        field(60000;"EDI Control No.";Code[20])
        {
            // cleaned
        }
        field(60101;"Plant Code";Code[10])
        {
            // cleaned
        }
        field(60102;"Dock Code";Code[10])
        {
            // cleaned
        }
    }
}
