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
            tableelement("Sales Header"; "Sales Header")
            {
                MaxOccurs = Once;
                MinOccurs = Once;
                XmlName = 'SalesHeader';
                SourceTableView = SORTING("Document Type", "No.")
                                  WHERE("Document Type" = CONST(1));
                UseTemporary = true;
                fieldelement(EDIPOID; "Sales Header"."EDI PO ID")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SalesId)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(EDIOrder; "Sales Header"."EDI Order")
                {
                }
                fieldelement(EDIBatchID; "Sales Header"."EDI Batch ID")
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
                        "Sales Header"."Posting Date" := EvaluateDate(PostingDate);
                    end;
                }
                textelement(OrderDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        "Sales Header"."Order Date" := EvaluateDate(OrderDate);
                    end;
                }
                textelement(DocumentDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        "Sales Header"."Document Date" := EvaluateDate(DocumentDate);
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
                        "Sales Header"."Requested Delivery Date" := EvaluateDate(RequestedDeliveryDate);
                    end;
                }
                textelement(PromisedDeliveryDate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    begin
                        "Sales Header"."Promised Delivery Date" := EvaluateDate(PromisedDeliveryDate);
                    end;
                }
                fieldelement(ExternalDocumentNo; "Sales Header"."External Document No.")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(SalespersonCode; "Sales Header"."Salesperson Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CampaignNo; "Sales Header"."Campaign No.")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ResponsibilityCenter; "Sales Header"."Responsibility Center")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShortcutDimension1Code; "Sales Header"."Shortcut Dimension 1 Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShortcutDimension2Code; "Sales Header"."Shortcut Dimension 2 Code")
                {
                    FieldValidate = No;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(PaymentTermsCode; "Sales Header"."Payment Terms Code")
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
                        "Sales Header"."Due Date" := EvaluateDate(DueDate);
                    end;
                }
                fieldelement(PaymentDiscount; "Sales Header"."Payment Discount %")
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
                        "Sales Header"."Pmt. Discount Date" := EvaluateDate(PmtDiscountDate);
                    end;
                }
                fieldelement(PaymentMethodCode; "Sales Header"."Payment Method Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(LocationCode; "Sales Header"."Location Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShipmentMethodCode; "Sales Header"."Shipment Method Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShippingAgentCode; "Sales Header"."Shipping Agent Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ShippingAgentServiceCode; "Sales Header"."Shipping Agent Service Code")
                {
                    AutoCalcField = false;
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(PackageTrackingNo; "Sales Header"."Package Tracking No.")
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
                        "Sales Header"."Shipment Date" := EvaluateDate(ShipmentDate);
                    end;
                }
                fieldelement(YourReference; "Sales Header"."Your Reference")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerPostingGroup; "Sales Header"."Customer Posting Group")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyCode; "Sales Header"."Currency Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyFactor; "Sales Header"."Currency Factor")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerPriceGroup; "Sales Header"."Customer Price Group")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(PricesIncludingVAT; "Sales Header"."Prices Including VAT")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(InvoiceDiscCode; "Sales Header"."Invoice Disc. Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerDiscGroup; "Sales Header"."Customer Disc. Group")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(OnHold; "Sales Header"."On Hold")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(VATRegistrationNo; "Sales Header"."VAT Registration No.")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CombineShipments; "Sales Header"."Combine Shipments")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(ReasonCode; "Sales Header"."Reason Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(TransportMethod; "Sales Header"."Transport Method")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(TaxAreaCode; "Sales Header"."Tax Area Code")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(CustomerOrderNo; "Sales Header"."Your Reference")
                {
                }
                fieldelement(PlantCode; "Sales Header"."Plant Code")
                {
                }
                fieldelement(DockCode; "Sales Header"."Dock Code")
                {
                }
                textelement(SelltoCustomer)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    fieldelement(SelltoCustomerNo; "Sales Header"."Sell-to Customer No.")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCustomerName; "Sales Header"."Sell-to Customer Name")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCustomerName2; "Sales Header"."Sell-to Customer Name 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoAddress; "Sales Header"."Sell-to Address")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoAddress2; "Sales Header"."Sell-to Address 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCity; "Sales Header"."Sell-to City")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoContact; "Sales Header"."Sell-to Contact")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCounty; "Sales Header"."Sell-to County")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoPostCode; "Sales Header"."Sell-to Post Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoCountryRegionCode; "Sales Header"."Sell-to Country/Region Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoContactNo; "Sales Header"."Sell-to Contact No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SelltoICPartnerCode; "Sales Header"."Sell-to IC Partner Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }
                textelement(BilltoCustomer)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    fieldelement(BilltoCustomerNo; "Sales Header"."Bill-to Customer No.")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoName; "Sales Header"."Bill-to Name")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoName2; "Sales Header"."Bill-to Name 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoAddress; "Sales Header"."Bill-to Address")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoAddress2; "Sales Header"."Bill-to Address 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoCity; "Sales Header"."Bill-to City")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoContact; "Sales Header"."Bill-to Contact")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoCounty; "Sales Header"."Bill-to County")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoPostCode; "Sales Header"."Bill-to Post Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoCountryRegionCode; "Sales Header"."Bill-to Country/Region Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoContactNo; "Sales Header"."Bill-to Contact No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BilltoICPartnerCode; "Sales Header"."Bill-to IC Partner Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }
                textelement(Shipto)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    fieldelement(ShiptoCode; "Sales Header"."Ship-to Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoName; "Sales Header"."Ship-to Name")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoName2; "Sales Header"."Ship-to Name 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoAddress; "Sales Header"."Ship-to Address")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoAddress2; "Sales Header"."Ship-to Address 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoCity; "Sales Header"."Ship-to City")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoContact; "Sales Header"."Ship-to Contact")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoCounty; "Sales Header"."Ship-to County")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ShiptoPostCode; "Sales Header"."Ship-to Post Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                }
                tableelement("Sales Line"; "Sales Line")
                {
                    LinkFields = "Document Type" = FIELD("Document Type"),
                                 "Document No." = FIELD("No.");
                    LinkTable = "Sales Header";
                    LinkTableForceInsert = true;
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    XmlName = 'SalesLine';
                    UseTemporary = true;
                    fieldelement(LINACTION; "Sales Line"."Prod. Kit Order No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                    }
                    fieldelement(LineNum; "Sales Line"."FB Line No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SalesId; "Sales Line"."FB Order No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(EDILineNo; "Sales Line"."EDI Line No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Type; "Sales Line".Type)
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
                        begin
                            //>> NF1.00:CIS.NG 10/30/15
                            "Sales Line"."No." := No_;
                            //IF "Sales Line".Type = TempSalesLine.Type::Item THEN BEGIN
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
                    fieldelement(EDICrossReference; "Sales Line"."EDI Item Cross Ref.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Description; "Sales Line".Description)
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Description2; "Sales Line"."Description 2")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LocationCode; "Sales Line"."Location Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(Quantity; "Sales Line".Quantity)
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(UnitofMeasureCode; "Sales Line"."Unit of Measure Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(UnitPrice; "Sales Line"."Unit Price")
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
                            "Sales Line"."Shipment Date" := EvaluateDate(ShipmentDate_Line);
                        end;
                    }
                    fieldelement(TaxGroupCode; "Sales Line"."Tax Group Code")
                    {
                        FieldValidate = No;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineAmount; "Sales Line"."Line Amount")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(AmountIncludingVAT; "Sales Line"."Amount Including VAT")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineDiscount; "Sales Line"."Line Discount %")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineDiscountAmount; "Sales Line"."Line Discount Amount")
                    {
                        AutoCalcField = false;
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ExternalDocumentNo; "Sales Line"."External Document No.")
                    {
                        MinOccurs = Zero;
                    }
                    fieldelement(CertificateNo; "Sales Line"."Certificate No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DrawingNo; "Sales Line"."Drawing No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(RevisionNo; "Sales Line"."Revision No.")
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
                            "Sales Line"."Revision Date" := EvaluateDate(RevisionDate);
                        end;
                    }
                    fieldelement(TotalParcels; "Sales Line"."Total Parcels")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(StorageLocation; "Sales Line"."Storage Location")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineSupplyLocation; "Sales Line"."Line Supply Location")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DeliverTo; "Sales Line"."Deliver To")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ReceivingArea; "Sales Line"."Receiving Area")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(RanNo; "Sales Line"."Ran No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ContainerNo; "Sales Line"."Container No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(KanbanNo; "Sales Line"."Kanban No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ResMfg; "Sales Line"."Res. Mfg.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ReleaseNo; "Sales Line"."Release No.")
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
                            "Sales Line"."Mfg. Date" := EvaluateDate(MfgDate);
                        end;
                    }
                    fieldelement(ManNo; "Sales Line"."Man No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DeliveryOrderNo; "Sales Line"."Delivery Order No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(PlantCode; "Sales Line"."Plant Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(DockCode; "Sales Line"."Dock Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(BoxWeight; "Sales Line"."Box Weight")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(StoreAddress; "Sales Line"."Store Address")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(FRSNo; "Sales Line"."FRS No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(MainRoute; "Sales Line"."Main Route")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(LineSideAddress; "Sales Line"."Line Side Address")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SubRouteNumber; "Sales Line"."Sub Route Number")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(SpecialMarkings; "Sales Line"."Special Markings")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(EngChangeNo; "Sales Line"."Eng. Change No.")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(GroupCode; "Sales Line"."Group Code")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    fieldelement(ModelYear; "Sales Line"."Model Year")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }

                    trigger OnAfterInitRecord()
                    begin
                        MyLineNo += 10000;
                        "Sales Line"."Line No." := MyLineNo;
                        //TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Sales Header"."Document Type" := "Sales Header"."Document Type"::Order;
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
        NewSalesHeader: Record "Sales Header";
        NewSalesLine: Record "Sales Line";
        EDISetup: Record "LAX EDI Setup";
        CustomerSellTo: Record Customer;
        CustomerBillTo: Record Customer;
        MyLineNo: Integer;
        Text000Err: Label 'DOCACTION = %1 is invalid.', Comment = '%1';
        Text002Err: Label 'SalesId must not be blank when DOCACTION = Update.';
        Text003Err: Label 'Cust# %1 N/A or N/F.', Comment = '%1';

    procedure GetOrderNo(): Code[20]
    begin
        EXIT(NewSalesHeader."No.");
    end;

    procedure CreateSalesOrder()
    begin
        EDISetup.GET();

        "Sales Header".RESET();
        IF "Sales Header".FINDFIRST() THEN BEGIN
            CASE DOCACTION OF
                'Insert':
                    BEGIN
                        NewSalesHeader.INIT();
                        NewSalesHeader.SetHideValidationDialog(NOT EDISetup."Show Messages On Import");
                        NewSalesHeader."Document Type" := NewSalesHeader."Document Type"::Order;
                        NewSalesHeader."No." := '';
                        NewSalesHeader.INSERT(TRUE);
                        ModSalesHeader();
                    END;
                'Update':
                    BEGIN
                        CLEAR(NewSalesHeader);
                        NewSalesHeader.RESET();
                        IF SalesId = '' THEN
                            ERROR(Text002Err);
                        NewSalesHeader.GET(NewSalesHeader."Document Type"::Order, SalesId);
                        ModSalesHeader();
                    END;
                'Delete':
                    BEGIN
                        CLEAR(NewSalesHeader);
                        NewSalesHeader.RESET();
                        NewSalesHeader.GET(NewSalesHeader."Document Type"::Order, SalesId);
                        NewSalesHeader.DELETE(TRUE);
                    END;
                ELSE
                    ERROR(Text000Err, DOCACTION);
            END;

            "Sales Line".RESET();
            IF "Sales Line".FINDSET() THEN
                REPEAT
                    CASE "Sales Line"."Prod. Kit Order No." OF
                        'INSERT':
                            BEGIN
                                NewSalesLine.INIT();
                                NewSalesLine.SetHideValidationDialog(NOT EDISetup."Show Messages On Import");
                                NewSalesLine."Document Type" := NewSalesHeader."Document Type";
                                NewSalesLine."Document No." := NewSalesHeader."No.";
                                NewSalesLine."Line No." := GetNewLineNo();
                                NewSalesLine.INSERT(TRUE);
                                ModSalesLines();
                            END;
                        'UPDATE':
                            BEGIN
                                CLEAR(NewSalesLine);
                                NewSalesLine.RESET();
                                NewSalesLine.GET("Sales Line"."Document Type"::Order, "Sales Line"."FB Order No.", "Sales Line"."FB Line No.");
                                ModSalesLines();
                            END;
                        'DELETE':
                            BEGIN
                                CLEAR(NewSalesLine);
                                NewSalesLine.RESET();
                                NewSalesLine.GET("Sales Line"."Document Type"::Order, "Sales Line"."FB Order No.", "Sales Line"."FB Line No.");
                                DeleteItemTracking(NewSalesLine);  //NF1.00:CIS.NG 11/16/15
                                NewSalesLine.DELETE(TRUE);
                            END;
                        ELSE
                            ERROR(Text001, "Sales Line"."Prod. Kit Order No.");
                    END;
                UNTIL "Sales Line".NEXT() = 0;
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
        IF NOT ("Sales Header"."EDI PO ID" = '') THEN
            NewSalesHeader.VALIDATE("EDI PO ID", "Sales Header"."EDI PO ID");

        IF NOT ("Sales Header"."EDI Order" = FALSE) THEN
            NewSalesHeader.VALIDATE("EDI Order", "Sales Header"."EDI Order");

        IF NOT ("Sales Header"."EDI Batch ID" = '') THEN
            NewSalesHeader.VALIDATE("EDI Batch ID", "Sales Header"."EDI Batch ID");

        IF NOT ("Sales Header"."Sell-to Customer No." = '') THEN BEGIN
            IF NOT CustomerSellTo.GET("Sales Header"."Sell-to Customer No.") THEN
                ERROR(Text003Err, "Sales Header"."Sell-to Customer No.");
            NewSalesHeader.VALIDATE("Sell-to Customer No.", CustomerSellTo."No.");
        END;
        IF NOT ("Sales Header"."Sell-to Customer Name" = '') THEN BEGIN
            NewSalesHeader."Sell-to Customer Name" := "Sales Header"."Sell-to Customer Name";
            NewSalesHeader."Sell-to Customer Name 2" := "Sales Header"."Sell-to Customer Name 2";
            NewSalesHeader."Sell-to Address" := "Sales Header"."Sell-to Address";
            NewSalesHeader."Sell-to Address 2" := "Sales Header"."Sell-to Address 2";
            NewSalesHeader."Sell-to City" := "Sales Header"."Sell-to City";
            NewSalesHeader."Sell-to Contact" := "Sales Header"."Sell-to Contact";
            NewSalesHeader."Sell-to Post Code" := "Sales Header"."Sell-to Post Code";
            NewSalesHeader."Sell-to County" := "Sales Header"."Sell-to County";
            NewSalesHeader."Sell-to Country/Region Code" := "Sales Header"."Sell-to Country/Region Code";
            NewSalesHeader."Sell-to Contact No." := "Sales Header"."Sell-to Contact No.";
            NewSalesHeader."Sell-to IC Partner Code" := "Sales Header"."Sell-to IC Partner Code";
        END;

        IF (NOT ("Sales Header"."Bill-to Customer No." = '')) AND
           (NOT ("Sales Header"."Bill-to Customer No." = CustomerSellTo."Bill-to Customer No.")) THEN BEGIN
            IF NOT CustomerBillTo.GET("Sales Header"."Bill-to Customer No.") THEN
                ERROR(Text003Err, "Sales Header"."Bill-to Customer No.");
            NewSalesHeader.VALIDATE("Bill-to Customer No.", CustomerBillTo."No.");
        END;
        IF NOT ("Sales Header"."Bill-to Name" = '') THEN BEGIN
            NewSalesHeader."Bill-to Name" := "Sales Header"."Bill-to Name";
            NewSalesHeader."Bill-to Name 2" := "Sales Header"."Bill-to Name 2";
            NewSalesHeader."Bill-to Address" := "Sales Header"."Bill-to Address";
            NewSalesHeader."Bill-to Address 2" := "Sales Header"."Bill-to Address 2";
            NewSalesHeader."Bill-to City" := "Sales Header"."Bill-to City";
            NewSalesHeader."Bill-to Contact" := "Sales Header"."Bill-to Contact";
            NewSalesHeader."Bill-to Post Code" := "Sales Header"."Bill-to Post Code";
            NewSalesHeader."Bill-to County" := "Sales Header"."Bill-to County";
            NewSalesHeader."Bill-to Country/Region Code" := "Sales Header"."Bill-to Country/Region Code";
            NewSalesHeader."Bill-to Contact No." := "Sales Header"."Bill-to Contact No.";
            NewSalesHeader."Bill-to IC Partner Code" := "Sales Header"."Bill-to IC Partner Code";
        END;

        IF NOT ("Sales Header"."Ship-to Code" = '') THEN
            NewSalesHeader.VALIDATE("Ship-to Code", "Sales Header"."Ship-to Code");
        IF NOT ("Sales Header"."Ship-to Name" = '') THEN BEGIN
            NewSalesHeader."Ship-to Name" := "Sales Header"."Ship-to Name";
            NewSalesHeader."Ship-to Name 2" := "Sales Header"."Ship-to Name 2";
            NewSalesHeader."Ship-to Address" := "Sales Header"."Ship-to Address";
            NewSalesHeader."Ship-to Address 2" := "Sales Header"."Ship-to Address 2";
            NewSalesHeader."Ship-to City" := "Sales Header"."Ship-to City";
            NewSalesHeader."Ship-to Contact" := "Sales Header"."Ship-to Contact";
            NewSalesHeader."Ship-to Post Code" := "Sales Header"."Ship-to Post Code";
            NewSalesHeader."Ship-to County" := "Sales Header"."Ship-to County";
            NewSalesHeader."Ship-to Country/Region Code" := "Sales Header"."Ship-to Country/Region Code";
        END;



        IF NOT ("Sales Header"."Posting Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Posting Date", "Sales Header"."Posting Date");
        IF NOT ("Sales Header"."Order Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Order Date", "Sales Header"."Order Date");
        IF NOT ("Sales Header"."Document Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Document Date", "Sales Header"."Document Date");
        IF NOT ("Sales Header"."Requested Delivery Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Requested Delivery Date", "Sales Header"."Requested Delivery Date");
        IF NOT ("Sales Header"."Promised Delivery Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Promised Delivery Date", "Sales Header"."Promised Delivery Date");
        IF NOT ("Sales Header"."External Document No." = '') THEN
            NewSalesHeader.VALIDATE("External Document No.", "Sales Header"."External Document No.");
        IF NOT ("Sales Header"."Salesperson Code" = '') THEN
            NewSalesHeader.VALIDATE("Salesperson Code", "Sales Header"."Salesperson Code");
        IF NOT ("Sales Header"."Campaign No." = '') THEN
            NewSalesHeader.VALIDATE("Campaign No.", "Sales Header"."Campaign No.");
        IF NOT ("Sales Header"."Responsibility Center" = '') THEN
            NewSalesHeader.VALIDATE("Responsibility Center", "Sales Header"."Responsibility Center");
        IF NOT ("Sales Header"."Shortcut Dimension 1 Code" = '') THEN
            NewSalesHeader.VALIDATE("Shortcut Dimension 1 Code", "Sales Header"."Shortcut Dimension 1 Code");
        IF NOT ("Sales Header"."Shortcut Dimension 2 Code" = '') THEN
            NewSalesHeader.VALIDATE("Shortcut Dimension 2 Code", "Sales Header"."Shortcut Dimension 2 Code");
        IF NOT ("Sales Header"."Payment Terms Code" = '') THEN
            NewSalesHeader.VALIDATE("Payment Terms Code", "Sales Header"."Payment Terms Code");
        IF NOT ("Sales Header"."Due Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Due Date", "Sales Header"."Due Date");
        IF NOT ("Sales Header"."Payment Discount %" = 0) THEN
            NewSalesHeader.VALIDATE("Payment Discount %", "Sales Header"."Payment Discount %");
        IF NOT ("Sales Header"."Pmt. Discount Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Pmt. Discount Date", "Sales Header"."Pmt. Discount Date");
        IF NOT ("Sales Header"."Payment Method Code" = '') THEN
            NewSalesHeader.VALIDATE("Payment Method Code", "Sales Header"."Payment Method Code");
        IF NOT ("Sales Header"."Location Code" = '') THEN
            NewSalesHeader.VALIDATE("Location Code", "Sales Header"."Location Code");
        IF NOT ("Sales Header"."Shipment Method Code" = '') THEN
            NewSalesHeader.VALIDATE("Shipment Method Code", "Sales Header"."Shipment Method Code");
        IF NOT ("Sales Header"."Shipping Agent Code" = '') THEN
            NewSalesHeader.VALIDATE("Shipping Agent Code", "Sales Header"."Shipping Agent Code");
        IF NOT ("Sales Header"."Shipping Agent Service Code" = '') THEN
            NewSalesHeader.VALIDATE("Shipping Agent Service Code", "Sales Header"."Shipping Agent Service Code");
        IF NOT ("Sales Header"."Package Tracking No." = '') THEN
            NewSalesHeader.VALIDATE("Package Tracking No.", "Sales Header"."Package Tracking No.");
        IF NOT ("Sales Header"."On Hold" = '') THEN
            NewSalesHeader.VALIDATE("On Hold", "Sales Header"."On Hold");
        IF NOT ("Sales Header"."VAT Registration No." = '') THEN
            NewSalesHeader.VALIDATE("VAT Registration No.", "Sales Header"."VAT Registration No.");
        IF "Sales Header"."Combine Shipments" THEN
            NewSalesHeader.VALIDATE("Combine Shipments", "Sales Header"."Combine Shipments");
        IF NOT ("Sales Header"."Reason Code" = '') THEN
            NewSalesHeader.VALIDATE("Reason Code", "Sales Header"."Reason Code");
        IF NOT ("Sales Header"."Transport Method" = '') THEN
            NewSalesHeader.VALIDATE("Transport Method", "Sales Header"."Transport Method");
        IF NOT ("Sales Header"."Tax Area Code" = '') THEN
            NewSalesHeader.VALIDATE("Tax Area Code", "Sales Header"."Tax Area Code");
        IF NOT ("Sales Header"."Your Reference" = '') THEN
            NewSalesHeader.VALIDATE("Your Reference", "Sales Header"."Your Reference");
        IF NOT ("Sales Header"."Shipment Date" = 0D) THEN
            NewSalesHeader.VALIDATE("Shipment Date", "Sales Header"."Shipment Date");
        IF NOT ("Sales Header"."Currency Code" = '') THEN
            NewSalesHeader.VALIDATE("Currency Code", "Sales Header"."Currency Code");
        IF NOT ("Sales Header"."Currency Factor" = 0) THEN
            NewSalesHeader.VALIDATE("Currency Factor", "Sales Header"."Currency Factor");
        IF NOT ("Sales Header"."Customer Posting Group" = '') THEN
            NewSalesHeader.VALIDATE("Customer Posting Group", "Sales Header"."Customer Posting Group");
        IF NOT ("Sales Header"."Customer Price Group" = '') THEN
            NewSalesHeader.VALIDATE("Customer Price Group", "Sales Header"."Customer Price Group");
        IF "Sales Header"."Prices Including VAT" THEN
            NewSalesHeader.VALIDATE("Prices Including VAT", "Sales Header"."Prices Including VAT");
        IF NOT ("Sales Header"."Invoice Disc. Code" = '') THEN
            NewSalesHeader.VALIDATE("Invoice Disc. Code", "Sales Header"."Invoice Disc. Code");
        IF NOT ("Sales Header"."Customer Disc. Group" = '') THEN
            NewSalesHeader.VALIDATE("Customer Disc. Group", "Sales Header"."Customer Disc. Group");
        NewSalesHeader."Plant Code" := "Sales Header"."Plant Code";
        NewSalesHeader."Dock Code" := "Sales Header"."Dock Code";
        NewSalesHeader.MODIFY(TRUE);
    end;

    local procedure ModSalesLines()
    begin
        NewSalesLine.VALIDATE(Type, "Sales Line".Type);
        NewSalesLine.VALIDATE("No.", "Sales Line"."No.");

        IF NOT ("Sales Line"."EDI Line No." = 0) THEN
            NewSalesLine.VALIDATE("EDI Line No.", "Sales Line"."EDI Line No.");

        IF NOT ("Sales Line"."EDI Item Cross Ref." = '') THEN
            NewSalesLine.VALIDATE("EDI Item Cross Ref.", "Sales Line"."EDI Item Cross Ref.");

        IF NOT ("Sales Line"."Location Code" = '') THEN
            NewSalesLine.VALIDATE("Location Code", "Sales Line"."Location Code");

        IF NOT ("Sales Line"."Shipment Date" = 0D) THEN
            NewSalesLine.VALIDATE("Shipment Date", "Sales Line"."Shipment Date");


        IF NOT ("Sales Line"."Unit of Measure Code" = '') THEN
            NewSalesLine.VALIDATE("Unit of Measure Code", "Sales Line"."Unit of Measure Code");
        IF NOT ("Sales Line".Quantity = 0) THEN
            NewSalesLine.VALIDATE(Quantity, "Sales Line".Quantity);
        IF NOT ("Sales Line"."Unit Price" = 0) THEN
            NewSalesLine.VALIDATE("Unit Price", "Sales Line"."Unit Price");

        IF NOT ("Sales Line".Description = '') THEN
            NewSalesLine.VALIDATE(Description, "Sales Line".Description);
        IF NOT ("Sales Line"."Description 2" = '') THEN
            NewSalesLine.VALIDATE("Description 2", "Sales Line"."Description 2");

        IF NOT ("Sales Line"."Tax Group Code" = '') THEN
            NewSalesLine.VALIDATE("Tax Group Code", "Sales Line"."Tax Group Code");
        IF NOT ("Sales Line"."Line Amount" = 0) THEN
            NewSalesLine.VALIDATE("Line Amount", "Sales Line"."Line Amount");
        IF NOT ("Sales Line"."Amount Including VAT" = 0) THEN
            NewSalesLine.VALIDATE("Amount Including VAT", "Sales Line"."Amount Including VAT");
        IF NOT ("Sales Line"."Line Discount %" = 0) THEN
            NewSalesLine.VALIDATE("Line Discount %", "Sales Line"."Line Discount %");
        IF NOT ("Sales Line"."Line Discount Amount" = 0) THEN
            NewSalesLine.VALIDATE("Line Discount Amount", "Sales Line"."Line Discount Amount");

        //jrr 17Mar16
        IF NOT ("Sales Line"."External Document No." = '') THEN
            NewSalesLine.VALIDATE("External Document No.", "Sales Line"."External Document No.");
        //jrr 17Mar16 end

        IF NOT ("Sales Line"."Certificate No." = '') THEN
            NewSalesLine.VALIDATE("Certificate No.", "Sales Line"."Certificate No.");

        IF NOT ("Sales Line"."Drawing No." = '') THEN
            NewSalesLine.VALIDATE("Drawing No.", "Sales Line"."Drawing No.");

        IF NOT ("Sales Line"."Revision No." = '') THEN
            NewSalesLine.VALIDATE("Revision No.", "Sales Line"."Revision No.");

        IF NOT ("Sales Line"."Revision Date" = 0D) THEN
            NewSalesLine.VALIDATE("Revision Date", "Sales Line"."Revision Date");

        IF NOT ("Sales Line"."Total Parcels" = 0) THEN
            NewSalesLine.VALIDATE("Total Parcels", "Sales Line"."Total Parcels");

        IF NOT ("Sales Line"."Storage Location" = '') THEN
            NewSalesLine.VALIDATE("Storage Location", "Sales Line"."Storage Location");

        IF NOT ("Sales Line"."Line Supply Location" = '') THEN
            NewSalesLine.VALIDATE("Line Supply Location", "Sales Line"."Line Supply Location");

        IF NOT ("Sales Line"."Deliver To" = '') THEN
            NewSalesLine.VALIDATE("Deliver To", "Sales Line"."Deliver To");

        IF NOT ("Sales Line"."Receiving Area" = '') THEN
            NewSalesLine.VALIDATE("Receiving Area", "Sales Line"."Receiving Area");

        IF NOT ("Sales Line"."Ran No." = '') THEN
            NewSalesLine.VALIDATE("Ran No.", "Sales Line"."Ran No.");

        IF NOT ("Sales Line"."Container No." = '') THEN
            NewSalesLine.VALIDATE("Container No.", "Sales Line"."Container No.");

        IF NOT ("Sales Line"."Kanban No." = '') THEN
            NewSalesLine.VALIDATE("Kanban No.", "Sales Line"."Kanban No.");

        IF NOT ("Sales Line"."Res. Mfg." = '') THEN
            NewSalesLine.VALIDATE("Res. Mfg.", "Sales Line"."Res. Mfg.");

        IF NOT ("Sales Line"."Release No." = '') THEN
            NewSalesLine.VALIDATE("Release No.", "Sales Line"."Release No.");

        IF NOT ("Sales Line"."Mfg. Date" = 0D) THEN
            NewSalesLine.VALIDATE("Mfg. Date", "Sales Line"."Mfg. Date");

        IF NOT ("Sales Line"."Man No." = '') THEN
            NewSalesLine.VALIDATE("Man No.", "Sales Line"."Man No.");

        IF NOT ("Sales Line"."Delivery Order No." = '') THEN
            NewSalesLine.VALIDATE("Delivery Order No.", "Sales Line"."Delivery Order No.");

        IF NOT ("Sales Line"."Plant Code" = '') THEN
            NewSalesLine.VALIDATE("Plant Code", "Sales Line"."Plant Code");

        IF NOT ("Sales Line"."Dock Code" = '') THEN
            NewSalesLine.VALIDATE("Dock Code", "Sales Line"."Dock Code");

        IF NOT ("Sales Line"."Box Weight" = 0) THEN
            NewSalesLine.VALIDATE("Box Weight", "Sales Line"."Box Weight");

        IF NOT ("Sales Line"."Store Address" = '') THEN
            NewSalesLine.VALIDATE("Store Address", "Sales Line"."Store Address");

        IF NOT ("Sales Line"."FRS No." = '') THEN
            NewSalesLine.VALIDATE("FRS No.", "Sales Line"."FRS No.");

        IF NOT ("Sales Line"."Main Route" = '') THEN
            NewSalesLine.VALIDATE("Main Route", "Sales Line"."Main Route");

        IF NOT ("Sales Line"."Line Side Address" = '') THEN
            NewSalesLine.VALIDATE("Line Side Address", "Sales Line"."Line Side Address");

        IF NOT ("Sales Line"."Sub Route Number" = '') THEN
            NewSalesLine.VALIDATE("Sub Route Number", "Sales Line"."Sub Route Number");

        IF NOT ("Sales Line"."Special Markings" = '') THEN
            NewSalesLine.VALIDATE("Special Markings", "Sales Line"."Special Markings");

        IF NOT ("Sales Line"."Eng. Change No." = '') THEN
            NewSalesLine.VALIDATE("Eng. Change No.", "Sales Line"."Eng. Change No.");

        IF NOT ("Sales Line"."Group Code" = '') THEN
            NewSalesLine.VALIDATE("Group Code", "Sales Line"."Group Code");

        IF NOT ("Sales Line"."Model Year" = '') THEN
            NewSalesLine.VALIDATE("Model Year", "Sales Line"."Model Year");

        NewSalesLine.MODIFY(TRUE);
    end;

    local procedure GetNewLineNo(): Integer
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.LOCKTABLE();
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", NewSalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", NewSalesHeader."No.");
        IF SalesLine.FINDLAST() THEN
            EXIT(SalesLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    /*  local procedure RepalceString(var String1: Code[20]; String2: Text; String3: Text)
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
     end; */

    procedure DeleteItemTracking(var SalesLine_vRec: Record "Sales Line")
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        NewDeleteItemTracking: Boolean;
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

        ReserveSalesLine.SetDeleteItemTracking(NewDeleteItemTracking);
        ReserveSalesLine.DeleteLine(SalesLine_vRec);
        //<< NF1.00:CIS.NG 11/16/15
    end;
}

