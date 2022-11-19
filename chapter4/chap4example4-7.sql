CREATE OR REPLACE PROCEDURE LOG_ACTION(action_message IN VARCHAR2,
 code_location IN VARCHAR2) IS
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
 INSERT INTO LOGGING(EVENT_DATE, action_message, code_location)
 VALUES (SYSDATE, action_message, code_location);
 COMMIT;
END;