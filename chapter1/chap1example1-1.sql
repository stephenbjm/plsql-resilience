DECLARE
 x NUMBER := 100;
BEGIN
 FOR i IN 1..20 LOOP -- A for loop similar to Java
 IF MOD(i, 2) = 0 THEN -- if i is even
 INSERT INTO temp VALUES (i, x, 'i is even');
 ELSE
 INSERT INTO temp VALUES (i, x, 'i is odd');
 END IF;
 x := x + 100;
 END LOOP;
 COMMIT;
END;
