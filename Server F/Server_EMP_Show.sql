create or replace view emp_view_server(EMP_Name,SALARY,POSITION,OFFICE) as
select EMP_NAME,POSITION,SALARY,OFFICE from EMP_H;


select * from emp_view_server;

commit;
