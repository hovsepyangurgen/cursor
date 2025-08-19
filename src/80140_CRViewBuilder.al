codeunit 80140 "CR View Builder"
{
    SingleInstance = false;

    procedure RebuildUnpostedHeaders()
    var
        GenJnlLine: Record "Gen. Journal Line";
        HeaderView: Record "CR Unposted Header View";
        GenJnlTemplate: Record "Gen. Journal Template";
        LastTemplateName: Code[20];
    begin
        HeaderView.DeleteAll();

        GenJnlTemplate.Reset();
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::"Cash Receipts");
        if GenJnlTemplate.FindSet() then
            repeat
                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate.Name);
                if GenJnlLine.FindSet() then
                    repeat
                        if not HeaderView.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", GenJnlLine."Document No.") then begin
                            HeaderView.Init();
                            HeaderView."Journal Template Name" := GenJnlLine."Journal Template Name";
                            HeaderView."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                            HeaderView."Document No." := GenJnlLine."Document No.";
                            HeaderView."Posting Date" := GenJnlLine."Posting Date";
                            HeaderView."External Document No." := GenJnlLine."External Document No.";
                            HeaderView.Insert();
                        end;
                    until GenJnlLine.Next() = 0;
            until GenJnlTemplate.Next() = 0;
    end;

    procedure RebuildPostedHeaders()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        HeaderView: Record "CR Posted Header View";
        AmountSum: Decimal;
    begin
        HeaderView.DeleteAll();

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Payment);
        if CustLedgEntry.FindSet() then
            repeat
                if not HeaderView.Get(CustLedgEntry."Document No.") then begin
                    AmountSum := 0;
                    CustLedgEntry2.Reset();
                    CustLedgEntry2.SetRange("Document No.", CustLedgEntry."Document No.");
                    CustLedgEntry2.SetRange("Document Type", CustLedgEntry2."Document Type"::Payment);
                    if CustLedgEntry2.FindSet() then
                        repeat
                            AmountSum += CustLedgEntry2.Amount;
                        until CustLedgEntry2.Next() = 0;

                    HeaderView.Init();
                    HeaderView."Document No." := CustLedgEntry."Document No.";
                    HeaderView."Posting Date" := CustLedgEntry."Posting Date";
                    HeaderView."Customer No." := CustLedgEntry."Customer No.";
                    HeaderView.Amount := AmountSum;
                    HeaderView.Insert();
                end;
            until CustLedgEntry.Next() = 0;
    end;
}

