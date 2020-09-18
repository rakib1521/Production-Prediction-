/*
DROP TABLE Factory CASCADE CONSTRAINTS;

CREATE TABLE Factory (
	tdate DATE, 
	Assembled int,  
	Passed int, 
	Target int default 0,
        PRIMARY KEY(tdate)); 

insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('010720', 'DDMMYY'), 100, 80,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('020720', 'DDMMYY'), 110, 85,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('030720', 'DDMMYY'), 115, 87,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('040720', 'DDMMYY'), 100, 80,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('050720', 'DDMMYY'), 120, 90,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('060720', 'DDMMYY'), 130, 95,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('070720', 'DDMMYY'), 140, 105,110); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('080720', 'DDMMYY'), 150, 120,120);
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('090720', 'DDMMYY'), 130, 110,130); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('100720', 'DDMMYY'), 140, 115,140); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('110720', 'DDMMYY'), 100, 95,150); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('120720', 'DDMMYY'), 140, 120,130); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('130720', 'DDMMYY'), 150, 92,120); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('140720', 'DDMMYY'), 150, 103,125); 
insert into factory (tdate, Assembled,Passed,Target) values (TO_DATE('150720', 'DDMMYY'), 160, 113,130);  

*/
DROP TABLE EMP_F CASCADE CONSTRAINTS;

CREATE TABLE EMP_F (
	ID INTEGER, 
	EMP_NAME VARCHAR2(5),
	POSITION VARCHAR2(10),
	SALARY int, 
	OFFICE VARCHAR2(10),
        PRIMARY KEY(ID)); 


insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (1,'N','MANAGER',70000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (2,'O','SUPERVISOR',50000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (3,'P','SUPERVISOR',50000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (4,'Q','SUPERVISOR',50000 ,'FACTORY'); 
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (5,'R','WORKER',35000 ,'FACTORY'); 
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (6,'S','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (7,'T','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (8,'U','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (9,'V','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (10,'W','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (11,'X','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (12,'Y','WORKER',35000 ,'FACTORY');
insert into EMP_F (ID,EMP_NAME,POSITION,SALARY,OFFICE) values (13,'Z','WORKER',35000 ,'FACTORY');

COMMIT;

--SELECT * FROM EMP_F;			
		