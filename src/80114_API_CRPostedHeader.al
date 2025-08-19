page 80114 "API CR Posted Header"
{
    PageType = API;
    Caption = 'Posted Cash Receipt';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'postedCashReceipt';
    EntitySetName = 'postedCashReceipts';
    SourceTable = "CR Posted Header View";
    ODataKeyFields = "Document No.";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
            }
            part(lines; "API CR Posted Lines")
            {
                EntityName = 'line';
                EntitySetName = 'lines';
                SubPageLink = "Document No." = field("Document No.");
                Caption = 'Lines';
            }
        }
    }

    trigger OnOpenPage()
    var
        Builder: Codeunit "CR View Builder";
    begin
        Builder.RebuildPostedHeaders();
    end;
}

