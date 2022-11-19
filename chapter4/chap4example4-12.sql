create or replace PROCEDURE update_employees
AS
 CURSOR c_employee
 IS
 SELECT
 ename, empno, sal
 FROM emp
 ORDER BY
 sal DESC;
BEGIN
 FOR r_employee IN c_employee
 LOOP
 dbms_output.put_line( r_employee.ename || ': $' || r_employee.sal );
 DBMS_OUTPUT.PUT_LINE('Success - we got here 1!');
 INSERT INTO temp VALUES
 (r_employee.empno,
 r_employee.ename,
 r_employee.sal);
 DBMS_OUTPUT.PUT_LINE('Successful insert!');
 END LOOP;
END;