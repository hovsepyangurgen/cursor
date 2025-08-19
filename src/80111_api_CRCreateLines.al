page 80111 "API CR Create Lines"
{
    PageType = API;
    Caption = 'Cash Receipt Line';
    APIPublisher = 'yourcompany';
    APIGroup = 'cashManagement';
    APIVersion = 'v1.0';
    EntityName = 'cashReceiptLine';
    EntitySetName = 'cashReceiptLines';
    SourceTable = "CR Staging Line";
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
                field(headerId; Rec."Header Id")
                {
                    Caption = 'Header Id';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(accountNo; Rec."Account No.")
                {
                    Caption = 'Account No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        StagingLine: Record "CR Staging Line";
    begin
        if Rec.Id = Guid::EmptyGuid() then
            Rec.Id := CreateGuid();
        if Rec."Line No." = 0 then
            Rec."Line No." := 10000;
        exit(true);
    end;
}

