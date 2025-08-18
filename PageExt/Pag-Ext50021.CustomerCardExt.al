pageextension 50021 CustomerCardExt extends "Customer Card"
{
    // version NAVW18.00,NAVNA8.00,SE0.54.10,NV4.35,NIF1.096,NMX1.000,NIF.N15.C9IN.001

    layout
    {
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                //>>NV
                this.CheckReqFields(false);
                //<<NV
            end;
        }
        addafter(ContactName)
        {
            field("DUNS Number"; Rec."DUNS Number")
            {
                Caption = 'DUNS Number';
                ToolTip = 'Specifies the value of the DUNS Number field.';
                ApplicationArea = All;
            }
            field("Original No."; Rec."Original No.")
            {
                DrillDown = false;
                ToolTip = 'Specifies the value of the Original No. field.';
                ApplicationArea = All;
            }
        }
        moveafter("Original No."; "Name 2")
        addafter("Tax Exemption No.")
        {
            field("Master Customer No."; Rec."Master Customer No.")
            {
                ToolTip = 'Specifies the value of the Master Customer No. field.';
                ApplicationArea = All;
            }
            field(MasterAmount_0; Rec.MasterAmount(0))
            {
                Caption = 'Master Balance';
                Editable = false;
                ToolTip = 'Specifies the value of the (0) field.';
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    Rec.ShowMasterCustomerList();
                end;
            }
            field("Master Credit Limit"; Rec."Master Credit Limit"())
            {
                Caption = 'Master Credit Limit';
                DecimalPlaces = 0 : 2;
                Editable = false;
                ToolTip = 'Specifies the value of the Master Credit Limit field.';
                ApplicationArea = All;
            }
            field("No. of Relations"; Rec."No. of Relations")
            {
                ToolTip = 'Specifies the value of the No. of Relations field.';
                ApplicationArea = All;
            }
            field("Master Customer Name"; Rec."Master Customer Name")
            {
                DrillDown = false;
                ToolTip = 'Specifies the value of the Master Customer Name field.';
                ApplicationArea = All;
            }
        }
        addafter(Reserve)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Caption = 'Division Code';
                ToolTip = 'Specifies the value of the Division Code field.';
                ApplicationArea = All;
            }
        }
        addafter("Customized Calendar")
        {
            field("Freight Code"; Rec."Freight Code")
            {
                ToolTip = 'Specifies the value of the Freight Code field.';
                ApplicationArea = All;
            }
            field("SCAC Code"; Rec."SCAC Code")
            {
                ToolTip = 'Specifies the value of the SCAC Code field.';
                ApplicationArea = All;
            }
            field("Mode of Transport"; Rec."Mode of Transport")
            {
                ToolTip = 'Specifies the value of the Mode of Transport field.';
                ApplicationArea = All;
            }
        }
        addafter("Bank Communication")
        {
            field("Port of Discharge"; Rec."Port of Discharge")
            {
                Visible = "Port of DischargeVisible";
                ToolTip = 'Specifies the value of the Port of Discharge field.';
                ApplicationArea = All;
            }
            field("Pitex/Maquila No."; Rec."Pitex/Maquila No.")
            {
                Visible = "Pitex/Maquila No.Visible";
                ToolTip = 'Specifies the value of the Pitex/Maquila No. field.';
                ApplicationArea = All;
            }
            field("Export Pediment No."; Rec."Export Pediment No.")
            {
                Caption = 'Pedimento Virtual No.';
                Lookup = true;
                ToolTip = 'Specifies the value of the Pedimento Virtual No. field.';
                ApplicationArea = All;
            }
        }
        addafter("VAT Registration No.")
        {
            field("Customs Clearance by"; Rec."Customs Clearance by")
            {
                ToolTip = 'Specifies the value of the Customs Clearance by field.';
                ApplicationArea = All;
            }
            group(EDI)
            {
                Caption = 'EDI';
                field("EDI ID"; Rec."EDI ID")
                {
                    ToolTip = 'Specifies the value of the EDI ID field.';
                    ApplicationArea = All;
                }
                field("Default Model Year"; Rec."Default Model Year")
                {
                    DrillDown = false;
                    ToolTip = 'Specifies the value of the Default Model Year field.';
                    ApplicationArea = All;
                }
                field("CISCO Code"; Rec."CISCO Code")
                {
                    ToolTip = 'Specifies the value of the CISCO Code field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {

        // addafter("Prepa&yment Percentages") //TODO
        // {
        //     action("&Contracts")
        //     {
        //         Caption = '&Contracts';
        //         RunObject = Page 50113;
        //         RunPageLink = "Customer No." = FIELD("No.");
        //         ApplicationArea = All;
        //     }
        // }
        // addafter("Action 147")
        // {
        //     action("Sales Invoice Lines") //TODO
        //     {
        //         Caption = 'Sales Invoice Lines';
        //         RunObject = Page 50058;
        //         RunPageLink = "Sell-to Customer No." = field("No.");
        //         ApplicationArea = All;
        //     }
        // }
    }

    var
        SRSetup: Record "Sales & Receivables Setup";
        NVM: Codeunit 50021;
        "Port of DischargeVisible": Boolean;
        "Pitex/Maquila No.Visible": Boolean;

    trigger OnAfterGetRecord()
    begin
        this.ActivateFieldsCustom();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        this.ActivateFieldsCustom();
    end;

    trigger OnOpenPage()
    begin
        this.ActivateFieldsCustom();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        //>>NV
        this.CheckReqFields(TRUE);
        //<<NV
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        //>>NV
        this.CheckReqFields(FALSE);
        //<<NV    
    end;


    procedure CheckReqFields(HideMessage: Boolean);
    var
        RecRef: RecordRef;
    begin
        //>>NV
        RecRef.GETTABLE(Rec);
        if NVM.TestRequiredField(RecRef, COPYSTR(CurrPage.OBJECTID(false), 6), HideMessage) then
            Rec.Blocked := Rec.Blocked::All;
        //<<NV
    end;

    local procedure ActivateFieldsCustom()
    begin
        //jrr 080316
        "Port of DischargeVisible" := true;
        "Pitex/Maquila No.Visible" := true;

        if STRPOS(COMPANYNAME, 'Mexi') = 0 then begin
            "Port of DischargeVisible" := false;
            "Pitex/Maquila No.Visible" := false;
        end;
    end;
}

