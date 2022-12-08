--Example 9-12. The backend procedure that is called by the invoker
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
 smaller_callstack hr.logging.code_location%TYPE;
BEGIN
 IF NOT (proj_cur%ISOPEN) THEN
 OPEN proj_cur;
 DBMS_OUTPUT.put_line ('Opened cursor');
 FETCH proj_cur INTO proj_rec;
 DBMS_OUTPUT.put_line (
 'Project ID: ' || proj_rec.PROJECT_ID
 || '-' || ' CLIENT_PROJ: ' || proj_rec.CLIENT_PROJ || '-'
 || ' hours_worked ' || proj_rec.hours_worked);
 IF (proj_cur%rowcount = 0) THEN
 LOGGINGPACKAGE.LOG_ACTION('process_project_data',
 'NO DATA FOUND IN CURSOR');
 ELSIF (proj_cur%rowcount > 0) THEN
 DBMS_OUTPUT.put_line ('Calling handle_insert');
 handle_insert(proj_rec.project_id, proj_rec.client_proj,
 proj_rec.hours_worked, proj_rec.employee_id, proj_rec.contact,
 proj_rec.rate, proj_rec.tax, proj_rec.recipient);
 COMMIT;
 END IF;
 IF (proj_cur%ISOPEN) THEN
 DBMS_OUTPUT.put_line ('Closing cursor');
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
 err_msg := SUBSTR(SQLERRM, 1, 100);
 callstack_msg := DBMS_UTILITY.FORMAT_CALL_STACK;
 smaller_callstack := SUBSTR(callstack_msg, 1, 200);
 loggingPackage.LOG_ACTION('We hit a general exception error number -
 '|| ' ' || err_num || ' Error message: ' || err_msg,
 'process_project_data' || ' Callstack message: ' || smaller_callstack);
 ROLLBACK;
END;
