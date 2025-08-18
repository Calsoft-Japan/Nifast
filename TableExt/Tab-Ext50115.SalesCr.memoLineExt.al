tableextension 50115 "Sales Cr.Memo Line Ext" extends "Sales Cr.Memo Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.55.08,NV4.29,NIF1.050,NIF.N15.C9IN.001,AKK1606.01
    fields
    {
        field(50800; "Entry/Exit Date"; Date)
        {
            Caption = 'Entry/Exit Date';
            Description = 'AKK1606.01';
        }
        field(50801; "Entry/Exit No."; Code[20])
        {
            Caption = 'Entry/Exit No.';
            Description = 'AKK1606.01';
        }
        field(50802; National; Boolean)
        {
            Caption = 'National';
            Description = 'AKK1606.01';
        }
        //TODO
        /*   field(14017611; "Order Date"; Date)
          {
              Description = 'NV';
          }
          field(14017615; "Salesperson Code"; Code[10])
          {
              Description = 'NV';
              TableRelation = "Salesperson/Purchaser".Code WHERE(Sales = CONST(Yes));
          }
          field(14017616; "Inside Salesperson Code"; Code[10])
          {
              Description = 'NV';
              TableRelation = "Salesperson/Purchaser".Code WHERE("Inside Sales" = CONST(Yes));
          }
          field(14017618; "External Document No."; Code[20])
          {
              Description = 'NV';
          }
          field(14017633; "Line Comment"; Boolean)
          {
              Description = 'NF1.00:CIS.CM 09-29-15';
              Editable = false;
              Enabled = false;
              FieldClass = FlowField;
          }
          field(14017645; "Contract No."; Code[20])
          {
              Description = 'NV';
              TableRelation = "Price Contract" WHERE("Customer No." = FIELD("Sell-to Customer No."));
          }
          field(14017752; "Ship-to Code"; Code[10])
          {
              Description = 'NV';
          }
          field(14017756; "Item Group Code"; Code[10])
          {
              Description = 'NF1.00:CIS.CM 09-29-15';
          }
   */
        //TODO
    }
    keys
    {
        key(Key9; "Shipment Date")
        {
        }
    }
}
