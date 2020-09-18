SET SERVEROUTPUT ON;

DECLARE
tdate DATE;
fdate DATE;
sdate DATE;
v_day INTEGER;
I_DATE VARCHAR(6);
unit_price INTEGER :=&Enter_Unit_Price;
production_cost INTEGER :=&Enter_Production_cost;

BEGIN
myPackage.proc_m_data_create;
SELECT TO_CHAR(CURRENT_DATE, 'DDMMYY') INTO I_DATE FROM dual;
tdate :=to_date(I_DATE,'DDMMYY');
fdate:=LAST_DAY(TO_DATE(I_DATE, 'DDMMYY'));
v_day:=EXTRACT(DAY FROM tdate);
sdate:=tdate-v_day+1;
myPackage.m_porf(unit_price,production_cost,sdate,fdate);
myPackage.delete_extra_data;

END;
/
