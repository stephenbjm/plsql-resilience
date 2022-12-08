--Example 8-13. The main procedure using the two helpers
CREATE OR REPLACE FUNCTION get_payment(in_revenue hr.invoices.revenue%TYPE,
 in_hours_worked
 hr.invoices.hours_worked%TYPE,
 in_rate hr.invoices.rate%TYPE,
 in_tax hr.invoices.tax%TYPE)
 RETURN hr.invoices.payment%TYPE
IS
BEGIN
 RETURN in_revenue + in_hours_worked * in_rate * in_tax;
END;
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
 FETCH
 proj_cur
 INTO
 proj_rec;
 DBMS_OUTPUT.put_line ( 'Project ID: '
 || proj_rec.PROJECT_ID
 || '-'
 || ' CLIENT_PROJ: '
 || proj_rec.CLIENT_PROJ
 || '-'
 || ' hours_worked '
 || proj_rec.hours_worked);
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
 get_payment(get_revenue(proj_rec.hours_worked))
 );
 CLOSE proj_cur;
END;