report 50089 "[P] Availability Canada"
{
    // NF1.00:CIS.CM  09-15-15 Merged during upgrade
    // NF1.00:CIS.CM  09-29-15 Update for New Vision Removal Task
    // NF1.00:CIS.NG  07-18-16 Update Code to Fix Excel Layout Issue and Correct Qty
    // NF1.00:CIS.NG  07-22-16 Update Code to Fix Excel Layout Issue and Correct Qty (for PO Detail,Hide Vehicle Deteail if no data exists)
    // NF1.00:CIS.NG  07-29-16 Update Code to Fix Excel Layout Issue and Correct Qty 2 Point error. two cells to the right & Fix for multiple customer forcast export
    // NF1.00:CIS.NG  08-03-16 Update code to Fix the Issue for Multiple PO Coming in Report
    // 
    // 1/24/07 Added "Qty. on S.O. in the Item body.
    // 1/24/07 Deleted "Companyname" on the Header and added "ItemFilter"
    // 1/24/07 Added Location Filter and Division code filter function
    // 1/2407  added location filter and division code filter in sales order loop and purchase order loop
    // 1/24/07 connection to Item Cross Reference Detroit Version
    // 1/24/07 ShowDetails, ShowDetails2, ShowDetailDetroit
    // 1/24/07 Multiple Items display fixed
    // 
    // 1/25/07 Activated Nifast Forecast
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\PAvailabilityCanada.rdl';
    ApplicationArea = All;
    Caption = '[P] Availability Canada';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Vendor No.", "Global Dimension 1 Filter", "Forecast on/off", "Shipping Agent Code";
            RequestFilterHeading = 'Select Item No.';
            column(Title; Title)
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(MinOrdQ; MinOrdQ)
            {

            }
            column(Daily42; Daily42)
            {

            }
            column(DayOnHand; DayOnHand)
            {

            }
            column(Weekly90; Weekly90)
            {

            }
            column(Maintain; Maintain)
            {

            }
            column(MaxInvQ; MaxInvQ)
            {

            }
            column(MaximumInv; MaximumInv)
            {

            }
            column(MinimumInv; MinimumInv)
            {

            }
            column(Item__Lead_Time_; "Lead Time")
            {

            }
            column(Item_Description; Description)
            {
            }
            column(Item__Vendor_No__; "Vendor No.")
            {
            }
            column(SNP; SNP)
            {
            }
            column(AveForecast; AveForecast)
            {

            }
            column(ItemLedgerEntry__Remaining_Quantity_; ItemLedgerEntry."Remaining Quantity")
            {

            }
            column(BQ; BQ)
            {

            }
            column(Item__No__; "No.")
            {
            }
            column(PeriodStartingDate_10_; FORMAT(PeriodStartingDate[10]))
            {
            }
            column(PeriodStartingText_10_; PeriodStartingText[10])
            {
            }
            column(PeriodStartingText_11_; PeriodStartingText[11])
            {
            }
            column(PeriodStartingDate_11_; FORMAT(PeriodStartingDate[11]))
            {
            }
            column(PeriodStartingDate_12_; FORMAT(PeriodStartingDate[12]))
            {
            }
            column(PeriodStartingText_12_; PeriodStartingText[12])
            {
            }
            column(PeriodStartingDate_13_; FORMAT(PeriodStartingDate[13]))
            {
            }
            column(PeriodStartingText_13_; PeriodStartingText[13])
            {
            }
            column(PeriodStartingDate_14_; FORMAT(PeriodStartingDate[14]))
            {
            }
            column(PeriodStartingText_14_; PeriodStartingText[14])
            {
            }
            column(PeriodStartingDate_15_; FORMAT(PeriodStartingDate[15]))
            {
            }
            column(PeriodStartingText_15_; PeriodStartingText[15])
            {
            }
            column(PeriodStartingDate_16_; FORMAT(PeriodStartingDate[16]))
            {
            }
            column(PeriodStartingText_16_; PeriodStartingText[16])
            {
            }
            column(PeriodStartingText_17_; PeriodStartingText[17])
            {
            }
            column(PeriodStartingText_18_; PeriodStartingText[18])
            {
            }
            column(PeriodStartingText_19_; PeriodStartingText[19])
            {
            }
            column(PeriodStartingText_20_; PeriodStartingText[20])
            {
            }
            column(PeriodStartingText_21_; PeriodStartingText[21])
            {
            }
            column(PeriodStartingText_22_; PeriodStartingText[22])
            {
            }
            column(PeriodStartingText_23_; PeriodStartingText[23])
            {
            }
            column(PeriodStartingText_24_; PeriodStartingText[24])
            {
            }
            column(PeriodStartingText_25_; PeriodStartingText[25])
            {
            }
            column(PeriodStartingDate_17_; FORMAT(PeriodStartingDate[17]))
            {
            }
            column(PeriodStartingDate_18_; FORMAT(PeriodStartingDate[18]))
            {
            }
            column(PeriodStartingDate_19_; FORMAT(PeriodStartingDate[19]))
            {
            }
            column(PeriodStartingDate_20_; FORMAT(PeriodStartingDate[20]))
            {
            }
            column(PeriodStartingDate_21_; FORMAT(PeriodStartingDate[21]))
            {
            }
            column(PeriodStartingDate_22_; FORMAT(PeriodStartingDate[22]))
            {
            }
            column(PeriodStartingDate_23_; FORMAT(PeriodStartingDate[23]))
            {
            }
            column(PeriodStartingDate_24_; FORMAT(PeriodStartingDate[24]))
            {
            }
            column(PeriodStartingDate_25_; FORMAT(PeriodStartingDate[25]))
            {
            }
            column(ForecastQty_10_; ForecastQty[10])
            {

            }
            column(ForecastQty_11_; ForecastQty[11])
            {

            }
            column(ForecastQty_12_; ForecastQty[12])
            {

            }
            column(ForecastQty_13_; ForecastQty[13])
            {

            }
            column(ForecastQty_14_; ForecastQty[14])
            {

            }
            column(ForecastQty_15_; ForecastQty[15])
            {

            }
            column(OnHand_10_; OnHand[10])
            {

            }
            column(OnHand_11_; OnHand[11])
            {

            }
            column(OnHand_12_; OnHand[12])
            {

            }
            column(OnHand_13_; OnHand[13])
            {

            }
            column(OnHand_14_; OnHand[14])
            {

            }
            column(OnHand_15_; OnHand[15])
            {

            }
            column(PurchaseNeeds_10_; PurchaseNeeds[10])
            {

            }
            column(PurchaseNeeds_11_; PurchaseNeeds[11])
            {

            }
            column(PurchaseNeeds_12_; PurchaseNeeds[12])
            {

            }
            column(PurchaseNeeds_13_; PurchaseNeeds[13])
            {

            }
            column(PurchaseNeeds_14_; PurchaseNeeds[14])
            {

            }
            column(PurchaseNeeds_15_; PurchaseNeeds[15])
            {

            }
            column(TotalForecast_10_; TotalForecast[10])
            {

            }
            column(TotalForecast_11_; TotalForecast[11])
            {

            }
            column(TotalForecast_12_; TotalForecast[12])
            {

            }
            column(TotalForecast_13_; TotalForecast[13])
            {

            }
            column(TotalForecast_14_; TotalForecast[14])
            {

            }
            column(TotalForecast_15_; TotalForecast[15])
            {

            }
            column(Order_10_; Order[10])
            {

            }
            column(Order_11_; Order[11])
            {

            }
            column(Order_12_; Order[12])
            {

            }
            column(Order_13_; Order[13])
            {

            }
            column(Order_14_; Order[14])
            {

            }
            column(Order_15_; Order[15])
            {

            }
            column(QtyOnPurchOrders_15_; QtyOnPurchOrders[15])
            {

            }
            column(QtyOnPurchOrders_14_; QtyOnPurchOrders[14])
            {

            }
            column(QtyOnPurchOrders_13_; QtyOnPurchOrders[13])
            {

            }
            column(QtyOnPurchOrders_12_; QtyOnPurchOrders[12])
            {

            }
            column(QtyOnPurchOrders_11_; QtyOnPurchOrders[11])
            {

            }
            column(QtyOnPurchOrders_10_; QtyOnPurchOrders[10])
            {

            }
            column(OnHand_16_; OnHand[16])
            {

            }
            column(Order_16_; Order[16])
            {

            }
            column(PurchaseNeeds_16_; PurchaseNeeds[16])
            {

            }
            column(TotalForecast_16_; TotalForecast[16])
            {

            }
            column(QtyOnPurchOrders_16_; QtyOnPurchOrders[16])
            {

            }
            column(ForecastQty_16_; ForecastQty[16])
            {

            }
            column(PurchSign_10_; FORMAT(PurchSign[10]))
            {
            }
            column(PurchSign_11_; FORMAT(PurchSign[11]))
            {
            }
            column(PurchSign_12_; FORMAT(PurchSign[12]))
            {
            }
            column(PurchSign_13_; FORMAT(PurchSign[13]))
            {
            }
            column(PurchSign_14_; FORMAT(PurchSign[14]))
            {
            }
            column(PurchSign_15_; FORMAT(PurchSign[15]))
            {
            }
            column(PurchSign_16_; FORMAT(PurchSign[16]))
            {
            }
            column(NewWeek_10_; NewWeek[10])
            {

            }
            column(NewWeek_11_; NewWeek[11])
            {

            }
            column(NewWeek_12_; NewWeek[12])
            {

            }
            column(NewWeek_13_; NewWeek[13])
            {

            }
            column(NewWeek_14_; NewWeek[14])
            {

            }
            column(NewWeek_15_; NewWeek[15])
            {

            }
            column(NewWeek_16_; NewWeek[16])
            {

            }
            column(Order_9_; Order[9])
            {

            }
            column(OnHand_17_; OnHand[17])
            {

            }
            column(QtyOnPurchOrders_17_; QtyOnPurchOrders[17])
            {

            }
            column(ForecastQty_17_; ForecastQty[17])
            {

            }
            column(TotalForecast_17_; TotalForecast[17])
            {

            }
            column(OnHand_18_; OnHand[18])
            {

            }
            column(QtyOnPurchOrders_18_; QtyOnPurchOrders[18])
            {

            }
            column(ForecastQty_18_; ForecastQty[18])
            {

            }
            column(TotalForecast_18_; TotalForecast[18])
            {

            }
            column(OnHand_19_; OnHand[19])
            {

            }
            column(QtyOnPurchOrders_19_; QtyOnPurchOrders[19])
            {

            }
            column(ForecastQty_19_; ForecastQty[19])
            {

            }
            column(TotalForecast_19_; TotalForecast[19])
            {

            }
            column(OnHand_20_; OnHand[20])
            {

            }
            column(QtyOnPurchOrders_20_; QtyOnPurchOrders[20])
            {

            }
            column(ForecastQty_20_; ForecastQty[20])
            {

            }
            column(TotalForecast_20_; TotalForecast[20])
            {

            }
            column(OnHand_21_; OnHand[21])
            {

            }
            column(QtyOnPurchOrders_21_; QtyOnPurchOrders[21])
            {

            }
            column(ForecastQty_21_; ForecastQty[21])
            {

            }
            column(TotalForecast_21_; TotalForecast[21])
            {

            }
            column(OnHand_22_; OnHand[22])
            {

            }
            column(QtyOnPurchOrders_22_; QtyOnPurchOrders[22])
            {

            }
            column(ForecastQty_22_; ForecastQty[22])
            {

            }
            column(TotalForecast_22_; TotalForecast[22])
            {

            }
            column(OnHand_23_; OnHand[23])
            {

            }
            column(QtyOnPurchOrders_23_; QtyOnPurchOrders[23])
            {

            }
            column(ForecastQty_23_; ForecastQty[23])
            {

            }
            column(TotalForecast_23_; TotalForecast[23])
            {

            }
            column(OnHand_24_; OnHand[24])
            {

            }
            column(QtyOnPurchOrders_24_; QtyOnPurchOrders[24])
            {

            }
            column(ForecastQty_24_; ForecastQty[24])
            {

            }
            column(TotalForecast_24_; TotalForecast[24])
            {

            }
            column(OnHand_25_; OnHand[25])
            {

            }
            column(QtyOnPurchOrders_25_; QtyOnPurchOrders[25])
            {

            }
            column(ForecastQty_25_; ForecastQty[25])
            {

            }
            column(TotalForecast_25_; TotalForecast[25])
            {

            }
            column(Order_17_; Order[17])
            {

            }
            column(PurchaseNeeds_25_; PurchaseNeeds[25])
            {

            }
            column(PurchSign_17_; FORMAT(PurchSign[17]))
            {
            }
            column(NewWeek_17_; NewWeek[17])
            {

            }
            column(Order_18_; Order[18])
            {

            }
            column(PurchaseNeeds_17_; PurchaseNeeds[17])
            {

            }
            column(PurchSign_18_; FORMAT(PurchSign[18]))
            {
            }
            column(NewWeek_18_; NewWeek[18])
            {

            }
            column(Order_19_; Order[19])
            {

            }
            column(PurchaseNeeds_18_; PurchaseNeeds[18])
            {

            }
            column(PurchSign_19_; FORMAT(PurchSign[19]))
            {
            }
            column(NewWeek_19_; NewWeek[19])
            {

            }
            column(Order_20_; Order[20])
            {

            }
            column(PurchaseNeeds_19_; PurchaseNeeds[19])
            {

            }
            column(PurchSign_20_; FORMAT(PurchSign[20]))
            {
            }
            column(NewWeek_20_; NewWeek[20])
            {

            }
            column(Order_21_; Order[21])
            {

            }
            column(PurchaseNeeds_20_; PurchaseNeeds[20])
            {

            }
            column(PurchSign_21_; FORMAT(PurchSign[21]))
            {
            }
            column(NewWeek_21_; NewWeek[21])
            {

            }
            column(Order_22_; Order[22])
            {

            }
            column(PurchaseNeeds_21_; PurchaseNeeds[21])
            {

            }
            column(PurchSign_22_; FORMAT(PurchSign[22]))
            {
            }
            column(NewWeek_22_; NewWeek[22])
            {

            }
            column(Order_23_; Order[23])
            {

            }
            column(PurchaseNeeds_22_; PurchaseNeeds[22])
            {

            }
            column(PurchSign_23_; FORMAT(PurchSign[23]))
            {
            }
            column(NewWeek_23_; NewWeek[23])
            {

            }
            column(Order_24_; Order[24])
            {

            }
            column(PurchaseNeeds_23_; PurchaseNeeds[23])
            {

            }
            column(PurchSign_24_; FORMAT(PurchSign[24]))
            {
            }
            column(NewWeek_24_; NewWeek[24])
            {

            }
            column(Order_25_; Order[25])
            {

            }
            column(PurchaseNeeds_24_; PurchaseNeeds[24])
            {

            }
            column(PurchSign_25_; FORMAT(PurchSign[25]))
            {
            }
            column(NewWeek_25_; NewWeek[25])
            {

            }
            column(OpenPOTotal; OpenPOTotal)
            {

            }
            column(QtyPurchased_1_; QtyPurchased[1])
            {

            }
            column(QtySold_1_; QtySold[1])
            {

            }
            column(QtyAdjusted_1_; QtyAdjusted[1])
            {

            }
            column(QtyPurchased_10_; QtyPurchased[10])
            {

            }
            column(QtyAdjusted_10_; QtyAdjusted[10])
            {
            }
            column(QtySold_10_; QtySold[10])
            {
            }
            column(QtyPurchased_11_; QtyPurchased[11])
            {

            }
            column(QtyAdjusted_11_; QtyAdjusted[11])
            {
            }
            column(QtySold_11_; QtySold[11])
            {
            }
            column(QtyPurchased_12_; QtyPurchased[12])
            {
            }
            column(QtyAdjusted_12_; QtyAdjusted[12])
            {
            }
            column(QtySold_12_; QtySold[12])
            {
            }
            column(QtyPurchased_13_; QtyPurchased[13])
            {
            }
            column(QtyAdjusted_13_; QtyAdjusted[13])
            {
            }
            column(QtySold_13_; QtySold[13])
            {
            }
            column(QtyPurchased_14_; QtyPurchased[14])
            {
            }
            column(QtyAdjusted_14_; QtyAdjusted[14])
            {
            }
            column(QtySold_14_; QtySold[14])
            {
            }
            column(QtyPurchased_15_; QtyPurchased[15])
            {
            }
            column(QtyAdjusted_15_; QtyAdjusted[15])
            {
            }
            column(QtySold_15_; QtySold[15])
            {
            }
            column(QtyPurchased_16_; QtyPurchased[16])
            {
            }
            column(QtySold_16_; QtySold[16])
            {
            }
            column(QtyAdjusted_16_; QtyAdjusted[16])
            {
            }
            column(QtyTransferred_1_; QtyTransferred[1])
            {

            }
            column(QtyTransferred_10_; QtyTransferred[10])
            {
            }
            column(QtyTransferred_11_; QtyTransferred[11])
            {
            }
            column(QtyTransferred_12_; QtyTransferred[12])
            {
            }
            column(QtyTransferred_13_; QtyTransferred[13])
            {
            }
            column(QtyTransferred_14_; QtyTransferred[14])
            {
            }
            column(QtyTransferred_15_; QtyTransferred[15])
            {
            }
            column(QtyTransferred_16_; QtyTransferred[16])
            {
            }
            column(QtyPurchased_17_; QtyPurchased[17])
            {
            }
            column(QtySold_17_; QtySold[17])
            {
            }
            column(QtyAdjusted_17_; QtyAdjusted[17])
            {
            }
            column(QtyTransferred_17_; QtyTransferred[17])
            {
            }
            column(QtyPurchased_18_; QtyPurchased[18])
            {
            }
            column(QtySold_18_; QtySold[18])
            {
            }
            column(QtyAdjusted_18_; QtyAdjusted[18])
            {
            }
            column(QtyTransferred_18_; QtyTransferred[18])
            {
            }
            column(QtyPurchased_19_; QtyPurchased[19])
            {
            }
            column(QtySold_19_; QtySold[19])
            {
            }
            column(QtyAdjusted_19_; QtyAdjusted[19])
            {
            }
            column(QtyTransferred_19_; QtyTransferred[19])
            {
            }
            column(QtyPurchased_20_; QtyPurchased[20])
            {
            }
            column(QtySold_20_; QtySold[20])
            {
            }
            column(QtyAdjusted_20_; QtyAdjusted[20])
            {
            }
            column(QtyTransferred_20_; QtyTransferred[20])
            {
            }
            column(QtyPurchased_21_; QtyPurchased[21])
            {
            }
            column(QtySold_21_; QtySold[21])
            {
            }
            column(QtyAdjusted_21_; QtyAdjusted[21])
            {
            }
            column(QtyTransferred_21_; QtyTransferred[21])
            {
            }
            column(QtyPurchased_22_; QtyPurchased[22])
            {
            }
            column(QtySold_22_; QtySold[22])
            {
            }
            column(QtyAdjusted_22_; QtyAdjusted[22])
            {
            }
            column(QtyTransferred_22_; QtyTransferred[22])
            {
            }
            column(QtyPurchased_23_; QtyPurchased[23])
            {
            }
            column(QtySold_23_; QtySold[23])
            {
            }
            column(QtyAdjusted_23_; QtyAdjusted[23])
            {
            }
            column(QtyTransferred_23_; QtyTransferred[23])
            {
            }
            column(QtyPurchased_24_; QtyPurchased[24])
            {
            }
            column(QtySold_24_; QtySold[24])
            {
            }
            column(QtyAdjusted_24_; QtyAdjusted[24])
            {
            }
            column(QtyTransferred_24_; QtyTransferred[24])
            {
            }
            column(QtyPurchased_25_; QtyPurchased[25])
            {
            }
            column(QtySold_25_; QtySold[25])
            {
            }
            column(QtyAdjusted_25_; QtyAdjusted[25])
            {
            }
            column(QtyTransferred_25_; QtyTransferred[25])
            {
            }
            column(Item__Unit_Price_; "Unit Price")
            {
            }
            column(Item__Unit_Cost_; "Unit Cost")
            {
            }
            column(Item__Manufacturer_Code_; "Manufacturer Code")
            {
            }
            column(Item__Gross_Weight_; "Gross Weight")
            {
            }
            column(Fore__Ave__Daily_Usage_Caption; Fore__Ave__Daily_Usage_CaptionLbl)
            {
            }
            column(Day_On_HandCaption; Day_On_HandCaptionLbl)
            {
            }
            column(Minimum_Order_Qty_Caption; Minimum_Order_Qty_CaptionLbl)
            {
            }
            column(Actual_Ave__Wkly__Usage__last_12weeks_Caption; Actual_Ave__Wkly__Usage__last_12weeks_CaptionLbl)
            {
            }
            column(Min_Inventory_Level_QtyCaption; Min_Inventory_Level_QtyCaptionLbl)
            {
            }
            column(Max__Inventory_Level_Qty_Caption; Max__Inventory_Level_Qty_CaptionLbl)
            {
            }
            column(WeeksCaption; WeeksCaptionLbl)
            {
            }
            column(WeeksCaption_Control1000000228; WeeksCaption_Control1000000228Lbl)
            {
            }
            column(WeeksCaption_Control1000000417; WeeksCaption_Control1000000417Lbl)
            {
            }
            column(Mimimum_Inventory_LevelCaption; Mimimum_Inventory_LevelCaptionLbl)
            {
            }
            column(Maximum_Inventory_LevelCaption; Maximum_Inventory_LevelCaptionLbl)
            {
            }
            column(Lead_TimeCaption; Lead_TimeCaptionLbl)
            {
            }
            column(Item__Vendor_No__Caption; FIELDCAPTION("Vendor No."))
            {
            }
            column(SNP__Units_Per_Parcel_Caption; SNP__Units_Per_Parcel_CaptionLbl)
            {
            }
            column(Ave__Forecast__Next_8_weeks_Caption; Ave__Forecast__Next_8_weeks_CaptionLbl)
            {
            }
            column(Blocked_Inv_Caption; Blocked_Inv_CaptionLbl)
            {
            }
            column(Over_120_DaysCaption; Over_120_DaysCaptionLbl)
            {
            }
            column(Qty__on_HandCaption; Qty__on_HandCaptionLbl)
            {
            }
            column(Suggested_ReceiptCaption; Suggested_ReceiptCaptionLbl)
            {
            }
            column(ForecastCaption; ForecastCaptionLbl)
            {
            }
            column(Suggested_Order_Qty_Caption; Suggested_Order_Qty_CaptionLbl)
            {
            }
            column(Qty__AvailableCaption; Qty__AvailableCaptionLbl)
            {
            }
            column(OPEN_P_O_Caption; OPEN_P_O_CaptionLbl)
            {
            }
            column(EXPEDITECaption; EXPEDITECaptionLbl)
            {
            }
            column(Weeks_on_HandCaption; Weeks_on_HandCaptionLbl)
            {
            }
            column(Qty__ReceivedCaption; Qty__ReceivedCaptionLbl)
            {
            }
            column(Sales_Invoice_LinesCaption; Sales_Invoice_LinesCaptionLbl)
            {
            }
            column(Qty__AdjustedCaption; Qty__AdjustedCaptionLbl)
            {
            }
            column(Qty__TransferredCaption; Qty__TransferredCaptionLbl)
            {
            }
            column(Item__Unit_Price_Caption; FIELDCAPTION("Unit Price"))
            {
            }
            column(Item__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
            {
            }
            column(ManufacturerCaption; ManufacturerCaptionLbl)
            {
            }
            column(Item__Gross_Weight_Caption; FIELDCAPTION("Gross Weight"))
            {
            }
            column(This_is_the_ENDCaption; This_is_the_ENDCaptionLbl)
            {
            }
            column(Item_Forecast_OnOff; Item."Forecast on/off")
            {
            }
            column(ShowDetails3; ShowDetails3)
            {
            }
            column(ShowDetails2; ShowDetails2)
            {
            }
            column(ShowDetails; ShowDetails)
            {
            }
            column(ForecastEntryFound; ForecastEntryFound)
            {
            }
            column(VendorNo_Cap; VendorNo_Cap)
            {
            }
            column(Forecast_BreakdownCaption; Forecast_BreakdownCaptionLbl)
            {
            }
            column(LotNo_Cap; LotNo_Cap)
            {
            }
            column(Inventory_Cap; Inventory_Cap)
            {
            }
            column(LotCreationDate_Cap; LotCreationDate_Cap)
            {
            }
            column(InvAge_Cap; InvAge_Cap)
            {
            }
            column(ShowAge; ShowAge)
            {
            }
            dataitem("Item Category"; "Item Category")
            {
                DataItemLink = Code = FIELD("Item Category Code");
                DataItemTableView = SORTING(Code);
                column(Code_Item_Category; Code)
                {
                }
            }
            dataitem("Forecast Ledger Entry"; "Forecast Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Division Code");
                PrintOnlyIfDetail = false;
                column(ForecastQty2_10_; ForecastQty2[10])
                {
                }
                column(ForecastQty2_11_; ForecastQty2[11])
                {
                }
                column(ForecastQty2_12_; ForecastQty2[12])
                {
                }
                column(ForecastQty2_13_; ForecastQty2[13])
                {
                }
                column(ForecastQty2_14_; ForecastQty2[14])
                {
                }
                column(ForecastQty2_15_; ForecastQty2[15])
                {
                }
                column(ForecastQty2_16_; ForecastQty2[16])
                {
                }
                column(ForecastQty2_17_; ForecastQty2[17])
                {
                }
                column(ForecastQty2_18_; ForecastQty2[18])
                {
                }
                column(ForecastQty2_19_; ForecastQty2[19])
                {
                }
                column(ForecastQty2_20_; ForecastQty2[20])
                {
                }
                column(ForecastQty2_21_; ForecastQty2[21])
                {
                }
                column(ForecastQty2_22_; ForecastQty2[22])
                {
                }
                column(ForecastQty2_23_; ForecastQty2[23])
                {
                }
                column(ForecastQty2_24_; ForecastQty2[24])
                {
                }
                column(ForecastQty2_25_; ForecastQty2[25])
                {
                }
                column(ForecastQty3_10_; ForecastQty3[10])
                {
                }
                column(ForecastQty3_11_; ForecastQty3[11])
                {
                }
                column(ForecastQty3_12_; ForecastQty3[12])
                {
                }
                column(ForecastQty3_13_; ForecastQty3[13])
                {
                }
                column(ForecastQty3_14_; ForecastQty3[14])
                {
                }
                column(ForecastQty3_15_; ForecastQty3[15])
                {
                }
                column(ForecastQty3_16_; ForecastQty3[16])
                {
                }
                column(ForecastQty3_17_; ForecastQty3[17])
                {
                }
                column(ForecastQty3_18_; ForecastQty3[18])
                {
                }
                column(ForecastQty3_19_; ForecastQty3[19])
                {
                }
                column(ForecastQty3_20_; ForecastQty3[20])
                {
                }
                column(ForecastQty3_21_; ForecastQty3[21])
                {
                }
                column(ForecastQty3_22_; ForecastQty3[22])
                {
                }
                column(ForecastQty3_23_; ForecastQty3[23])
                {
                }
                column(ForecastQty3_24_; ForecastQty3[24])
                {
                }
                column(ForecastQty3_25_; ForecastQty3[25])
                {
                }
                column(ForecastQty2_10__Control1000000271; ForecastQty2[10])
                {

                }
                column(ForecastQty2_11__Control1000000272; ForecastQty2[11])
                {

                }
                column(ForecastQty2_12__Control1000000273; ForecastQty2[12])
                {

                }
                column(ForecastQty2_13__Control1000000274; ForecastQty2[13])
                {

                }
                column(ForecastQty2_14__Control1000000291; ForecastQty2[14])
                {

                }
                column(ForecastQty2_15__Control1000000292; ForecastQty2[15])
                {

                }
                column(ForecastQty2_16__Control1000000326; ForecastQty2[16])
                {

                }
                column(Forecast_Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(ForecastQty2_17__Control1000000306; ForecastQty2[17])
                {

                }
                column(ForecastQty2_18__Control1000000307; ForecastQty2[18])
                {

                }
                column(ForecastQty2_19__Control1000000308; ForecastQty2[19])
                {

                }
                column(ForecastQty2_20__Control1000000336; ForecastQty2[20])
                {

                }
                column(ForecastQty2_21__Control1000000337; ForecastQty2[21])
                {

                }
                column(ForecastQty2_22__Control1000000338; ForecastQty2[22])
                {

                }
                column(ForecastQty2_23__Control1000000339; ForecastQty2[23])
                {

                }
                column(ForecastQty2_24__Control1000000340; ForecastQty2[24])
                {

                }
                column(ForecastQty2_25__Control1000000341; ForecastQty2[25])
                {

                }
                column(ForecastQty3_10__Control1000000404; ForecastQty3[10])
                {

                }
                column(ForecastQty3_11__Control1000000405; ForecastQty3[11])
                {

                }
                column(ForecastQty3_12__Control1000000406; ForecastQty3[12])
                {

                }
                column(ForecastQty3_13__Control1000000407; ForecastQty3[13])
                {

                }
                column(ForecastQty3_14__Control1000000408; ForecastQty3[14])
                {

                }
                column(ForecastQty3_15__Control1000000409; ForecastQty3[15])
                {

                }
                column(ForecastQty3_16__Control1000000410; ForecastQty3[16])
                {

                }
                column(Forecast_Ledger_Entry__Customer_No___Control1000000057; "Customer No.")
                {
                }
                column(ForecastQty3_17__Control1000000362; ForecastQty3[17])
                {

                }
                column(ForecastQty3_18__Control1000000363; ForecastQty3[18])
                {

                }
                column(ForecastQty3_19__Control1000000364; ForecastQty3[19])
                {

                }
                column(ForecastQty3_20__Control1000000365; ForecastQty3[20])
                {

                }
                column(ForecastQty3_21__Control1000000366; ForecastQty3[21])
                {

                }
                column(ForecastQty3_22__Control1000000367; ForecastQty3[22])
                {

                }
                column(ForecastQty3_23__Control1000000368; ForecastQty3[23])
                {

                }
                column(ForecastQty3_24__Control1000000369; ForecastQty3[24])
                {

                }
                column(ForecastQty3_25__Control1000000370; ForecastQty3[25])
                {

                }
                column(Nifast_ForecastCaption; Nifast_ForecastCaptionLbl)
                {
                }
                column(Forecast_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Forecast_Ledger_Entry_Item_No_; "Item No.")
                {
                }
                column(Forecast_Ledger_Entry_Shipping_Date; "Shipping Date")
                {
                }
                column(Forecast_Ledger_Entry_Forecast_Quantity; "Forecast Quantity")
                {
                }
                column(Forecast_Ledger_Entry_Division_Code; "Division Code")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    FOR i := 2 TO 61 DO
                        //SETCURRENTKEY("Entry No.","Item No.","Customer No.","Forecast Quantity","Shipping Date","Division Code");
                        //SETRANGE("Customer No.");
                        //CALCSUMS("Forecast Quantity");

                        IF ("Shipping Date" >= PeriodStartingDate[i]) AND
                          ("Shipping Date" < PeriodStartingDate[i + 1]) AND
                           ("Forecast Quantity" <> 0)
                           AND ("Nifast Forecast" = FALSE)

                        THEN
                            ForecastQty2[i] := "Forecast Quantity"


                        ELSE
                            ForecastQty2[i] := 0;

                    FOR i := 2 TO 61 DO
                        IF ("Shipping Date" >= PeriodStartingDate[i]) AND
                          ("Shipping Date" < PeriodStartingDate[i + 1]) AND
                           ("Forecast Quantity" <> 0)
                           AND ("Nifast Forecast" = TRUE)

                         THEN
                            ForecastQty3[i] := "Forecast Quantity"

                        ELSE
                            ForecastQty3[i] := 0;
                end;

                trigger OnPreDataItem()
                begin
                    // CurrReport.CREATETOTALS(ForecastQty2);
                    // CurrReport.CREATETOTALS(ForecastQty3);
                end;
            }
            dataitem(PurchOrderLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = false;
                column(QtyOnPurchOrdersDetail_10_; QtyOnPurchOrdersDetail[10])
                {
                }
                column(QtyOnPurchOrdersDetail_11_; QtyOnPurchOrdersDetail[11])
                {
                }
                column(QtyOnPurchOrdersDetail_12_; QtyOnPurchOrdersDetail[12])
                {
                }
                column(QtyOnPurchOrdersDetail_13_; QtyOnPurchOrdersDetail[13])
                {
                }
                column(QtyOnPurchOrdersDetail_14_; QtyOnPurchOrdersDetail[14])
                {
                }
                column(QtyOnPurchOrdersDetail_15_; QtyOnPurchOrdersDetail[15])
                {
                }
                column(PurchLine__Document_No__________PurchHeader__Buy_from_Vendor_Name_; PurchLine."Document No." + ':' + PurchHeader."Buy-from Vendor Name")
                {
                }
                column(QtyOnPurchOrdersDetail_16_; QtyOnPurchOrdersDetail[16])
                {
                }
                column(QtyOnPurchOrdersDetail_17_; QtyOnPurchOrdersDetail[17])
                {
                }
                column(QtyOnPurchOrdersDetail_18_; QtyOnPurchOrdersDetail[18])
                {
                }
                column(QtyOnPurchOrdersDetail_19_; QtyOnPurchOrdersDetail[19])
                {
                }
                column(QtyOnPurchOrdersDetail_20_; QtyOnPurchOrdersDetail[20])
                {
                }
                column(QtyOnPurchOrdersDetail_21_; QtyOnPurchOrdersDetail[21])
                {
                }
                column(QtyOnPurchOrdersDetail_22_; QtyOnPurchOrdersDetail[22])
                {
                }
                column(QtyOnPurchOrdersDetail_23_; QtyOnPurchOrdersDetail[23])
                {
                }
                column(QtyOnPurchOrdersDetail_24_; QtyOnPurchOrdersDetail[24])
                {
                }
                column(QtyOnPurchOrdersDetail_25_; QtyOnPurchOrdersDetail[25])
                {
                }
                column(QtyOnPurchOrders_10__Control1000000183; QtyOnPurchOrders[10])
                {
                }
                column(QtyOnPurchOrders_11__Control1000000184; QtyOnPurchOrders[11])
                {
                }
                column(QtyOnPurchOrders_12__Control1000000185; QtyOnPurchOrders[12])
                {
                }
                column(QtyOnPurchOrders_13__Control1000000186; QtyOnPurchOrders[13])
                {
                }
                column(QtyOnPurchOrders_14__Control1000000187; QtyOnPurchOrders[14])
                {
                }
                column(QtyOnPurchOrders_15__Control1000000188; QtyOnPurchOrders[15])
                {
                }
                column(QtyOnPurchOrders_16__Control1000000322; QtyOnPurchOrders[16])
                {
                }
                column(QtyOnPurchOrders_17__Control1000000384; QtyOnPurchOrders[17])
                {
                }
                column(QtyOnPurchOrders_18__Control1000000385; QtyOnPurchOrders[18])
                {
                }
                column(QtyOnPurchOrders_19__Control1000000386; QtyOnPurchOrders[19])
                {
                }
                column(QtyOnPurchOrders_20__Control1000000387; QtyOnPurchOrders[20])
                {
                }
                column(QtyOnPurchOrders_21__Control1000000388; QtyOnPurchOrders[21])
                {
                }
                column(QtyOnPurchOrders_22__Control1000000396; QtyOnPurchOrders[22])
                {
                }
                column(QtyOnPurchOrders_23__Control1000000397; QtyOnPurchOrders[23])
                {
                }
                column(QtyOnPurchOrders_24__Control1000000398; QtyOnPurchOrders[24])
                {
                }
                column(QtyOnPurchOrders_25__Control1000000399; QtyOnPurchOrders[25])
                {
                }
                column(Purchase_OrdersCaption; Purchase_OrdersCaptionLbl)
                {
                }
                column(Qty__on_Purchase_OrdersCaption; Qty__on_Purchase_OrdersCaptionLbl)
                {
                }
                column(PurchOrderLoop_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        PurchLine.FIND('-')
                    ELSE
                        PurchLine.NEXT;

                    CLEAR(QtyOnPurchOrdersDetail);
                    FOR i := 1 TO 61 DO
                        IF (PurchLine."Expected Receipt Date" >= PeriodStartingDate[i]) AND
                          (PurchLine."Expected Receipt Date" < PeriodStartingDate[i + 1])
                        THEN
                            QtyOnPurchOrdersDetail[i] := PurchLine."Outstanding Qty. (Base)";


                    IF NOT PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.") THEN
                        CLEAR(PurchHeader);
                end;

                trigger OnPreDataItem()
                begin
                    PurchLine.RESET;

                    PurchLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                            "Location Code", "Expected Receipt Date");
                    PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                    PurchLine.SETRANGE("No.", Item."No.");
                    PurchLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
                    SETRANGE(Number, 1, PurchLine.COUNT);
                end;
            }
            dataitem(SalesOrderLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = false;
                column(QtyOnSalesOrdersDetail_10_; QtyOnSalesOrdersDetail[10])
                {
                }
                column(QtyOnSalesOrdersDetail_11_; QtyOnSalesOrdersDetail[11])
                {
                }
                column(QtyOnSalesOrdersDetail_12_; QtyOnSalesOrdersDetail[12])
                {
                }
                column(QtyOnSalesOrdersDetail_13_; QtyOnSalesOrdersDetail[13])
                {
                }
                column(QtyOnSalesOrdersDetail_14_; QtyOnSalesOrdersDetail[14])
                {
                }
                column(QtyOnSalesOrdersDetail_15_; QtyOnSalesOrdersDetail[15])
                {
                }
                column(SalesLine__Document_No___________SalesHeader__Sell_to_Customer_Name_; SalesLine."Document No." + ':' + SalesHeader."Sell-to Customer Name")
                {
                }
                column(QtyOnSalesOrdersDetail_16_; QtyOnSalesOrdersDetail[16])
                {
                }
                column(QtyOnSalesOrdersDetail_17_; QtyOnSalesOrdersDetail[17])
                {
                }
                column(QtyOnSalesOrdersDetail_18_; QtyOnSalesOrdersDetail[18])
                {
                }
                column(QtyOnSalesOrdersDetail_19_; QtyOnSalesOrdersDetail[19])
                {
                }
                column(QtyOnSalesOrdersDetail_20_; QtyOnSalesOrdersDetail[20])
                {
                }
                column(QtyOnSalesOrdersDetail_21_; QtyOnSalesOrdersDetail[21])
                {
                }
                column(QtyOnSalesOrdersDetail_22_; QtyOnSalesOrdersDetail[22])
                {
                }
                column(QtyOnSalesOrdersDetail_23_; QtyOnSalesOrdersDetail[23])
                {
                }
                column(QtyOnSalesOrdersDetail_24_; QtyOnSalesOrdersDetail[24])
                {
                }
                column(QtyOnSalesOrdersDetail_25_; QtyOnSalesOrdersDetail[25])
                {
                }
                column(QtyOnSalesOrders_10_; QtyOnSalesOrders[10])
                {
                }
                column(QtyOnSalesOrders_11_; QtyOnSalesOrders[11])
                {
                }
                column(QtyOnSalesOrders_12_; QtyOnSalesOrders[12])
                {
                }
                column(QtyOnSalesOrders_13_; QtyOnSalesOrders[13])
                {
                }
                column(QtyOnSalesOrders_14_; QtyOnSalesOrders[14])
                {
                }
                column(QtyOnSalesOrders_15_; QtyOnSalesOrders[15])
                {
                }
                column(QtyOnSalesOrders_16_; QtyOnSalesOrders[16])
                {
                }
                column(QtyOnSalesOrders_17_; QtyOnSalesOrders[17])
                {
                }
                column(QtyOnSalesOrders_18_; QtyOnSalesOrders[18])
                {
                }
                column(QtyOnSalesOrders_19_; QtyOnSalesOrders[19])
                {
                }
                column(QtyOnSalesOrders_20_; QtyOnSalesOrders[20])
                {
                }
                column(QtyOnSalesOrders_21_; QtyOnSalesOrders[21])
                {
                }
                column(QtyOnSalesOrders_22_; QtyOnSalesOrders[22])
                {
                }
                column(QtyOnSalesOrders_23_; QtyOnSalesOrders[23])
                {
                }
                column(QtyOnSalesOrders_24_; QtyOnSalesOrders[24])
                {
                }
                column(QtyOnSalesOrders_25_; QtyOnSalesOrders[25])
                {
                }
                column(Sales_OrdersCaption; Sales_OrdersCaptionLbl)
                {
                }
                column(Qty__on_Sales_OrdersCaption; Qty__on_Sales_OrdersCaptionLbl)
                {
                }
                column(SalesOrderLoop_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        SalesLine.FIND('-')
                    ELSE
                        SalesLine.NEXT;

                    CLEAR(QtyOnSalesOrdersDetail);
                    FOR i := 2 TO 61 DO
                        IF (SalesLine."Shipment Date" >= PeriodStartingDate[i]) AND
                          (SalesLine."Shipment Date" < PeriodStartingDate[i + 1])
                        THEN
                            QtyOnSalesOrdersDetail[i] := SalesLine."Outstanding Qty. (Base)";

                    IF NOT SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                        CLEAR(SalesHeader);
                end;

                trigger OnPreDataItem()
                begin
                    SalesLine.RESET;

                    SalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Shipment Date");
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    SalesLine.SETRANGE("No.", Item."No.");
                    SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
                    SETRANGE(Number, 1, SalesLine.COUNT);
                end;
            }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = FIELD("Vendor No.");
                DataItemTableView = SORTING("No.");
                column(Vendor_Name; Name)
                {
                }
                column(Vendor_NameCaption; FIELDCAPTION(Name))
                {
                }
                column(Vendor_No_; "No.")
                {
                }
            }
            dataitem("Lot No. Information"; "Lot No. Information")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Variant Code", "Lot No.")
                                    WHERE(Inventory = FILTER(> 0));
                column(Lot_No__Information__Lot_No__; "Lot No.")
                {
                }
                column(Lot_No__Information_Inventory; Inventory)
                {
                }
                column(Lot_No__Information__Lot_Creation_Date_; FORMAT("Lot Creation Date"))
                {
                }
                column(Over; Over)
                {
                }
                column(Lot_No__Information_Item_No_; "Item No.")
                {
                }
                column(Lot_No__Information_Variant_Code; "Variant Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Over := TODAY - "Lot Creation Date";
                    IF (ExportToExcel) AND (Over > 120) THEN
                        MakeExcelLotInfoBody_lFnc;
                end;

                trigger OnPreDataItem()
                begin
                    IF (ExportToExcel) AND (COUNT <> 0) THEN
                        MakeExcelLotInfoHeader_lFnc;
                end;
            }
            dataitem("Vehicle Production"; "Vehicle Production")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Active, "Item No.", Model, EMU, Per);

                trigger OnAfterGetRecord()
                begin
                    IF ExportToExcel THEN
                        MakeExcelVehicleProdBody_lFnc;
                end;

                trigger OnPostDataItem()
                begin
                    IF ExportToExcel AND (COUNT > 0) THEN BEGIN
                        MakeExcelENDLine_lFnc;
                        HideNewLineInItem_gBln := TRUE;
                        EndLineExecute_gBln := TRUE;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    HideNewLineInItem_gBln := FALSE;
                    EndLineExecute_gBln := FALSE;
                    IF ExportToExcel AND (COUNT > 0) THEN
                        MakeExcelVehicleProdHeader_lFnc;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ItemLedgerEntry.RESET;
                ForecastLedgerEntry.RESET;
                WarehouseEntry.RESET;



                MinimumInv := "Minimum Inventory Level";
                MaximumInv := "Maximum Inventory Level";
                MinOrdQ := "Order Qty.";
                SNP := "Units per Parcel";




                CLEAR(QtyAdjusted);
                CLEAR(QtyOnPurchOrders);
                CLEAR(OnHand);
                CLEAR(PurchaseNeeds);
                CLEAR(Order);
                CLEAR(PurchSign);
                CLEAR(WeekOnHand);
                CLEAR(AveForecast);
                CLEAR(MaxInvQ);
                CLEAR(BQ);
                T := TODAY;


                //////BLOCK BIN CALCULATION START
                WarehouseEntry.SETCURRENTKEY("Bin Code", "Location Code", "Item No.");
                WarehouseEntry.SETRANGE("Item No.", "No.");
                WarehouseEntry.SETFILTER("Bin Code", 'Q1-01-1..R0-REPACK');

                WarehouseEntry.CALCSUMS("Qty. (Base)");
                BQ := WarehouseEntry."Qty. (Base)";

                //////BLOCK BIN CALCULATION END

                ForecastLedgerEntry.SETRANGE("Item No.", "No.");
                ForecastLedgerEntry.SETRANGE("Customer No.");
                ForecastLedgerEntry.SETRANGE("Shipping Date", PeriodStartingDate[11], PeriodStartingDate[19] - 1);
                ForecastLedgerEntry.CALCSUMS("Forecast Quantity");

                //average weekly by forecasted usage(8 weeks)
                AveForecast := ROUND(ForecastLedgerEntry."Forecast Quantity" / 8, 1, '>');

                FOR i := 1 TO 61 DO BEGIN
                    IF i = 1 THEN BEGIN


                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Posting Date", 0D, PeriodStartingDate[10] - 1);
                        // ItemLedgerEntry.SETRANGE("Location Code",'Mich');
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        OnHand[10] := ItemLedgerEntry.Quantity - BQ;


                        ItemLedgerEntry.SETRANGE("Location Code", 'OTW-IT');
                        //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'MPD');
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        OTW[10] := ItemLedgerEntry.Quantity;

                        TotalForecast[9] := OnHand[10] - OTW[10];


                        ForecastQty[9] := 0;
                        ForecastQty[8] := 0;
                        ForecastQty[7] := 0;
                        ForecastQty[6] := 0;
                        ForecastQty[5] := 0;
                        ForecastQty[4] := 0;
                        ForecastQty[3] := 0;
                        ForecastQty[2] := 0;
                        ForecastQty[1] := 0;

                        PurchLine.SETCURRENTKEY("Document Type", "No.", "Expected Receipt Date", "Shortcut Dimension 1 Code", "Outstanding Quantity", Type);

                        COPYFILTER("Global Dimension 1 Filter", PurchLine."Shortcut Dimension 1 Code");
                        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                        PurchLine.SETRANGE("No.", "No.");


                        PurchLine.SETRANGE("Expected Receipt Date", 0D, PeriodStartingDate[2] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[1] := PurchLine."Outstanding Qty. (Base)";

                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[2], PeriodStartingDate[3] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[2] := PurchLine."Outstanding Qty. (Base)";


                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[3], PeriodStartingDate[4] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[3] := PurchLine."Outstanding Qty. (Base)";


                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[4], PeriodStartingDate[5] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[4] := PurchLine."Outstanding Qty. (Base)";


                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[5], PeriodStartingDate[6] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[5] := PurchLine."Outstanding Qty. (Base)";

                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[6], PeriodStartingDate[7] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[6] := PurchLine."Outstanding Qty. (Base)";


                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[7], PeriodStartingDate[8] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[7] := PurchLine."Outstanding Qty. (Base)";


                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[8], PeriodStartingDate[9] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[8] := PurchLine."Outstanding Qty. (Base)";

                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[9], PeriodStartingDate[10] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[9] := PurchLine."Outstanding Qty. (Base)";

                        PurchLine.SETRANGE("Expected Receipt Date", PeriodStartingDate[10], PeriodStartingDate[11] - 1);
                        PurchLine.SETRANGE("Outstanding Quantity", 1, 100000000);
                        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
                        PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        QtyOnPurchOrders[10] := PurchLine."Outstanding Qty. (Base)";




                        //Entry Type,Item No.,Variant Code,Drop Shipment,Location Code,Posting Date,QC Hold

                    END ELSE
                        IF i = 2 THEN BEGIN
                            //ItemLedgerEntry.SETCURRENTKEY("Entry Type","Item No.","Variant Code","Drop Shipment",
                            //                              "Global Dimension 1 Code","Global Dimension 2 Code","Location Code","Posting Date","QC Hold");
                            //COPYFILTER("Global Dimension 1 Filter",ItemLedgerEntry."Global Dimension 1 Code");
                            //COPYFILTER("Location Filter",ItemLedgerEntry."Location Code");
                            //ItemLedgerEntry.SETRANGE("Item No.","No.");
                            //ItemLedgerEntry.SETRANGE("Posting Date",0D,PeriodStartingDate[3] - 1);

                            //ItemLedgerEntry.CALCSUMS(Quantity);
                            //OnHand[6] := TotalForecast[5];

                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[1], PeriodStartingDate[2] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[1], PeriodStartingDate[2] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            //  QtySold[1] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[1] := "Purchases (Qty.)";
                            QtyTransferred[1] := "Transferred (Qty.)";


                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[2], PeriodStartingDate[3] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[2], PeriodStartingDate[3] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[2] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[2] := "Purchases (Qty.)";
                            QtyTransferred[2] := "Transferred (Qty.)";

                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[3], PeriodStartingDate[4] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[3], PeriodStartingDate[4] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[3] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[3] := "Purchases (Qty.)";
                            QtyTransferred[3] := "Transferred (Qty.)";

                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[4], PeriodStartingDate[5] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[4], PeriodStartingDate[5] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[4] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[4] := "Purchases (Qty.)";
                            QtyTransferred[4] := "Transferred (Qty.)";

                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[5], PeriodStartingDate[6] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[5], PeriodStartingDate[6] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[5] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[5] := "Purchases (Qty.)";
                            QtyTransferred[5] := "Transferred (Qty.)";

                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[6], PeriodStartingDate[7] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[6], PeriodStartingDate[7] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[6] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[6] := "Purchases (Qty.)";
                            QtyTransferred[6] := "Transferred (Qty.)";


                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[7], PeriodStartingDate[8] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[7], PeriodStartingDate[8] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[7] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[7] := "Purchases (Qty.)";
                            QtyTransferred[7] := "Transferred (Qty.)";


                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[8], PeriodStartingDate[9] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[8], PeriodStartingDate[9] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[8] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[8] := "Purchases (Qty.)";
                            QtyTransferred[8] := "Transferred (Qty.)";

                            //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[9], PeriodStartingDate[10] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE("Location Code", 'CNF');
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[9], PeriodStartingDate[10] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              //"Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtySold[9] := "Sales (Qty.)";
                            // QtyOnSalesOrders[2] := "Qty. on Sales Order";
                            // QtyOnPurchOrders[2] := "Qty. on Purch. Order";
                            QtyPurchased[9] := "Purchases (Qty.)";
                            QtyTransferred[9] := "Transferred (Qty.)";

                            OnHand[9] := TotalForecast[9] - QtyPurchased[9] - QtyTransferred[9] + QtySold[9];
                            TotalForecast[8] := OnHand[9];


                            OnHand[8] := TotalForecast[8] - QtyPurchased[8] - QtyTransferred[8] + QtySold[8];
                            TotalForecast[7] := OnHand[8];

                            OnHand[7] := TotalForecast[7] - QtyPurchased[7] - QtyTransferred[7] + QtySold[7];
                            TotalForecast[6] := OnHand[7];

                            OnHand[6] := TotalForecast[6] - QtyPurchased[6] - QtyTransferred[6] + QtySold[6];
                            TotalForecast[5] := OnHand[6];

                            OnHand[5] := TotalForecast[5] - QtyPurchased[5] - QtyTransferred[5] + QtySold[5];
                            TotalForecast[4] := OnHand[5];

                            OnHand[4] := TotalForecast[4] - QtyPurchased[4] - QtyTransferred[4] + QtySold[4];
                            TotalForecast[3] := OnHand[4];

                            OnHand[3] := TotalForecast[3] - QtyPurchased[3] - QtyTransferred[3] + QtySold[3];
                            TotalForecast[2] := OnHand[3];


                            OnHand[2] := TotalForecast[2] - QtyPurchased[2] - QtyTransferred[2] + QtySold[2];
                            TotalForecast[1] := OnHand[2];


                            OnHand[1] := TotalForecast[1] - QtyPurchased[1] - QtyTransferred[1] + QtySold[1];
                            //TotalForecast[1]:=OnHand[2];




                            //Entry Type,Item No.,Variant Code,Drop Shipment,Location Code,Posting Date,QC Hold

                        END ELSE
                            IF i = 10 THEN BEGIN
                                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                              "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                ItemLedgerEntry.SETRANGE("Posting Date", 0D, PeriodStartingDate[11] - 1);

                                //ItemLedgerEntry.SETRANGE("Location Code",'Mich');
                                ItemLedgerEntry.CALCSUMS(Quantity);
                                //OnHand[9] := OnHand[8];




                                //Average Weekly USAGE(Last 90days) starts----------------------------------------------------------------
                                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                              "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                                COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[10] - 84, PeriodStartingDate[10] - 1);
                                ItemLedgerEntry.CALCSUMS(Quantity);
                                Weekly90 := ROUND(-ItemLedgerEntry.Quantity / 12, 1, '>');

                                ///FORECAST vs HISTORY calculation (2/1/08)
                                IF AveForecast > 0 THEN BEGIN
                                    Maintain := AveForecast * MinimumInv;
                                END ELSE
                                    IF AveForecast = 0 THEN BEGIN
                                        Maintain := Weekly90 * MinimumInv;
                                    END;
                                ///FORECAST vs HISTORY end

                                //Average Weekly USAGE(Last 90days) ends----------------------------------------------------------------



                                //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                              "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[10], PeriodStartingDate[11] - 1);
                                //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');
                                // ItemLedgerEntry.SETRANGE("Location Code",'Mich');

                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                                ItemLedgerEntry.CALCSUMS(Quantity);
                                QtyTransferred[10] := ItemLedgerEntry.Quantity;

                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.CALCSUMS(Quantity);
                                QtySold[10] := -ItemLedgerEntry.Quantity;

                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.CALCSUMS(Quantity);
                                "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                                //QtyTransferred[10] := ItemLedgerEntry.Quantity;
                                SETRANGE("Date Filter", PeriodStartingDate[9], PeriodStartingDate[10] - 1);

                                CALCFIELDS(
                                   "Qty. on Sales Order", "Qty. on Purch. Order");
                                //"Qty. on Sales Order","Qty. on Purch. Order",
                                //  "Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                                // "Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)");
                                //QtyTransferred[9] := "Transferred (Qty.)";
                                //QtySold[9] := "Sales (Qty.)";
                                // QtyOnSalesOrders[9] := "Qty. on Sales Order";
                                // QtyOnPurchOrders[9] := "Qty. on Purch. Order";
                                QtyPurchased[10] := "Purchases (Qty.)";

                                // QtyOnPosAdj[9] := "Positive Adjmt. (Qty.)";
                                // QtyOnNegAdj[9]:="Negative Adjmt. (Qty.)";


                                //Entry No.,Item No.,Customer No.,Forecast Quantity,Shipping Date,Division Code
                                ForecastLedgerEntry.SETCURRENTKEY("Entry No.", "Item No.", "Customer No.", "Shipping Date", "Forecast Quantity", "Division Code");
                                COPYFILTER("Global Dimension 1 Filter", ForecastLedgerEntry."Division Code");
                                ForecastLedgerEntry.SETRANGE("Item No.", "No.");
                                ForecastLedgerEntry.SETRANGE("Customer No.");
                                ForecastLedgerEntry.SETRANGE("Shipping Date", PeriodStartingDate[10], PeriodStartingDate[11] - 1);

                                ForecastLedgerEntry.CALCSUMS("Forecast Quantity");




                                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                              "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                                COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[10], PeriodStartingDate[11] - 1);
                                // ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'TENN');
                                //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');

                                SETRANGE("Date Filter", PeriodStartingDate[9], PeriodStartingDate[10] - 1);

                                CALCFIELDS(
                                  "Qty. on Sales Order", "Qty. on Purch. Order",
                                  "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)", "Transferred (Qty.)");
                                QtyOnSalesOrders[10] := "Qty. on Sales Order";
                                // QtyOnPurchOrders[10] := "Qty. on Purch. Order";
                                //  QtyTransferred[9] := "Transferred (Qty.)";

                                IF ForecastLedgerEntry."Forecast Quantity" - QtySold[10] - QtyOnSalesOrders[10] >= 0 THEN BEGIN
                                    ForecastQty[10] := ForecastLedgerEntry."Forecast Quantity" - QtySold[10] - QtyOnSalesOrders[10];

                                END ELSE
                                    IF ForecastLedgerEntry."Forecast Quantity" - QtySold[10] - QtyOnSalesOrders[10] < 0 THEN BEGIN
                                        ForecastQty[10] := 0;

                                    END;


                                IF ForecastQty[10] > 0 THEN BEGIN
                                    TotalForecast[10] := OnHand[10] - ForecastQty[10] + QtyOnPurchOrders[10] - QtyOnSalesOrders[10]
                                    + QtyPurchased[10] - QtySold[10] + QtyTransferred[10];
                                    // +QtyOnNegAdj[9]+QtyOnPosAdj[9];
                                    // +QtyPurchased[9] - QtySold[9]-OTW[9]+OTW[1]+MPD[1]-MPD[2]+DIVIT[1]-DIVIT[2];

                                END ELSE
                                    IF ForecastQty[10] = 0 THEN BEGIN
                                        TotalForecast[10] := OnHand[10] + QtyOnPurchOrders[10] - QtyOnSalesOrders[10]
                                        + QtyPurchased[10] - QtySold[10] + QtyTransferred[10];
                                        // +QtyOnNegAdj[2]+QtyOnPosAdj[2];
                                        //+QtyPurchased[2] - QtySold[2]-OTW[2]+OTW[1]+MPD[1]-MPD[2]+DIVIT[1]-DIVIT[2];
                                    END;

                                //New Version on 5/31/07

                                IF (MinOrdQ <= -(TotalForecast[10] - MaxInvQ)) AND
                                //(TotalForecast[2]+MPD[2]+OTW[2]+DIVIT[2]<Maintain) AND (AveForecast>0)THEN  BEGIN
                                (TotalForecast[10] < Maintain) AND (SNP > 0) THEN BEGIN
                                    PurchaseNeeds[10] := SNP * ROUND((MaxInvQ - (TotalForecast[10])) / SNP, 1, '>');

                                END ELSE
                                    IF (MinOrdQ > (MaxInvQ - TotalForecast[10])) AND
                           //(TotalForecast[2]+MPD[2]+OTW[2]+DIVIT[2]<Maintain) AND (AveForecast>0)THEN  BEGIN
                           (TotalForecast[10] < Maintain) AND (SNP > 0) THEN BEGIN
                                        PurchaseNeeds[10] := SNP * ROUND((MinOrdQ) / SNP, 1, '>');

                                    END;


                                IF AveForecast <> 0 THEN BEGIN
                                    WeekOnHand[10] := (OnHand[10] + QtyPurchased[10] + QtyTransferred[10] + QtyOnPurchOrders[10]) / (AveForecast);
                                    NewWeek[10] := FORMAT(ROUND(WeekOnHand[10], 0.1));

                                END ELSE
                                    IF (AveForecast = 0) AND (Weekly90 > 0) THEN BEGIN
                                        WeekOnHand[10] := (OnHand[10] + QtyPurchased[10] + QtyTransferred[10] + QtyOnPurchOrders[10]) / (Weekly90);
                                        NewWeek[10] := FORMAT(ROUND(WeekOnHand[10], 0.1));


                                        //NewWeek[2]:='N/A';

                                    END;


                            END ELSE
                                IF i > 10 THEN BEGIN
                                    ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                                  "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                    COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                    //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                                    COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                    ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                    ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                                    ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                    ItemLedgerEntry.CALCSUMS(Quantity);
                                    "Sales (Qty.)" := -ItemLedgerEntry.Quantity;
                                    ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                    ItemLedgerEntry.CALCSUMS(Quantity);
                                    "Purchases (Qty.)" := ItemLedgerEntry.Quantity;
                                    IF i = 11 THEN BEGIN
                                        //>> NF1.00:CIS.CM  09/29/15
                                        //OnHand[i] := TotalForecast[i-1]+"Qty. on Prod. Kit Lines";
                                        OnHand[i] := TotalForecast[i - 1];
                                        //<< NF1.00:CIS.CM  09/29/15
                                    END;

                                    IF i <> 11 THEN BEGIN
                                        OnHand[i] := TotalForecast[i - 1];
                                    END;

                                    //OnHand[i] := TotalForecast[i-1]+PurchaseNeeds[i-1]+OTW[i-1]+DIVIT[i-1]+MPD[i-1];
                                    //April 24 2007 added
                                    ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                                  "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                    COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                    //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                                    COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                    ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                    ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);



                                    //QTYSOLD
                                    ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                                  "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                                    COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                                    //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                                    COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                                    ItemLedgerEntry.SETRANGE("Item No.", "No.");
                                    ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                                    // ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'TENN');
                                    // ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');

                                    SETRANGE("Date Filter", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);

                                    CALCFIELDS(
                                      "Qty. on Sales Order", "Qty. on Purch. Order",
                                      "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)", "Transferred (Qty.)");

                                    QtySold[i] := "Sales (Qty.)";


                                    //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                    ForecastLedgerEntry.SETRANGE("Item No.", "No.");
                                    ForecastLedgerEntry.SETRANGE("Customer No.");
                                    ForecastLedgerEntry.SETRANGE("Shipping Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                                    ForecastLedgerEntry.CALCSUMS("Forecast Quantity");

                                    //  ForecastQty[i]:=ForecastLedgerEntry."Forecast Quantity"-QtySold[i]- QtyOnSalesOrders[i];

                                    //    IF (PeriodStartingDate[i]>=T) THEN BEGIN
                                    //    ForecastQty[i]:=ForecastLedgerEntry."Forecast Quantity";

                                    //        END ELSE IF (PeriodStartingDate[i]<T) THEN BEGIN
                                    //    ForecastQty[i]:=0;
                                    //          END;

                                    TotalForecast2 := ForecastQty[17] + ForecastQty[18] + ForecastQty[19] + ForecastQty[20] + ForecastQty[21] + ForecastQty[22]
                                    + ForecastQty[23] + ForecastQty[24] + ForecastQty[25] + ForecastQty[26] + ForecastQty[27];


                                END;

                    ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                  "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                    COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                    //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                    COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                    ItemLedgerEntry.SETRANGE("Item No.", "No.");
                    ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                    // ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'TENN');
                    //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');

                    SETRANGE("Date Filter", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                    CALCFIELDS(
                      "Qty. on Sales Order", "Qty. on Purch. Order",
                      "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)", "Transferred (Qty.)");
                    QtyOnSalesOrders[i] := "Qty. on Sales Order";
                    QtyOnPurchOrders[i] := "Qty. on Purch. Order";

                    IF ForecastLedgerEntry."Forecast Quantity" - QtySold[i] - QtyOnSalesOrders[i] >= 0 THEN BEGIN
                        ForecastQty[i] := ForecastLedgerEntry."Forecast Quantity" - QtySold[i] - QtyOnSalesOrders[i];

                    END ELSE
                        IF ForecastLedgerEntry."Forecast Quantity" - QtySold[i] - QtyOnSalesOrders[i] < 0 THEN BEGIN
                            ForecastQty[i] := 0
                        END;

                    IF i = 1 THEN BEGIN
                        QtySold[1] := 0;
                        QtyPurchased[1] := 0;
                        QtyAdjusted[1] := 0;
                        QtyTransferred[1] := 0;
                        QtyAvailable[1] := OnHand[1] + QtyOnPurchOrders[1] - QtyOnSalesOrders[1] - QtyOnForecast[1];


                    END ELSE
                        IF i > 10 THEN BEGIN
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date", "QC Hold");
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);
                            // ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'TENN');
                            //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');

                            SETRANGE("Date Filter", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)", "Transferred (Qty.)");



                            QtySold[i] := "Sales (Qty.)";
                            QtyPurchased[i] := "Purchases (Qty.)";

                            QtyAdjusted[i] := "Positive Adjmt. (Qty.)" - "Negative Adjmt. (Qty.)";
                            QtyTransferred[i] := "Transferred (Qty.)";

                            QtyAvailable[i] := OnHand[i] + QtyOnPurchOrders[i] - QtyOnSalesOrders[i] - QtyOnForecast[i]
                             + QtyPurchased[i] - QtySold[i] + QtyAdjusted[i] + QtyTransferred[i];



                            //Total(Include Forecast)
                            IF ForecastQty[i] > 0 THEN BEGIN
                                TotalForecast[i] := OnHand[i] - ForecastQty[i] + QtyOnPurchOrders[i] - QtyOnSalesOrders[i]
                                + QtyPurchased[i] - QtySold[i] + QtyAdjusted[i] + QtyTransferred[i];


                            END ELSE
                                IF ForecastQty[i] <= 0 THEN BEGIN
                                    TotalForecast[i] := OnHand[i] + QtyOnPurchOrders[i] - QtyOnSalesOrders[i]
                                    + QtyPurchased[i] - QtySold[i] + QtyAdjusted[i] + QtyTransferred[i];
                                END;


                            //WeekonHand
                            IF AveForecast <> 0 THEN BEGIN
                                WeekOnHand[i] := (OnHand[i] + QtyPurchased[i] + QtyTransferred[i] + QtyOnPurchOrders[i]) / (AveForecast);
                                //WeekOnHand[i]:= TotalForecast[i]/(AveForecast);
                                NewWeek[i] := FORMAT(ROUND(WeekOnHand[i], 0.1));

                            END ELSE
                                IF (AveForecast = 0) AND (Weekly90 > 0) THEN BEGIN
                                    WeekOnHand[i] := (OnHand[i] + QtyPurchased[i] + QtyTransferred[i] + QtyOnPurchOrders[i]) / (Weekly90);
                                    //WeekOnHand[i]:= TotalForecast[i]/(AveForecast);
                                    NewWeek[i] := FORMAT(ROUND(WeekOnHand[i], 0.1));


                                    //NewWeek[i]:='N/A';

                                END;



                            //Day On Hand -----------------------------------------

                            Daily42 := AveForecast / 5;

                            IF Daily42 = 0 THEN BEGIN
                                DayOnHand := 0;
                            END ELSE
                                IF Daily42 <> 0 THEN BEGIN
                                    DayOnHand := OnHand[10] / Daily42;
                                END;

                            //Purchase Needs Calculation
                            IF (AveForecast > 0) AND (MaximumInv * AveForecast > (MinOrdQ + Maintain)) OR (SNP = 0) THEN BEGIN
                                MaxInvQ := MaximumInv * AveForecast

                            END ELSE
                                IF (AveForecast > 0) AND (MaximumInv * AveForecast <= (MinOrdQ + Maintain)) THEN BEGIN
                                    MaxInvQ := MaximumInv * AveForecast

                                END ELSE
                                    IF (AveForecast = 0) AND (Weekly90 > 0) THEN BEGIN
                                        MaxInvQ := MaximumInv * Weekly90

                                        //END ELSE IF (MaximumInv*AveForecast<=(MinOrdQ+Maintain)) THEN BEGIN
                                        //MaxInvQ:= MinOrdQ+Maintain

                                    END;

                            LT := "Lead Time";

                            IF (MinOrdQ <= -(TotalForecast[i] - MaxInvQ)) AND
                            //(TotalForecast[i]<Maintain) AND (AveForecast>0)THEN  BEGIN
                            (TotalForecast[i] < Maintain) AND (SNP > 0) THEN BEGIN
                                PurchaseNeeds[i] := SNP * ROUND((MaxInvQ - (TotalForecast[i])) / SNP, 1, '>');

                            END ELSE
                                IF (MinOrdQ > (MaxInvQ - TotalForecast[i])) AND
                       //(TotalForecast[i]<Maintain) AND (AveForecast>0)THEN  BEGIN
                       (TotalForecast[i] < Maintain) AND (SNP > 0) THEN BEGIN
                                    PurchaseNeeds[i] := SNP * ROUND((MinOrdQ) / SNP, 1, '>');

                                END;

                            //   IF (i>LT+1) AND (MinOrdQ<=-(TotalForecast[i]-MaxInvQ)) AND (TotalForecast[i]<Maintain) AND (SNP<>0)THEN  BEGIN
                            //   PurchaseNeeds[i]:= SNP*ROUND((MaxInvQ-TotalForecast[i])/SNP,1,'>')

                            //   END ELSE IF (i>LT+1) AND (MinOrdQ>(MaxInvQ-TotalForecast[i])) AND (TotalForecast[i]<Maintain) THEN  BEGIN
                            //   PurchaseNeeds[i]:=SNP*ROUND((MinOrdQ)/SNP,1,'>')

                            //   END ELSE IF (i<=LT+1) THEN BEGIN
                            //   PurchaseNeeds[i]:=0

                            //  END;

                            //Purchase YES/NO
                            IF (i <= LT + 1) AND (TotalForecast[i] < Maintain) THEN BEGIN
                                PurchSign[i] := TRUE;
                            END;

                            OpenPOTotal := QtyOnPurchOrders[1] + QtyOnPurchOrders[2] + QtyOnPurchOrders[3] + QtyOnPurchOrders[4] + QtyOnPurchOrders[5]
                            + QtyOnPurchOrders[6] + QtyOnPurchOrders[7] + QtyOnPurchOrders[8] + QtyOnPurchOrders[9];

                            //Order Timing
                            IF (LT = 1) THEN BEGIN
                                Order[9] := PurchaseNeeds[10];
                            END ELSE
                                IF (LT = 2) THEN BEGIN
                                    Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11];

                                END ELSE
                                    IF (LT = 3) THEN BEGIN
                                        Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12];

                                    END ELSE
                                        IF (LT = 4) THEN BEGIN
                                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13];

                                        END ELSE
                                            IF (LT = 5) THEN BEGIN
                                                Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                         PurchaseNeeds[14];

                                            END ELSE
                                                IF (LT = 6) THEN BEGIN
                                                    Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                             PurchaseNeeds[14] + PurchaseNeeds[15];

                                                END ELSE
                                                    IF (LT = 7) THEN BEGIN
                                                        Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                                 PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16];

                                                    END ELSE
                                                        IF (LT = 8) THEN BEGIN
                                                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                                     PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17];

                                                        END ELSE
                                                            IF (LT = 9) THEN BEGIN
                                                                Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                                         PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18];

                                                            END ELSE
                                                                IF (LT = 10) THEN BEGIN
                                                                    Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                                             PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18] + PurchaseNeeds[19];

                                                                END ELSE
                                                                    IF (LT = 11) THEN BEGIN
                                                                        Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                                                PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18] + PurchaseNeeds[19]
                                                                                 + PurchaseNeeds[20];

                                                                    END ELSE
                                                                        IF (LT = 12) THEN BEGIN
                                                                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                                                                    PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18] + PurchaseNeeds[19]
                                                                                     + PurchaseNeeds[20] + PurchaseNeeds[21];

                                                                        END ELSE
                                                                            IF (LT = 13) THEN BEGIN
                                                                                Order[9] := PurchaseNeeds[22] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                        PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                         + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21];

                                                                            END ELSE
                                                                                IF (LT = 14) THEN BEGIN
                                                                                    Order[9] := PurchaseNeeds[23] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                            PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                             + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22];

                                                                                END ELSE
                                                                                    IF (LT = 15) THEN BEGIN
                                                                                        Order[9] := PurchaseNeeds[24] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                                PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                                 + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23];

                                                                                    END ELSE
                                                                                        IF (LT = 16) THEN BEGIN
                                                                                            Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24];

                                                                                        END ELSE
                                                                                            IF (LT = 17) THEN BEGIN
                                                                                                Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                                        PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                                         + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                                                                                         + PurchaseNeeds[26];

                                                                                            END ELSE
                                                                                                IF (LT = 18) THEN BEGIN
                                                                                                    Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                                            PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                                             + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                                                                                             + PurchaseNeeds[26] + PurchaseNeeds[27];

                                                                                                END ELSE
                                                                                                    IF (LT = 19) THEN BEGIN
                                                                                                        Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                                                PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                                                 + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                                                                                                 + PurchaseNeeds[26] + PurchaseNeeds[27] + PurchaseNeeds[28];

                                                                                                    END ELSE
                                                                                                        IF (LT = 20) THEN BEGIN
                                                                                                            Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                                                                                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                                                                                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                                                                                                     + PurchaseNeeds[26] + PurchaseNeeds[27] + PurchaseNeeds[28] + PurchaseNeeds[29];



                                                                                                        END;



                            IF (i - LT > 0) AND (i > 10) THEN BEGIN

                                Order[i - LT] := PurchaseNeeds[i];
                            END;




                            IF (QtySold[i] <> 0) THEN BEGIN
                                PrintSales := TRUE;
                                PrintFooter := TRUE;
                            END;
                            IF (QtyPurchased[i] <> 0) THEN BEGIN
                                PrintPurch := TRUE;
                                PrintFooter := TRUE;
                            END;
                            IF (QtyAdjusted[i] <> 0) THEN BEGIN
                                PrintAdj := TRUE;
                                PrintFooter := TRUE;
                            END;
                            IF (QtyTransferred[i] <> 0) THEN BEGIN
                                PrintTrans := TRUE;
                                PrintFooter := TRUE;
                            END;
                        END;
                END;
                IF ExportToExcel THEN BEGIN
                    CLEAR(ForeCastEntryExist_gBln);
                    CLEAR(PurchLineExist_gBln);
                    CLEAR(SalesLineExist_gBln);
                    IF Vendor_gRec.GET("Vendor No.") THEN;
                    CalculateQty_lFnc;
                    MakeExcelDataHeader_lFnc;
                    MakeExcelItemDataBody_lFnc;
                END;
            end;

            trigger OnPostDataItem()
            begin
                InvtQty := ItemLedgerEntry."Remaining Quantity";
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PeriodStartingDate_2; PeriodStartingDate[2])
                    {
                        Caption = 'Starting Date';
                    }
                    field(PeriodCalculation; PeriodCalculation)
                    {
                        Caption = 'Length Of Period';
                    }
                    field(ExportToExcel; ExportToExcel)
                    {
                        Caption = 'Export To Excel';
                    }
                    field(ShowDetails; ShowDetails)
                    {
                        Caption = 'Customer, Sales, Purchase Details';
                    }
                    field(ShowDetailDetroit; ShowDetailDetroit)
                    {
                        Caption = 'Cross Ref. Info.';
                    }
                    field(ShowAge; ShowAge)
                    {
                        Caption = 'Show Inventory Age';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        IF PeriodCalculation = '' THEN
            PeriodCalculation := '1W';
    end;

    trigger OnPostReport()
    begin
        IF ExportToExcel THEN BEGIN
            IF NOT EndLineExecute_gBln THEN
                MakeExcelENDLine_lFnc;  //NF1.00:CIS.NG  07-18-16
            //ExcelBuf_gRecTmp.CreateBookAndOpenExcel(MainTitle, MainTitle, COMPANYNAME, USERID);
            ExcelBuf_gRecTmp.CreateNewBook(MainTitle);
            ExcelBuf_gRecTmp.WriteSheet(MainTitle, COMPANYNAME, USERID);
            ExcelBuf_gRecTmp.CloseBook();
            ExcelBuf_gRecTmp.OpenExcel();
            ERROR('');
        END;
    end;

    trigger OnPreReport()
    begin
        ItemFilter := Item.GETFILTERS;
        LocFilter := Item.GETFILTER("Location Filter");

        IF ExportToExcel THEN BEGIN
            ExcelBuf_gRecTmp.DELETEALL;
            MainTitle := 'Nifast Availability Projection';
            MakeExcelInfo_lFnc;
        END;



        //If UserForecastBatch[1]='' THEN
        //ERROR('You must specify a forecast');

        Title := Text000;

        PeriodStartingDate[1] := 0D;
        Date.RESET;
        Date.SETRANGE("Period Type", Date."Period Type"::Week);
        Date.SETFILTER("Period Start", '<=%1', PeriodStartingDate[2] - 56);
        Date.FIND('+');
        PeriodStartingDate[2] := Date."Period Start";
        PeriodStartingText[2] := 'WK' + FORMAT(Date."Period No.");

        Date.SETRANGE("Period Start");

        FOR i := 2 TO 60 DO BEGIN
            Date.NEXT;
            PeriodStartingDate[i + 1] := Date."Period Start";
            PeriodStartingText[i + 1] := 'WK' + FORMAT(Date."Period No.");
        END;

        PeriodStartingDate[62] := DMY2Date(30, 12, 9999);

        //FOR i:= 1 TO 15 DO
        //IF UseForecastBatch[i]<>'' THEN BEGIN
        // DelSchedBatch.SETRANGE("No.",UseForecastBatch[i]);
        //DelSchedBatch.FIND('-');
        //DelSchedBatch.CALCFIELDS("Model Year");
        //SubTitle[i]:='Forecast'+FORMAT(i)+':'+DelSchedBatch."No."+'-Model Year'+DelSchedBatch."Model Year";
        // END;
        CompanyInformation.GET;
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemFilter: Text[250];
        Title: Text[50];
        NoVariant: Text[30];
        PrintFooter: Boolean;
        PeriodStartingDate: array[62] of Date;
        PrintSales: Boolean;
        PrintPurch: Boolean;
        PrintAdj: Boolean;
        PrintTrans: Boolean;
        OnHand: array[62] of Decimal;
        QtyAvailable: array[62] of Decimal;
        QtyOnPurchOrders: array[62] of Decimal;
        QtyOnSalesOrders: array[62] of Decimal;
        QtyOnForecast: array[62] of Decimal;
        QtySold: array[62] of Decimal;
        QtyPurchased: array[62] of Decimal;
        QtyAdjusted: array[62] of Decimal;
        QtyTransferred: array[62] of Decimal;
        i: Integer;
        PeriodCalculation: Code[10];
        Date: Record 2000000007;
        PeriodStartingText: array[62] of Text[30];
        UseForecastBatch: array[62] of Code[20];
        DailyUsage: Decimal;
        DaysSupply: Integer;
        DelSchedBatch: Record 50020;
        DelSchedHdr: Record 50012;
        DelSchedLine: Record 50013;
        j: Integer;
        LinesFound: Boolean;
        ForecastText: Text[30];
        TotalQtyOnPurchOrders: Decimal;
        TotalQtyOnSalesOrders: Decimal;
        TotalQtyOnForecast: Decimal;
        TotalQtySold: Decimal;
        TotalQtyPurchased: Decimal;
        TotalQtyAdjusted: Decimal;
        TotalQtyTransferred: Decimal;
        PrintForecast: Boolean;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        QtyOnSalesOrdersDetail: array[62] of Decimal;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        QtyOnPurchOrdersDetail: array[62] of Decimal;
        CumQtyExpected: Decimal;
        CumQtyActual: Decimal;
        SalesShptLine: Record "Sales Shipment Line";
        Text003: Label 'Before';
        d: Dialog;
        SubTitle: array[62] of Text[100];
        MinusWeekly: array[62] of Integer;
        MinimumInv: Decimal;
        PurchaseNeeds: array[62] of Decimal;
        ForecastQty: array[62] of Decimal;
        ForecastLedgerEntry: Record 50027;
        Text000: Label 'Nifast Availability Projection Ver.1.0';
        TotalForecast: array[62] of Decimal;
        ForecastQty2: array[62] of Decimal;
        PurchSign: array[62] of Boolean;
        LT: Integer;
        "Order": array[62] of Decimal;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[30];
        Weekly90: Decimal;
        ShowDetails: Boolean;
        Daily42: Decimal;
        DayOnHand: Decimal;
        MaximumInv: Decimal;
        Maintain: Decimal;
        MinOrdQ: Decimal;
        MaxInvQ: Decimal;
        TotalForecast2: Decimal;
        SNP: Decimal;
        SNPQty: Integer;
        ShowDetails2: Boolean;
        ShowDetailDetroit: Boolean;
        LocFilter: Code[250];
        ForecastQty3: array[62] of Decimal;
        AveForecast: Decimal;
        T: Date;
        EmuUp: array[62] of Decimal;
        EmuLow: array[62] of Decimal;
        EmuMid: array[62] of Decimal;
        ShowDetails3: Boolean;
        ProductionDate: Date;
        WeekOnHand: array[62] of Decimal;
        NewWeek: array[62] of Text[30];
        InvtQty: Decimal;
        Over: Integer;
        ShowAge: Boolean;
        WarehouseEntry: Record "Warehouse Entry";
        BQ: Decimal;
        OpenPOTotal: Decimal;
        OTW: array[62] of Decimal;
        Fore__Ave__Daily_Usage_CaptionLbl: Label 'Fore. Ave. Daily Usage ';
        Day_On_HandCaptionLbl: Label 'Day On Hand';
        Minimum_Order_Qty_CaptionLbl: Label 'Minimum Order Qty.';
        Actual_Ave__Wkly__Usage__last_12weeks_CaptionLbl: Label 'Actual Ave. Wkly. Usage (last 12weeks)';
        Min_Inventory_Level_QtyCaptionLbl: Label 'Min Inventory Level Qty';
        Max__Inventory_Level_Qty_CaptionLbl: Label 'Max. Inventory Level Qty.';
        WeeksCaptionLbl: Label 'Weeks';
        WeeksCaption_Control1000000228Lbl: Label 'Weeks';
        WeeksCaption_Control1000000417Lbl: Label 'Weeks';
        Mimimum_Inventory_LevelCaptionLbl: Label 'Mimimum Inventory Level';
        Maximum_Inventory_LevelCaptionLbl: Label 'Maximum Inventory Level';
        Lead_TimeCaptionLbl: Label 'Lead Time';
        SNP__Units_Per_Parcel_CaptionLbl: Label 'SNP (Units Per Parcel)';
        Ave__Forecast__Next_8_weeks_CaptionLbl: Label 'Ave. Forecast (Next 8 weeks)';
        Blocked_Inv_CaptionLbl: Label 'Blocked Inv.';
        Over_120_DaysCaptionLbl: Label 'Over 120 Days';
        Qty__on_HandCaptionLbl: Label 'Qty. on Hand';
        Suggested_ReceiptCaptionLbl: Label 'Suggested Receipt';
        ForecastCaptionLbl: Label 'Forecast';
        Suggested_Order_Qty_CaptionLbl: Label 'Suggested Order Qty.';
        Qty__AvailableCaptionLbl: Label 'Qty. Available';
        OPEN_P_O_CaptionLbl: Label 'OPEN P.O.';
        EXPEDITECaptionLbl: Label 'EXPEDITE';
        Weeks_on_HandCaptionLbl: Label 'Weeks on Hand';
        Qty__ReceivedCaptionLbl: Label 'Qty. Received';
        Sales_Invoice_LinesCaptionLbl: Label 'Sales Invoice Lines';
        Qty__AdjustedCaptionLbl: Label 'Qty. Adjusted';
        Qty__TransferredCaptionLbl: Label 'Qty. Transferred';
        ManufacturerCaptionLbl: Label 'Manufacturer';
        This_is_the_ENDCaptionLbl: Label 'This is the END';
        Forecast_BreakdownCaptionLbl: Label 'Forecast Breakdown';
        Nifast_ForecastCaptionLbl: Label 'Nifast Forecast';
        Purchase_OrdersCaptionLbl: Label 'Purchase Orders';
        Qty__on_Purchase_OrdersCaptionLbl: Label 'Qty. on Purchase Orders';
        Sales_OrdersCaptionLbl: Label 'Sales Orders';
        Qty__on_Sales_OrdersCaptionLbl: Label 'Qty. on Sales Orders';
        Inv__Age__days_CaptionLbl: Label 'Inv. Age (days)';
        VendorNo_Cap: Label 'Vendor No.';
        ForecastLedgEntry: Record 50027;
        ForecastEntryFound: Boolean;
        Text50000_gCtx: Label 'Company Name';
        Text50001_gCtx: Label 'Report Name';
        Text50002_gCtx: Label '[P] Availability Canada';
        Text50003_gCtx: Label 'Report No.';
        Text50004_gCtx: Label 'User ID';
        Text50005_gCtx: Label 'Date';
        Text50006_gCtx: Label 'Vendor Name';
        Text50007_gCtx: Label 'Manufacturer';
        Text50008_gCtx: Label 'Customer';
        ExcelBuf_gRecTmp: Record "Excel Buffer" temporary;
        Text50009_gCtx: Label 'Min. Inv.';
        Text50010_gCtx: Label 'Min. Inv. Qty.';
        Text50011_gCtx: Label 'OTW';
        Text50012_gCtx: Label 'Max. Inv';
        Text50013_gCtx: Label 'Max. Inv. Qty.';
        Text50014_gCtx: Label 'Blocked Qty';
        Text50015_gCtx: Label 'Lead Time';
        Text50016_gCtx: Label 'Shpmt Actl 12wk';
        Text50017_gCtx: Label 'SNP';
        Text50018_gCtx: Label 'F-Ave Customer';
        Text50019_gCtx: Label 'Min. Ord. Qty';
        Text50020_gCtx: Label 'F-Adjusted';
        Text50021_gCtx: Label 'Beg. Inv.';
        Text50022_gCtx: Label 'PO Received';
        Text50023_gCtx: Label 'Open PO';
        Text50024_gCtx: Label 'Sug. Rec.';
        Text50025_gCtx: Label 'Req. Rec.';
        Text50026_gCtx: Label 'Purch. Forcst.';
        Text50027_gCtx: Label 'Forecast';
        Text50028_gCtx: Label 'Firm Orders';
        Text50029_gCtx: Label 'End. Inv.';
        Text50030_gCtx: Label 'Sug. Wks.';
        Text50031_gCtx: Label 'Req. Wks.';
        Text50032_gCtx: Label 'Apprvd. Ord.';
        Text50033_gCtx: Label 'Apprvd. Forcst.';
        Text50034_gCtx: Label 'Nifast Forecast';
        Text50035_gCtx: Label 'Before';
        ForecastLedgEntry_gRec: Record 50027;
        PurchLine_gRec: Record "Purchase Line";
        SalesLine_gRec: Record "Sales Line";
        ForeCastEntryExist_gBln: Boolean;
        PurchLineExist_gBln: Boolean;
        SalesLineExist_gBln: Boolean;
        Text50036_gCtx: Label 'EOP';
        Text50037_gCtx: Label 'EMU';
        Text50038_gCtx: Label 'Pcs/Vehicle';
        Text50039_gCtx: Label 'MODEL';
        Vendor_gRec: Record "Vendor";
        Text50040_gCtx: Label 'Forecast Daily Usage';
        Text50041_gCtx: Label 'Days on Hand';
        Text50042_gCtx: Label 'After';
        Text50043_gCtx: Label 'Customer No.';
        Text50044_gCtx: Label 'REMARKS';
        LotNo_Cap: Label 'Lot No.';
        Inventory_Cap: Label 'Inventory';
        LotCreationDate_Cap: Label 'Lot Creation Date';
        InvAge_Cap: Label 'Inv. Age (Days)';
        HideNewLineInItem_gBln: Boolean;
        POList_gCodArr: array[62] of Code[20];
        POListCount_gInt: Integer;
        EndLineExecute_gBln: Boolean;
        ForcastCust_gCodArr: array[62] of Code[20];
        ForcastCustCount_gInt: Integer;

    procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
    begin
        // adjust remaining quantity
        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry.Quantity;
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Cost Application", "Outbound Item Entry No.");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, PeriodStartingDate[2] - 120);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= PeriodStartingDate[2])
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" + ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, PeriodStartingDate[2] - 120);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= PeriodStartingDate[2])
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" - ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END;
    end;

    local procedure MakeExcelInfo_lFnc()
    begin
        ExcelBuf_gRecTmp.SetUseInfoSheet;
        ExcelBuf_gRecTmp.AddInfoColumn(FORMAT(Text50000_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(FORMAT(Text50001_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(FORMAT(Text50002_gCtx), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(FORMAT(Text50003_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(REPORT::"[P] Availability Canada", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(FORMAT(Text50004_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(FORMAT(Text50005_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.ClearNewRow;
    end;

    local procedure MakeExcelDataHeader_lFnc()
    var
        ItemCategory_lRec: Record "Item Category";
    begin
        IF NOT HideNewLineInItem_gBln THEN
            ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item.FIELDCAPTION("No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item.FIELDCAPTION("Vendor No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50006_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50007_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50008_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(TODAY, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);

        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item."Vendor No.", FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Vendor_gRec.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item."Manufacturer Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

        //>> NF1.00:CIS.NG  07-18-16
        IF ItemCategory_lRec.GET(Item."Item Category Code") THEN BEGIN
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            ExcelBuf_gRecTmp.AddColumn(ItemCategory_lRec.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        END;
        //<< NF1.00:CIS.NG  07-18-16

        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50009_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MinimumInv, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50010_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Maintain, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50040_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Daily42, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50012_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MaximumInv, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50013_gCtx, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MaxInvQ, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50014_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(BQ, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50015_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item."Lead Time", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50016_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Weekly90, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50041_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(FORMAT(DayOnHand), FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50017_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(SNP, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50018_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(AveForecast, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50011_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(OTW[10], FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50019_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MinOrdQ, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50020_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelItemDataBody_lFnc()
    var
        CurrencyCodeToPrint: Code[20];
        p: Integer;
        CalPOQty_lDec: Decimal;
        Q: Integer;
        C: Integer;
        D: Integer;
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        IF ForeCastEntryExist_gBln THEN BEGIN
            //>> NF1.00:CIS.NG  07-29-16
            //ExcelBuf_gRecTmp.AddColumn(ForecastLedgEntry_gRec."Customer No.",FALSE,'@',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
            //ExcelBuf_gRecTmp.AddColumn(ForecastLedgEntry_gRec."Customer No.",FALSE,'@',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);

            FOR C := 1 TO ForcastCustCount_gInt DO BEGIN
                ExcelBuf_gRecTmp.AddColumn(ForcastCust_gCodArr[C], FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(ForcastCust_gCodArr[C], FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            END;
            //<< NF1.00:CIS.NG  07-29-16
        END;

        IF PurchLineExist_gBln THEN
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        IF SalesLineExist_gBln THEN
            ExcelBuf_gRecTmp.AddColumn(SalesHeader."Sell-to Customer Name", FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50021_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50022_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50023_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50024_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50025_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50026_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50027_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50028_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50029_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50030_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50031_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50032_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50033_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        IF ForeCastEntryExist_gBln THEN BEGIN
            //>> NF1.00:CIS.NG  07-29-16
            //ExcelBuf_gRecTmp.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
            //ExcelBuf_gRecTmp.AddColumn(Text50034_gCtx,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);

            FOR C := 1 TO ForcastCustCount_gInt DO BEGIN
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(Text50034_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            END;
            //<< NF1.00:CIS.NG  07-29-16
        END;

        IF PurchLineExist_gBln THEN BEGIN
            //ExcelBuf_gRecTmp.AddColumn(PurchLine_gRec."Document No.",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf_gRecTmp."Cell Type"::Text);
            FOR p := 1 TO POListCount_gInt DO
                ExcelBuf_gRecTmp.AddColumn(POList_gCodArr[p], FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRecTmp."Cell Type"::Text);
        END;

        IF SalesLineExist_gBln THEN
            ExcelBuf_gRecTmp.AddColumn(SalesLine_gRec."Document No.", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50035_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        FOR i := 1 TO 61 DO BEGIN
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            IF i > 1 THEN BEGIN
                IF i < 61 THEN
                    ExcelBuf_gRecTmp.AddColumn(PeriodStartingDate[i], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date)
                ELSE
                    ExcelBuf_gRecTmp.AddColumn(Text50042_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(OnHand[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                IF i < 11 THEN
                    ExcelBuf_gRecTmp.AddColumn(QtyTransferred[i] + QtyPurchased[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number)
                ELSE
                    ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(QtyOnPurchOrders[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                IF i > 9 THEN
                    ExcelBuf_gRecTmp.AddColumn(ForecastQty[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number)
                ELSE
                    ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(QtySold[i] + QtyOnSalesOrders[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                ExcelBuf_gRecTmp.AddColumn(TotalForecast[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

                IF ForeCastEntryExist_gBln THEN BEGIN
                    //>> NF1.00:CIS.NG  07-29-16
                    //ExcelBuf_gRecTmp.AddColumn(ForecastQty2[i],FALSE,'',FALSE,FALSE,FALSE,'#,##,##0',ExcelBuf_gRecTmp."Cell Type"::Number);
                    //ExcelBuf_gRecTmp.AddColumn(ForecastQty3[i],FALSE,'',FALSE,FALSE,FALSE,'#,##,##0',ExcelBuf_gRecTmp."Cell Type"::Number);

                    FOR C := 1 TO ForcastCustCount_gInt DO BEGIN
                        CLEAR(ForecastQty2);
                        CLEAR(ForecastQty3);

                        ForecastLedgEntry_gRec.RESET;
                        ForecastLedgEntry_gRec.SETCURRENTKEY("Customer No.", "Division Code");
                        ForecastLedgEntry_gRec.ASCENDING(TRUE);
                        ForecastLedgEntry_gRec.SETRANGE("Item No.", Item."No.");
                        ForecastLedgEntry_gRec.SETRANGE("Customer No.", ForcastCust_gCodArr[C]);
                        IF ForecastLedgEntry_gRec.FINDFIRST THEN BEGIN
                            REPEAT
                                ForeCastEntryExist_gBln := TRUE;
                                IF (ForecastLedgEntry_gRec."Shipping Date" >= PeriodStartingDate[i]) AND
                                  (ForecastLedgEntry_gRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                                   (ForecastLedgEntry_gRec."Forecast Quantity" <> 0)
                                   AND (NOT ForecastLedgEntry_gRec."Nifast Forecast")
                                THEN
                                    ForecastQty2[i] += ForecastLedgEntry_gRec."Forecast Quantity";  //NF1.00:CIS.NG  07-18-16

                                IF (ForecastLedgEntry_gRec."Shipping Date" >= PeriodStartingDate[i]) AND
                                   (ForecastLedgEntry_gRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                                   (ForecastLedgEntry_gRec."Forecast Quantity" <> 0)
                                   AND ForecastLedgEntry_gRec."Nifast Forecast"
                                THEN
                                    ForecastQty3[i] += ForecastLedgEntry_gRec."Forecast Quantity";

                            UNTIL ForecastLedgEntry_gRec.NEXT = 0;
                        END;



                        ExcelBuf_gRecTmp.AddColumn(ForecastQty2[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                        ExcelBuf_gRecTmp.AddColumn(ForecastQty3[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                    END;
                    //<< NF1.00:CIS.NG  07-29-16
                END;

                IF PurchLineExist_gBln THEN BEGIN
                    //ExcelBuf_gRecTmp.AddColumn(QtyOnPurchOrdersDetail[i],FALSE,'',FALSE,FALSE,FALSE,'#,##,##0',ExcelBuf_gRecTmp."Cell Type"::Number);
                    FOR p := 1 TO POListCount_gInt DO BEGIN
                        CalPOQty_lDec := 0;
                        PurchLine_gRec.RESET;
                        PurchLine_gRec.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                                "Location Code", "Expected Receipt Date");
                        PurchLine_gRec.SETRANGE("Document Type", PurchLine_gRec."Document Type"::Order);
                        PurchLine_gRec.SETRANGE("Document No.", POList_gCodArr[p]);
                        PurchLine_gRec.SETRANGE(Type, PurchLine_gRec.Type::Item);
                        PurchLine_gRec.SETRANGE("No.", Item."No.");
                        PurchLine_gRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
                        IF PurchLine_gRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF (PurchLine_gRec."Expected Receipt Date" >= PeriodStartingDate[i]) AND
                                   (PurchLine_gRec."Expected Receipt Date" < PeriodStartingDate[i + 1])
                                THEN BEGIN
                                    CalPOQty_lDec := PurchLine_gRec."Outstanding Qty. (Base)";
                                END;
                            UNTIL PurchLine_gRec.NEXT = 0;
                        END;

                        ExcelBuf_gRecTmp.AddColumn(CalPOQty_lDec, FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                    END;
                END;

                IF SalesLineExist_gBln THEN
                    ExcelBuf_gRecTmp.AddColumn(QtyOnSalesOrdersDetail[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
            END ELSE BEGIN
                ExcelBuf_gRecTmp.AddColumn(QtyOnPurchOrders[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(QtySold[i] + QtyOnSalesOrders[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

                //>> NF1.00:CIS.NG  07-29-16
                IF ForeCastEntryExist_gBln THEN BEGIN
                    FOR C := 1 TO ForcastCustCount_gInt DO BEGIN
                        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                    END;
                END;
                //<< NF1.00:CIS.NG  07-29-16

                IF PurchLineExist_gBln THEN BEGIN
                    //ExcelBuf_gRecTmp.AddColumn(QtyOnPurchOrdersDetail[i],FALSE,'',FALSE,FALSE,FALSE,'#,##,##0',ExcelBuf_gRecTmp."Cell Type"::Number);
                    FOR p := 1 TO POListCount_gInt DO BEGIN
                        CalPOQty_lDec := 0;
                        PurchLine_gRec.RESET;
                        PurchLine_gRec.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                                "Location Code", "Expected Receipt Date");
                        PurchLine_gRec.SETRANGE("Document Type", PurchLine_gRec."Document Type"::Order);
                        PurchLine_gRec.SETRANGE("Document No.", POList_gCodArr[p]);
                        PurchLine_gRec.SETRANGE(Type, PurchLine_gRec.Type::Item);
                        PurchLine_gRec.SETRANGE("No.", Item."No.");
                        PurchLine_gRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
                        IF PurchLine_gRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF (PurchLine_gRec."Expected Receipt Date" >= PeriodStartingDate[i]) AND
                                   (PurchLine_gRec."Expected Receipt Date" < PeriodStartingDate[i + 1])
                                THEN BEGIN
                                    CalPOQty_lDec := PurchLine_gRec."Outstanding Qty. (Base)";
                                END;
                            UNTIL PurchLine_gRec.NEXT = 0;
                        END;

                        ExcelBuf_gRecTmp.AddColumn(CalPOQty_lDec, FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                    END;
                END;

                IF SalesLineExist_gBln THEN
                    ExcelBuf_gRecTmp.AddColumn(QtyOnSalesOrdersDetail[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
            END;
            ExcelBuf_gRecTmp.NewRow;
        END;
    end;

    local procedure MakeExcelItemCategoryDataBody_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Item Category".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelLotInfoHeader_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(LotNo_Cap, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Inventory_Cap, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(LotCreationDate_Cap, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(InvAge_Cap, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelLotInfoBody_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Lot No. Information"."Lot No.", FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Lot No. Information".Inventory, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn("Lot No. Information"."Lot Creation Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);
        ExcelBuf_gRecTmp.AddColumn(Over, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
    end;

    local procedure MakeExcelVehicleProdHeader_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50043_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50036_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50037_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50038_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50039_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50044_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelVehicleProdBody_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production"."Customer No.", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".EOP, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".EMU, FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production"."Pieces Per Vehicle", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".Model, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".Remarks, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelENDLine_lFnc()
    begin
        //>> NF1.00:CIS.NG  07-18-16
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('END', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        //<< NF1.00:CIS.NG  07-18-16
    end;

    local procedure CalculateQty_lFnc()
    var
        PreCust_lCod: Code[20];
        Consider_lBln: Boolean;
        d: Integer;
    begin
        //>> NF1.00:CIS.NG  07-18-16
        CLEAR(ForecastQty2);
        CLEAR(ForecastQty3);
        //<< NF1.00:CIS.NG  07-18-16

        //>> NF1.00:CIS.NG  07-29-16
        CLEAR(ForcastCust_gCodArr);
        ForcastCustCount_gInt := 0;
        PreCust_lCod := '';

        ForecastLedgEntry_gRec.RESET;
        ForecastLedgEntry_gRec.SETCURRENTKEY("Customer No.", "Division Code");
        ForecastLedgEntry_gRec.ASCENDING(TRUE);
        ForecastLedgEntry_gRec.SETRANGE("Item No.", Item."No.");
        IF ForecastLedgEntry_gRec.FINDFIRST THEN BEGIN
            REPEAT
                ForeCastEntryExist_gBln := TRUE;
                IF PreCust_lCod <> ForecastLedgEntry_gRec."Customer No." THEN BEGIN
                    ForcastCustCount_gInt += 1;
                    ForcastCust_gCodArr[ForcastCustCount_gInt] := ForecastLedgEntry_gRec."Customer No.";
                    PreCust_lCod := ForecastLedgEntry_gRec."Customer No.";
                END;
            UNTIL ForecastLedgEntry_gRec.NEXT = 0;
        END;
        //<< NF1.00:CIS.NG  07-29-16

        ForecastLedgEntry_gRec.RESET;
        ForecastLedgEntry_gRec.SETCURRENTKEY("Customer No.", "Division Code");
        ForecastLedgEntry_gRec.ASCENDING(TRUE);
        ForecastLedgEntry_gRec.SETRANGE("Item No.", Item."No.");
        IF ForecastLedgEntry_gRec.FINDFIRST THEN BEGIN
            REPEAT
                ForeCastEntryExist_gBln := TRUE;
                FOR i := 2 TO 61 DO
                    IF (ForecastLedgEntry_gRec."Shipping Date" >= PeriodStartingDate[i]) AND
                      (ForecastLedgEntry_gRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                       (ForecastLedgEntry_gRec."Forecast Quantity" <> 0)
                       AND (NOT ForecastLedgEntry_gRec."Nifast Forecast")
                    THEN
                        ForecastQty2[i] += ForecastLedgEntry_gRec."Forecast Quantity";  //NF1.00:CIS.NG  07-18-16
                                                                                        //ELSE
                                                                                        //  ForecastQty2[i]:=0;

                FOR i := 2 TO 61 DO
                    IF (ForecastLedgEntry_gRec."Shipping Date" >= PeriodStartingDate[i]) AND
                       (ForecastLedgEntry_gRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                       (ForecastLedgEntry_gRec."Forecast Quantity" <> 0)
                       AND ForecastLedgEntry_gRec."Nifast Forecast"
                    THEN
                        ForecastQty3[i] += ForecastLedgEntry_gRec."Forecast Quantity";
            //ELSE
            //  ForecastQty3[i]:=0;
            UNTIL ForecastLedgEntry_gRec.NEXT = 0;
        END;

        POListCount_gInt := 0;  //NG-N
        PurchLine_gRec.RESET;
        PurchLine_gRec.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                "Location Code", "Expected Receipt Date");
        PurchLine_gRec.SETRANGE("Document Type", PurchLine_gRec."Document Type"::Order);
        PurchLine_gRec.SETRANGE(Type, PurchLine_gRec.Type::Item);
        PurchLine_gRec.SETRANGE("No.", Item."No.");
        PurchLine_gRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF PurchLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                PurchLineExist_gBln := TRUE;
                CLEAR(QtyOnPurchOrdersDetail);
                FOR i := 1 TO 61 DO BEGIN
                    IF (PurchLine_gRec."Expected Receipt Date" >= PeriodStartingDate[i]) AND
                       (PurchLine_gRec."Expected Receipt Date" < PeriodStartingDate[i + 1])
                    THEN BEGIN
                        //>> NF1.00:CIS.NG  08-03-16
                        Consider_lBln := TRUE;
                        IF POListCount_gInt = 0 THEN
                            Consider_lBln := TRUE
                        ELSE BEGIN
                            FOR d := 1 TO POListCount_gInt DO BEGIN
                                IF POList_gCodArr[d] = PurchLine_gRec."Document No." THEN
                                    Consider_lBln := FALSE;
                            END;
                        END;
                        IF Consider_lBln THEN BEGIN
                            //<< NF1.00:CIS.NG  08-03-16
                            QtyOnPurchOrdersDetail[i] := PurchLine_gRec."Outstanding Qty. (Base)";
                            POListCount_gInt += 1;
                            POList_gCodArr[POListCount_gInt] := PurchLine_gRec."Document No.";
                        END;  //NF1.00:CIS.NG  08-03-16
                    END;
                END;
            UNTIL PurchLine_gRec.NEXT = 0;
        END;

        SalesLine_gRec.RESET;
        SalesLine_gRec.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Shipment Date");
        SalesLine_gRec.SETRANGE("Document Type", SalesLine_gRec."Document Type"::Order);
        SalesLine_gRec.SETRANGE(Type, SalesLine_gRec.Type::Item);
        SalesLine_gRec.SETRANGE("No.", Item."No.");
        SalesLine_gRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF SalesLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                SalesLineExist_gBln := TRUE;
                CLEAR(QtyOnSalesOrdersDetail);
                FOR i := 2 TO 61 DO
                    IF (SalesLine_gRec."Shipment Date" >= PeriodStartingDate[i]) AND
                       (SalesLine_gRec."Shipment Date" < PeriodStartingDate[i + 1]) THEN
                        QtyOnSalesOrdersDetail[i] := SalesLine_gRec."Outstanding Qty. (Base)";
            UNTIL SalesLine_gRec.NEXT = 0;

            IF NOT SalesHeader.GET(SalesLine_gRec."Document Type", SalesLine_gRec."Document No.") THEN
                CLEAR(SalesHeader);
        END;
    end;

}