--Example 8-11. The main procedure using the first helper to calculate revenue
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
 payment hr.invoices.payment%TYPE;
BEGIN
 OPEN proj_cur;
 FETCH
 proj_cur
 INTO
 proj_rec;
 DBMS_OUTPUT.put_line ('Project ID: '
 || proj_rec.PROJECT_ID
 || '-'
 || ' CLIENT_PROJ: '
 || proj_rec.CLIENT_PROJ
 || '-'
 || ' hours_worked '
 || proj_rec.hours_worked);
 payment := get_revenue(proj_rec.hours_worked, proj_rec.rate) +
 proj_rec.hours_worked*proj_rec.rate*proj_rec.tax;
 INSERT INTO
 INVOICES
 (
 PROJECT_ID ,
 CLIENT_PROJ ,
HOURS_WORKED,
EMPLOYEE_ID ,
CONTACT ,
RATE ,
REVENUE ,
TAX ,
RECIPIENT ,
 PAYMENT
 )
 VALUES
 (
 proj_rec.project_id ,
 proj_rec.client_proj ,
 proj_rec.hours_worked ,
 proj_rec.employee_id ,
 proj_rec.contact ,
 proj_rec.rate ,
 get_revenue(proj_rec.hours_worked, proj_rec.rate),
 proj_rec.tax ,
 proj_rec.recipient ,
 payment
 );
 CLOSE proj_cur;
END;
