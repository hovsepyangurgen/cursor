page 50111 "Cash Receipt Journal Lines API"
{
    PageType = API;
    APIPublisher = 'contoso';
    APIGroup = 'cash';
    APIVersion = 'v1.0';
    EntityName = 'cashReceiptLine';
    EntitySetName = 'cashReceiptLines';
    SourceTable = "Gen. Journal Line";
    SourceTableView = where("Journal Template Name" = const('CASH RECEIPTS'));
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        LastLine: Record "Gen. Journal Line";
        NextLineNo: Integer;
    begin
        if Rec."Line No." = 0 then begin
            LastLine.Reset();
            LastLine.SetRange("Journal Template Name", Rec."Journal Template Name");
            LastLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
            if LastLine.FindLast() then
                NextLineNo := LastLine."Line No." + 10000
            else
                NextLineNo := 10000;
            Rec."Line No." := NextLineNo;
        end;
        exit(false);
    end;

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
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
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
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }
}

