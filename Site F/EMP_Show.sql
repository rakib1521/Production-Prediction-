create or replace view emp_view_si(EMP_Name,SALARY,POSITION,OFFICE) as
select EMP_NAME,POSITION,SALARY,OFFICE from EMP_F;


select * from emp_view_si;

commit;
