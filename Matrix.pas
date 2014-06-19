program Matrix;
{$APPTYPE CONSOLE}
uses
  Windows, SysUtils, SyncObjs;
var
  Thread: LongWord;
  S: TCriticalSection;

procedure LineFall;
  var
    Coord: TCoord;
    Y: Integer;
  i: Integer;

      procedure WriteSymbol(var Y: Integer; Rand: Integer); overload;
        begin
          Coord.Y := Y;
          SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), Coord);
          S.Enter;
            write(char(Rand));
          S.Leave;
          sleep(random(150) + 50);
          inc(Y);
        end;

  begin
    randomize;
    Y := 0;
    Coord.Y := 0;
    Coord.X := random(78);

    repeat
      WriteSymbol(Y, random(254)+1);
    until Y > 24;
    Y := 0;
    repeat
      WriteSymbol(Y, 32);
    until Y > 24;
    ExitThread(0);
  end;

begin
  S := TCriticalSection.Create;
  repeat
    SetConsoleTextAttribute( GetStdHandle( STD_OUTPUT_HANDLE ), FOREGROUND_GREEN);
    BeginThread(nil, 0, @LineFall, @LineFall, 0, Thread);
    Sleep(350);
  until 2 < 1;

  readln;
end.
