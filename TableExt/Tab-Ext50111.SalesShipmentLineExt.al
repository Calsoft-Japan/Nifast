tableextension 50111 "Sales Shipment Line Ext" extends "Sales Shipment Line"
{
    // version NAVW18.00,NAVNA8.00,SE0.60,NV4.35,NIF1.095,NIF.N15.C9IN.001,AKK1606.01
    fields
    {
        field(50005; "Certificate No."; Code[30])
        {
            // cleaned
        }
        field(50010; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50020; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50025; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50027; "Revision No. (Label Only)"; Code[20])
        {
            // cleaned
        }
        field(50030; "Total Parcels"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '#10069';
        }
        field(50100; "Storage Location"; Code[10])
        {
            // cleaned
        }
        field(50105; "Line Supply Location"; Code[10])
        {
            // cleaned
        }
        field(50110; "Deliver To"; Code[10])
        {
            // cleaned
        }
        field(50115; "Receiving Area"; Code[10])
        {
            // cleaned
        }
        field(50120; "Ran No."; Code[20])
        {
            // cleaned
        }
        field(50125; "Container No."; Code[20])
        {
            // cleaned
        }
        field(50130; "Kanban No."; Code[20])
        {
            // cleaned
        }
        field(50135; "Res. Mfg."; Code[20])
        {
            // cleaned
        }
        field(50140; "Release No."; Code[20])
        {
            // cleaned
        }
        field(50145; "Mfg. Date"; Date)
        {
            // cleaned
        }
        field(50150; "Man No."; Code[20])
        {
            // cleaned
        }
        field(50155; "Delivery Order No."; Code[20])
        {
            // cleaned
        }
        field(50157; "Plant Code"; Code[10])
        {
            // cleaned
        }
        field(50160; "Dock Code"; Code[10])
        {
            // cleaned
        }
        field(50165; "Box Weight"; Decimal)
        {
            // cleaned
        }
        field(50170; "Store Address"; Text[50])
        {
            // cleaned
        }
        field(50175; "FRS No."; Code[10])
        {
            // cleaned
        }
        field(50180; "Main Route"; Code[10])
        {
            // cleaned
        }
        field(50185; "Line Side Address"; Text[50])
        {
            // cleaned
        }
        field(50190; "Sub Route Number"; Code[10])
        {
            // cleaned
        }
        field(50195; "Special Markings"; Text[30])
        {
            // cleaned
        }
        field(50200; "Eng. Change No."; Code[20])
        {
            // cleaned
        }
        field(50205; "Group Code"; Code[20])
        {
            // cleaned
        }
        field(50500; "Model Year"; Code[10])
        {
            // cleaned
        }
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
              TableRelation = "Salesperson/Purchaser".Code WHERE("Sales" = CONST(Yes));
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
          field(37015330; "FB Order No."; Code[20])
          {
              Description = 'NV';
          }
          field(37015331; "FB Line No."; Integer)
          {
              Description = 'NV';
          }
          field(37015332; "FB Tag No."; Code[20])
          {
              Description = 'NV';
          }
          field(37015333; "FB Customer Bin"; Code[20])
          {
              Description = 'NV';
          } */
        //TODO
    }
    keys
    {
        key(Key9; "Shipment Date")
        {
        }
        /*  key(Key10; "Sell-to Customer No.", "Ship-to Code", Type, "No.", "Location Code", "Model Year", "Posting Date")
         {
             SumIndexFields = Quantity, "Quantity (Base)";
         }
         key(Key11; "Sell-to Customer No.", "No.", "EDI Release No.", "EDI Ship Req. Date")
         {
         } */
    }
    PROCEDURE ">>NIF_fcn"();
    BEGIN
    END;

    PROCEDURE ShowSpecialFields();
    VAR
    // SalesShptLine: Record 111;
    // SpecialFields: Page 50007;
    BEGIN
        //TODO
        /*  IF (Type <> Type::Item) OR ("No." = '') THEN
             EXIT;
         SalesShptLine.SETRANGE("Document No.", "Document No.");
         SalesShptLine.SETRANGE("Line No.", "Line No.");
         SpecialFields.SETTABLEVIEW(SalesShptLine);
         SpecialFields.RUN; */
        //TODO
    END;

    PROCEDURE ShowItemTrackingLines_gFnc(VAR TempItemLedgEntry_vRecTmp: Record 32 temporary);
    VAR
       // ItemTrackingMgt: Codeunit 6500;
    BEGIN
        //TODO
        /*  //>> NF1.00:CIS.NG    09/12/16
         ItemTrackingMgt.CallPostedItemTrackingForm_gFnc(DATABASE::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.", TempItemLedgEntry_vRecTmp);
         //<< NF1.00:CIS.NG    09/12/16 */
        //TODO
    END;
}
