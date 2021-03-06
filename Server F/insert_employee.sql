SET SERVEROUTPUT ON;

DECLARE

	ID INTEGER; 
	EMP_NAME VARCHAR2(9):='&Employee_Name';
	POSITION VARCHAR2(10):='&Position';
	SALARY int:=&SALARY; 
	

NEG_VALUE EXCEPTION ;

BEGIN
IF SALARY<=0 THEN
RAISE NEG_VALUE;
END IF;
select count(ID) into ID from emp_h;
ID:= ID +1;
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (ID,EMP_NAME,POSITION,SALARY,'H_OFFICE');
COMMIT;

EXCEPTION 
WHEN NEG_VALUE THEN
DBMS_OUTPUT.PUT_LINE('SALARY CAN NOT BE NEGETIVE');
END;
/
