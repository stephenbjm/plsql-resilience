--Example 8-10. First helper to calculate revenue
CREATE OR REPLACE FUNCTION get_revenue(
in_hours_worked hr.invoices.hours_worked%TYPE, in_rate hr.invoices.rate%TYPE)
RETURN hr.invoices.payment%TYPE
IS
BEGIN
 RETURN in_hours_worked * in_rate;
END;
