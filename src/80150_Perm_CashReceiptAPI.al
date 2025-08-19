permissionset 80150 "CR API"
{
    Assignable = true;
    Caption = 'Cash Receipt API Access';

    Permissions =
        tabledata "CR Staging Header" = RIMD,
        tabledata "CR Staging Line" = RIMD,
        tabledata "CR Unposted Header View" = RIMD,
        tabledata "CR Posted Header View" = RIMD,
        tabledata "Gen. Journal Line" = RIMD,
        tabledata "Gen. Journal Batch" = R,
        tabledata "Gen. Journal Template" = R,
        tabledata "Cust. Ledger Entry" = R,
        tabledata Customer = R,
        tabledata Vendor = R,
        tabledata "G/L Account" = R,
        tabledata "Bank Account" = R,
        page "API CR Create Header" = X,
        page "API CR Create Lines" = X,
        page "API CR Unposted Header" = X,
        page "API CR Unposted Lines" = X,
        page "API CR Posted Header" = X,
        page "API CR Posted Lines" = X,
        page "API CR Combined Header" = X,
        page "API CR Combined Lines" = X,
        codeunit "CR View Builder" = X,
        codeunit "CR Journal Mgt" = X,
        codeunit "CR Create Endpoint" = X,
        codeunit "CR Combined Builder" = X;
}

