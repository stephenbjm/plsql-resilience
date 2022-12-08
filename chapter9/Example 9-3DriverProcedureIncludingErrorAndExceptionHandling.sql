--Example 9-3. Driver procedure including error and exception handling
create or replace PROCEDURE process_project_data (
 project_id_in IN hr.projects.project_id%TYPE)
IS
 CURSOR proj_cur
 IS
 SELECT PROJECT_ID, client_proj, hours_worked, employee_id, contact,
 rate, revenue, tax, recipient
 FROM hr.projects
 WHERE project_id = project_id_in;
 proj_rec proj_cur%ROWTYPE;
 err_num NUMBER;
 err_msg VARCHAR2(100);
 callstack_msg VARCHAR2(32767);
BEGIN
 IF NOT (proj_cur%ISOPEN) THEN
 OPEN proj_cur;
 FETCH proj_cur INTO proj_rec;
 DBMS_OUTPUT.put_line (
 'Project ID: ' || proj_rec.PROJECT_ID
 || '-'
 || ' CLIENT_PROJ: '
 || proj_rec.CLIENT_PROJ
 || '-'
 || ' hours_worked '
 || proj_rec.hours_worked);
 IF (proj_cur%rowcount = 0) THEN
 LOGGINGPACKAGE.LOG_ACTION('process_project_data',
 'NO DATA FOUND IN CURSOR');
 ELSIF (proj_cur%rowcount > 0) THEN
 handle_insert(proj_rec.project_id, proj_rec.client_proj,
 proj_rec.hours_worked, proj_rec.employee_id, proj_rec.contact,
 proj_rec.rate, proj_rec.tax, proj_rec.recipient);
 COMMIT;
 END IF;
 IF (proj_cur%ISOPEN) THEN
 CLOSE proj_cur;
 END IF;
 END IF;
 EXCEPTION
 WHEN INVALID_CURSOR
 THEN
 LOGGINGPACKAGE.LOG_ACTION('process_project_data', 'INVALID_CURSOR');
 ROLLBACK;
 WHEN OTHERS
 THEN
 err_num := SQLCODE;
backend PL/SQL and adding unit tests
 err_msg := SUBSTR(SQLERRM, 1, 100);
 callstack_msg := DBMS_UTILITY.FORMAT_CALL_STACK;
 loggingPackage.LOG_ACTION('We hit a general exception error number -
 '|| ' ' || err_num || ' Error message: ' || err_msg,
 'process_project_data' || ' Callstack message: ' || callstack_msg);
 ROLLBACK;
END;