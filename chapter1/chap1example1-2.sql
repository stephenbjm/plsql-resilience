declare
 n number(10):=1; -- Notice the lack of spaces
begin
 while n<=10 -- Notice the lack of spaces again!
 loop
 dbms_output.put_line(n);
 n:=n+1;
 end loop;
end;
