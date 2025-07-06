report 50120 "Forecast Module"
{
    // NF1.00:CIS.CM  09-09-15 Merged during upgrade
    // NF1.00:CIS.CM  09-29-15 Update for New Vision Removal Task
    // NF1.00:CIS.NG  07-18-16 Update Code to Fix Excel Layout Issue and Correct Qty
    // NF1.00:CIS.NG  07-22-16 Update Code to Fix Excel Layout Issue and Correct Qty (for PO Detail,Hide Vehicle Deteail if no data exists)
    // NF1.00:CIS.NG  07-29-16 Update Code to Fix Excel Layout Issue and Correct Qty 2 Point error. two cells to the right
    // NF1.00:CIS.NG  08-22-16 Update Code to Get Correct Customer Name from Forcast Ledger Entry - Added Code to Filter GD1 from Item Rec
    // SM 001 09-13-16 Deleted Nilesh's 08-22-16 to show all forecast from MPD|MICH|IBN customers
    // SM 001 10-14-16 Added filter for 92616-60818 and 90105-10406
    // SM 002 05-17-17 filter only MPD sales orders and purchase orders
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
    // 
    // SM 05-22-20 modified from actual 12 weeks to 13 weeks. Also added from 26 weeks to 14 weeks
    // 
    // SM 02-20-23 Standardize
    // SM 03-27-23 Eliminated
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\RDLC\Forecast Module.rdlc';
    Caption = 'Forecast Module';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Vendor No.", "Global Dimension 1 Code", "Forecast on/off";
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
                DecimalPlaces = 0 : 0;
            }
            column(Daily42; Daily42)
            {
                DecimalPlaces = 0 : 0;
            }
            column(DayOnHand; DayOnHand)
            {
                DecimalPlaces = 1 : 1;
            }
            column(Weekly90; Weekly90)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Maintain; Maintain)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MaxInvQ; MaxInvQ)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MaximumInv; MaximumInv)
            {
                DecimalPlaces = 1 : 1;
            }
            column(MinimumInv; MinimumInv)
            {
                DecimalPlaces = 1 : 1;
            }
            column(Item__Lead_Time_; "Lead Time")
            {
                DecimalPlaces = 1 : 1;
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
                DecimalPlaces = 0 : 0;
            }
            column(ItemLedgerEntry__Remaining_Quantity_; ItemLedgerEntry."Remaining Quantity")
            {
                DecimalPlaces = 0 : 0;
            }
            column(BQ; BQ)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item__No__; "No.")
            {
            }
            column(VendorNo_Cap; VendorNo_Cap)
            {
            }
            column(PeriodStartingDate_2_; FORMAT(PeriodStartingDate[2]))
            {
            }
            column(PeriodStartingText_2_; PeriodStartingText[2])
            {
            }
            column(PeriodStartingText_3_; PeriodStartingText[3])
            {
            }
            column(PeriodStartingDate_3_; FORMAT(PeriodStartingDate[3]))
            {
            }
            column(PeriodStartingText_4_; PeriodStartingText[4])
            {
            }
            column(PeriodStartingDate_4_; FORMAT(PeriodStartingDate[4]))
            {
            }
            column(PeriodStartingText_5_; PeriodStartingText[5])
            {
            }
            column(PeriodStartingDate_5_; FORMAT(PeriodStartingDate[5]))
            {
            }
            column(PeriodStartingDate_6_; FORMAT(PeriodStartingDate[6]))
            {
            }
            column(PeriodStartingText_6_; PeriodStartingText[6])
            {
            }
            column(PeriodStartingDate_7_; FORMAT(PeriodStartingDate[7]))
            {
            }
            column(PeriodStartingText_7_; PeriodStartingText[7])
            {
            }
            column(PeriodStartingDate_8_; FORMAT(PeriodStartingDate[8]))
            {
            }
            column(PeriodStartingText_8_; PeriodStartingText[8])
            {
            }
            column(PeriodStartingText_9_; PeriodStartingText[9])
            {
            }
            column(PeriodStartingDate_9_; FORMAT(PeriodStartingDate[9]))
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
            column(PeriodStartingDate_1_; FORMAT(PeriodStartingDate[1]))
            {
            }
            column(PeriodStartingText_1_; PeriodStartingText[1])
            {
            }
            column(OnHand_2_; OnHand[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_3_; OnHand[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_4_; OnHand[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_5_; OnHand[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_2_; PurchaseNeeds[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_3_; PurchaseNeeds[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_4_; PurchaseNeeds[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_5_; PurchaseNeeds[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_10_; ForecastQty[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_11_; ForecastQty[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_12_; ForecastQty[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_13_; ForecastQty[13])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_14_; ForecastQty[14])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_15_; ForecastQty[15])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_6_; OnHand[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_7_; OnHand[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_8_; OnHand[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_9_; OnHand[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_10_; OnHand[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_11_; OnHand[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_12_; OnHand[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_13_; OnHand[13])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_14_; OnHand[14])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_15_; OnHand[15])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_6_; PurchaseNeeds[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_7_; PurchaseNeeds[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_8_; PurchaseNeeds[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_9_; PurchaseNeeds[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_10_; PurchaseNeeds[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_11_; PurchaseNeeds[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_12_; PurchaseNeeds[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_13_; PurchaseNeeds[13])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_14_; PurchaseNeeds[14])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_15_; PurchaseNeeds[15])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_2_; TotalForecast[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_3_; TotalForecast[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_4_; TotalForecast[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_5_; TotalForecast[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_6_; TotalForecast[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_7_; TotalForecast[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_8_; TotalForecast[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_9_; TotalForecast[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_10_; TotalForecast[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_11_; TotalForecast[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_12_; TotalForecast[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_13_; TotalForecast[13])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_14_; TotalForecast[14])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_15_; TotalForecast[15])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_2_; Order[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_3_; Order[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_4_; Order[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_5_; Order[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_6_; Order[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_7_; Order[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_8_; Order[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_9_; Order[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_10_; Order[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_11_; Order[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_12_; Order[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_13_; Order[13])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_14_; Order[14])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_15_; Order[15])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_15_; QtyOnPurchOrders[15])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_14_; QtyOnPurchOrders[14])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_13_; QtyOnPurchOrders[13])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_12_; QtyOnPurchOrders[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_11_; QtyOnPurchOrders[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_10_; QtyOnPurchOrders[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_9_; QtyOnPurchOrders[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_8_; QtyOnPurchOrders[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_7_; QtyOnPurchOrders[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_6_; QtyOnPurchOrders[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_5_; QtyOnPurchOrders[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_4_; QtyOnPurchOrders[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_3_; QtyOnPurchOrders[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_2_; QtyOnPurchOrders[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OnHand_16_; OnHand[16])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_16_; Order[16])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchaseNeeds_16_; PurchaseNeeds[16])
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalForecast_16_; TotalForecast[16])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOnPurchOrders_16_; QtyOnPurchOrders[16])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ForecastQty_16_; ForecastQty[16])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PurchSign_2_; FORMAT(PurchSign[2]))
            {
            }
            column(PurchSign_3_; FORMAT(PurchSign[3]))
            {
            }
            column(PurchSign_4_; FORMAT(PurchSign[4]))
            {
            }
            column(PurchSign_5_; FORMAT(PurchSign[5]))
            {
            }
            column(PurchSign_6_; FORMAT(PurchSign[6]))
            {
            }
            column(PurchSign_7_; FORMAT(PurchSign[7]))
            {
            }
            column(PurchSign_8_; FORMAT(PurchSign[8]))
            {
            }
            column(PurchSign_9_; FORMAT(PurchSign[9]))
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
            column(NewWeek_2_; NewWeek[2])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_3_; NewWeek[3])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_4_; NewWeek[4])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_5_; NewWeek[5])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_6_; NewWeek[6])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_7_; NewWeek[7])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_8_; NewWeek[8])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_9_; NewWeek[9])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_10_; NewWeek[10])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_11_; NewWeek[11])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_12_; NewWeek[12])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_13_; NewWeek[13])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_14_; NewWeek[14])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_15_; NewWeek[15])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(NewWeek_16_; NewWeek[16])
            {
                //DecimalPlaces = 1 : 1;
            }
            column(QtyOnPurchOrders_1_; QtyOnPurchOrders[1])
            {
                DecimalPlaces = 0 : 0;
            }
            column(Order_1_; Order[1])
            {
                DecimalPlaces = 0 : 0;
            }
            column(OTW_10_; OTW[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyPurchased_1_; QtyPurchased[1])
            {
            }
            column(QtySold_1_; QtySold[1])
            {
            }
            column(QtyPurchased_2_; QtyPurchased[2])
            {
            }
            column(QtyAdjusted_1_; QtyAdjusted[1])
            {
            }
            column(QtyAdjusted_2_; QtyAdjusted[2])
            {
            }
            column(QtySold_2_; QtySold[2])
            {
            }
            column(QtyPurchased_3_; QtyPurchased[3])
            {
            }
            column(QtyAdjusted_3_; QtyAdjusted[3])
            {
            }
            column(QtySold_3_; QtySold[3])
            {
            }
            column(QtyPurchased_4_; QtyPurchased[4])
            {
            }
            column(QtyAdjusted_4_; QtyAdjusted[4])
            {
            }
            column(QtySold_4_; QtySold[4])
            {
            }
            column(QtyPurchased_5_; QtyPurchased[5])
            {
            }
            column(QtyAdjusted_5_; QtyAdjusted[5])
            {
            }
            column(QtySold_5_; QtySold[5])
            {
            }
            column(QtyPurchased_6_; QtyPurchased[6])
            {
            }
            column(QtyAdjusted_6_; QtyAdjusted[6])
            {
            }
            column(QtySold_6_; QtySold[6])
            {
            }
            column(QtyPurchased_7_; QtyPurchased[7])
            {
            }
            column(QtyAdjusted_7_; QtyAdjusted[7])
            {
            }
            column(QtySold_7_; QtySold[7])
            {
            }
            column(QtyPurchased_8_; QtyPurchased[8])
            {
            }
            column(QtyAdjusted_8_; QtyAdjusted[8])
            {
            }
            column(QtySold_8_; QtySold[8])
            {
            }
            column(QtyPurchased_9_; QtyPurchased[9])
            {
            }
            column(QtyAdjusted_9_; QtyAdjusted[9])
            {
            }
            column(QtySold_9_; QtySold[9])
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
            column(QtyTransferred_2_; QtyTransferred[2])
            {
            }
            column(QtyTransferred_3_; QtyTransferred[3])
            {
            }
            column(QtyTransferred_4_; QtyTransferred[4])
            {
            }
            column(QtyTransferred_5_; QtyTransferred[5])
            {
            }
            column(QtyTransferred_6_; QtyTransferred[6])
            {
            }
            column(QtyTransferred_7_; QtyTransferred[7])
            {
            }
            column(QtyTransferred_8_; QtyTransferred[8])
            {
            }
            column(QtyTransferred_9_; QtyTransferred[9])
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
            column(ShowDetails; ShowDetails)
            {
            }
            column(ShowDetails2; ShowDetails2)
            {
            }
            column(Forecast_BreakdownCaption; Forecast_BreakdownCaptionLbl)
            {
            }
            column(Purchase_OrdersCaption; Purchase_OrdersCaptionLbl)
            {
            }
            column(Qty__on_Purchase_OrdersCaption; Qty__on_Purchase_OrdersCaptionLbl)
            {
            }
            column(Sales_OrdersCaption; Sales_OrdersCaptionLbl)
            {
            }
            column(Qty__on_Sales_OrdersCaption; Qty__on_Sales_OrdersCaptionLbl)
            {
            }
            column(ForecastEntryFound; ForecastEntryFound)
            {
            }
            dataitem("Item Category"; "Item Category")
            {
                DataItemLink = Code = FIELD("Item Category Code");
                DataItemTableView = SORTING(Code);
                column(Code_Item_Category; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>> NF1.00:CIS.NG  07-18-16
                    //IF ExportToExcel THEN
                    //  MakeExcelItemCategoryDataBody_lFnc;
                    //<< NF1.00:CIS.NG  07-18-16
                end;
            }
            dataitem("Forecast Ledger Entry"; "Forecast Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Division Code");
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Item No.", "Division Code";
                RequestFilterHeading = 'Forecast';
                column(ForecastQty2_2_; ForecastQty2[2])
                {
                }
                column(ForecastQty2_3_; ForecastQty2[3])
                {
                }
                column(ForecastQty2_4_; ForecastQty2[4])
                {
                }
                column(ForecastQty2_5_; ForecastQty2[5])
                {
                }
                column(ForecastQty2_6_; ForecastQty2[6])
                {
                }
                column(ForecastQty2_7_; ForecastQty2[7])
                {
                }
                column(ForecastQty2_8_; ForecastQty2[8])
                {
                }
                column(ForecastQty2_9_; ForecastQty2[9])
                {
                }
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
                column(ForecastQty3_2_; ForecastQty3[2])
                {
                }
                column(ForecastQty3_3_; ForecastQty3[3])
                {
                }
                column(ForecastQty3_4_; ForecastQty3[4])
                {
                }
                column(ForecastQty3_5_; ForecastQty3[5])
                {
                }
                column(ForecastQty3_6_; ForecastQty3[6])
                {
                }
                column(ForecastQty3_7_; ForecastQty3[7])
                {
                }
                column(ForecastQty3_8_; ForecastQty3[8])
                {
                }
                column(ForecastQty3_9_; ForecastQty3[9])
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
                column(ForecastQty2_2__Control1000000263; ForecastQty2[2])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_3__Control1000000264; ForecastQty2[3])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_4__Control1000000265; ForecastQty2[4])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_5__Control1000000266; ForecastQty2[5])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_6__Control1000000267; ForecastQty2[6])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_7__Control1000000268; ForecastQty2[7])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_8__Control1000000269; ForecastQty2[8])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_9__Control1000000270; ForecastQty2[9])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_10__Control1000000271; ForecastQty2[10])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_11__Control1000000272; ForecastQty2[11])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_12__Control1000000273; ForecastQty2[12])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_13__Control1000000274; ForecastQty2[13])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_14__Control1000000291; ForecastQty2[14])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_15__Control1000000292; ForecastQty2[15])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty2_16__Control1000000326; ForecastQty2[16])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Forecast_Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(ForecastQty3_2__Control1000000396; ForecastQty3[2])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_3__Control1000000397; ForecastQty3[3])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_4__Control1000000398; ForecastQty3[4])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_5__Control1000000399; ForecastQty3[5])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_6__Control1000000400; ForecastQty3[6])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_7__Control1000000401; ForecastQty3[7])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_8__Control1000000402; ForecastQty3[8])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_9__Control1000000403; ForecastQty3[9])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_10__Control1000000404; ForecastQty3[10])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_11__Control1000000405; ForecastQty3[11])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_12__Control1000000406; ForecastQty3[12])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_13__Control1000000407; ForecastQty3[13])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_14__Control1000000408; ForecastQty3[14])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_15__Control1000000409; ForecastQty3[15])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ForecastQty3_16__Control1000000410; ForecastQty3[16])
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Forecast_Ledger_Entry__Customer_No___Control1000000057; "Customer No.")
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
                    FOR i := 2 TO 85 DO
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

                    FOR i := 2 TO 85 DO
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
                    //CurrReport.CREATETOTALS(ForecastQty2);BC Upgrade
                    //CurrReport.CREATETOTALS(ForecastQty3);BC Upgrade
                end;
            }
            dataitem(PurchOrderLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = false;
                column(QtyOnPurchOrdersDetail_2_; QtyOnPurchOrdersDetail[2])
                {
                }
                column(QtyOnPurchOrdersDetail_3_; QtyOnPurchOrdersDetail[3])
                {
                }
                column(QtyOnPurchOrdersDetail_4_; QtyOnPurchOrdersDetail[4])
                {
                }
                column(QtyOnPurchOrdersDetail_5_; QtyOnPurchOrdersDetail[5])
                {
                }
                column(QtyOnPurchOrdersDetail_6_; QtyOnPurchOrdersDetail[6])
                {
                }
                column(QtyOnPurchOrdersDetail_7_; QtyOnPurchOrdersDetail[7])
                {
                }
                column(QtyOnPurchOrdersDetail_8_; QtyOnPurchOrdersDetail[8])
                {
                }
                column(QtyOnPurchOrdersDetail_9_; QtyOnPurchOrdersDetail[9])
                {
                }
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
                column(QtyOnPurchOrders_2__Control1000000064; QtyOnPurchOrders[2])
                {
                }
                column(QtyOnPurchOrders_3__Control1000000176; QtyOnPurchOrders[3])
                {
                }
                column(QtyOnPurchOrders_4__Control1000000177; QtyOnPurchOrders[4])
                {
                }
                column(QtyOnPurchOrders_5__Control1000000178; QtyOnPurchOrders[5])
                {
                }
                column(QtyOnPurchOrders_6__Control1000000179; QtyOnPurchOrders[6])
                {
                }
                column(QtyOnPurchOrders_7__Control1000000180; QtyOnPurchOrders[7])
                {
                }
                column(QtyOnPurchOrders_8__Control1000000181; QtyOnPurchOrders[8])
                {
                }
                column(QtyOnPurchOrders_9__Control1000000182; QtyOnPurchOrders[9])
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
                    FOR i := 1 TO 85 DO
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
                    //SM 03-27-23 Eliminated
                    //PurchLine.SETRANGE("Shortcut Dimension 1 Code",'MPD');
                    //SM 03-27-23 Eliminated
                    PurchLine.SETFILTER("Outstanding Quantity", '<>%1', 0);


                    SETRANGE(Number, 1, PurchLine.COUNT);
                end;
            }
            dataitem(SalesOrderLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = false;
                column(QtyOnSalesOrdersDetail_2_; QtyOnSalesOrdersDetail[2])
                {
                }
                column(QtyOnSalesOrdersDetail_3_; QtyOnSalesOrdersDetail[3])
                {
                }
                column(QtyOnSalesOrdersDetail_4_; QtyOnSalesOrdersDetail[4])
                {
                }
                column(QtyOnSalesOrdersDetail_5_; QtyOnSalesOrdersDetail[5])
                {
                }
                column(QtyOnSalesOrdersDetail_6_; QtyOnSalesOrdersDetail[6])
                {
                }
                column(QtyOnSalesOrdersDetail_7_; QtyOnSalesOrdersDetail[7])
                {
                }
                column(QtyOnSalesOrdersDetail_8_; QtyOnSalesOrdersDetail[8])
                {
                }
                column(QtyOnSalesOrdersDetail_9_; QtyOnSalesOrdersDetail[9])
                {
                }
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
                column(QtyOnSalesOrders_2_; QtyOnSalesOrders[2])
                {
                }
                column(QtyOnSalesOrders_3_; QtyOnSalesOrders[3])
                {
                }
                column(QtyOnSalesOrders_4_; QtyOnSalesOrders[4])
                {
                }
                column(QtyOnSalesOrders_5_; QtyOnSalesOrders[5])
                {
                }
                column(QtyOnSalesOrders_6_; QtyOnSalesOrders[6])
                {
                }
                column(QtyOnSalesOrders_7_; QtyOnSalesOrders[7])
                {
                }
                column(QtyOnSalesOrders_8_; QtyOnSalesOrders[8])
                {
                }
                column(QtyOnSalesOrders_9_; QtyOnSalesOrders[9])
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
                    FOR i := 2 TO 85 DO
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
                    //SM 03-27-23 Eliminated
                    //SalesLine.SETRANGE("Shortcut Dimension 1 Code",'MPD');
                    //SM 03-27-23 Eliminated
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
                column(Lot_No__Information__Lot_Creation_Date_; "Lot Creation Date")
                {
                }
                column(Over; Over)
                {
                }
                column(Lot_No__Information__Lot_No__Caption; FIELDCAPTION("Lot No."))
                {
                }
                column(Lot_No__Information_InventoryCaption; FIELDCAPTION(Inventory))
                {
                }
                column(Lot_No__Information__Lot_Creation_Date_Caption; FIELDCAPTION("Lot Creation Date"))
                {
                }
                column(Inv__Age__days_Caption; Inv__Age__days_CaptionLbl)
                {
                }
                column(Lot_No__Information_Item_No_; "Item No.")
                {
                }
                column(Lot_No__Information_Variant_Code; "Variant Code")
                {
                }
                column(ShowAge; ShowAge)
                {
                }
                column(Blocked; Blocked)
                {
                }
                column(blockedLotQty; blockedLotQty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Lot Creation Date" = 0D then//BC Upgrade
                        "Lot Creation Date" := DMY2Date(1, 1, Date2DMY(TODAY, 3));//BC Upgrade
                    Over := TODAY - "Lot Creation Date";
                    IF (ExportToExcel) AND ((Over > 180) OR (Blocked)) THEN BEGIN
                        MakeExcelLotInfoBody_lFnc;
                    END;


                    // "Lot No. Information".SETFILTER(Blocked,'YES');
                    // "Lot No. Information".SETFILTER(Inventory,'>0');
                    //  blockedLotQty:="Lot No. Information".Inventory;
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
                column(PPAPDate; "Vehicle Production"."PPAP Approved Date")
                {
                }

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
                    EndLineExecute_gBln := FALSE;
                    HideNewLineInItem_gBln := FALSE;
                    IF ExportToExcel AND (COUNT > 0) THEN
                        MakeExcelVehicleProdHeader_lFnc;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ForecastEntryFound);
                ForecastLedgEntry.RESET;
                ForecastLedgEntry.SETRANGE("Item No.", "No.");
                ForecastFilter := ForecastLedgerEntry.GETFILTER("Division Code");


                IF ForecastLedgEntry.FINDFIRST THEN
                    ForecastEntryFound := TRUE;

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
                WarehouseEntry.SETFILTER("Bin Code", 'A-01-02|D-08-01|QA WIP|RETURN|MISSING|QA-AR-EA|RO-REPACK');

                WarehouseEntry.CALCSUMS("Qty. (Base)");
                BQ := WarehouseEntry."Qty. (Base)";

                //////BLOCK BIN CALCULATION END

                ForecastLedgerEntry.SETRANGE("Item No.", "No.");
                ForecastLedgerEntry.SETRANGE("Customer No.");
                ForecastLedgerEntry.SETRANGE("Shipping Date", PeriodStartingDate[19], PeriodStartingDate[27] - 1);
                ForecastLedgerEntry.SETFILTER("Division Code", ForecastFilter);
                //>> NF1.00:CIS.NG  08-22-16
                //IF Item.GETFILTER("Global Dimension 1 Code") <> '' THEN
                //ForecastLedgerEntry.SETFILTER("Division Code",Item.GETFILTER("Global Dimension 1 Code"));

                //SM 001 09-13-16

                //SM 03-27-23 Eliminated
                //ForecastLedgerEntry.SETFILTER("Division Code",'MPD|MICH|IBN');
                //SM 03-27-23 Eliminated

                //ForecastLedgerEntry.SETFILTER("Division Code",ForecastLedgerEntry.GETFILTER("Division Code"));
                //SM 001 09-13-16
                //<< NF1.00:CIS.NG  08-22-16

                ForecastLedgerEntry.CALCSUMS("Forecast Quantity");

                //average weekly by forecasted usage(8 weeks)
                AveForecast := ROUND(ForecastLedgerEntry."Forecast Quantity" / 8, 1, '>');



                FOR i := 1 TO 85 DO BEGIN
                    IF i = 1 THEN BEGIN


                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Posting Date", 0D, PeriodStartingDate[18] - 1);
                        ItemLedgerEntry.SETRANGE("Location Code");
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        OnHand[18] := ItemLedgerEntry.Quantity - BQ;


                        ItemLedgerEntry.SETRANGE("Location Code", 'OTW-IT');
                        //SM 03-27-23 Eliminated
                        //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'MPD');
                        //SM 03-27-23 Eliminated
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        OTW[18] := ItemLedgerEntry.Quantity;

                        TotalForecast[17] := OnHand[18];//-OTW[18];


                        PurchLine.SETCURRENTKEY("Document Type", "No.", "Expected Receipt Date", "Shortcut Dimension 1 Code", "Outstanding Quantity", Type);

                        COPYFILTER("Global Dimension 1 Filter", PurchLine."Shortcut Dimension 1 Code");
                        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                        PurchLine.SETRANGE("No.", "No.");

                        //SM 03-27-23 Eliminated
                        //PurchLine.SETRANGE("Shortcut Dimension 1 Code",'MPD');
                        //SM 03-27-23 Eliminated

                        //  FOR x := 1 TO 17 DO BEGIN
                        //   ForecastQty[x]:= 0;

                        //     PurchLine.SETRANGE("Expected Receipt Date",0D,PeriodStartingDate[x+1] - 1);
                        //     PurchLine.SETRANGE("Outstanding Quantity",1,100000000);
                        //     PurchLine.SETRANGE(Type,PurchLine.Type::Item);
                        //     PurchLine.SETRANGE("Shortcut Dimension 1 Code",'MPD');
                        //    PurchLine.CALCSUMS("Outstanding Qty. (Base)");

                        //     QtyOnPurchOrders[x] := PurchLine."Outstanding Qty. (Base)";

                        //  END;




                        //Entry Type,Item No.,Variant Code,Drop Shipment,Location Code,Posting Date,QC Hold

                    END ELSE IF i = 2 THEN BEGIN

                        //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        FOR x := 1 TO 17 DO BEGIN
                            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                          "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                            COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                            COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[x], PeriodStartingDate[x + 1] - 1);

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Sales (Qty.)" := -ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                            ItemLedgerEntry.CALCSUMS(Quantity);
                            "Transferred (Qty.)" := ItemLedgerEntry.Quantity;

                            SETRANGE("Date Filter", PeriodStartingDate[x], PeriodStartingDate[x + 1] - 1);

                            CALCFIELDS(
                              "Qty. on Sales Order", "Qty. on Purch. Order",
                              "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)");

                            QtyPurchased[x] := "Purchases (Qty.)";
                            QtyTransferred[x] := "Transferred (Qty.)";
                            QtySold[x] := "Sales (Qty.)";

                        END;


                        FOR x := 1 TO 17 DO BEGIN
                            IF x < 17 THEN BEGIN
                                OnHand[18 - x] := TotalForecast[18 - x] - QtyPurchased[18 - x] - QtyTransferred[18 - x] + QtySold[18 - x];
                                TotalForecast[17 - x] := OnHand[18 - x];

                            END ELSE IF x = 17 THEN BEGIN
                                OnHand[18 - x] := TotalForecast[18 - x] - QtyPurchased[18 - x] - QtyTransferred[18 - x] + QtySold[18 - x];
                            END;

                        END;




                        //Entry Type,Item No.,Variant Code,Drop Shipment,Location Code,Posting Date,QC Hold

                    END ELSE IF i = 18 THEN BEGIN
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", 0D, PeriodStartingDate[19] - 1);

                        //ItemLedgerEntry.SETRANGE("Location Code",'Mich');
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //OnHand[9] := OnHand[8];




                        //Average Weekly USAGE(Last 90days) starts----------------------------------------------------------------
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);

                        //SM 05-22-20  Average shipment of last 13weeks
                        //ItemLedgerEntry.SETRANGE("Posting Date",PeriodStartingDate[10]-84,PeriodStartingDate[10] - 1);
                        //Change from 12weeks to 13 weeks
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[18] - 91, PeriodStartingDate[18] - 1);

                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //Weekly90 := ROUND(-ItemLedgerEntry.Quantity/12,1,'>');
                        Weekly90 := ROUND(-ItemLedgerEntry.Quantity / 13, 1, '>');
                        //SM 05-22-20

                        ///FORECAST vs HISTORY calculation (2/1/08)
                        IF AveForecast > 0 THEN BEGIN
                            Maintain := AveForecast * MinimumInv;
                        END ELSE IF AveForecast = 0 THEN BEGIN
                            Maintain := Weekly90 * MinimumInv;
                        END;
                        ///FORECAST vs HISTORY end

                        //Average Weekly USAGE(Last 90days) ends----------------------------------------------------------------


                        //SM 05-22-20  Added actual shipment of last 26 weeks to 14 weeks as Weekly180
                        //Average Weekly USAGE(Last 90days) starts----------------------------------------------------------------
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);

                        //SM 05-22-20  Average shipment of last 13weeks
                        //ItemLedgerEntry.SETRANGE("Posting Date",PeriodStartingDate[10]-84,PeriodStartingDate[10] - 1);
                        //Change from 12weeks to 13 weeks
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[18] - 182, PeriodStartingDate[18] - 92);

                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //Weekly90 := ROUND(-ItemLedgerEntry.Quantity/12,1,'>');
                        weekly180 := ROUND(-ItemLedgerEntry.Quantity / 13, 1, '>');
                        //SM 05-22-20


                        //Average Weekly USAGE(Last 90days) ends----------------------------------------------------------------
                        // SM 05-22-20


                        //SM 06-11-20  Added actual shipment of last 39 weeks to 27 weeks as Weekly270
                        //Average Weekly USAGE(Last 90days) starts----------------------------------------------------------------
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);

                        //SM 05-22-20  Average shipment of last 13weeks
                        //ItemLedgerEntry.SETRANGE("Posting Date",PeriodStartingDate[10]-84,PeriodStartingDate[10] - 1);
                        //Change from 12weeks to 13 weeks
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[18] - 273, PeriodStartingDate[18] - 183);

                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //Weekly90 := ROUND(-ItemLedgerEntry.Quantity/12,1,'>');
                        weekly270 := ROUND(-ItemLedgerEntry.Quantity / 13, 1, '>');
                        //SM 06-11-20


                        //Average Weekly USAGE(Last 90days) ends----------------------------------------------------------------
                        // SM 06-11-20

                        //SM 06-11-20  Added actual shipment of last 40 weeks to 52 weeks as Weekly360
                        //Average Weekly USAGE(Last 90days) starts----------------------------------------------------------------
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);

                        //SM 05-22-20  Average shipment of last 13weeks
                        //ItemLedgerEntry.SETRANGE("Posting Date",PeriodStartingDate[10]-84,PeriodStartingDate[10] - 1);
                        //Change from 12weeks to 13 weeks
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[18] - 365, PeriodStartingDate[18] - 274);

                        ItemLedgerEntry.CALCSUMS(Quantity);
                        //Weekly90 := ROUND(-ItemLedgerEntry.Quantity/12,1,'>');
                        weekly365 := ROUND(-ItemLedgerEntry.Quantity / 13, 1, '>');
                        //SM 06-11-20


                        //Average Weekly USAGE(Last 90days) ends----------------------------------------------------------------
                        // SM 06-11-20


                        //Forecast Quantity from Forecast Ledger Entry TABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[18], PeriodStartingDate[19] - 1);
                        //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');
                        // ItemLedgerEntry.SETRANGE("Location Code",'Mich');

                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        QtyTransferred[18] := ItemLedgerEntry.Quantity;

                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        QtySold[18] := -ItemLedgerEntry.Quantity;

                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                        ItemLedgerEntry.CALCSUMS(Quantity);
                        "Purchases (Qty.)" := ItemLedgerEntry.Quantity;

                        //QtyTransferred[10] := ItemLedgerEntry.Quantity;
                        SETRANGE("Date Filter", PeriodStartingDate[9], PeriodStartingDate[18] - 1);

                        CALCFIELDS(
                           "Qty. on Sales Order", "Qty. on Purch. Order");
                        //"Qty. on Sales Order","Qty. on Purch. Order",
                        //  "Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)","Transferred (Qty.)");
                        // "Positive Adjmt. (Qty.)","Negative Adjmt. (Qty.)");
                        //QtyTransferred[9] := "Transferred (Qty.)";
                        //QtySold[9] := "Sales (Qty.)";
                        // QtyOnSalesOrders[9] := "Qty. on Sales Order";
                        // QtyOnPurchOrders[9] := "Qty. on Purch. Order";
                        QtyPurchased[18] := "Purchases (Qty.)";

                        // QtyOnPosAdj[9] := "Positive Adjmt. (Qty.)";
                        // QtyOnNegAdj[9]:="Negative Adjmt. (Qty.)";


                        //Entry No.,Item No.,Customer No.,Forecast Quantity,Shipping Date,Division Code
                        ForecastLedgerEntry.SETCURRENTKEY("Entry No.", "Item No.", "Customer No.", "Shipping Date", "Forecast Quantity", "Division Code");
                        COPYFILTER("Global Dimension 1 Filter", ForecastLedgerEntry."Division Code");
                        ForecastLedgerEntry.SETRANGE("Item No.", "No.");
                        ForecastLedgerEntry.SETRANGE("Customer No.");
                        ForecastLedgerEntry.SETRANGE("Shipping Date", PeriodStartingDate[18], PeriodStartingDate[19] - 1);

                        //>> NF1.00:CIS.NG  08-22-16
                        //IF Item.GETFILTER("Global Dimension 1 Code") <> '' THEN
                        //  ForecastLedgerEntry.SETFILTER("Division Code",Item.GETFILTER("Global Dimension 1 Code"));
                        //<< NF1.00:CIS.NG  08-22-16


                        //SM 03-27-23 Eliminated
                        //SM 002 10-14-16
                        // IF ("No."= '90105-10406') THEN BEGIN
                        //ForecastLedgerEntry.SETFILTER("Division Code",'TENN');

                        //END ELSE IF ("No."= '92616-60818') THEN BEGIN
                        //ForecastLedgerEntry.SETFILTER("Division Code",'TENN');

                        // END ELSE BEGIN
                        //ForecastLedgerEntry.SETFILTER("Division Code",'MPD|IBN|MICH');
                        //END;

                        //SM 002 10-14-16
                        //SM 03-27-23 Eliminated


                        ForecastLedgerEntry.CALCSUMS("Forecast Quantity");




                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[18], PeriodStartingDate[19] - 1);
                        // ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'TENN');
                        //ItemLedgerEntry.SETRANGE("Global Dimension 1 Code",'Mich');

                        SETRANGE("Date Filter", PeriodStartingDate[17], PeriodStartingDate[18] - 1);

                        CALCFIELDS(
                          "Qty. on Sales Order", "Qty. on Purch. Order",
                          "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)", "Transferred (Qty.)");
                        QtyOnSalesOrders[18] := "Qty. on Sales Order";
                        QtyOnPurchOrders[18] := "Qty. on Purch. Order";
                        //  QtyTransferred[9] := "Transferred (Qty.)";



                        IF ForecastLedgerEntry."Forecast Quantity" - QtySold[18] - QtyOnSalesOrders[18] >= 0 THEN BEGIN
                            ForecastQty[18] := ForecastLedgerEntry."Forecast Quantity" - QtySold[18] - QtyOnSalesOrders[18];


                        END ELSE IF ForecastLedgerEntry."Forecast Quantity" - QtySold[18] - QtyOnSalesOrders[18] < 0 THEN BEGIN
                            ForecastQty[18] := 0;

                        END;


                        //MESSAGE:=FORMAT(PeriodStartingDate[1]);
                        //MESSAGE:=FORMAT(QtySold[1]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[2]);
                        //MESSAGE:=FORMAT(QtySold[2]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[3]);
                        //MESSAGE:=FORMAT(QtySold[3]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[4]);
                        //MESSAGE:=FORMAT(QtySold[4]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[5]);
                        //MESSAGE:=FORMAT(QtySold[5]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[6]);
                        //MESSAGE:=FORMAT(QtySold[6]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[7]);
                        //MESSAGE:=FORMAT(QtySold[7]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[8]);
                        //MESSAGE:=FORMAT(QtySold[8]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[9]);
                        //MESSAGE:=FORMAT(QtySold[9]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[10]);
                        //MESSAGE:=FORMAT(QtySold[10]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[11]);
                        //MESSAGE:=FORMAT(QtySold[11]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[12]);
                        //MESSAGE:=FORMAT(QtySold[12]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[13]);
                        //MESSAGE:=FORMAT(QtySold[13]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[14]);
                        //MESSAGE:=FORMAT(QtySold[14]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[15]);
                        //MESSAGE:=FORMAT(QtySold[15]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[16]);
                        //MESSAGE:=FORMAT(QtySold[16]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[17]);
                        //MESSAGE:=FORMAT(QtySold[17]);
                        //MESSAGE:=FORMAT(PeriodStartingDate[18]);
                        //MESSAGE:=FORMAT(QtySold[18]);







                        IF ForecastQty[18] > 0 THEN BEGIN
                            TotalForecast[18] := OnHand[18] - ForecastQty[18] + QtyOnPurchOrders[18] - QtyOnSalesOrders[18]
                            + QtyPurchased[18] - QtySold[18] + QtyTransferred[18];
                            // +QtyOnNegAdj[9]+QtyOnPosAdj[9];
                            // +QtyPurchased[9] - QtySold[9]-OTW[9]+OTW[1]+MPD[1]-MPD[2]+DIVIT[1]-DIVIT[2];

                        END ELSE IF ForecastQty[18] = 0 THEN BEGIN
                            TotalForecast[18] := OnHand[18] + QtyOnPurchOrders[18] - QtyOnSalesOrders[18]
                            + QtyPurchased[18] - QtySold[18] + QtyTransferred[18];
                            // +QtyOnNegAdj[2]+QtyOnPosAdj[2];
                            //+QtyPurchased[2] - QtySold[2]-OTW[2]+OTW[1]+MPD[1]-MPD[2]+DIVIT[1]-DIVIT[2];
                        END;

                        //New Version on 5/31/07

                        IF (MinOrdQ <= -(TotalForecast[18] - MaxInvQ)) AND
                        //(TotalForecast[2]+MPD[2]+OTW[2]+DIVIT[2]<Maintain) AND (AveForecast>0)THEN  BEGIN
                        (TotalForecast[18] < Maintain) AND (SNP > 0) THEN BEGIN
                            PurchaseNeeds[18] := SNP * ROUND((MaxInvQ - (TotalForecast[18])) / SNP, 1, '>');

                        END ELSE IF (MinOrdQ > (MaxInvQ - TotalForecast[18])) AND
                        //(TotalForecast[2]+MPD[2]+OTW[2]+DIVIT[2]<Maintain) AND (AveForecast>0)THEN  BEGIN
                        (TotalForecast[18] < Maintain) AND (SNP > 0) THEN BEGIN
                            PurchaseNeeds[18] := SNP * ROUND((MinOrdQ) / SNP, 1, '>');

                        END;


                        IF AveForecast <> 0 THEN BEGIN
                            WeekOnHand[18] := (OnHand[18] + QtyPurchased[18] + QtyTransferred[18] + QtyOnPurchOrders[18]) / (AveForecast);
                            NewWeek[18] := FORMAT(ROUND(WeekOnHand[18], 0.1));

                        END ELSE IF (AveForecast = 0) AND (Weekly90 > 0) THEN BEGIN
                            WeekOnHand[18] := (OnHand[18] + QtyPurchased[18] + QtyTransferred[18] + QtyOnPurchOrders[18]) / (Weekly90);
                            NewWeek[18] := FORMAT(ROUND(WeekOnHand[18], 0.1));


                            //NewWeek[2]:='N/A';

                        END;


                    END ELSE IF i > 18 THEN BEGIN
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
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
                        IF i = 19 THEN BEGIN
                            //>> NF1.00:CIS.CM  09/29/15
                            //OnHand[i] := TotalForecast[i-1]+"Qty. on Prod. Kit Lines";
                            OnHand[i] := TotalForecast[i - 1];
                            //<< NF1.00:CIS.CM  09/29/15
                        END;

                        IF i <> 19 THEN BEGIN
                            OnHand[i] := TotalForecast[i - 1];
                        END;

                        //OnHand[i] := TotalForecast[i-1]+PurchaseNeeds[i-1]+OTW[i-1]+DIVIT[i-1]+MPD[i-1];
                        //April 24 2007 added
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
                        COPYFILTER("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                        //COPYFILTER("Global Dimension 2 Filter",ItemLedgerEntry."Global Dimension 2 Code");
                        COPYFILTER("Location Filter", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry.SETRANGE("Item No.", "No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", PeriodStartingDate[i], PeriodStartingDate[i + 1] - 1);



                        //QTYSOLD
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
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

                        //>> NF1.00:CIS.NG  08-22-16
                        //IF Item.GETFILTER("Global Dimension 1 Code") <> '' THEN
                        //  ForecastLedgerEntry.SETFILTER("Division Code",Item.GETFILTER("Global Dimension 1 Code"));
                        //<< NF1.00:CIS.NG  08-22-16

                        //SM 001 09-13-16
                        IF ("No." = 'MU0035') THEN BEGIN
                            ForecastLedgerEntry.SETFILTER("Division Code", 'MPD|MICH|IBN');
                        END;
                        //ForecastLedgerEntry.SETFILTER("Division Code",'TENN');
                        //ForecastLedgerEntry.SETFILTER("Division Code",ForecastLedgerEntry.GETFILTER("Division Code"));
                        //SM 001 09-13-16



                        ForecastLedgerEntry.CALCSUMS("Forecast Quantity");

                        //  ForecastQty[i]:=ForecastLedgerEntry."Forecast Quantity"-QtySold[i]- QtyOnSalesOrders[i];

                        //    IF (PeriodStartingDate[i]>=T) THEN BEGIN
                        //    ForecastQty[i]:=ForecastLedgerEntry."Forecast Quantity";

                        //        END ELSE IF (PeriodStartingDate[i]<T) THEN BEGIN
                        //    ForecastQty[i]:=0;
                        //          END;

                        TotalForecast2 := ForecastQty[17 + 8] + ForecastQty[18 + 8] + ForecastQty[19 + 8] + ForecastQty[20 + 8] + ForecastQty[21 + 8] + ForecastQty[22 + 8]
                        + ForecastQty[23 + 8] + ForecastQty[24 + 8] + ForecastQty[25 + 8] + ForecastQty[26 + 8] + ForecastQty[27 + 8];


                    END;

                    ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                  "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
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

                    END ELSE IF ForecastLedgerEntry."Forecast Quantity" - QtySold[i] - QtyOnSalesOrders[i] < 0 THEN BEGIN
                        ForecastQty[i] := 0
                    END;

                    IF i = 1 THEN BEGIN
                        QtySold[1] := 0;
                        QtyPurchased[1] := 0;
                        QtyAdjusted[1] := 0;
                        QtyTransferred[1] := 0;
                        QtyAvailable[1] := OnHand[1] + QtyOnPurchOrders[1] - QtyOnSalesOrders[1] - QtyOnForecast[1];


                    END ELSE IF i > 18 THEN BEGIN
                        ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Drop Shipment",
                                                      "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Posting Date");//, "QC Hold"); BC Upgrade
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


                        END ELSE IF ForecastQty[i] <= 0 THEN BEGIN
                            TotalForecast[i] := OnHand[i] + QtyOnPurchOrders[i] - QtyOnSalesOrders[i]
                            + QtyPurchased[i] - QtySold[i] + QtyAdjusted[i] + QtyTransferred[i];
                        END;


                        //WeekonHand
                        IF AveForecast <> 0 THEN BEGIN
                            WeekOnHand[i] := (OnHand[i] + QtyPurchased[i] + QtyTransferred[i] + QtyOnPurchOrders[i]) / (AveForecast);
                            //WeekOnHand[i]:= TotalForecast[i]/(AveForecast);
                            NewWeek[i] := FORMAT(ROUND(WeekOnHand[i], 0.1));

                        END ELSE IF (AveForecast = 0) AND (Weekly90 > 0) THEN BEGIN
                            WeekOnHand[i] := (OnHand[i] + QtyPurchased[i] + QtyTransferred[i] + QtyOnPurchOrders[i]) / (Weekly90);
                            //WeekOnHand[i]:= TotalForecast[i]/(AveForecast);
                            NewWeek[i] := FORMAT(ROUND(WeekOnHand[i], 0.1));


                            //NewWeek[i]:='N/A';

                        END;



                        //Day On Hand -----------------------------------------

                        IF Daily42 = 0 THEN BEGIN
                            DayOnHand := 0;
                        END ELSE IF Daily42 <> 0 THEN BEGIN
                            DayOnHand := OnHand[2] / Daily42;
                        END;

                        //Purchase Needs Calculation
                        IF (AveForecast > 0) AND (MaximumInv * AveForecast > (MinOrdQ + Maintain)) OR (SNP = 0) THEN BEGIN
                            MaxInvQ := MaximumInv * AveForecast

                        END ELSE IF (AveForecast > 0) AND (MaximumInv * AveForecast <= (MinOrdQ + Maintain)) THEN BEGIN
                            MaxInvQ := MaximumInv * AveForecast

                        END ELSE IF (AveForecast = 0) AND (Weekly90 > 0) THEN BEGIN
                            MaxInvQ := MaximumInv * Weekly90

                            //END ELSE IF (MaximumInv*AveForecast<=(MinOrdQ+Maintain)) THEN BEGIN
                            //MaxInvQ:= MinOrdQ+Maintain

                        END;

                        LT := "Lead Time";

                        IF (MinOrdQ <= -(TotalForecast[i] - MaxInvQ)) AND
                        //(TotalForecast[i]<Maintain) AND (AveForecast>0)THEN  BEGIN
                        (TotalForecast[i] < Maintain) AND (SNP > 0) THEN BEGIN
                            PurchaseNeeds[i] := SNP * ROUND((MaxInvQ - (TotalForecast[i])) / SNP, 1, '>');

                        END ELSE IF (MinOrdQ > (MaxInvQ - TotalForecast[i])) AND
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

                        //Order Timing
                        IF (LT = 1) THEN BEGIN
                            Order[9] := PurchaseNeeds[10];
                        END ELSE IF (LT = 2) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11];

                        END ELSE IF (LT = 3) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12];

                        END ELSE IF (LT = 4) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13];

                        END ELSE IF (LT = 5) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                     PurchaseNeeds[14];

                        END ELSE IF (LT = 6) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                     PurchaseNeeds[14] + PurchaseNeeds[15];

                        END ELSE IF (LT = 7) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                     PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16];

                        END ELSE IF (LT = 8) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                     PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17];

                        END ELSE IF (LT = 9) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                     PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18];

                        END ELSE IF (LT = 10) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                     PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18] + PurchaseNeeds[19];

                        END ELSE IF (LT = 11) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                    PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18] + PurchaseNeeds[19]
                                     + PurchaseNeeds[20];

                        END ELSE IF (LT = 12) THEN BEGIN
                            Order[9] := PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] + PurchaseNeeds[13] +
                                    PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18] + PurchaseNeeds[19]
                                     + PurchaseNeeds[20] + PurchaseNeeds[21];

                        END ELSE IF (LT = 13) THEN BEGIN
                            Order[9] := PurchaseNeeds[22] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21];

                        END ELSE IF (LT = 14) THEN BEGIN
                            Order[9] := PurchaseNeeds[23] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22];

                        END ELSE IF (LT = 15) THEN BEGIN
                            Order[9] := PurchaseNeeds[24] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23];

                        END ELSE IF (LT = 16) THEN BEGIN
                            Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24];

                        END ELSE IF (LT = 17) THEN BEGIN
                            Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                     + PurchaseNeeds[26];

                        END ELSE IF (LT = 18) THEN BEGIN
                            Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                     + PurchaseNeeds[26] + PurchaseNeeds[27];

                        END ELSE IF (LT = 19) THEN BEGIN
                            Order[9] := PurchaseNeeds[25] + PurchaseNeeds[10] + PurchaseNeeds[11] + PurchaseNeeds[12] +
                                    PurchaseNeeds[13] + PurchaseNeeds[14] + PurchaseNeeds[15] + PurchaseNeeds[16] + PurchaseNeeds[17] + PurchaseNeeds[18]
                                     + PurchaseNeeds[19] + PurchaseNeeds[20] + PurchaseNeeds[21] + PurchaseNeeds[22] + PurchaseNeeds[23] + PurchaseNeeds[24]
                                     + PurchaseNeeds[26] + PurchaseNeeds[27] + PurchaseNeeds[28];

                        END ELSE IF (LT = 20) THEN BEGIN
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
                    field(PeriodStartingDate; PeriodStartingDate[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(PeriodCalculation; PeriodCalculation)
                    {
                        ApplicationArea = All;
                        Caption = 'Length of Period';
                    }
                    field(ExportToExcel; ExportToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Export To Excel';
                    }
                    field(ShowDetails; ShowDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer, Sales, Purhcase Details';
                    }
                    field(ShowDetailDetroit; ShowDetailDetroit)
                    {
                        ApplicationArea = All;
                        Caption = 'Cross Ref. Info.';
                    }
                    field(ShowAge; ShowAge)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Inventory Age';
                        Visible = false;
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

            //ExcelBuf_gRecTmp.CreateBookAndOpenExcel(MainTitle,MainTitle,COMPANYNAME,USERID);BC Upgrade
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


        Title := Text000;

        PeriodStartingDate[1] := 0D;
        Date.RESET;
        Date.SETRANGE("Period Type", Date."Period Type"::Week);
        Date.SETFILTER("Period Start", '<=%1', PeriodStartingDate[2] - 112);    //SM 02-20-23 Standardize Change from 56 to 112
        Date.FIND('+');
        PeriodStartingDate[2] := Date."Period Start";
        PeriodStartingText[2] := 'WK' + FORMAT(Date."Period No.");

        Date.SETRANGE("Period Start");

        FOR i := 2 TO 85 DO BEGIN
            Date.NEXT;
            PeriodStartingDate[i + 1] := Date."Period Start";
            PeriodStartingText[i + 1] := 'WK' + FORMAT(Date."Period No.");
        END;

        //Canada portion
        PeriodStartingDate[78] := 99991230D;
        PeriodStartingText[77] := 'after';

        //MESSAGE(FORMAT(PeriodStartingDate[77]));

        //canada portion
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemFilter: Text[250];
        Title: Text[50];
        NoVariant: Text[30];
        PrintFooter: Boolean;
        PeriodStartingDate: array[86] of Date;
        PrintSales: Boolean;
        PrintPurch: Boolean;
        PrintAdj: Boolean;
        PrintTrans: Boolean;
        OnHand: array[86] of Decimal;
        QtyAvailable: array[86] of Decimal;
        QtyOnPurchOrders: array[86] of Decimal;
        QtyOnSalesOrders: array[86] of Decimal;
        QtyOnForecast: array[86] of Decimal;
        QtySold: array[86] of Decimal;
        QtyPurchased: array[86] of Decimal;
        QtyAdjusted: array[86] of Decimal;
        QtyTransferred: array[86] of Decimal;
        i: Integer;
        PeriodCalculation: Code[10];
        Date: Record Date;
        PeriodStartingText: array[86] of Text[30];
        UseForecastBatch: array[86] of Code[20];
        DailyUsage: Decimal;
        DaysSupply: Integer;
        DelSchedBatch: Record "Delivery Schedule Batch";
        DelSchedHdr: Record "Delivery Schedule Header";
        DelSchedLine: Record "Delivery Schedule Line";
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
        QtyOnSalesOrdersDetail: array[86] of Decimal;
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        QtyOnPurchOrdersDetail: array[86] of Decimal;
        CumQtyExpected: Decimal;
        CumQtyActual: Decimal;
        SalesShptLine: Record "Sales Shipment Line";
        Text003: Label 'Before';
        d: Dialog;
        SubTitle: array[86] of Text[100];
        MinusWeekly: array[86] of Integer;
        MinimumInv: Decimal;
        PurchaseNeeds: array[86] of Decimal;
        ForecastQty: array[86] of Decimal;
        ForecastLedgerEntry: Record "Forecast Ledger Entry";
        Text000: Label 'Nifast Availability Projection Ver.1.0';
        TotalForecast: array[86] of Decimal;
        ForecastQty2: array[86] of Decimal;
        PurchSign: array[86] of Boolean;
        LT: Integer;
        "Order": array[86] of Decimal;
        RowNo: Integer;
        ColumnNo: Integer;
        ExportToExcel: Boolean;
        MainTitle: Text[30];
        Weekly90: Decimal;
        //[InDataSet]BC Upgrade
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
        ForecastQty3: array[86] of Decimal;
        AveForecast: Decimal;
        T: Date;
        EmuUp: array[86] of Decimal;
        EmuLow: array[86] of Decimal;
        EmuMid: array[86] of Decimal;
        ShowDetails3: Boolean;
        ProductionDate: Date;
        WeekOnHand: array[86] of Decimal;
        NewWeek: array[86] of Text[30];
        InvtQty: Decimal;
        Over: Integer;
        ShowAge: Boolean;
        WarehouseEntry: Record "Warehouse Entry";
        BQ: Decimal;
        OTW: array[86] of Decimal;
        BlockedQty: Decimal;
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
        Sales_Invoice_LinesCaptionLbl: Label 'Sales Inv. Lines';
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
        ForecastLedgEntry: Record "Forecast Ledger Entry";
        ForecastEntryFound: Boolean;
        Text50000_gCtx: Label 'Company Name';
        Text50001_gCtx: Label 'Report Name';
        Text50002_gCtx: Label 'Availability US MPD';
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
        Text50016_gCtx: Label 'Shpmt Actl 13wk';
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
        PurchLine_gRec: Record "Purchase Line";
        SalesLine_gRec: Record "Sales Line";
        ForeCastEntryExist_gBln: Boolean;
        PurchLineExist_gBln: Boolean;
        SalesLineExist_gBln: Boolean;
        Text50036_gCtx: Label 'EOP';
        Text50037_gCtx: Label 'EMU';
        Text50038_gCtx: Label 'Pcs/Vehicle';
        Text50039_gCtx: Label 'MODEL';
        Vendor_gRec: Record Vendor;
        HideNewLineInItem_gBln: Boolean;
        POList_gCodArr: array[86] of Code[20];
        POListCount_gInt: Integer;
        EndLineExecute_gBln: Boolean;
        ForCastCust_gCodArr: array[86] of Code[20];
        ForCastCust_gInt: Integer;
        ForecastFilter: Code[70];
        blockedLotQty: Decimal;
        weekly180: Decimal;
        weekly270: Decimal;
        weekly365: Decimal;
        x: Integer;
        LotNo_Cap: Label 'Lot No.';
        Inventory_Cap: Label 'Inventory';
        LotCreationDate_Cap: Label 'Lot Creation Date';
        InvAge_Cap: Label 'Inv. Age (Days)';

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
        ExcelBuf_gRecTmp.AddInfoColumn(REPORT::"Forecast Module", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
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
        //ExcelBuf_gRecTmp.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50008_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchasing Policy', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
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
            ExcelBuf_gRecTmp.AddColumn(ItemCategory_lRec.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        END;
        //<< NF1.00:CIS.NG  07-18-16

        // SM Standardize Purchasing Policy
        ExcelBuf_gRecTmp.AddColumn(Item."Purchasing Policy", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);


        // SM Standardize Purchasing Policy

        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50009_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MinimumInv, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50010_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Maintain, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        //ExcelBuf_gRecTmp.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50011_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(OTW[18], FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('Remarks', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50012_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MaximumInv, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50013_gCtx, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MaxInvQ, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        //ExcelBuf_gRecTmp.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50014_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(BQ, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Item."Free Form", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50015_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Item."Lead Time", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50016_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Weekly90, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('Avg Shp -26wk to -14wk', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(weekly180, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        //ExcelBuf_gRecTmp.AddColumn('Remarks',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);

        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50017_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(SNP, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50018_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(AveForecast, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn('Avg Shp -39wk to -27wk', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(weekly270, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);


        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50019_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(MinOrdQ, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn(Text50020_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Avg Shp -40wk to -52wk', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(weekly365, FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
    end;

    local procedure MakeExcelItemDataBody_lFnc()
    var
        CurrencyCodeToPrint: Code[20];
        p: Integer;
        CalPOQty_lDec: Decimal;
        c: Integer;
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
            //>> NF1.00:CIS.NG  08-22-16
            //ExcelBuf_gRecTmp.AddColumn(ForecastLedgEntry_gRec."Customer No.",FALSE,'@',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
            //ExcelBuf_gRecTmp.AddColumn(ForecastLedgEntry_gRec."Customer No.",FALSE,'@',FALSE,FALSE,FALSE,'',ExcelBuf_gRecTmp."Cell Type"::Text);
            FOR c := 1 TO ForCastCust_gInt DO BEGIN
                ExcelBuf_gRecTmp.AddColumn(ForCastCust_gCodArr[c], FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(ForCastCust_gCodArr[c], FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            END;
            //<< NF1.00:CIS.NG  08-22-16
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
            //>> NF1.00:CIS.NG  08-22-16
            FOR c := 1 TO ForCastCust_gInt DO BEGIN
                //<< NF1.00:CIS.NG  08-22-16
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(Text50034_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            END;  //NF1.00:CIS.NG  08-22-16
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
        FOR i := 1 TO 77 DO BEGIN     //SM Standard
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
            IF i > 1 THEN BEGIN
                ExcelBuf_gRecTmp.AddColumn(PeriodStartingDate[i], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);
                ExcelBuf_gRecTmp.AddColumn(OnHand[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                IF i < 19 THEN
                    ExcelBuf_gRecTmp.AddColumn(QtyTransferred[i] + QtyPurchased[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number)
                ELSE
                    ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn(QtyOnPurchOrders[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                IF i > 17 THEN
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
                    //>> NF1.00:CIS.NG  08-22-16
                    FOR c := 1 TO ForCastCust_gInt DO BEGIN
                        GetForcastCostValue_lFnc(ForCastCust_gCodArr[c]);
                        //<< NF1.00:CIS.NG  08-22-16

                        ExcelBuf_gRecTmp.AddColumn(ForecastQty2[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
                        ExcelBuf_gRecTmp.AddColumn(ForecastQty3[i], FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);

                    END;  //NF1.00:CIS.NG  08-22-16
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
                        //SM 03-27-23 Eliminated
                        //PurchLine_gRec.SETRANGE("Shortcut Dimension 1 Code",'MPD');
                        //SM 03-27-23 Eliminated
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
                IF ForeCastEntryExist_gBln THEN BEGIN  //NF1.00:CIS.NG  07-29-16

                    //>> NF1.00:CIS.NG  08-22-16
                    FOR c := 1 TO ForCastCust_gInt DO BEGIN
                        //<< NF1.00:CIS.NG  08-22-16
                        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
                    END;  //NF1.00:CIS.NG  08-22-16

                END;  //NF1.00:CIS.NG  07-29-16

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
                        //SM 03-27-23 Eliminated
                        //PurchLine_gRec.SETRANGE("Shortcut Dimension 1 Code",'MPD');
                        //SM 03-27-23 Eliminated
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
        ExcelBuf_gRecTmp.AddColumn('Blocked', FALSE, '', FALSE, FALSE, FALSE, '#,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
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
        ExcelBuf_gRecTmp.AddColumn("Lot No. Information".Blocked, FALSE, '@', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelVehicleProdHeader_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50036_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50037_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50038_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn(Text50039_gCtx, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('PPAP Approved Date', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Customer No.', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

        //4-2-20 SM
        ExcelBuf_gRecTmp.AddColumn('SOP', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Remarks', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
    end;

    local procedure MakeExcelVehicleProdBody_lFnc()
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".EOP, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".EMU, FALSE, '', FALSE, FALSE, FALSE, '#,##,##0', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production"."Pieces Per Vehicle", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Number);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".Model, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

        ExcelBuf_gRecTmp.AddColumn("Vehicle Production"."PPAP Approved Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Date);
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production"."Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);

        //4-2-20 SM
        ExcelBuf_gRecTmp.AddColumn("Vehicle Production".SOP, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRecTmp."Cell Type"::Text);
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
        ForecastLedgEntry_lRec: Record "Forecast Ledger Entry";
        PreCustNo_iCod: Code[20];
    begin
        //>> NF1.00:CIS.NG  07-18-16
        CLEAR(ForecastQty2);
        CLEAR(ForecastQty3);
        //<< NF1.00:CIS.NG  07-18-16


        //>> NF1.00:CIS.NG  08-22-16
        CLEAR(ForCastCust_gCodArr);
        ForCastCust_gInt := 0;
        PreCustNo_iCod := '';
        //<< NF1.00:CIS.NG  08-22-16

        ForecastLedgEntry_lRec.RESET;
        ForecastLedgEntry_lRec.SETCURRENTKEY("Customer No.", "Division Code");
        ForecastLedgEntry_lRec.ASCENDING(TRUE);
        ForecastLedgEntry_lRec.SETRANGE("Item No.", Item."No.");

        //>> NF1.00:CIS.NG  08-22-16
        //IF Item.GETFILTER("Global Dimension 1 Code") <> '' THEN
        //  ForecastLedgEntry_lRec.SETFILTER("Division Code",Item.GETFILTER("Global Dimension 1 Code"));
        //<< NF1.00:CIS.NG  08-22-16

        //SM 03-27-23 Eliminated
        //SM 001 09-13-16
        //ForecastLedgEntry_lRec.SETFILTER("Division Code",'MPD|MICH|IBN');
        ////ForecastLedgerEntry.SETFILTER("Division Code",ForecastLedgerEntry.GETFILTER("Division Code"));
        //SM 001 09-13-16
        //SM 03-27-23 Eliminated


        IF ForecastLedgEntry_lRec.FINDFIRST THEN BEGIN
            REPEAT
                ForeCastEntryExist_gBln := TRUE;

                //>> NF1.00:CIS.NG  08-22-16
                //    FOR i := 2 TO 45 DO
                //      IF (ForecastLedgEntry_gRec."Shipping Date" >= PeriodStartingDate[i]) AND
                //        (ForecastLedgEntry_gRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                //         (ForecastLedgEntry_gRec."Forecast Quantity"<>0)
                //         AND (NOT ForecastLedgEntry_gRec."Nifast Forecast")
                //      THEN
                //        ForecastQty2[i] += ForecastLedgEntry_gRec."Forecast Quantity";  //NF1.00:CIS.NG  07-18-16

                //    FOR i := 2 TO 45 DO
                //      IF (ForecastLedgEntry_gRec."Shipping Date" >= PeriodStartingDate[i]) AND
                //         (ForecastLedgEntry_gRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                //         (ForecastLedgEntry_gRec."Forecast Quantity"<>0)
                //         AND ForecastLedgEntry_gRec."Nifast Forecast"
                //      THEN
                //        ForecastQty3[i] += ForecastLedgEntry_gRec."Forecast Quantity";  //NF1.00:CIS.NG  07-18-16

                IF PreCustNo_iCod <> ForecastLedgEntry_lRec."Customer No." THEN BEGIN
                    ForCastCust_gInt += 1;
                    ForCastCust_gCodArr[ForCastCust_gInt] := ForecastLedgEntry_lRec."Customer No.";
                    PreCustNo_iCod := ForecastLedgEntry_lRec."Customer No."
                END;
            //<< NF1.00:CIS.NG  08-22-16

            UNTIL ForecastLedgEntry_lRec.NEXT = 0;
        END;

        POListCount_gInt := 0;  //NG-N
        PurchLine_gRec.RESET;
        PurchLine_gRec.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment",
                                "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                "Location Code", "Expected Receipt Date");
        PurchLine_gRec.SETRANGE("Document Type", PurchLine_gRec."Document Type"::Order);
        PurchLine_gRec.SETRANGE(Type, PurchLine_gRec.Type::Item);
        PurchLine_gRec.SETRANGE("No.", Item."No.");
        //SM 03-27-23 Eliminated
        //PurchLine_gRec.SETRANGE("Shortcut Dimension 1 Code",'MPD');
        //SM 03-27-23 Eliminated
        PurchLine_gRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF PurchLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                PurchLineExist_gBln := TRUE;
                CLEAR(QtyOnPurchOrdersDetail);
                FOR i := 1 TO 85 DO BEGIN
                    IF (PurchLine_gRec."Expected Receipt Date" >= PeriodStartingDate[i]) AND
                       (PurchLine_gRec."Expected Receipt Date" < PeriodStartingDate[i + 1])
                    THEN BEGIN
                        QtyOnPurchOrdersDetail[i] := PurchLine_gRec."Outstanding Qty. (Base)";
                        POListCount_gInt += 1;
                        POList_gCodArr[POListCount_gInt] := PurchLine_gRec."Document No.";
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
        //SM 03-27-23 Eliminated
        //SalesLine_gRec.SETRANGE("Shortcut Dimension 1 Code",'MPD');
        //SM 03-27-23 Eliminated
        SalesLine_gRec.SETFILTER("Outstanding Quantity", '<>%1', 0);

        IF SalesLine_gRec.FINDFIRST THEN BEGIN
            REPEAT
                SalesLineExist_gBln := TRUE;
                CLEAR(QtyOnSalesOrdersDetail);
                FOR i := 2 TO 85 DO
                    IF (SalesLine_gRec."Shipment Date" >= PeriodStartingDate[i]) AND
                       (SalesLine_gRec."Shipment Date" < PeriodStartingDate[i + 1]) THEN
                        QtyOnSalesOrdersDetail[i] := SalesLine_gRec."Outstanding Qty. (Base)";
            UNTIL SalesLine_gRec.NEXT = 0;

            IF NOT SalesHeader.GET(SalesLine_gRec."Document Type", SalesLine_gRec."Document No.") THEN
                CLEAR(SalesHeader);
        END;
    end;

    local procedure GetForcastCostValue_lFnc(CustomerNo_iCod: Code[20])
    var
        ForecastLedgEntry_lRec: Record "Forecast Ledger Entry";
    begin
        //>> NF1.00:CIS.NG  08-22-16
        CLEAR(ForecastQty2);
        CLEAR(ForecastQty3);

        ForecastLedgEntry_lRec.RESET;
        ForecastLedgEntry_lRec.SETCURRENTKEY("Customer No.", "Division Code");
        ForecastLedgEntry_lRec.ASCENDING(TRUE);
        ForecastLedgEntry_lRec.SETRANGE("Item No.", Item."No.");
        ForecastLedgEntry_lRec.SETRANGE("Customer No.", CustomerNo_iCod);

        //IF Item.GETFILTER("Global Dimension 1 Code") <> '' THEN
        //ForecastLedgEntry_lRec.SETFILTER("Division Code",Item.GETFILTER("Global Dimension 1 Code"));

        //SM 03-27-23 Eliminated
        // SM 001 009-13-16
        //ForecastLedgEntry_lRec.SETFILTER("Division Code",'MPD|MICH|IBN');
        ////ForecastLedgerEntry.SETFILTER("Division Code",ForecastLedgerEntry.GETFILTER("Division Code"));
        // SM 001 009-13-16
        //SM 03-27-23 Eliminated

        IF ForecastLedgEntry_lRec.FINDFIRST THEN BEGIN
            REPEAT

                IF (ForecastLedgEntry_lRec."Shipping Date" >= PeriodStartingDate[i]) AND
                  (ForecastLedgEntry_lRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                   (ForecastLedgEntry_lRec."Forecast Quantity" <> 0)
                   AND (NOT ForecastLedgEntry_lRec."Nifast Forecast")
                THEN
                    ForecastQty2[i] += ForecastLedgEntry_lRec."Forecast Quantity";


                IF (ForecastLedgEntry_lRec."Shipping Date" >= PeriodStartingDate[i]) AND
                   (ForecastLedgEntry_lRec."Shipping Date" < PeriodStartingDate[i + 1]) AND
                   (ForecastLedgEntry_lRec."Forecast Quantity" <> 0)
                   AND ForecastLedgEntry_lRec."Nifast Forecast"
                THEN
                    ForecastQty3[i] += ForecastLedgEntry_lRec."Forecast Quantity";

            UNTIL ForecastLedgEntry_lRec.NEXT = 0;
        END;
        //<< NF1.00:CIS.NG  08-22-16
    end;
}
