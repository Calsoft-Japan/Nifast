codeunit 50132 "NewVision Validation"
{
    // NF1.00:CIS.NG    09/28/15 Update for New Vision Removal Task (Fill-Bill Functionality Renumber)


    trigger OnRun()
    begin
    end;

    procedure ValidateCustomer(CustNo: Code[20]): Boolean
    var
        Customer: Record 18;
    begin
        EXIT(Customer.GET(CustNo));
    end;

    procedure ValidateShipTo(CustNo: Code[20]; ShipToCode: Code[10]): Boolean
    var
        ShiptoAddress: Record 222;
    begin
        EXIT(ShiptoAddress.GET(CustNo, ShipToCode));
    end;

    procedure ValidateItem(ItemNo: Code[20]): Boolean
    var
        Item: Record 27;
    begin
        EXIT(Item.GET(ItemNo));
    end;

    procedure ValidateVendor(VendorNo: Code[20]): Boolean
    var
        Vendor: Record 23;
    begin
        EXIT(Vendor.GET(VendorNo));
    end;

    procedure VaidateOrderAddress(VendorNo: Code[20]; OrderAddressCode: Code[10]): Boolean
    var
        OrderAddress: Record 224;
    begin
        EXIT(OrderAddress.GET(VendorNo, OrderAddressCode));
    end;

    procedure ValidateUOM(UOMCode: Code[10]): Boolean
    var
        UOM: Record 204;
    begin
        EXIT(UOM.GET(UOMCode));
    end;

    procedure ValidateIUOM(ItemNo: Code[20]; UOMCode: Code[10]): Boolean
    var
        IUOM: Record 5404;
    begin
        EXIT(IUOM.GET(ItemNo, UOMCode));
    end;

    procedure ValidatePriceContract(ContractNo: Code[20]): Boolean
    var
        Contract: Record 50110;
    begin
        EXIT(Contract.GET(ContractNo));
    end;

    procedure ValidateLotNo(ItemNo: Code[20]; VarNo: Code[10]; LotNo: Code[20]): Boolean
    var
        LotInfo: Record 6505;
    begin
        LotInfo.SETRANGE("Item No.", ItemNo);
        LotInfo.SETRANGE("Variant Code", VarNo);
        LotInfo.SETRANGE("Lot No.", LotNo);
        EXIT(not LotInfo.IsEmpty());
    end;

    procedure ValidateCustItemCrossRef(CustNo: Code[20]; CrossRefNo: Code[20]): Boolean
    var
        ItemXRef: Record "Item Reference";
    begin
        ItemXRef.SETRANGE("Reference Type", ItemXRef."Reference Type"::Customer);
        ItemXRef.SETRANGE("Reference Type No.", CustNo);
        ItemXRef.SETRANGE("Reference No.", CrossRefNo);
        EXIT(Not ItemXRef.IsEmpty());
    end;

    procedure ValidateFBTag(TagNo: Code[20]): Boolean
    var
        FBTag: Record 50134;
    begin
        EXIT(FBTag.GET(TagNo));
    end;

    procedure ValidateLocation(LocationCode: Code[10]): Boolean
    var
        Location: Record 14;
    begin
        EXIT(Location.GET(LocationCode));
    end;

    procedure FindLotNo(var ItemNo: Code[20]; var VarNo: Code[10]; LotNo: Code[20]): Boolean
    var
        LotInfo: Record 6505;
    begin
        IF ItemNo <> '' THEN
            LotInfo.SETRANGE("Item No.", ItemNo);
        IF VarNo <> '' THEN
            LotInfo.SETRANGE("Variant Code", VarNo);
        LotInfo.SETRANGE("Lot No.", LotNo);
        IF not LotInfo.IsEmpty() THEN BEGIN
            ItemNo := LotInfo."Item No.";
            VarNo := LotInfo."Variant Code";
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;

    procedure FindCustItemCrossRef(CustNo: Code[20]; CrossRefNo: Code[20]; var ItemNo: Code[20]; var VarNo: Code[10]; var UOM: Code[10]): Boolean
    var
        ItemXRef: Record "Item Reference";
    begin
        ItemXRef.SETRANGE("Reference Type", ItemXRef."Reference Type"::Customer);
        ItemXRef.SETRANGE("Reference Type No.", CustNo);
        ItemXRef.SETRANGE("Reference No.", CrossRefNo);
        IF not ItemXRef.IsEmpty() THEN BEGIN
            ItemNo := ItemXRef."Item No.";
            VarNo := ItemXRef."Variant Code";
            UOM := ItemXRef."Unit of Measure";
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;
}

