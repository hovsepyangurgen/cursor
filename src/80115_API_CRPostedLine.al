page 80115 "API CR Posted Lines"
{
    PageType = API;
    Caption = 'Posted Cash Receipt Line';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'postedCashReceiptLine';
    EntitySetName = 'postedCashReceiptLines';
    SourceTable = "Cust. Ledger Entry";
    ODataKeyFields = "Entry No.";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Document Type", Rec."Document Type"::Payment);
    end;
}

