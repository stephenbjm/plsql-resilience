--Example 9-18. Exercising the logging code
BEGIN
HR.LOGGINGPACKAGE.LOG_ACTION('A log message', 'Trouble at mill');
END;
select * from HR.LOGGING;
delete from LOGGING;
