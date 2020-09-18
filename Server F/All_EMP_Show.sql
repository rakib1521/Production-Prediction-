create or replace view emp_view(EMP_Name,SALARY,POSITION,OFFICE) as
select EMP_NAME,POSITION,SALARY,OFFICE from EMP_H
UNION
select EMP_NAME,POSITION,SALARY,OFFICE from EMP_F@SITE_LINK;


select * from emp_view;

commit;
