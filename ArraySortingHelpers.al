codeunit 50100 "Array Sorting Helpers"
{
    procedure SortIntegers(var Values: array[100] of Integer; ValueCount: Integer; Descending: Boolean)
    begin
        if ValueCount <= 1 then
            exit;
        QuickSortInt(Values, 1, ValueCount, Descending);
    end;

    local procedure QuickSortInt(var Values: array[100] of Integer; Left: Integer; Right: Integer; Desc: Boolean)
    var
        i: Integer;
        j: Integer;
        pivot: Integer;
        tmp: Integer;
    begin
        i := Left;
        j := Right;
        pivot := Values[(Left + Right) div 2];

        repeat
            if Desc then begin
                while Values[i] > pivot do
                    i := i + 1;
                while Values[j] < pivot do
                    j := j - 1;
            end else begin
                while Values[i] < pivot do
                    i := i + 1;
                while Values[j] > pivot do
                    j := j - 1;
            end;

            if i <= j then begin
                tmp := Values[i];
                Values[i] := Values[j];
                Values[j] := tmp;
                i := i + 1;
                j := j - 1;
            end;
        until i > j;

        if Left < j then
            QuickSortInt(Values, Left, j, Desc);
        if i < Right then
            QuickSortInt(Values, i, Right, Desc);
    end;

    procedure SortTexts(var Values: array[100] of Text[250]; ValueCount: Integer; Descending: Boolean)
    begin
        if ValueCount <= 1 then
            exit;
        QuickSortText(Values, 1, ValueCount, Descending);
    end;

    local procedure QuickSortText(var Values: array[100] of Text[250]; Left: Integer; Right: Integer; Desc: Boolean)
    var
        i: Integer;
        j: Integer;
        pivot: Text[250];
        tmp: Text[250];
    begin
        i := Left;
        j := Right;
        pivot := Values[(Left + Right) div 2];

        repeat
            if Desc then begin
                while Values[i] > pivot do
                    i := i + 1;
                while Values[j] < pivot do
                    j := j - 1;
            end else begin
                while Values[i] < pivot do
                    i := i + 1;
                while Values[j] > pivot do
                    j := j - 1;
            end;

            if i <= j then begin
                tmp := Values[i];
                Values[i] := Values[j];
                Values[j] := tmp;
                i := i + 1;
                j := j - 1;
            end;
        until i > j;

        if Left < j then
            QuickSortText(Values, Left, j, Desc);
        if i < Right then
            QuickSortText(Values, i, Right, Desc);
    end;
}

