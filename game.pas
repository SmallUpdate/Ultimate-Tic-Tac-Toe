uses GraphABC, ABCObjects;

//const
  //blueCl = RGB(127, 127, 255);
  //redCl = RGB(255, 127, 127);

var
  map: array [0..8] of array [0..8] of byte;

procedure setWindow;
begin
  SetWindowSize(360, 370);
  CenterWindow;
  SetWindowTitle('Ultimate Tic Tac Toe');
  Window.IsFixedSize := true;
  //SetSmoothingOff;
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

procedure MouseDown(x, y, mb: integer);
begin
  SetBrushColor(RGB(127, 127, 255));
  if (x > 15) and (x < 345) then
    if (y > 15) and (x < 345) then
    begin
      var posX := (x - 15) div 30;
      var posY := (y - 15) div 30;
      if ((posX mod 3 <> 0) and (posX <> 0)) and ((posY mod 3 <> 0) and (posY <> 0)) then
        FillRect(15 + posX * 30, 15 + posY * 30, 45 + posX * 30, 45 + posY * 30);
    end;
  //fillRoundRect(((x - 15 - 30 * (x div 120)) div 30 + 1) * 30 + 30 * (x div 120) - 10, ((y - 15 - 30 * (y div 120)) div 30 + 1) * 30 + 30 * (y div 120) - 10, ((x - 15 - 30 * (x div 120)) div 30 + 1) * 30 + 30 * (x div 120) + 10, ((y - 15 - 30 * (y div 120)) div 30 + 1) * 30 + 30 * (y div 120) + 10, 8, 8);
end;

procedure MouseMove(x, y, mb: integer);
begin
  TextOut(0, 355, 'x: ' + x + ' y:' + y);
  TextOut(80, 355, 'x: ' + (x - 15) div 30 + ' y:' + (y - 15) div 30);
end;

begin
  setWindow;
  drawLines;
  onMouseDown := mouseDown;
  onMouseMove := mouseMove;
end.