--Example 9-1. The main procedure using the three helpers
CREATE OR REPLACE PROCEDURE process_project_data (
 project_id_in IN hr.projects.project_id%TYPE)
IS
 CURSOR proj_cur IS
 SELECT
 PROJECT_ID ,
 client_proj ,
 hours_worked,
 employee_id ,
 contact ,
 rate ,
 revenue ,
 tax ,
 recipient
 FROM
 hr.projects
 WHERE
 project_id = project_id_in;
 proj_rec proj_cur%ROWTYPE;
BEGIN
 OPEN proj_cur;
backend PL/SQL and adding unit tests
 FETCH
 proj_cur
 INTO
 proj_rec;
 DBMS_OUTPUT.put_line ( 'Project ID: '
 || proj_rec.PROJECT_ID || '-' || ' CLIENT_PROJ: '
 || proj_rec.CLIENT_PROJ || '-' || ' hours_worked '
 || proj_rec.hours_worked);
 -- THE ADDITIONAL HELPER
 handle_insert(proj_rec.project_id, proj_rec.client_proj,
 proj_rec.hours_worked, proj_rec.employee_id, proj_rec.contact,
 proj_rec.rate, hr.projects.tax, hr.projects.recipient);
 CLOSE proj_cur;
END;
