--Example 9-9. The exception-aware code we want to call to record log events
create or replace PROCEDURE LOG_ACTION
 (action_message IN logging.action_message%TYPE,
 code_location IN logging.code_location%TYPE)
IS
 PRAGMA AUTONOMOUS_TRANSACTION;
 err_num NUMBER;
 err_msg VARCHAR2(100);
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
 );
 COMMIT;
EXCEPTION
 WHEN OTHERS THEN
 err_num := SQLCODE;
 err_msg := SUBSTR(SQLERRM, 1, 100);
 EMERGENCY_OUTPUT(err_num, err_msg, DBMS_UTILITY.FORMAT_CALL_STACK);
 ROLLBACK;
END;
