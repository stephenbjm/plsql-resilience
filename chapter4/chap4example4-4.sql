create or replace PROCEDURE update_employees
IS
 CURSOR c1 is
 SELECT ename, empno, sal FROM emp
 ORDER BY sal DESC; -- start with highest paid employee
 my_ename VARCHAR2(10);
 my_empno NUMBER(4);
 my_sal NUMBER(7,2);
 err_num NUMBER;
 err_msg VARCHAR2(100);
BEGIN
 OPEN c1;
 FOR i IN 1..5 LOOP
 FETCH c1 INTO my_ename, my_empno, my_sal;
 EXIT WHEN c1%NOTFOUND; /* in case the number requested */
 /* is more than the total */
 /* number of employees */
 DBMS_OUTPUT.PUT_LINE('Success - we got here 1!');
 INSERT INTO temp VALUES (my_sal, my_empno, my_ename);
 DBMS_OUTPUT.PUT_LINE('Successful insert!');
 COMMIT;
 END LOOP;
 CLOSE c1;
 DBMS_OUTPUT.PUT_LINE('Success - we got here!');
 EXCEPTION
 WHEN NO_DATA_FOUND THEN -- catches all 'no data found' errors
 DBMS_OUTPUT.PUT_LINE('Ouch, we hit an exception');
 ROLLBACK;
 WHEN OTHERS THEN -- handles all other errors
 err_num := SQLCODE;
 err_msg := SUBSTR(SQLERRM, 1, 100);
 DBMS_OUTPUT.PUT_LINE('We hit a general exception error number ' ||
 err_num || ' Error message: ' || err_msg);
 ROLLBACK;
END;