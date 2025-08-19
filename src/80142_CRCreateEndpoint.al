codeunit 80142 "CR Create Endpoint"
{
    procedure CreateCashReceipt(var Header: Record "CR Staging Header")
    var
        StagingLine: Record "CR Staging Line";
        JournalMgt: Codeunit "CR Journal Mgt";
    begin
        StagingLine.Reset();
        StagingLine.SetRange("Header Id", Header.Id);
        if StagingLine.FindSet() then
            repeat
                JournalMgt.CreateJournalLineFromStagingLine(StagingLine, Header);
            until StagingLine.Next() = 0;
    end;
}

