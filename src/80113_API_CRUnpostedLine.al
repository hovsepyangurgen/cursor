page 80113 "API CR Unposted Lines"
{
    PageType = API;
    Caption = 'Unposted Cash Receipt Line';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'unpostedCashReceiptLine';
    EntitySetName = 'unpostedCashReceiptLines';
    SourceTable = "Gen. Journal Line";
    ODataKeyFields = "Journal Template Name", "Journal Batch Name", "Document No.", "Line No.";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
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

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
        Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        Rec.SetRange("Document No.", Rec."Document No.");
    end;
}

