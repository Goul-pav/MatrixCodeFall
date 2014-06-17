program Matrix;

{$APPTYPE CONSOLE}

uses
  Windows, SyncObjs;
  
var
  Thread: LongWord;
  StartLine: array [0..78] of Boolean;
  S: TCriticalSection;

procedure LineFall;
  var
    Coord: TCoord;
    Y: Integer;

  procedure WriteSymbol(var Y: Integer; Rand: Integer); overload;
    begin
      Coord.Y := Y;
      SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), Coord);
      SetConsoleTextAttribute( GetStdHandle( STD_OUTPUT_HANDLE ), FOREGROUND_GREEN);
      write(char(Rand));
      sleep(random(300) + 50);
      inc(Y);
    end;

  begin
    randomize;
    Y := 0;
    Coord.Y := 0;
    Coord.X := random(78);

    S.Enter;
    if StartLine[Coord.X] then
      ExitThread(0);
    StartLine[Coord.X] := True;
    S.Leave;

    repeat
      WriteSymbol(Y, random(254)+1);
    until Y > 24;
    Y := 0;
    repeat
      WriteSymbol(Y, 32);
    until Y > 24;

    S.enter;
    StartLine[Coord.X] := False;
    S.Leave;
    ExitThread(0);
  end;

begin

  S := TCriticalSection.Create;
  repeat
    BeginThread(nil, 0, @LineFall, @LineFall, 0, Thread);
    Sleep(500);
  until 2 < 1;

  readln;
end.
