page 80116 "API CR Combined Header"
{
    PageType = API;
    Caption = 'Cash Receipt (All)';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'cashReceiptAll';
    EntitySetName = 'cashReceiptsAll';
    SourceTable = "CR Combined Header View";
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
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
            }
            part(lines; "API CR Combined Lines")
            {
                EntityName = 'line';
                EntitySetName = 'lines';
                SubPageLink = "Header Id" = field(Id);
                Caption = 'Lines';
            }
        }
    }

    trigger OnOpenPage()
    var
        Builder: Codeunit "CR Combined Builder";
    begin
        ClearCombined();
        Builder.Rebuild();
    end;

    local procedure ClearCombined()
    var
        H: Record "CR Combined Header View";
        L: Record "CR Combined Line View";
    begin
        L.DeleteAll();
        H.DeleteAll();
    end;
}

