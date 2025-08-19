page 80117 "API CR Combined Lines"
{
    PageType = API;
    Caption = 'Cash Receipt Line (All)';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'cashReceiptAllLine';
    EntitySetName = 'cashReceiptsAllLines';
    SourceTable = "CR Combined Line View";
    ODataKeyFields = Id;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                }
                field(headerId; Rec."Header Id")
                {
                    Caption = 'Header Id';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
            }
        }
    }
}

