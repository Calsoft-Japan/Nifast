xmlport 50000 "EDI Sales Order Import"
{
    // NF1.00:CIS.NG    10/05/15 Merge the (AP6) Functionality object provided by Jagdish
    // NF1.00:CIS.NG    10/15/15 XMLport Development - EDI Sales Order Import
    // NF1.00:CIS.NG    10/30/15 XMLport Development - Added code to replace the single space in item by multiple space
    // NF1.00:CIS.NG    11/16/15 XMLport Development - Added code to delete the item tracking line before we delete the sales lines
    // NF1.00:CIS.JR    12/03/15 XMLport Development - Added External Document#
    // NF1.00:CIS.NG    12/08/15 To Prevent white space in item code update xmlport port property - PreserveWhiteSpace = Yes
    // DMS0001 TJB 05/10/10:
    //   - Created XMLPort to import Sales orders

    Direction = Import;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(NAVXML)
        {
            textelement(DOCTYPE)
            {
            }
            textelement(DOCACTION)
            {
            }
            tableelement(tempsalesheader; Table36)
            {
                MaxOccurs = Once;
                MinOccurs = Once;
                XmlName = 'SalesHeader';
                SourceTableView = SORTING(Field1, Field3)
                                  WHERE(Field1 = CONST(1));
                UseTemporary = true;
                fieldelement(EDIPOID; TempSalesHeader."EDI PO ID")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SalesId)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(EDIOrder; TempSalesHeader."EDI Order")
                {
                }
                fieldelement(EDIBatchID; TempSalesHeader."EDI Batch ID")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PostingDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Posting Date" := EvaluateDate(PostingDate);
                    end;
                }
                textelement(OrderDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Order Date" := EvaluateDate(OrderDate);
                    end;
                }
                textelement(DocumentDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Document Date" := EvaluateDate(DocumentDate);
                    end;
                }
                textelement(DocumentType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RequestedDeliveryDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Requested Delivery Date" := EvaluateDate(RequestedDeliveryDate);
                    end;
                }
                textelement(PromisedDeliveryDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Promised Delivery Date" := EvaluateDate(PromisedDeliveryDate);
                    end;
                }
                fieldelement(ExternalDocumentNo; TempSalesHeader."External Document No.")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(SalespersonCode; TempSalesHeader."Salesperson Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CampaignNo; TempSalesHeader."Campaign No.")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ResponsibilityCenter; TempSalesHeader."Responsibility Center")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShortcutDimension1Code; TempSalesHeader."Shortcut Dimension 1 Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShortcutDimension2Code; TempSalesHeader."Shortcut Dimension 2 Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(PaymentTermsCode; TempSalesHeader."Payment Terms Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(DueDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Due Date" := EvaluateDate(DueDate);
                    end;
                }
                fieldelement(PaymentDiscount; TempSalesHeader."Payment Discount %")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PmtDiscountDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Pmt. Discount Date" := EvaluateDate(PmtDiscountDate);
                    end;
                }
                fieldelement(PaymentMethodCode; TempSalesHeader."Payment Method Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(LocationCode; TempSalesHeader."Location Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShipmentMethodCode; TempSalesHeader."Shipment Method Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShippingAgentCode; TempSalesHeader."Shipping Agent Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShippingAgentServiceCode; TempSalesHeader."Shipping Agent Service Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(PackageTrackingNo; TempSalesHeader."Package Tracking No.")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ShipmentDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        TempSalesHeader."Shipment Date" := EvaluateDate(ShipmentDate);
                    end;
                }
                fieldelement(YourReference; TempSalesHeader."Your Reference")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerPostingGroup; TempSalesHeader."Customer Posting Group")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyCode; TempSalesHeader."Currency Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyFactor; TempSalesHeader."Currency Factor")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerPriceGroup; TempSalesHeader."Customer Price Group")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(PricesIncludingVAT; TempSalesHeader."Prices Including VAT")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(InvoiceDiscCode; TempSalesHeader."Invoice Disc. Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerDiscGroup; TempSalesHeader."Customer Disc. Group")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(OnHold; TempSalesHeader."On Hold")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(VATRegistrationNo; TempSalesHeader."VAT Registration No.")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CombineShipments; TempSalesHeader."Combine Shipments")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ReasonCode; TempSalesHeader."Reason Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(TransportMethod; TempSalesHeader."Transport Method")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(TaxAreaCode; TempSalesHeader."Tax Area Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerOrderNo; TempSalesHeader."Your Reference")
                {
                }
                fieldelement(PlantCode; TempSalesHeader."Plant Code")
                {
                }
                fieldelement(DockCode; TempSalesHeader."Dock Code")
                {
                }
                textelement(SelltoCustomer)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    fieldelement(SelltoCustomerNo; TempSalesHeader."Sell-to Customer No.")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCustomerName; TempSalesHeader."Sell-to Customer Name")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCustomerName2; TempSalesHeader."Sell-to Customer Name 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoAddress; TempSalesHeader."Sell-to Address")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoAddress2; TempSalesHeader."Sell-to Address 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCity; TempSalesHeader."Sell-to City")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoContact; TempSalesHeader."Sell-to Contact")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCounty; TempSalesHeader."Sell-to County")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoPostCode; TempSalesHeader."Sell-to Post Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCountryRegionCode; TempSalesHeader."Sell-to Country/Region Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoContactNo; TempSalesHeader."Sell-to Contact No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoICPartnerCode; TempSalesHeader."Sell-to IC Partner Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }
                textelement(BilltoCustomer)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    fieldelement(BilltoCustomerNo; TempSalesHeader."Bill-to Customer No.")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoName; TempSalesHeader."Bill-to Name")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoName2; TempSalesHeader."Bill-to Name 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoAddress; TempSalesHeader."Bill-to Address")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoAddress2; TempSalesHeader."Bill-to Address 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoCity; TempSalesHeader."Bill-to City")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoContact; TempSalesHeader."Bill-to Contact")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoCounty; TempSalesHeader."Bill-to County")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoPostCode; TempSalesHeader."Bill-to Post Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoCountryRegionCode; TempSalesHeader."Bill-to Country/Region Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoContactNo; TempSalesHeader."Bill-to Contact No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoICPartnerCode; TempSalesHeader."Bill-to IC Partner Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }
                textelement(Shipto)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    fieldelement(ShiptoCode; TempSalesHeader."Ship-to Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoName; TempSalesHeader."Ship-to Name")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoName2; TempSalesHeader."Ship-to Name 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoAddress; TempSalesHeader."Ship-to Address")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoAddress2; TempSalesHeader."Ship-to Address 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoCity; TempSalesHeader."Ship-to City")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoContact; TempSalesHeader."Ship-to Contact")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoCounty; TempSalesHeader."Ship-to County")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoPostCode; TempSalesHeader."Ship-to Post Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }
                tableelement(tempsalesline; Table37)
                {
                    LinkFields = Field1 = FIELD(Field1),
                                 Field3 = FIELD(Field3);
                    LinkTable = TempSalesHeader;
                    LinkTableForceInsert = true;
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    XmlName = 'SalesLine';
                    UseTemporary = true;
                    fieldelement(LINACTION; TempSalesLine."Prod. Kit Order No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                    }
                    fieldelement(LineNum; TempSalesLine."FB Line No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SalesId; TempSalesLine."FB Order No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(EDILineNo; TempSalesLine."EDI Line No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Type; TempSalesLine.Type)
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(no_)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'No';

                        trigger OnAfterAssignVariable()
                        var
                            Item: Record "27";
                        begin
                            //>> NF1.00:CIS.NG 10/30/15
                            TempSalesLine."No." := No_;
                            //IF TempSalesLine.Type = TempSalesLine.Type::Item THEN BEGIN
                            //  Item.RESET;
                            //  Item.SETRANGE("No.",TempSalesLine."No.");
                            //  Item.SETRANGE(Inactive,TRUE);
                            //  IF Item.FINDFIRST THEN BEGIN
                            //    IF STRPOS(TempSalesLine."No.",' ') <> 0 THEN BEGIN
                            //      RepalceString(TempSalesLine."No.",' ','  ');
                            //    END;
                            //  END;

                            //  Item.RESET;
                            //  Item.SETRANGE("No.",TempSalesLine."No.");
                            //  IF Item.ISEMPTY THEN BEGIN
                            //    IF STRPOS(TempSalesLine."No.",' ') <> 0 THEN BEGIN
                            //      RepalceString(TempSalesLine."No.",' ','  ');
                            //    END;
                            //  END;
                            //END;
                            //<< NF1.00:CIS.NG 10/30/15
                        end;
                    }
                    fieldelement(EDICrossReference; TempSalesLine."EDI Item Cross Ref.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Description; TempSalesLine.Description)
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Description2; TempSalesLine."Description 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LocationCode; TempSalesLine."Location Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Quantity; TempSalesLine.Quantity)
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(UnitofMeasureCode; TempSalesLine."Unit of Measure Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(UnitPrice; TempSalesLine."Unit Price")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(shipmentdate_line)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'ShipmentDate';

                        trigger OnAfterAssignVariable()
                        begin
                            TempSalesLine."Shipment Date" := EvaluateDate(ShipmentDate_Line);
                        end;
                    }
                    fieldelement(TaxGroupCode; TempSalesLine."Tax Group Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineAmount; TempSalesLine."Line Amount")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(AmountIncludingVAT; TempSalesLine."Amount Including VAT")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineDiscount; TempSalesLine."Line Discount %")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineDiscountAmount; TempSalesLine."Line Discount Amount")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ExternalDocumentNo; TempSalesLine."External Document No.")
                    {
                        MinOccurs = Zero;
                    }
                    fieldelement(CertificateNo; TempSalesLine."Certificate No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DrawingNo; TempSalesLine."Drawing No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(RevisionNo; TempSalesLine."Revision No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(RevisionDate)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable()
                        begin
                            TempSalesLine."Revision Date" := EvaluateDate(RevisionDate);
                        end;
                    }
                    fieldelement(TotalParcels; TempSalesLine."Total Parcels")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(StorageLocation; TempSalesLine."Storage Location")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineSupplyLocation; TempSalesLine."Line Supply Location")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DeliverTo; TempSalesLine."Deliver To")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ReceivingArea; TempSalesLine."Receiving Area")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(RanNo; TempSalesLine."Ran No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ContainerNo; TempSalesLine."Container No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(KanbanNo; TempSalesLine."Kanban No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ResMfg; TempSalesLine."Res. Mfg.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ReleaseNo; TempSalesLine."Release No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(MfgDate)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;

                        trigger OnAfterAssignVariable()
                        begin
                            TempSalesLine."Mfg. Date" := EvaluateDate(MfgDate);
                        end;
                    }
                    fieldelement(ManNo; TempSalesLine."Man No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DeliveryOrderNo; TempSalesLine."Delivery Order No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(PlantCode; TempSalesLine."Plant Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DockCode; TempSalesLine."Dock Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BoxWeight; TempSalesLine."Box Weight")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(StoreAddress; TempSalesLine."Store Address")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(FRSNo; TempSalesLine."FRS No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(MainRoute; TempSalesLine."Main Route")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineSideAddress; TempSalesLine."Line Side Address")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SubRouteNumber; TempSalesLine."Sub Route Number")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SpecialMarkings; TempSalesLine."Special Markings")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(EngChangeNo; TempSalesLine."Eng. Change No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(GroupCode; TempSalesLine."Group Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ModelYear; TempSalesLine."Model Year")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterInitRecord()
                    begin
                        MyLineNo += 10000;
                        TempSalesLine."Line No." := MyLineNo;
                        //TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    TempSalesHeader."Document Type" := TempSalesHeader."Document Type"::Order;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        CreateSalesOrder();
    end;

    trigger OnPreXmlPort()
    begin
        MyLineNo := 0;
    end;

    var
        NewSalesHeader: Record "36";
        NewSalesLine: Record "37";
        EDISetup: Record "14002367";
        CustomerSellTo: Record "18";
        CustomerBillTo: Record "18";
        MyLineNo: Integer;
        Text000: Label 'DOCACTION = %1 is invalid.';
        Text001: Label 'LINACTION = %1 is invalid.';
        Text002: Label 'SalesId must not be blank when DOCACTION = Update.';
        Text003: Label 'Cust# %1 N/A or N/F.';

    procedure GetOrderNo(): Code[20]
    begin
        EXIT(NewSalesHeader."No.");
    end;

    procedure CreateSalesOrder()
    begin
        EDISetup.GET;

        TempSalesHeader.RESET;
        IF TempSalesHeader.FINDFIRST THEN BEGIN
            CASE DOCACTION OF
                'Insert':
                    BEGIN
                        NewSalesHeader.INIT;
                        NewSalesHeader.SetHideValidationDialog(NOT EDISetup."Show Messages On Import");
                        NewSalesHeader."Document Type" := NewSalesHeader."Document Type"::Order;
                        NewSalesHeader."No." := '';
                        NewSalesHeader.INSERT(TRUE);
                        ModSalesHeader;
                    END;
                'Update':
                    BEGIN
                        CLEAR(NewSalesHeader);
                        NewSalesHeader.RESET;
                        IF SalesId = '' THEN
                            ERROR(Text002);
                        NewSalesHeader.GET(NewSalesHeader."Document Type"::Order, SalesId);
                        ModSalesHeader;
                    END;
                'Delete':
                    BEGIN
                        CLEAR(NewSalesHeader);
                        NewSalesHeader.RESET;
                        NewSalesHeader.GET(NewSalesHeader."Document Type"::Order, SalesId);
                        NewSalesHeader.DELETE(TRUE);
                    END;
                ELSE
                    ERROR(Text000, DOCACTION);
            END;

            TempSalesLine.RESET;
            IF TempSalesLine.FINDSET THEN BEGIN
                REPEAT
                    CASE TempSalesLine."Prod. Kit Order No." OF
                        'INSERT':
                            BEGIN
                                NewSalesLine.INIT;
                                NewSalesLine.SetHideValidationDialog(NOT EDISetup."Show Messages On Import");
                                NewSalesLine."Document Type" := NewSalesHeader."Document Type";
                                NewSalesLine."Document No." := NewSalesHeader."No.";
                                NewSalesLine."Line No." := GetNewLineNo;
                                NewSalesLine.INSERT(TRUE);

                                ModSalesLines;
                            END;
                        'UPDATE':
                            BEGIN
                                CLEAR(NewSalesLine);
                                NewSalesLine.RESET;
                                NewSalesLine.GET(TempSalesLine."Document Type"::Order, TempSalesLine."FB Order No.", TempSalesLine."FB Line No.");

                                ModSalesLines;
                            END;
                        'DELETE':
                            BEGIN
                                CLEAR(NewSalesLine);
                                NewSalesLine.RESET;
                                NewSalesLine.GET(TempSalesLine."Document Type"::Order, TempSalesLine."FB Order No.", TempSalesLine."FB Line No.");
                                DeleteItemTracking(NewSalesLine);  //NF1.00:CIS.NG 11/16/15
                                NewSalesLine.DELETE(TRUE);
                            END;
                        ELSE
                            ERROR(Text001, TempSalesLine."Prod. Kit Order No.");
                    END;
                UNTIL TempSalesLine.NEXT = 0;
            END;
        END;
    end;

    local procedure EvaluateDate(parDateText: Text[8]): Date
    var
        locYear: Integer;
        locMonth: Integer;
        locDay: Integer;
    begin
        IF EVALUATE(locYear, COPYSTR(parDateText, 1, 4)) AND
           EVALUATE(locMonth, COPYSTR(parDateText, 5, 2)) AND
           EVALUATE(locDay, COPYSTR(parDateText, 7, 2))
        THEN
            EXIT(DMY2DATE(locDay, locMonth, locYear))
        ELSE
            EXIT(0D);
    end;

    local procedure ModSalesHeader()
    begin
        IF NOT (TempSalesHeader."EDI PO ID" = '') THEN
            NewSalesHeader.VALIDATE("EDI PO ID", TempSalesHeader."EDI PO ID");

        IF NOT (TempSalesHeader."EDI Order" = FALSE) THEN
            NewSalesHeader.VALIDATE("EDI Order", TempSalesHeader."EDI Order");

        IF NOT (TempSalesHeader."EDI Batch ID" = '') THEN
            NewSalesHeader.VALIDATE("EDI Batch ID", TempSalesHeader."EDI Batch ID");

        IF NOT (TempSalesHeader."Sell-to Customer No." = '') THEN BEGIN
            IF NOT CustomerSellTo.GET(TempSalesHeader."Sell-to Customer No.") THEN
                ERROR(Text003, TempSalesHeader."Sell-to Customer No.");
            NewSalesHeader.VALIDATE("Sell-to Customer No.", CustomerSellTo."No.");
        END;
        IF NOT (TempSalesHeader."Sell-to Customer Name" = '') THEN BEGIN
            NewSalesHeader."Sell-to Customer Name" := TempSalesHeader."Sell-to Customer Name";
            NewSalesHeader."Sell-to Customer Name 2" := TempSalesHeader."Sell-to Customer Name 2";
            NewSalesHeader."Sell-to Address" := TempSalesHeader."Sell-to Address";
            NewSalesHeader."Sell-to Address 2" := TempSalesHeader."Sell-to Address 2";
            NewSalesHeader."Sell-to City" := TempSalesHeader."Sell-to City";
            NewSalesHeader."Sell-to Contact" := TempSalesHeader."Sell-to Contact";
            NewSalesHeader."Sell-to Post Code" := TempSalesHeader."Sell-to Post Code";
            NewSalesHeader."Sell-to County" := TempSalesHeader."Sell-to County";
            NewSalesHeader."Sell-to Country/Region Code" := TempSalesHeader."Sell-to Country/Region Code";
            NewSalesHeader."Sell-to Contact No." := TempSalesHeader."Sell-to Contact No.";
            NewSalesHeader."Sell-to IC Partner Code" := TempSalesHeader."Sell-to IC Partner Code";
        END;

        IF (NOT (TempSalesHeader."Bill-to Customer No." = '')) AND
           (NOT (TempSalesHeader."Bill-to Customer No." = CustomerSellTo."Bill-to Customer No.")) THEN BEGIN
            IF NOT CustomerBillTo.GET(TempSalesHeader."Bill-to Customer No.") THEN
                ERROR(Text003, TempSalesHeader."Bill-to Customer No.");
            NewSalesHeader.VALIDATE("Bill-to Customer No.", CustomerBillTo."No.");
        END;
        IF NOT (TempSalesHeader."Bill-to Name" = '') THEN BEGIN
            NewSalesHeader."Bill-to Name" := TempSalesHeader."Bill-to Name";
            NewSalesHeader."Bill-to Name 2" := TempSalesHeader."Bill-to Name 2";
            NewSalesHeader."Bill-to Address" := TempSalesHeader."Bill-to Address";
            NewSalesHeader."Bill-to Address 2" := TempSalesHeader."Bill-to Address 2";
            NewSalesHeader."Bill-to City" := TempSalesHeader."Bill-to City";
            NewSalesHeader."Bill-to Contact" := TempSalesHeader."Bill-to Contact";
            NewSalesHeader."Bill-to Post Code" := TempSalesHeader."Bill-to Post Code";
            NewSalesHeader."Bill-to County" := TempSalesHeader."Bill-to County";
            NewSalesHeader."Bill-to Country/Region Code" := TempSalesHeader."Bill-to Country/Region Code";
            NewSalesHeader."Bill-to Contact No." := TempSalesHeader."Bill-to Contact No.";
            NewSalesHeader."Bill-to IC Partner Code" := TempSalesHeader."Bill-to IC Partner Code";
        END;

        IF NOT (TempSalesHeader."Ship-to Code" = '') THEN
            NewSalesHeader.VALIDATE("Ship-to Code", TempSalesHeader."Ship-to Code");
        IF NOT (TempSalesHeader."Ship-to Name" = '') THEN BEGIN
            NewSalesHeader."Ship-to Name" := TempSalesHeader."Ship-to Name";
            NewSalesHeader."Ship-to Name 2" := TempSalesHeader."Ship-to Name 2";
            NewSalesHeader."Ship-to Address" := TempSalesHeader."Ship-to Address";
            NewSalesHeader."Ship-to Address 2" := TempSalesHeader."Ship-to Address 2";
            NewSalesHeader."Ship-to City" := TempSalesHeader."Ship-to City";
            NewSalesHeader."Ship-to Contact" := TempSalesHeader."Ship-to Contact";
            NewSalesHeader."Ship-to Post Code" := TempSalesHeader."Ship-to Post Code";
            NewSalesHeader."Ship-to County" := TempSalesHeader."Ship-to County";
            NewSalesHeader."Ship-to Country/Region Code" := TempSalesHeader."Ship-to Country/Region Code";
        END;



        IF NOT (TempSalesHeader."Posting Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Posting Date", TempSalesHeader."Posting Date");
        IF NOT (TempSalesHeader."Order Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Order Date", TempSalesHeader."Order Date");
        IF NOT (TempSalesHeader."Document Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Document Date", TempSalesHeader."Document Date");
        IF NOT (TempSalesHeader."Requested Delivery Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Requested Delivery Date", TempSalesHeader."Requested Delivery Date");
        IF NOT (TempSalesHeader."Promised Delivery Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Promised Delivery Date", TempSalesHeader."Promised Delivery Date");
        IF NOT (TempSalesHeader."External Document No." = '') THEN
            NewSalesHeader.VALIDATE("External Document No.", TempSalesHeader."External Document No.");
        IF NOT (TempSalesHeader."Salesperson Code" = '') THEN
            NewSalesHeader.VALIDATE("Salesperson Code", TempSalesHeader."Salesperson Code");
        IF NOT (TempSalesHeader."Campaign No." = '') THEN
            NewSalesHeader.VALIDATE("Campaign No.", TempSalesHeader."Campaign No.");
        IF NOT (TempSalesHeader."Responsibility Center" = '') THEN
            NewSalesHeader.VALIDATE("Responsibility Center", TempSalesHeader."Responsibility Center");
        IF NOT (TempSalesHeader."Shortcut Dimension 1 Code" = '') THEN
            NewSalesHeader.VALIDATE("Shortcut Dimension 1 Code", TempSalesHeader."Shortcut Dimension 1 Code");
        IF NOT (TempSalesHeader."Shortcut Dimension 2 Code" = '') THEN
            NewSalesHeader.VALIDATE("Shortcut Dimension 2 Code", TempSalesHeader."Shortcut Dimension 2 Code");
        IF NOT (TempSalesHeader."Payment Terms Code" = '') THEN
            NewSalesHeader.VALIDATE("Payment Terms Code", TempSalesHeader."Payment Terms Code");
        IF NOT (TempSalesHeader."Due Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Due Date", TempSalesHeader."Due Date");
        IF NOT (TempSalesHeader."Payment Discount %" = 0) THEN
            NewSalesHeader.VALIDATE("Payment Discount %", TempSalesHeader."Payment Discount %");
        IF NOT (TempSalesHeader."Pmt. Discount Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Pmt. Discount Date", TempSalesHeader."Pmt. Discount Date");
        IF NOT (TempSalesHeader."Payment Method Code" = '') THEN
            NewSalesHeader.VALIDATE("Payment Method Code", TempSalesHeader."Payment Method Code");
        IF NOT (TempSalesHeader."Location Code" = '') THEN
            NewSalesHeader.VALIDATE("Location Code", TempSalesHeader."Location Code");
        IF NOT (TempSalesHeader."Shipment Method Code" = '') THEN
            NewSalesHeader.VALIDATE("Shipment Method Code", TempSalesHeader."Shipment Method Code");
        IF NOT (TempSalesHeader."Shipping Agent Code" = '') THEN
            NewSalesHeader.VALIDATE("Shipping Agent Code", TempSalesHeader."Shipping Agent Code");
        IF NOT (TempSalesHeader."Shipping Agent Service Code" = '') THEN
            NewSalesHeader.VALIDATE("Shipping Agent Service Code", TempSalesHeader."Shipping Agent Service Code");
        IF NOT (TempSalesHeader."Package Tracking No." = '') THEN
            NewSalesHeader.VALIDATE("Package Tracking No.", TempSalesHeader."Package Tracking No.");
        IF NOT (TempSalesHeader."On Hold" = '') THEN
            NewSalesHeader.VALIDATE("On Hold", TempSalesHeader."On Hold");
        IF NOT (TempSalesHeader."VAT Registration No." = '') THEN
            NewSalesHeader.VALIDATE("VAT Registration No.", TempSalesHeader."VAT Registration No.");
        IF TempSalesHeader."Combine Shipments" THEN
            NewSalesHeader.VALIDATE("Combine Shipments", TempSalesHeader."Combine Shipments");
        IF NOT (TempSalesHeader."Reason Code" = '') THEN
            NewSalesHeader.VALIDATE("Reason Code", TempSalesHeader."Reason Code");
        IF NOT (TempSalesHeader."Transport Method" = '') THEN
            NewSalesHeader.VALIDATE("Transport Method", TempSalesHeader."Transport Method");
        IF NOT (TempSalesHeader."Tax Area Code" = '') THEN
            NewSalesHeader.VALIDATE("Tax Area Code", TempSalesHeader."Tax Area Code");
        IF NOT (TempSalesHeader."Your Reference" = '') THEN
            NewSalesHeader.VALIDATE("Your Reference", TempSalesHeader."Your Reference");
        IF NOT (TempSalesHeader."Shipment Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Shipment Date", TempSalesHeader."Shipment Date");
        IF NOT (TempSalesHeader."Currency Code" = '') THEN
            NewSalesHeader.VALIDATE("Currency Code", TempSalesHeader."Currency Code");
        IF NOT (TempSalesHeader."Currency Factor" = 0) THEN
            NewSalesHeader.VALIDATE("Currency Factor", TempSalesHeader."Currency Factor");
        IF NOT (TempSalesHeader."Customer Posting Group" = '') THEN
            NewSalesHeader.VALIDATE("Customer Posting Group", TempSalesHeader."Customer Posting Group");
        IF NOT (TempSalesHeader."Customer Price Group" = '') THEN
            NewSalesHeader.VALIDATE("Customer Price Group", TempSalesHeader."Customer Price Group");
        IF TempSalesHeader."Prices Including VAT" THEN
            NewSalesHeader.VALIDATE("Prices Including VAT", TempSalesHeader."Prices Including VAT");
        IF NOT (TempSalesHeader."Invoice Disc. Code" = '') THEN
            NewSalesHeader.VALIDATE("Invoice Disc. Code", TempSalesHeader."Invoice Disc. Code");
        IF NOT (TempSalesHeader."Customer Disc. Group" = '') THEN
            NewSalesHeader.VALIDATE("Customer Disc. Group", TempSalesHeader."Customer Disc. Group");
        NewSalesHeader."Plant Code" := TempSalesHeader."Plant Code";
        NewSalesHeader."Dock Code" := TempSalesHeader."Dock Code";
        NewSalesHeader.MODIFY(TRUE);
    end;

    local procedure ModSalesLines()
    begin
        NewSalesLine.VALIDATE(Type, TempSalesLine.Type);
        NewSalesLine.VALIDATE("No.", TempSalesLine."No.");

        IF NOT (TempSalesLine."EDI Line No." = 0) THEN
            NewSalesLine.VALIDATE("EDI Line No.", TempSalesLine."EDI Line No.");

        IF NOT (TempSalesLine."EDI Item Cross Ref." = '') THEN
            NewSalesLine.VALIDATE("EDI Item Cross Ref.", TempSalesLine."EDI Item Cross Ref.");

        IF NOT (TempSalesLine."Location Code" = '') THEN
            NewSalesLine.VALIDATE("Location Code", TempSalesLine."Location Code");

        IF NOT (TempSalesLine."Shipment Date" = 0D) THEN
            NewSalesLine.VALIDATE("Shipment Date", TempSalesLine."Shipment Date");


        IF NOT (TempSalesLine."Unit of Measure Code" = '') THEN
            NewSalesLine.VALIDATE("Unit of Measure Code", TempSalesLine."Unit of Measure Code");
        IF NOT (TempSalesLine.Quantity = 0) THEN
            NewSalesLine.VALIDATE(Quantity, TempSalesLine.Quantity);
        IF NOT (TempSalesLine."Unit Price" = 0) THEN
            NewSalesLine.VALIDATE("Unit Price", TempSalesLine."Unit Price");

        IF NOT (TempSalesLine.Description = '') THEN
            NewSalesLine.VALIDATE(Description, TempSalesLine.Description);
        IF NOT (TempSalesLine."Description 2" = '') THEN
            NewSalesLine.VALIDATE("Description 2", TempSalesLine."Description 2");

        IF NOT (TempSalesLine."Tax Group Code" = '') THEN
            NewSalesLine.VALIDATE("Tax Group Code", TempSalesLine."Tax Group Code");
        IF NOT (TempSalesLine."Line Amount" = 0) THEN
            NewSalesLine.VALIDATE("Line Amount", TempSalesLine."Line Amount");
        IF NOT (TempSalesLine."Amount Including VAT" = 0) THEN
            NewSalesLine.VALIDATE("Amount Including VAT", TempSalesLine."Amount Including VAT");
        IF NOT (TempSalesLine."Line Discount %" = 0) THEN
            NewSalesLine.VALIDATE("Line Discount %", TempSalesLine."Line Discount %");
        IF NOT (TempSalesLine."Line Discount Amount" = 0) THEN
            NewSalesLine.VALIDATE("Line Discount Amount", TempSalesLine."Line Discount Amount");
        //jrr 17Mar16
        IF NOT (TempSalesLine."External Document No." = '') THEN
            NewSalesLine.VALIDATE("External Document No.", TempSalesLine."External Document No.");
        //jrr 17Mar16 end

        IF NOT (TempSalesLine."Certificate No." = '') THEN
            NewSalesLine.VALIDATE("Certificate No.", TempSalesLine."Certificate No.");

        IF NOT (TempSalesLine."Drawing No." = '') THEN
            NewSalesLine.VALIDATE("Drawing No.", TempSalesLine."Drawing No.");

        IF NOT (TempSalesLine."Revision No." = '') THEN
            NewSalesLine.VALIDATE("Revision No.", TempSalesLine."Revision No.");

        IF NOT (TempSalesLine."Revision Date" = 0D) THEN
            NewSalesLine.VALIDATE("Revision Date", TempSalesLine."Revision Date");

        IF NOT (TempSalesLine."Total Parcels" = 0) THEN
            NewSalesLine.VALIDATE("Total Parcels", TempSalesLine."Total Parcels");

        IF NOT (TempSalesLine."Storage Location" = '') THEN
            NewSalesLine.VALIDATE("Storage Location", TempSalesLine."Storage Location");

        IF NOT (TempSalesLine."Line Supply Location" = '') THEN
            NewSalesLine.VALIDATE("Line Supply Location", TempSalesLine."Line Supply Location");

        IF NOT (TempSalesLine."Deliver To" = '') THEN
            NewSalesLine.VALIDATE("Deliver To", TempSalesLine."Deliver To");

        IF NOT (TempSalesLine."Receiving Area" = '') THEN
            NewSalesLine.VALIDATE("Receiving Area", TempSalesLine."Receiving Area");

        IF NOT (TempSalesLine."Ran No." = '') THEN
            NewSalesLine.VALIDATE("Ran No.", TempSalesLine."Ran No.");

        IF NOT (TempSalesLine."Container No." = '') THEN
            NewSalesLine.VALIDATE("Container No.", TempSalesLine."Container No.");

        IF NOT (TempSalesLine."Kanban No." = '') THEN
            NewSalesLine.VALIDATE("Kanban No.", TempSalesLine."Kanban No.");

        IF NOT (TempSalesLine."Res. Mfg." = '') THEN
            NewSalesLine.VALIDATE("Res. Mfg.", TempSalesLine."Res. Mfg.");

        IF NOT (TempSalesLine."Release No." = '') THEN
            NewSalesLine.VALIDATE("Release No.", TempSalesLine."Release No.");

        IF NOT (TempSalesLine."Mfg. Date" = 0D) THEN
            NewSalesLine.VALIDATE("Mfg. Date", TempSalesLine."Mfg. Date");

        IF NOT (TempSalesLine."Man No." = '') THEN
            NewSalesLine.VALIDATE("Man No.", TempSalesLine."Man No.");

        IF NOT (TempSalesLine."Delivery Order No." = '') THEN
            NewSalesLine.VALIDATE("Delivery Order No.", TempSalesLine."Delivery Order No.");

        IF NOT (TempSalesLine."Plant Code" = '') THEN
            NewSalesLine.VALIDATE("Plant Code", TempSalesLine."Plant Code");

        IF NOT (TempSalesLine."Dock Code" = '') THEN
            NewSalesLine.VALIDATE("Dock Code", TempSalesLine."Dock Code");

        IF NOT (TempSalesLine."Box Weight" = 0) THEN
            NewSalesLine.VALIDATE("Box Weight", TempSalesLine."Box Weight");

        IF NOT (TempSalesLine."Store Address" = '') THEN
            NewSalesLine.VALIDATE("Store Address", TempSalesLine."Store Address");

        IF NOT (TempSalesLine."FRS No." = '') THEN
            NewSalesLine.VALIDATE("FRS No.", TempSalesLine."FRS No.");

        IF NOT (TempSalesLine."Main Route" = '') THEN
            NewSalesLine.VALIDATE("Main Route", TempSalesLine."Main Route");

        IF NOT (TempSalesLine."Line Side Address" = '') THEN
            NewSalesLine.VALIDATE("Line Side Address", TempSalesLine."Line Side Address");

        IF NOT (TempSalesLine."Sub Route Number" = '') THEN
            NewSalesLine.VALIDATE("Sub Route Number", TempSalesLine."Sub Route Number");

        IF NOT (TempSalesLine."Special Markings" = '') THEN
            NewSalesLine.VALIDATE("Special Markings", TempSalesLine."Special Markings");

        IF NOT (TempSalesLine."Eng. Change No." = '') THEN
            NewSalesLine.VALIDATE("Eng. Change No.", TempSalesLine."Eng. Change No.");

        IF NOT (TempSalesLine."Group Code" = '') THEN
            NewSalesLine.VALIDATE("Group Code", TempSalesLine."Group Code");

        IF NOT (TempSalesLine."Model Year" = '') THEN
            NewSalesLine.VALIDATE("Model Year", TempSalesLine."Model Year");

        NewSalesLine.MODIFY(TRUE);
    end;

    local procedure GetNewLineNo(): Integer
    var
        SalesLine: Record "37";
    begin
        SalesLine.LOCKTABLE;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", NewSalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", NewSalesHeader."No.");
        IF SalesLine.FINDLAST THEN
            EXIT(SalesLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    local procedure RepalceString(var String1: Code[20]; String2: Text; String3: Text)
    var
        AantalPos: Integer;
        Deel1: Text;
        Deel2: Text;
    begin
        //>> NF1.00:CIS.NG 10/30/15
        AantalPos := STRPOS(String1, String2);
        IF AantalPos <> 0 THEN BEGIN
            IF AantalPos > 1 THEN
                Deel1 := COPYSTR(String1, 1, AantalPos - 1);
            IF AantalPos <> STRLEN(String1) - (STRLEN(String2) - 1) THEN
                Deel2 := COPYSTR(String1, AantalPos + STRLEN(String2));

            String1 := Deel1 + String3 + Deel2;
        END;
        //<< NF1.00:CIS.NG 10/30/15
    end;

    procedure DeleteItemTracking(var SalesLine_vRec: Record "37")
    var
        ReserveSalesLine: Codeunit "99000832";
    begin
        //>> NF1.00:CIS.NG 11/16/15
        IF SalesLine_vRec.Type <> SalesLine_vRec.Type::Item THEN
            EXIT;

        IF NOT SalesLine_vRec.ItemExists(SalesLine_vRec."No.") THEN
            EXIT;

        IF SalesLine_vRec."Document Type" <> SalesLine_vRec."Document Type"::Order THEN
            EXIT;

        IF SalesLine_vRec.Quantity = 0 THEN
            EXIT;

        SalesLine_vRec.TESTFIELD("Quantity Shipped", 0);
        SalesLine_vRec.TESTFIELD("Quantity Invoiced", 0);

        IF NOT ReserveSalesLine.ReservEntryExist(SalesLine_vRec) THEN
            EXIT;

        ReserveSalesLine.SetDeleteItemTracking;
        ReserveSalesLine.DeleteLine(SalesLine_vRec);
        //<< NF1.00:CIS.NG 11/16/15
    end;
}

