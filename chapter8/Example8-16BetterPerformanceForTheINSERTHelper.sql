create or replace PROCEDURE handle_insert (
   PROJECT_ID_IN IN hr.projects.project_id%TYPE,
   CLIENT_PROJ_IN IN hr.projects.client_proj%TYPE,
   HOURS_WORKED_IN IN hr.projects.hours_worked%TYPE,
   EMPLOYEE_ID_IN IN hr.projects.employee_id%TYPE,
   CONTACT_IN IN hr.projects.contact%TYPE,
   RATE_IN IN hr.projects.rate%TYPE,
   TAX_IN IN hr.projects.tax%TYPE,
   RECIPIENT_IN IN hr.projects.recipient%TYPE)
IS
   revenue hr.invoices.revenue%TYPE := get_revenue(HOURS_WORKED_IN, RATE_IN);
   payment hr.invoices.payment%TYPE := get_payment(get_revenue(HOURS_WORKED_IN, RATE_IN),
                        HOURS_WORKED_IN, RATE_IN, TAX_IN);
BEGIN
        INSERT INTO
           INVOICES
           (
              PROJECT_ID  ,
              CLIENT_PROJ ,
              HOURS_WORKED,
              EMPLOYEE_ID ,
              CONTACT     ,
              RATE        ,
              REVENUE     ,
              TAX         ,
              RECIPIENT   ,
              PAYMENT
           )
           VALUES
           (                
               PROJECT_ID_IN  ,
               CLIENT_PROJ_IN ,
               HOURS_WORKED_IN,
               EMPLOYEE_ID_IN ,
               CONTACT_IN     ,
               RATE_IN        ,
               revenue        ,
               TAX_IN         ,
               RECIPIENT_IN   ,              
               payment);
END;