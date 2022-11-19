create or replace PROCEDURE update_employees
AS
 err_num NUMBER;
 err_msg VARCHAR2(100);
 CURSOR c_employee
 IS
 SELECT
 ename, empno, sal
 FROM
 emp
 ORDER BY
 sal DESC;
BEGIN
 FOR r_employee IN c_employee
 LOOP
 dbms_output.put_line( r_employee.ename || ': $' || r_employee.sal );
 DBMS_OUTPUT.PUT_LINE('Success - we got here 1!');
 INSERT INTO temp VALUES
 (r_employee.sal,
 r_employee.empno,
 r_employee.ename);
 DBMS_OUTPUT.PUT_LINE('Successful insert!');
 END LOOP;
EXCEPTION
WHEN NO_DATA_FOUND THEN -- catches all 'no data found' errors
 DBMS_OUTPUT.PUT_LINE('Ouch, we hit an exception');
 ROLLBACK;
WHEN OTHERS THEN -- handles all other errors
 err_num := SQLCODE;
 err_msg := SUBSTR(SQLERRM, 1, 100);
 DBMS_OUTPUT.PUT_LINE('We hit a general exception error number - '
 || ' '
 || err_num
 || ' Error message: '
 || err_msg);
 ROLLBACK;
END;