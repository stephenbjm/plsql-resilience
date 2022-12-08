--Example 8-12. Second helper to calculate payment
CREATE OR REPLACE FUNCTION get_payment(
 in_revenue hr.invoices.revenue%TYPE,
 in_hours_worked hr.invoices.hours_worked%TYPE,
 in_rate hr.invoices.rate%TYPE,
 in_tax hr.invoices.tax%TYPE)
RETURN hr.invoices.payment%TYPE
IS
BEGIN
 RETURN in_revenue + in_hours_worked * in_rate * in_tax;
END;