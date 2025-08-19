page 50113 "Posted Cash Receipt Applications API"
{
    PageType = API;
    APIPublisher = 'contoso';
    APIGroup = 'cash';
    APIVersion = 'v1.0';
    EntityName = 'postedCashReceiptApplication';
    EntitySetName = 'postedCashReceiptApplications';
    SourceTable = "Detailed Cust. Ledg. Entry";
    SourceTableView = where("Entry Type" = const(Application));
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System Id';
                    Editable = false;
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(custLedgerEntryNo; Rec."Cust. Ledger Entry No.")
                {
                    Caption = 'Cust. Ledger Entry No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
            }
        }
    }
}

