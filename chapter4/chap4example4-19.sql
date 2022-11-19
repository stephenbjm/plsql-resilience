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
 updateEmployeeData(r_employee.ename, r_employee.empno, r_employee.sal);
 END LOOP;
EXCEPTION
WHEN NO_DATA_FOUND THEN -- catches all 'no data found' errors
 loggingPackage.LOG_ACTION(('Ouch', 'we hit an exception');
 ROLLBACK;
WHEN OTHERS THEN -- handles all other errors
 err_num := SQLCODE;
 err_msg := SUBSTR(SQLERRM, 1, 100);
 loggingPackage.LOG_ACTION('We hit a general exception error number - '
 || ' '
 || err_num
 || ' Error message: '
 || err_msg, 'update_employees');
 ROLLBACK;
END;
