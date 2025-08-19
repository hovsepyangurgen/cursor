page 50112 "Posted Cash Receipts API"
{
    PageType = API;
    APIPublisher = 'contoso';
    APIGroup = 'cash';
    APIVersion = 'v1.0';
    EntityName = 'postedCashReceipt';
    EntitySetName = 'postedCashReceipts';
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = where("Document Type" = const(Payment));
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
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }
            }
            part(Applications; "Posted Cash Receipt Applications API")
            {
                EntityName = 'applications';
                EntitySetName = 'applications';
                SubPageLink = "Cust. Ledger Entry No." = field("Entry No.");
            }
        }
    }
}

