page 80110 "API CR Create Header"
{
    PageType = API;
    Caption = 'Cash Receipt';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'cashReceipt';
    EntitySetName = 'cashReceipts';
    SourceTable = "CR Staging Header";
    DelayedInsert = true;
    ODataKeyFields = Id;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.Id)
                {
                    Caption = 'Id';
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
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
            part(lines; "API CR Create Lines")
            {
                EntityName = 'line';
                EntitySetName = 'lines';
                SubPageLink = "Header Id" = field(Id);
                Caption = 'Lines';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateJournal)
            {
                Caption = 'Create Journal Lines';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Creator: Codeunit "CR Create Endpoint";
                    Header: Record "CR Staging Header";
                begin
                    Header := Rec;
                    Creator.CreateCashReceipt(Header);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.Id = Guid::EmptyGuid() then
            Rec.Id := CreateGuid();
        exit(true);
    end;
}

