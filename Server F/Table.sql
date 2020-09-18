

DROP TABLE EMP_H CASCADE CONSTRAINTS;

CREATE TABLE EMP_H (
	ID INTEGER, 
	EMP_NAME VARCHAR2(9),
	POSITION VARCHAR2(10),
	SALARY int, 
	OFFICE VARCHAR2(10),
        PRIMARY KEY(ID)); 


insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (1,'A','MANAGER',70000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (2,'B','SUPERVISOR',50000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (3,'C','SUPERVISOR',50000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (4,'D','SUPERVISOR',50000 ,'H_OFFICE'); 
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (5,'E','WORKER',35000 ,'H_OFFICE'); 
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (6,'F','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (7,'G','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (8,'H','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (9,'I','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (10,'J','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (11,'K','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (12,'L','WORKER',35000 ,'H_OFFICE');
insert into EMP_H (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (13,'M','WORKER',35000 ,'H_OFFICE');

COMMIT;

SELECT * FROM EMP_H;	



		
		