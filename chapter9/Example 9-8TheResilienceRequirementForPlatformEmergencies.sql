--Example 9-8. The resilience requirement for platform emergencies
CREATE OR REPLACE DIRECTORY EXT_DIR AS '/emergency_dir';
CREATE OR REPLACE PROCEDURE EMERGENCY_OUTPUT(err_num IN NUMBER,
err_msg IN VARCHAR2, call_stack IN VARCHAR2)
AS
 output_file UTL_FILE.FILE_TYPE;
BEGIN
 output_file := UTL_FILE.FOPEN('EXT_DIR', 'emergency.txt' , 'A');
 IF UTL_FILE.IS_OPEN(output_file) THEN
 UTL_FILE.PUT_LINE(output_file, SYSTIMESTAMP || ' A platform issue may
 have occurred - error number - ' || err_num || ' Error message: ' ||
 err_msg || ' Callstack message: ' || call_stack);
 END IF;
 IF UTL_FILE.IS_OPEN(output_file) THEN
 UTL_FILE.FCLOSE(output_file);
 END IF;
END;
