table 50138 "FB Import Data Log"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)

    DrillDownPageID = 50143;
    LookupPageID = 50143;
    fields
    {
        field(5; "No."; Code[20])
        {
            // cleaned
        }
        field(12; "Line No."; Integer)
        {
            // cleaned
        }
        field(15; "Import File Name"; Code[200])
        {
            // cleaned
        }
        field(20; "Import Date"; Date)
        {
            // cleaned
        }
        field(25; "Import Time"; Time)
        {
            // cleaned
        }
        field(30; "Customer No."; Code[20])
        {
            // cleaned
            TableRelation = Customer;
        }
        field(40; "Contract No."; Code[20])
        {
            // cleaned
            TableRelation = "Price Contract";
        }
        field(50; "Location Code"; Code[10])
        {
            // cleaned
            TableRelation = Location;
        }
        field(60; "Ship-to Code"; Code[10])
        {
            // cleaned
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(70; "Item No."; Code[20])
        {
            // cleaned
        }
        field(80; "Lot No."; Code[20])
        {
            // cleaned
        }
        field(90; "Tag No."; Code[20])
        {
            // cleaned
        }
        field(95; "Cross-Reference No."; Code[20])
        {
            // cleaned
        }
        field(100; "Variant Code"; Code[10])
        {
            // cleaned
        }
        field(110; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(120; "Unit of Measure Code"; Code[10])
        {
            // cleaned
        }
        field(140; "External Document No."; Code[20])
        {
            // cleaned
        }
        field(150; "Order Date"; Date)
        {
            // cleaned
        }
        field(160; "Order Time"; Time)
        {
            // cleaned
        }
        field(170; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';

            trigger OnValidate()
            var
            /*   ">>LT_NV": ;
              LTEXT14170180: Label 'Sales Lines exist. All Lines will be changed to the new value.';
              LTEXT14170181: Label 'Operation Canceled'; */
            begin
            end;

        }
        field(175; "Inside Salesperson Code"; Code[10])
        {
            // cleaned
        }
        field(180; "Required Date"; Date)
        {
            // cleaned
        }
        field(190; "Customer Bin"; Code[20])
        {
            // cleaned
        }
        field(200; "Purchase Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(210; "Sale Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(350; "Quantity Type"; Option)
        {
            OptionCaption = 'Order,Usage,Count';
            OptionMembers = "Order",Usage,"Count";
        }
        field(500; "Error Messages"; Integer)
        {
            CalcFormula = Count("FB Message" WHERE("Import Data Log No." = FIELD("No."),
                                                    "Line No." = FIELD("Line No."),
                                                    Status = CONST(Errors),
                                                    Source = FILTER('IMPORT' | 'TAGJNL')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "FB Order Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("FB Line" WHERE("Import Data Log No." = FIELD("No."),
                                                 "Import Data Log Line No."=FIELD("Line No.")));
            Editable = false;
        }
    }
    keys
    {
        key(Key1;"No.","Line No.")
        {
        }
        key(Key2;"Contract No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        FBMessage.SETCURRENTKEY("Import Data Log No.","Line No.",Source,Status);
        FBMessage.SETRANGE("Import Data Log No.","No.");
        FBMessage.SETRANGE("Line No.","Line No.");
        FBMessage.DELETEALL();
    end;

    var
        FBMessage: Record 50135;
}
