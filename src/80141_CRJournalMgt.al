codeunit 80141 "CR Journal Mgt"
{
    Permissions =
        tabledata "Gen. Journal Line" = RIMD,
        tabledata "Gen. Journal Batch" = R,
        tabledata "Gen. Journal Template" = R,
        tabledata Currency = R,
        tabledata Customer = R,
        tabledata Vendor = R,
        tabledata "Bank Account" = R,
        tabledata "G/L Account" = R;

    procedure EnsureBatchExists(JournalTemplateName: Code[20]; JournalBatchName: Code[20])
    var
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlBatch.SetRange(Name, JournalBatchName);
        if not GenJnlBatch.FindFirst() then
            Error('Journal Batch %1 for Template %2 not found.', JournalBatchName, JournalTemplateName);
    end;

    procedure CreateJournalLineFromStagingLine(StagingLine: Record "CR Staging Line"; Header: Record "CR Staging Header")
    var
        GenJnlLine: Record "Gen. Journal Line";
        MaxLineNo: Integer;
    begin
        EnsureBatchExists(Header."Journal Template Name", Header."Journal Batch Name");

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", Header."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Header."Journal Batch Name");
        GenJnlLine.SetRange("Document No.", Header."Document No.");
        if GenJnlLine.FindLast() then
            MaxLineNo := GenJnlLine."Line No."
        else
            MaxLineNo := 0;

        GenJnlLine.Init();
        GenJnlLine.Validate("Journal Template Name", Header."Journal Template Name");
        GenJnlLine.Validate("Journal Batch Name", Header."Journal Batch Name");
        GenJnlLine."Line No." := MaxLineNo + 10000;
        GenJnlLine.Validate("Document No.", Header."Document No.");
        if Header."Posting Date" <> 0D then
            GenJnlLine.Validate("Posting Date", Header."Posting Date");
        if Header."External Document No." <> '' then
            GenJnlLine.Validate("External Document No.", Header."External Document No.");

        GenJnlLine.Validate("Account Type", StagingLine."Account Type");
        GenJnlLine.Validate("Account No.", StagingLine."Account No.");
        if Header."Bal. Account Type" <> GenJnlLine."Bal. Account Type" then
            GenJnlLine.Validate("Bal. Account Type", Header."Bal. Account Type");
        if Header."Bal. Account No." <> '' then
            GenJnlLine.Validate("Bal. Account No.", Header."Bal. Account No.");

        if Header."Currency Code" <> '' then
            GenJnlLine.Validate("Currency Code", Header."Currency Code");

        if StagingLine.Description <> '' then
            GenJnlLine.Validate(Description, StagingLine.Description);
        if StagingLine."Applies-to Doc. No." <> '' then
            GenJnlLine.Validate("Applies-to Doc. No.", StagingLine."Applies-to Doc. No.");

        GenJnlLine.Validate(Amount, StagingLine.Amount);
        GenJnlLine.Insert(true);
    end;
}

