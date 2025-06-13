table 80091 "TEMP - Fix Cust. Ledger Entry"
{
    fields
    {
        field(1;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
        }
        field(3;"Customer No.";Code[20])
        {
            Caption = 'Customer No.';
        }
        field(4;"Posting Date";Date)
        {
            Caption = 'Posting Date';
        }
        field(5;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(7;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(11;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
        }
        field(13;Amount;Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(14;"Remaining Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(15;"Original Amt. (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Amt. ($)';
            Editable = false;
        }
        field(16;"Remaining Amt. (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amt. ($)';
            Editable = false;
        }
        field(17;"Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount ($)';
            Editable = false;
        }
        field(18;"Sales (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales ($)';
        }
        field(19;"Profit (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit ($)';
        }
        field(20;"Inv. Discount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount ($)';
        }
        field(21;"Sell-to Customer No.";Code[20])
        {
            Caption = 'Sell-to Customer No.';
        }
        field(22;"Customer Posting Group";Code[10])
        {
            Caption = 'Customer Posting Group';
        }
        field(23;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
        }
        field(24;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
        }
        field(25;"Salesperson Code";Code[10])
        {
            Caption = 'Salesperson Code';
        }
        field(27;"User ID";Code[20])
        {
            Caption = 'User ID';
            //This property is currently not supported
            //TestTableRelation = false;
            
        }
        field(28;"Source Code";Code[10])
        {
            Caption = 'Source Code';
        }
        field(33;"On Hold";Code[3])
        {
            Caption = 'On Hold';
        }
        field(34;"Applies-to Doc. Type";Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(35;"Applies-to Doc. No.";Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(36;Open;Boolean)
        {
            Caption = 'Open';
        }
        field(37;"Due Date";Date)
        {
            Caption = 'Due Date';
        }
        field(38;"Pmt. Discount Date";Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(39;"Original Pmt. Disc. Possible";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Pmt. Disc. Possible';
            Editable = false;
        }
        field(40;"Pmt. Disc. Given (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Given ($)';
        }
        field(43;Positive;Boolean)
        {
            Caption = 'Positive';
        }
        field(44;"Closed by Entry No.";Integer)
        {
            Caption = 'Closed by Entry No.';
        }
        field(45;"Closed at Date";Date)
        {
            Caption = 'Closed at Date';
        }
        field(46;"Closed by Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
        }
        field(47;"Applies-to ID";Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(49;"Journal Batch Name";Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(50;"Reason Code";Code[10])
        {
            Caption = 'Reason Code';
        }
        field(51;"Bal. Account Type";Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(52;"Bal. Account No.";Code[20])
        {
            Caption = 'Bal. Account No.';
        }
        field(53;"Transaction No.";Integer)
        {
            Caption = 'Transaction No.';
        }
        field(54;"Closed by Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount ($)';
        }
        field(58;"Debit Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            Editable = false;
        }
        field(59;"Credit Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            Editable = false;
        }
        field(60;"Debit Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount ($)';
            Editable = false;
        }
        field(61;"Credit Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount ($)';
            Editable = false;
        }
        field(62;"Document Date";Date)
        {
            Caption = 'Document Date';
        }
        field(63;"External Document No.";Code[20])
        {
            Caption = 'External Document No.';
        }
        field(64;"Calculate Interest";Boolean)
        {
            Caption = 'Calculate Interest';
        }
        field(65;"Closing Interest Calculated";Boolean)
        {
            Caption = 'Closing Interest Calculated';
        }
        field(66;"No. Series";Code[10])
        {
            Caption = 'No. Series';
        }
        field(67;"Closed by Currency Code";Code[10])
        {
            Caption = 'Closed by Currency Code';
        }
        field(68;"Closed by Currency Amount";Decimal)
        {
            AutoFormatExpression = "Closed by Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
        }
        field(73;"Adjusted Currency Factor";Decimal)
        {
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0:15;
        }
        field(74;"Original Currency Factor";Decimal)
        {
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0:15;
        }
        field(75;"Original Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Amount';
            Editable = false;
        }
        field(76;"Date Filter";Date)
        {
            Caption = 'Date Filter';
        }
        field(77;"Remaining Pmt. Disc. Possible";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Pmt. Disc. Possible';
        }
        field(78;"Pmt. Disc. Tolerance Date";Date)
        {
            Caption = 'Pmt. Disc. Tolerance Date';
        }
        field(79;"Max. Payment Tolerance";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance';
        }
        field(80;"Last Issued Reminder Level";Integer)
        {
            Caption = 'Last Issued Reminder Level';
        }
        field(81;"Accepted Payment Tolerance";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Accepted Payment Tolerance';
        }
        field(82;"Accepted Pmt. Disc. Tolerance";Boolean)
        {
            Caption = 'Accepted Pmt. Disc. Tolerance';
        }
        field(83;"Pmt. Tolerance (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Tolerance (LCY)';
        }
        field(50000;"EDI Control No.";Code[20])
        {
            // cleaned
        }
        field(52000;"Mex. Factura No.";Code[20])
        {
            // cleaned
        }
    }
}
