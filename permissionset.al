permissionset 50120 CashReceiptsApi
{
    Assignable = true;
    Caption = 'Cash Receipts API';

    Permissions =
        tabledata "Gen. Journal Batch" = RIMD,
        tabledata "Gen. Journal Line" = RIMD,
        tabledata "Cust. Ledger Entry" = R,
        tabledata "Detailed Cust. Ledg. Entry" = R,
        table "Gen. Journal Batch" = X,
        table "Gen. Journal Line" = X,
        table "Cust. Ledger Entry" = X,
        table "Detailed Cust. Ledg. Entry" = X,
        page "Cash Receipt Journals API" = X,
        page "Cash Receipt Journal Lines API" = X,
        page "Posted Cash Receipts API" = X,
        page "Posted Cash Receipt Applications API" = X;
}

