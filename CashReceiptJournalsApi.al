page 50110 "Cash Receipt Journals API"
{
    PageType = API;
    APIPublisher = 'contoso';
    APIGroup = 'cash';
    APIVersion = 'v1.0';
    EntityName = 'cashReceipt';
    EntitySetName = 'cashReceipts';
    SourceTable = "Gen. Journal Batch";
    SourceTableView = where("Journal Template Name" = const('CASH RECEIPTS'));
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
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
                field(journalBatchName; Rec.Name)
                {
                    Caption = 'Journal Batch Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }

            part(lines; "Cash Receipt Journal Lines API")
            {
                EntityName = 'cashReceiptLines';
                EntitySetName = 'cashReceiptLines';
                SubPageLink =
                    "Journal Template Name" = field("Journal Template Name"),
                    "Journal Batch Name" = field(Name);
            }
        }
    }

    actions
    {
        action(Post)
        {
            Caption = 'Post';
            ApplicationArea = All;
            trigger OnAction()
            var
                PostBatch: Codeunit "Gen. Jnl.-Post";
            begin
                // Post the whole batch
                PostBatch.RunWithCheck(Rec."Journal Template Name", Rec.Name);
            end;
        }
    }
}

