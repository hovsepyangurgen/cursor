page 80112 "API CR Unposted Header"
{
    PageType = API;
    Caption = 'Unposted Cash Receipt';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'unpostedCashReceipt';
    EntitySetName = 'unpostedCashReceipts';
    SourceTable = "CR Unposted Header View";
    ODataKeyFields = "Journal Template Name", "Journal Batch Name", "Document No.";
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
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
            }
            part(lines; "API CR Unposted Lines")
            {
                EntityName = 'line';
                EntitySetName = 'lines';
                SubPageLink = "Journal Template Name" = field("Journal Template Name"),
                              "Journal Batch Name" = field("Journal Batch Name"),
                              "Document No." = field("Document No.");
                Caption = 'Lines';
            }
        }
    }

    trigger OnOpenPage()
    var
        Builder: Codeunit "CR View Builder";
    begin
        Builder.RebuildUnpostedHeaders();
    end;
}

