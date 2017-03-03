program testindent;

  const
    c = 44;

  type
    t = integer;

  var
    s, i, j, a, b, d, e: t;
    r: 
      record
        x, y: integer;
        b, c: boolean;
        a: 
          array [1 .. 100] of t
      end;
    
  procedure p(var g: t);

    type
      q = 
        array [20 .. 30] of 
          array [-12 .. 67] of t;

  begin
    i := 3;
    if a = a then
      i := j + 1
    else
      if b = a then
        j := 99
  end;

begin
  while d < 9 do
    p(i);
  if a = 99 then
    begin
      j := 100
    end;
  begin
    i := 100
  end
end.