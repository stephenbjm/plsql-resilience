--Example 8-7. Retrieving data from the PROJECTS table
CREATE OR REPLACE PROCEDURE process_project_data (
 project_id_in IN hr.projects.project_id%TYPE)
IS
 CURSOR proj_cur
 IS
 SELECT PROJECT_ID, client_proj, hours_worked, employee_id, contact,
 rate, revenue, recipient
 FROM hr.projects
 WHERE project_id = project_id_in;
 proj_rec proj_cur%ROWTYPE;
BEGIN
 OPEN proj_cur;
 FETCH proj_cur INTO proj_rec;
 DBMS_OUTPUT.put_line (
 'Project ID: ' || proj_rec.PROJECT_ID
 || '-'
 || ' CLIENT_PROJ: '
 || proj_rec.CLIENT_PROJ);
 CLOSE proj_cur;
END;