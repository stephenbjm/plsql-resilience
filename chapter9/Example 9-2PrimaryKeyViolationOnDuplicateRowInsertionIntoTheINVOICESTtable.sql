--Example 9-2. Primary key violation on duplicate row insertion into the INVOICES table
-- RUN THIS INSERT TWICE TO CHECK THAT THE PRIMARY KEY WORKS
--**********************************************************
INSERT INTO INVOICES(PROJECT_ID, CLIENT_PROJ, HOURS_WORKED, EMPLOYEE_ID,
CONTACT, RATE, REVENUE, TAX, RECIPIENT, PAYMENT)
VALUES(1, 'Project', 10, 207, 'mark@provider.com', 100.00,
1000, 0.15, 'mary@acme.com', 1150);