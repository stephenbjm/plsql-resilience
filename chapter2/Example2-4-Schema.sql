-- Example 2-4. Schema Creation SQL
CREATE TABLE emp (
 ename VARCHAR2(10),
 empno NUMBER(4),
 sal NUMBER(7,2)
 );
CREATE TABLE temp (
 ename VARCHAR2(10),
 empno NUMBER(4),
 sal NUMBER(7,2)
 );
INSERT INTO emp (ename, empno, sal)
VALUES ('John', 1000, 40000.00);
INSERT INTO emp (ename, empno, sal)
VALUES ('Mary', 1001, 40000.00);
commit;
