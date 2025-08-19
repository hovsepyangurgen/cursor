table 80101 "CR Staging Line"
{
    Caption = 'Cash Receipt Staging Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Id"; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Header Id"; Guid)
        {
            Caption = 'Header Id';
            TableRelation = "CR Staging Header".Id;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No."
                            else if ("Account Type" = const(Customer)) Customer."No."
                            else if ("Account Type" = const(Vendor)) Vendor."No."
                            else if ("Account Type" = const("Bank Account")) "Bank Account"."No."
                            else if ("Account Type" = const("Fixed Asset")) "Fixed Asset"."No."
                            else if ("Account Type" = const("IC Partner")) "IC Partner".Code;
        }
        field(6; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
        key(LineKey; "Header Id", "Line No.")
        {
        }
    }
}

