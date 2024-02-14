uses GraphABC, ABCObjects;

const
  blueCl = RGB(127, 127, 255);
  redCl = RGB(255, 127, 127);
  yellowCl = RGB(255, 255, 127);

var
  cursor, target: SquareABC;
  
  map: array [0..8] of array [0..8] of byte; // 0 - free, 1 - blue, 2 - red;
  tagger: boolean; // true - blue, false - red;
  elXNeed := -1; elYNeed := -1;

procedure setWindow;
begin
  SetWindowSize(360, 360);
  CenterWindow;
  SetWindowTitle('Ultimate Tic Tac Toe');
  SetWindowIsFixedSize(true);
  SetSmoothingOff;
  cursor := new SquareABC(360, 360, 10, blueCl);
  cursor.Bordered := false;
  target := new SquareABC(360, 360, 90, yellowCl);
  target.Bordered := false;
  tagger := true;
  for var i := 0 to 8 do
    for var j := 0 to 8 do
      map[j][i] := 0;
end;

procedure drawLines;
begin
  SetPenWidth(4);
  SetPenColor(RGB(85, 85, 85));
  
  for var i := 1 to 2 do
    Line(120 * i, 0, 120 * i, 360);
  for var i := 1 to 2 do
    Line(0, 120 * i, 360, 120 * i);
  
  SetPenWidth(2);
  
  for var i := 0 to 2 do
    for var j := 0 to 2 do
    begin
      for var k := 1 to 2 do
        Line(15 + 30 * k + 120 * j, 15 + 120 * i, 15 + 30 * k + 120 * j, 105 + 120 * i);
      for var k := 1 to 2 do
        Line(15 + 120 * j, 15 + 30 * k + 120 * i, 105 + 120 * j, 15 + 30 * k + 120 * i);
    end;
end;

procedure checkWinner;
begin
  
end;

procedure MouseDown(x, y, mb: integer);
var
  posX, posY, divX, divY, modX, modY, elX, elY: integer;
begin
  divX := x div 120;
  divY := y div 120;
  modX := x mod 120;
  modY := y mod 120;
  elX := (divX) * 3 + (modX - 15) div 30;
  elY := (divY) * 3 + (modY - 15) div 30;
  if (modX > 15) and (modX < 105) and (modY > 15) and (modY < 105) and (map[elX][elY] = 0) then
    if (elXNeed = -1) or ((elXNeed <> -1) and (elX div 3 = elXNeed) and (elY div 3 = elYNeed)) then
    begin
      if tagger then
      begin
        SetBrushColor(blueCl);
        map[elX][elY] := 1;
        cursor.Color := blueCl;
      end
      else
      begin
        SetBrushColor(redCl);
        map[elX][elY] := 2;
        cursor.Color := redCl;
      end;
      posX := (modX - 15) div 30 * 30 + divX * 120;
      posY := (modY - 15) div 30 * 30 + divY * 120;
      FillRect(PosX + 20, posY + 20, posX + 40, posY + 40);
      elXNeed := (modX - 15) div 30;
      elYNeed := (modY - 15) div 30;
      tagger := not tagger;
      target.Position := (elXNeed * 120 + 15, elYNeed * 120 + 15);
      if tagger then
        cursor.Color := blueCl
      else
        cursor.Color := redCl;
    end;
end;

procedure MouseMove(x, y, mb: integer);
begin
  System.Windows.Forms.Cursor.Hide;
  cursor.Center := (x, y);
  {TextOut(0, 355, 'x: ' + x + ' y:' + y);
  TextOut(80, 355, 'x: ' + (x - 15) div 30 + ' y:' + (y - 15) div 30);
  TextOut(140, 355, 'x: ' + (x div 120) + ' y:' + (y div 120));
  TextOut(220, 355, ((x mod 120 - 15) div 30) + ' ' + ((y mod 120 - 15) div 30));
  TextOut(280, 355, ((x div 120) * 3 + (x mod 120 - 15) div 30) + ' ' + ((y div 120) * 3 + (y mod 120 - 15) div 30));}
end;

begin
  setWindow;
  drawLines;
  onMouseDown := mouseDown;
  onMouseMove := mouseMove;
  //SaveWindow('screen.png');
end.