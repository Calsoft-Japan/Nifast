tableextension 56505 "Lot No. Information Ext" extends "Lot No. Information"
{
    fields
    {
        field(50010; "Mfg. Lot No."; Text[30])
        {
            // cleaned
        }
        field(50050; "Mfg. Date"; Date)
        {
            // cleaned
        }
        field(50055; "Mfg. Name"; Text[50])
        {
            // cleaned
        }
        field(50060; "Vendor No."; Code[20])
        {
            // cleaned
        }
        field(50070; "Vendor Name"; Text[50])
        {
            // cleaned
        }
        field(50075; "Date Received"; Date)
        {
            // cleaned
        }
        field(50080; "Country of Origin"; Code[10])
        {
            // cleaned
        }
        field(50090; "Source Location"; Code[10])
        {
            // cleaned
        }
        field(50100; "Multiple Certifications"; Integer)
        {
            CalcFormula = count("Certifcation Results" where("Lot No." = field("Lot No."),
                                                              "Item No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50105; "Certification Number"; Code[20])
        {
            // cleaned
        }
        field(50110; "Certification Type"; Option)
        {
            OptionMembers = " ",Internal,Vendor,Manufacturer;
        }
        field(50115; "Certification Scope"; Option)
        {
            OptionMembers = " ","Visual Only",Sample,Full;
        }
        field(50120; "Passed Inspection"; Boolean)
        {
            // cleaned
            trigger OnValidate();
            var
                LotNoInfo2: Record "Lot No. Information";
            begin
                //>> NIF 06-12-05

                //>> NIF 06-12-05
                //CheckQCPermission(this.FIELDNAME("Passed Inspection"));

                //cannot be checked if also Blocked
                if "Passed Inspection" then
                    Rec.TESTFIELD(Blocked, false);

                if "Mfg. Lot No." <> '' then begin
                    LotNoInfo2.SETCURRENTKEY("Item No.", "Mfg. Lot No.");
                    LotNoInfo2.SETRANGE("Item No.", "Item No.");
                    LotNoInfo2.SETRANGE("Mfg. Lot No.", "Mfg. Lot No.");
                    LotNoInfo2.SETFILTER("Lot No.", '<>%1', "Lot No.");
                    LotNoInfo2.MODIFYALL("Passed Inspection", "Passed Inspection");
                end;
                //<< NIF 06-12-05
            end;
        }
        field(50125; "Inspection Comments"; Text[100])
        {
            // cleaned
        }
        field(50130; "Quantity Tested"; Decimal)
        {
            // cleaned
        }
        field(50135; "Tested By"; Code[10])
        {
            // cleaned
        }
        field(50140; "Tested Date"; Date)
        {
            // cleaned
        }
        field(50150; "Tested Time"; Time)
        {
            // cleaned
        }
        field(50155; "QC Order Lines"; Integer)
        {
            Editable = false;
            Enabled = false;
        }
        field(50160; "PO Number"; Code[20])
        {
            // cleaned
        }
        field(50170; "Drawing No."; Code[30])
        {
            // cleaned
        }
        field(50171; "Revision No."; Code[20])
        {
            // cleaned
        }
        field(50172; "Revision Date"; Date)
        {
            // cleaned
        }
        field(50500; "Open Whse. Entries Exist"; Boolean)
        {
            CalcFormula = exist("Warehouse Entry" where("Item No." = field("Item No."),
                                                         "Lot No." = field("Lot No."),
                                                         //Open = const(true), //TODO
                                                         "Location Code" = field("Location Filter"),
                                                         "Bin Code" = field("Bin Filter"),
                                                         "Variant Code" = field("Variant Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "Patente Original"; Code[10])
        {
            Description = 'Custom Agent License No.';
        }
        field(60002; "Aduana E/S"; Code[10])
        {
            Description = 'Customer Agent E/S';
        }
        field(60010; "Pediment No."; Code[10])
        {
            Description = 'Summary Entry No.';
        }
        field(60012; "CVE Pedimento"; Code[10])
        {
            Description = 'Summary Entry Code';
        }
        field(60015; "Fecha de entrada"; Date)
        {
            Description = 'Date of Entry';
        }
        field(60020; "Tipo Cambio (1 day before)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            Editable = true;
            MinValue = 0;
        }
        field(60022; "Tipo Cambio (USD)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            Editable = true;
            MinValue = 0;
        }
        field(60023; "Tipo Cambio (JPY)"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }

        field(50000; "Lot Creation Date"; Date)//NV-Lot From 14018077->50000
        {
            Description = 'NV-Lot';
        }
        field(14018070; "QC Hold"; Boolean)
        {
            Description = 'NV-QC';
        }
        field(14018071; "QC Hold Reason Code"; code[10])
        {
            TableRelation = "Reason Code".Code WHERE(Type = CONST(QC));
        }
        field(14018072; "QC External Test"; Boolean)
        {
        }
        field(14018073; "QC Tech"; code[10])
        {
            TableRelation = "Salesperson/Purchaser".Code WHERE("QC Tech" = CONST(true));
        }
        field(14018074; "QC Inspection Date"; Date)
        {
        }
        field(14018075; "QC Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                                                               "Variant Code" = FIELD("Variant Code"),
                                                                                                               "Lot No." = FIELD("Lot No."),
                                                                                                               "Location Code" = FIELD("Location Filter"),
                                                                                                               "QC Hold" = CONST(true)));
            CaptionML = ENU = 'Qty. on QC Hold';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(14018076; "QC Select"; code[20])
        {
            CaptionML = ENU = 'QC Select';
            Editable = false;
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                //>> NIF 06-12-05
                //CheckQCPermission(FIELDNAME(Blocked)); //TODO

                //cannot be blocked if passed inspection
                IF Blocked THEN
                    TESTFIELD("Passed Inspection", FALSE);
                //<< NIF 06-12-05
            end;
        }
    }
    keys
    {
        key(RPTSort; "Mfg. Lot No.")
        { }
    }
    // procedure CheckQCPermission(ChangedField: Text[50]);
    // var
    //     UserSetup: Record "User Setup";
    // begin
    //     if not UserSetup.GET(USERID) then
    //         ERROR('You are not set up as an authorized user to change the value of this field.');

    //     case ChangedField of
    //         FIELDNAME(Blocked):
    //             if ((Blocked) and (not UserSetup."Edit QC Hold - On")) or
    //               ((not Blocked) and (not UserSetup."Edit QC Hold - Off")) then
    //                 ERROR('You are not authorized to change the value of this field.');
    //         FIELDNAME("Passed Inspection"):
    //             if ((not "Passed Inspection") and (not UserSetup."Edit QC Hold - On")) or
    //               (("Passed Inspection") and (not UserSetup."Edit QC Hold - Off")) then
    //                 ERROR('You are not authorized to change the value of this field.');
    //     end;
    // end;

    procedure GetBinContentBuffer(var BinContentBuffer: Record 7330 temporary): Text[200];
    var
        BinContent: Record 7302;
        Location: Record 14;
        LotNoInfo: Record 6505;
    begin
        BinContentBuffer.RESET();
        BinContentBuffer.DELETEALL();

        BinContent.SETFILTER("Location Code", GETFILTER("Location Filter"));
        BinContent.SETRANGE("Variant Code", "Variant Code");
        BinContent.SETRANGE("Item No.", "Item No.");
        BinContent.SETRANGE("Lot No. Filter", "Lot No.");
        BinContent.CALCFIELDS(Quantity);
        BinContent.SETFILTER(Quantity, '<>%1', 0);
        if BinContent.FIND('-') then
            repeat
                BinContentBuffer.INIT();
                BinContent.CALCFIELDS(Quantity);
                BinContentBuffer."Location Code" := BinContent."Location Code";
                BinContentBuffer."Bin Code" := BinContent."Bin Code";
                BinContentBuffer."Item No." := BinContent."Item No.";
                BinContentBuffer."Lot No." := "Lot No.";
                BinContentBuffer."Zone Code" := BinContent."Zone Code";
                if not BinContentBuffer.FIND() then begin
                    BinContentBuffer."Qty. to Handle (Base)" := BinContent.Quantity;
                    BinContentBuffer.INSERT();
                end;

            until BinContent.NEXT() = 0;

        //account for locations that do not use bins
        Location.SETRANGE("Bin Mandatory", false);
        Location.SETFILTER(Code, GETFILTER("Location Filter"));
        if Location.FIND('-') then
            repeat
                LotNoInfo.GET("Item No.", "Variant Code", "Lot No.");
                LotNoInfo.SETRANGE("Location Filter", Location.Code);
                LotNoInfo.CALCFIELDS(Inventory);
                if LotNoInfo.Inventory <> 0 then begin
                    BinContentBuffer.INIT();
                    BinContentBuffer."Location Code" := Location.Code;
                    BinContentBuffer."Bin Code" := '';
                    BinContentBuffer."Item No." := "Item No.";
                    BinContentBuffer."Lot No." := "Lot No.";
                    BinContentBuffer."Zone Code" := '';
                    if not BinContentBuffer.FIND() then begin
                        BinContentBuffer."Qty. to Handle (Base)" := LotNoInfo.Inventory;
                        BinContentBuffer.INSERT();
                    end;
                end;
            until Location.NEXT() = 0;
    end;

    procedure InLocationBinGross(): Text[1024];
    var
        BinContentBuffer: Record 7330 temporary;
        BinString: Code[1024];
    begin
        GetBinContentBuffer(BinContentBuffer);
        //now loop through bin content to build string
        if BinContentBuffer.FIND('-') then begin
            BinString := BinContentBuffer."Location Code";
            if BinContentBuffer."Bin Code" <> '' then
                BinString := COPYSTR(BinString + '-' + BinContentBuffer."Bin Code", 1, 1024);
            if BinContentBuffer.NEXT() <> 0 then
                repeat
                    BinString := COPYSTR(BinString + '|' + BinContentBuffer."Location Code", 1, 1024);
                    if BinContentBuffer."Bin Code" <> '' then
                        BinString := COPYSTR(BinString + '-' + BinContentBuffer."Bin Code", 1, 1024);
                until BinContentBuffer.NEXT() = 0;
        end;

        exit(BinString);
    end;

    procedure ShowBinContentBufferGross();
    var
        LotBinContentBuffer: Record 7330;
        LotBinContentForm: Page 50147;
    begin
        GetBinContentBuffer(LotBinContentBuffer);
        LotBinContentForm.SETTABLEVIEW(LotBinContentBuffer);
        LotBinContentForm.RUN();
    end;
}
