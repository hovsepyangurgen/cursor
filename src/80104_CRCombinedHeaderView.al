table 80104 "CR Combined Header View"
{
    Caption = 'Cash Receipt Header (All)';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(2; Status; Enum "CR Receipt Status")
        {
            Caption = 'Status';
        }
        field(3; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
        }
        field(4; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(8; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }

    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
        key(DocKey; Status, "Journal Template Name", "Journal Batch Name", "Document No.")
        {
        }
    }
}

