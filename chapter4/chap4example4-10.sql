CREATE OR REPLACE PROCEDURE update_employees
AS
 CURSOR c1 IS
 SELECT
 ename ,
 empno ,
sal
 FROM
 emp
 ORDER BY
 sal DESC; -- start with highest paid employee
 my_ename VARCHAR2(10);
 my_empno NUMBER(4);
 my_sal NUMBER(7,2);
 err_num NUMBER;
 err_msg VARCHAR2(100);
BEGIN
 LOG_ACTION('Calling update', 'update_employees');
 OPEN c1;
 FOR i IN 1..5
 LOOP
 FETCH
 c1
 INTO
 my_ename ,
my_empno ,
 my_sal;
 EXIT WHEN c1%NOTFOUND;
 /* in case the number requested */
 /* is more than the total */
 /* number of employees */
 DBMS_OUTPUT.PUT_LINE('Success - we got here 1!');
 INSERT INTO
 temp VALUES
 (
 my_sal ,
 my_empno ,
 my_ename
 );
 DBMS_OUTPUT.PUT_LINE('Successful insert!');
 COMMIT;
 END LOOP;
 CLOSE c1;
 DBMS_OUTPUT.PUT_LINE('Success - we got here!');
EXCEPTION
WHEN NO_DATA_FOUND THEN -- catches all 'no data found' errors
 IF c1%ISOPEN THEN
 CLOSE c1;
 END IF;
 DBMS_OUTPUT.PUT_LINE('Ouch, we hit an exception - cursor open: '
 || sys.diutil.bool_to_int(c1%ISOPEN));
 ROLLBACK;
WHEN INVALID_NUMBER THEN -- handles INVALID_NUMBER
 IF c1%ISOPEN THEN
 CLOSE c1;
 END IF;
 err_num := SQLCODE;
 err_msg := SUBSTR(SQLERRM, 1, 100);
 DBMS_OUTPUT.PUT_LINE('We hit an invalid number exception error number - cursor open: '
 || sys.diutil.bool_to_int(c1%ISOPEN) || ' ' || err_num
 || ' Error message: ' || err_msg);
 ROLLBACK;
END;
