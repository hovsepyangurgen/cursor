table 80102 "CR Unposted Header View"
{
    Caption = 'Unposted Cash Receipt Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
        }
        field(2; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Document No.")
        {
            Clustered = true;
        }
    }
}

