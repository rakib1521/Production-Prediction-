set verify off;
set serveroutput on;
create or replace package body myPackage as

	function avgpassed(n_LOOP in INTEGER)
		  return INTEGER
		  is
	  
		Passed INTEGER;
		COUNT_FLAG INTEGER;
		PASSED_SUM INTEGER;
		c_date DATE;
		prevdate DATE;

	begin
		COUNT_FLAG :=0;
		PASSED_SUM :=0;	
		
		select current_date into c_date from dual;
		prevdate:= c_date-n_LOOP;
		FOR R IN (select Passed from factory where tdate>prevdate and tdate<c_date) LOOP
		Passed := R.Passed;
		IF COUNT_FLAG=n_LOOP THEN
		EXIT;
		ELSE
		PASSED_SUM := PASSED_SUM + Passed;
		COUNT_FLAG := COUNT_FLAG + 1;
		END IF;
		END LOOP;
		RETURN FLOOR(PASSED_SUM/n_LOOP);


	end avgpassed;

	function avgassemble(n_LOOP in INTEGER)
		  return INTEGER
		  is
		  
		Assembled INTEGER;
		COUNT_FLAG INTEGER;
		ASSEMBLED_SUM INTEGER;
		c_date DATE;
		prevdate DATE;

	begin
		COUNT_FLAG :=0;
		ASSEMBLED_SUM :=0;	

		select current_date into c_date from dual;
		prevdate:= c_date-n_LOOP;
		FOR R IN (select Assembled from factory where tdate>prevdate and tdate<c_date) LOOP
		--FOR R IN (select Assembled from factory ORDER BY tdate DESC) LOOP
		Assembled := R.Assembled;
		IF COUNT_FLAG=n_LOOP THEN
		EXIT;
		ELSE
		ASSEMBLED_SUM := ASSEMBLED_SUM + Assembled;
		COUNT_FLAG := COUNT_FLAG + 1;
		END IF;
		END LOOP;
		RETURN FLOOR(ASSEMBLED_SUM/n_LOOP);


	end avgassemble;


	function avgTarget(n_LOOP in INTEGER)
		  return INTEGER
		  is
	  
		Target INTEGER;
		COUNT_FLAG INTEGER;
		TARGET_SUM INTEGER;
		c_date DATE;
		prevdate DATE;

	begin
		COUNT_FLAG :=0;
		TARGET_SUM :=0;	

		select current_date into c_date from dual;
		prevdate:= c_date-n_LOOP;
		FOR R IN (select Target from factory where tdate>prevdate and tdate<c_date) LOOP
		
		Target := R.Target;
		IF COUNT_FLAG=n_LOOP THEN
		EXIT;
		ELSE
		TARGET_SUM := TARGET_SUM + Target;
		COUNT_FLAG := COUNT_FLAG + 1;
		END IF;
		END LOOP;
		RETURN FLOOR(TARGET_SUM/n_LOOP);


	end avgTarget;

	procedure daily_prediction_proc
			IS
			

		tdate DATE;
		Assembled INTEGER;
		Passed INTEGER;
		Target INTEGER;
		COUNT_FLAG INTEGER :=0;
		ASSEMBLED_SUM INTEGER :=0;
		PASSED_SUM INTEGER :=0;
		TARGET_SUM INTEGER :=0;
		c_date DATE;
		prevdate DATE;
		I_DATE VARCHAR(6);
		

	begin
		SELECT TO_CHAR(CURRENT_DATE, 'DDMMYY') INTO I_DATE FROM dual;
		c_date:=to_date(I_DATE,'DDMMYY');
		prevdate:= c_date-7;
		select Target into Target from factory where tdate=to_date(I_DATE,'DDMMYY');
		FOR R IN (select * from factory where tdate>prevdate and tdate<c_date) LOOP
		Assembled := R.Assembled;
		Passed := R.Passed;
		
		IF COUNT_FLAG=7 THEN
		EXIT;
		ELSE
		ASSEMBLED_SUM := ASSEMBLED_SUM+Assembled;
		PASSED_SUM := PASSED_SUM + Passed;	
		COUNT_FLAG :=COUNT_FLAG+1;
		END IF;
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('######');
		DBMS_OUTPUT.PUT_LINE('PREDICATION FOR TODAY BASED ON LAST 7 DAY');
		DBMS_OUTPUT.PUT_LINE('PREDICATED ASSEMBLE '||FLOOR(ASSEMBLED_SUM/7) ||' UNIT');
		DBMS_OUTPUT.PUT_LINE('PREDICATED PASS '||FLOOR(PASSED_SUM/7) ||' UNIT');
		DBMS_OUTPUT.PUT_LINE('TODAY TARGET '||Target ||' UNIT');
		DBMS_OUTPUT.PUT_LINE('TODAY '||c_date ||' ');
		DBMS_OUTPUT.PUT_LINE('######');
		
		
		EXCEPTION 
		WHEN no_data_found THEN 
		FOR R IN (select * from factory where tdate>prevdate and tdate<c_date) LOOP
		Assembled := R.Assembled;
		Passed := R.Passed;
		Target := R.Target;
		IF COUNT_FLAG=7 THEN
		EXIT;
		ELSE
		ASSEMBLED_SUM := ASSEMBLED_SUM+Assembled;
		PASSED_SUM := PASSED_SUM + Passed;
		TARGET_SUM := TARGET_SUM +Target;
		COUNT_FLAG :=COUNT_FLAG+1;
		END IF;
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('######');
		DBMS_OUTPUT.PUT_LINE('PREDICATION FOR TODAY BASED ON LAST 7 DAY');
		DBMS_OUTPUT.PUT_LINE('PREDICATED ASSEMBLE '||FLOOR(ASSEMBLED_SUM/7) ||' UNIT');
		DBMS_OUTPUT.PUT_LINE('PREDICATED PASS '||FLOOR(PASSED_SUM/7) ||' UNIT');
		DBMS_OUTPUT.PUT_LINE('PREDICATED TARGET '||FLOOR(TARGET_SUM/7) ||' UNIT');
		DBMS_OUTPUT.PUT_LINE('TODAY '||c_date ||' ');
		DBMS_OUTPUT.PUT_LINE('######');




	end daily_prediction_proc;
	
	

	procedure proc_porfit
			IS
			
		tdate DATE;
		Assembled INTEGER;
		Passed INTEGER;
		Target INTEGER;
		ndate DATE;
		COUNT_FLAG INTEGER ;
		ASSEMBLED_SUM INTEGER ;
		PASSED_SUM INTEGER ;
		TARGET_SUM INTEGER;	
		AVG_PASSED_SUM INTEGER ;
		AVG_TARGET_SUM INTEGER;	
		n_LOOP INTEGER;		
	begin
		COUNT_FLAG	:=0;
		ASSEMBLED_SUM :=0;
		PASSED_SUM :=0;
		TARGET_SUM :=0;
		n_LOOP:=7;
		FOR R IN (select * from factory order by tdate DESC) LOOP
		tdate :=R.tdate;
		Assembled := R.Assembled;
		Passed := R.Passed;
		Target := R.Target;
		IF COUNT_FLAG=n_LOOP THEN
		AVG_PASSED_SUM:=FLOOR(PASSED_SUM/n_LOOP);
		AVG_TARGET_SUM:=FLOOR(TARGET_SUM/n_LOOP);
		EXIT;
		ELSE
		ASSEMBLED_SUM := ASSEMBLED_SUM+Assembled;
		PASSED_SUM := PASSED_SUM + Passed;
		TARGET_SUM := TARGET_SUM +Target;
		COUNT_FLAG :=COUNT_FLAG+1;

		END IF;

		END LOOP;
		ndate:=tdate+n_LOOP +1;


		IF AVG_PASSED_SUM < AVG_TARGET_SUM THEN
		DBMS_OUTPUT.PUT_LINE('will not be able to match target');
		END IF;

	end proc_porfit;


	

end myPackage;
/
