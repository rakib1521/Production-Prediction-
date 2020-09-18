SET SERVEROUTPUT ON;

DECLARE


I_DATE VARCHAR(6);

T_Target INTEGER; 
Passed	INTEGER;
i_Target INTEGER := &Enter_Target_for_today;
p_date DATE;
NEG_VALUE EXCEPTION ;
ALREADY_ADDED EXCEPTION ;


BEGIN
IF i_Target<=0 THEN
RAISE NEG_VALUE;
ELSIF T_Target>0 THEN
RAISE ALREADY_ADDED;
END IF;
SELECT TO_CHAR(CURRENT_DATE, 'DDMMYY') INTO I_DATE FROM dual;
p_date:=to_date(I_DATE,'DDMMYY');

select Target into T_Target from factory@site_link where tdate=p_date;	
--DBMS_OUTPUT.PUT_LINE(p_date||' '||T_Target);
IF T_Target=0 THEN
	  UPDATE factory@site_link SET Target=i_Target WHERE tdate=p_date;
	  DBMS_OUTPUT.PUT_LINE('TARGET ADDED');
END IF;



EXCEPTION 
 
   WHEN no_data_found THEN 
      insert into factory@site_link (tdate,Assembled,Passed, Target) values (p_date,0,0,i_Target); 
	  DBMS_OUTPUT.PUT_LINE('TARGET ADDED');
	  commit;
   WHEN NEG_VALUE THEN
	  DBMS_OUTPUT.PUT_LINE('TARGET CAN NOT BE NEGETIVE OR ZERO');  
   WHEN ALREADY_ADDED THEN
	  DBMS_OUTPUT.PUT_LINE('TARGET ALREADY ADDED');  



END;
/
commit;