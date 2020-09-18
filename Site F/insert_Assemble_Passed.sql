SET SERVEROUTPUT ON;

DECLARE
I_tdate factory.tdate %TYPE;
I_Assembled factory.Assembled %TYPE := &INSET_TODAYS_ASSEMBLED;
I_Passed factory.Passed %TYPE := &INSET_TODAYS_PASSED;
I_DATE VARCHAR(6);
t_Assembled factory.Assembled%TYPE;
t_Passed	factory.Passed%TYPE ;

NEG_VALUE EXCEPTION ;
	



BEGIN

IF I_Assembled<=0   THEN
RAISE NEG_VALUE;
ELSIF I_Passed<=0 THEN
RAISE NEG_VALUE;
END IF;


SELECT TO_CHAR(CURRENT_DATE, 'DDMMYY') INTO I_DATE FROM dual;
I_tdate:=to_date(I_DATE,'DDMMYY');


select Assembled,Passed  into t_Assembled,t_Passed from factory where tdate=to_date(I_DATE,'DDMMYY');	

IF t_Assembled>0 THEN
DBMS_OUTPUT.PUT_LINE('Assembled and Passed alreday ADDED');  
ELSIF t_Assembled=0 THEN
	  UPDATE factory SET Assembled=I_Assembled,Passed=I_Passed WHERE tdate=I_tdate;
	  DBMS_OUTPUT.PUT_LINE('Assembled and Passed ADDED'); 

END IF;
EXCEPTION 
   WHEN no_data_found THEN 
    insert into factory (tdate, Assembled,Passed) values (to_date(I_DATE,'DDMMYY'),I_Assembled,I_Passed); 
	DBMS_OUTPUT.PUT_LINE('Assembled and Passed ADDED');  
   WHEN NEG_VALUE THEN
	  DBMS_OUTPUT.PUT_LINE('Values CAN NOT BE NEGETIVE OR ZERO');  	
END;
/
commit;