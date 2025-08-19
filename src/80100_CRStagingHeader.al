table 80100 "CR Staging Header"
{
    Caption = 'Cash Receipt Staging Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Id"; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(3; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(7; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
        }
        field(8; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"."No."
                            else if ("Bal. Account Type" = const(Customer)) Customer."No."
                            else if ("Bal. Account Type" = const(Vendor)) Vendor."No."
                            else if ("Bal. Account Type" = const("Bank Account")) "Bank Account"."No."
                            else if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"."No."
                            else if ("Bal. Account Type" = const("IC Partner")) "IC Partner".Code;
        }
        field(9; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(10; "Description"; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
        key(DocumentKey; "Journal Template Name", "Journal Batch Name", "Document No.")
        {
        }
    }
}

