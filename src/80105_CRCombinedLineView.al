table 80105 "CR Combined Line View"
{
    Caption = 'Cash Receipt Line (All)';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Header Id"; Guid)
        {
            Caption = 'Header Id';
            TableRelation = "CR Combined Header View".Id;
        }
        field(3; Status; Enum "CR Receipt Status")
        {
            Caption = 'Status';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(8; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(9; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
        }
        field(10; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
        }
        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(14; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(15; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(16; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
    }

    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
        key(HeaderKey; "Header Id", "Line No.")
        {
        }
    }
}

