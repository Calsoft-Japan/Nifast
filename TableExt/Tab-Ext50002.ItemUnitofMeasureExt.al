tableextension 50002 "Item Unit of Measure Ext" extends "Item Unit of Measure"
{
    fields
    {
        /*   field(14000701; "Std. Pack UPC/EAN Number"; Code[20])
          {
              Caption = 'Std. Pack UPC/EAN Number';

              trigger OnValidate()
              var
                  Item: Record Item;
              begin
                  if not (StrLen("Std. Pack UPC/EAN Number") in [0, 14]) then
                      if not Confirm(Text14000701, false, FieldName("Std. Pack UPC/EAN Number")) then
                          Error(Text14000702);

                  if "Std. Pack UPC/EAN Number" <> '' then begin
                      Item.Get("Item No.");
                      if Item."LAX Item UPC/EAN Number" <> '' then
                          if (StrPos("Std. Pack UPC/EAN Number", Item."LAX Item UPC/EAN Number") = 0) and
                             (StrPos("Std. Pack UPC/EAN Number",
                                  CopyStr(Item."LAX Item UPC/EAN Number", 1, StrLen(Item."LAX Item UPC/EAN Number") - 1)) = 0)
                          then
                              if not Confirm(
                                      Text14000703,
                                      false,
                                      Item.FieldName("LAX Item UPC/EAN Number"),
                                      Item."LAX Item UPC/EAN Number",
                                      FieldName("Std. Pack UPC/EAN Number"))
                              then
                                  Error(Text14000702);
                  end;
              end;
          } */

        field(70000; "Sales Qty Alt."; Boolean)
        {
            Caption = 'Sales Qty Alt.';
        }

        field(70001; "Purchase Qty Alt."; Boolean)
        {
            Caption = 'Purchase Qty Alt.';
        }

        field(70002; "Sales Price Per Alt."; Code[10])
        {
            Caption = 'Sales Price Per Alt.';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }

        field(70003; "Purchase Price Per Alt."; Code[10])
        {
            Caption = 'Purchase Price Per Alt.';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }

        field(70004; "Alt. Base Qty."; Decimal)
        {
            Caption = 'Alt. Base Qty.';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Alt. Base Qty." <> 0 then
                    Validate("Qty. per Unit of Measure", 1 / "Alt. Base Qty.");
            end;
        }

        field(70005; "Package Size Code"; Code[20])
        {
            Caption = 'Package Size Code';
            Description = 'NV';

            trigger OnValidate()
            begin
                // >> NV - 08/13/03
                // >> NF1.00:CIS.CM 09-29-15
                // IF "Package Size Code" <> xRec."Package Size Code" THEN BEGIN
                //   IF "Package Size Code" <> '' THEN
                //     "Container Size".GET("Package Size Code")
                //   ELSE
                //     CLEAR("Container Size"); // Zero values
                //   VALIDATE(Length,"Container Size".Length);
                //   VALIDATE(Width,"Container Size".Width);
                //   VALIDATE(Height,"Container Size".Height);
                // END;
                // << NF1.00:CIS.CM 09-29-15
                // << NV - 08/13/03
            end;
        }
    }
    keys
    {
        key(Key3; "Package Size Code") { }
    }
    var
        Text14000701: Label '%1 is normally 14 digit, use this number anyway?';
        Text14000702: Label 'Nothing Changed.';
        Text14000703: Label '%1 %2 is not part of %3, use tihs number anyway?';
}

