Example 5-1. The code we want to call from the job
create or replace PROCEDURE LOG_ACTION
 (action_message IN logging.action_message%TYPE,
 code_location IN logging.code_location%TYPE
Calling PL/SQL Using a Job | 141
 )
IS
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
 INSERT INTO LOGGING
 (EVENT_DATE
 , action_message
 , code_location
 )
 VALUES
 (SYSDATE
 , action_message
 , code_location
 )
 ;
 COMMIT;
END;