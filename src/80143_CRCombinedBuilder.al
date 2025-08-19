codeunit 80143 "CR Combined Builder"
{
    procedure Rebuild()
    begin
        BuildUnposted();
        BuildPosted();
    end;

    local procedure BuildUnposted()
    var
        Header: Record "CR Combined Header View";
        Line: Record "CR Combined Line View";
        GenJnlLine: Record "Gen. Journal Line";
        AmountSum: Decimal;
        HeaderId: Guid;
    begin
        GenJnlLine.Reset();
        if GenJnlLine.FindSet() then
            repeat
                if GenJnlLine."Document No." = '' then
                    continue;

                if not HasHeader(Header, GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", GenJnlLine."Document No.", Enum::"CR Receipt Status".Unposted, HeaderId) then begin
                    AmountSum := SumUnposted(GenJnlLine);
                    Header.Init();
                    Header.Id := CreateGuid();
                    Header.Status := Header.Status::Unposted;
                    Header."Journal Template Name" := GenJnlLine."Journal Template Name";
                    Header."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                    Header."Document No." := GenJnlLine."Document No.";
                    Header."Posting Date" := GenJnlLine."Posting Date";
                    Header."External Document No." := GenJnlLine."External Document No.";
                    Header.Amount := AmountSum;
                    Header.Insert();
                    HeaderId := Header.Id;
                end;

                Line.Init();
                Line.Id := CreateGuid();
                Line."Header Id" := HeaderId;
                Line.Status := Line.Status::Unposted;
                Line."Document No." := GenJnlLine."Document No.";
                Line."Line No." := GenJnlLine."Line No.";
                Line."Posting Date" := GenJnlLine."Posting Date";
                Line."Account Type" := GenJnlLine."Account Type";
                Line."Account No." := GenJnlLine."Account No.";
                Line."Bal. Account Type" := GenJnlLine."Bal. Account Type";
                Line."Bal. Account No." := GenJnlLine."Bal. Account No.";
                Line.Amount := GenJnlLine.Amount;
                Line."Currency Code" := GenJnlLine."Currency Code";
                Line.Description := GenJnlLine.Description;
                Line."Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
                Line.Insert();
            until GenJnlLine.Next() = 0;
    end;

    local procedure BuildPosted()
    var
        Header: Record "CR Combined Header View";
        Line: Record "CR Combined Line View";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntryLine: Record "Cust. Ledger Entry";
        AmountSum: Decimal;
        HeaderId: Guid;
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Payment);
        if CustLedgEntry.FindSet() then
            repeat
                if not HasHeader(Header, '', '', CustLedgEntry."Document No.", Enum::"CR Receipt Status".Posted, HeaderId) then begin
                    AmountSum := 0;
                    CustLedgEntryLine.Reset();
                    CustLedgEntryLine.SetRange("Document No.", CustLedgEntry."Document No.");
                    CustLedgEntryLine.SetRange("Document Type", CustLedgEntryLine."Document Type"::Payment);
                    if CustLedgEntryLine.FindSet() then
                        repeat
                            AmountSum += CustLedgEntryLine.Amount;
                        until CustLedgEntryLine.Next() = 0;

                    Header.Init();
                    Header.Id := CreateGuid();
                    Header.Status := Header.Status::Posted;
                    Header."Document No." := CustLedgEntry."Document No.";
                    Header."Posting Date" := CustLedgEntry."Posting Date";
                    Header."Customer No." := CustLedgEntry."Customer No.";
                    Header.Amount := AmountSum;
                    Header.Insert();
                    HeaderId := Header.Id;
                end;

                Line.Init();
                Line.Id := CreateGuid();
                Line."Header Id" := HeaderId;
                Line.Status := Line.Status::Posted;
                Line."Document No." := CustLedgEntry."Document No.";
                Line."Line No." := CustLedgEntry."Entry No.";
                Line."Posting Date" := CustLedgEntry."Posting Date";
                Line."Account Type" := Line."Account Type"::Customer;
                Line."Account No." := CustLedgEntry."Customer No.";
                Line.Amount := CustLedgEntry.Amount;
                Line."Currency Code" := CustLedgEntry."Currency Code";
                Line.Description := CustLedgEntry.Description;
                Line."Applies-to Doc. No." := CustLedgEntry."Applies-to Doc. No.";
                Line."Customer No." := CustLedgEntry."Customer No.";
                Line."Entry No." := CustLedgEntry."Entry No.";
                Line.Insert();
            until CustLedgEntry.Next() = 0;
    end;

    local procedure HasHeader(var Header: Record "CR Combined Header View"; Template: Code[20]; Batch: Code[20]; DocumentNo: Code[20]; Status: Enum "CR Receipt Status"; var HeaderId: Guid): Boolean
    begin
        Header.Reset();
        Header.SetRange(Status, Status);
        Header.SetRange("Journal Template Name", Template);
        Header.SetRange("Journal Batch Name", Batch);
        Header.SetRange("Document No.", DocumentNo);
        if Header.FindFirst() then begin
            HeaderId := Header.Id;
            exit(true);
        end else begin
            HeaderId := Guid::EmptyGuid();
            exit(false);
        end;
    end;
}

