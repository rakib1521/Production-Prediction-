set verify off;
set serveroutput on;
create or replace package body myPackage as


	function avgassemble(n_LOOP in INTEGER,c_date in DATE)
		return INTEGER
		is
	  
		Assembled INTEGER;
		COUNT_FLAG INTEGER;
		ASSEMBLED_SUM INTEGER;

		prevdate DATE;

	begin
		COUNT_FLAG :=0;
		ASSEMBLED_SUM :=0;	

		prevdate:= c_date-n_LOOP;

		FOR R IN (select Assembled from factory@site_link ORDER BY tdate DESC) LOOP
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


	function avgpassed(n_LOOP in INTEGER,c_date in DATE)
		return INTEGER
		is
	  
		Passed INTEGER;
		COUNT_FLAG INTEGER;
		PASSED_SUM INTEGER;
		prevdate DATE;

	begin
		COUNT_FLAG :=0;
		PASSED_SUM :=0;	

		prevdate:= c_date-n_LOOP;

		FOR R IN (select Passed from factory@site_link ORDER BY tdate DESC) LOOP
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



	function avgTarget(n_LOOP in INTEGER,c_date in DATE)
		return INTEGER
		is
		  
		Target INTEGER;
		COUNT_FLAG INTEGER;
		TARGET_SUM INTEGER;

		prevdate DATE;

	begin
		COUNT_FLAG :=0;
		TARGET_SUM :=0;	


		prevdate:= c_date-n_LOOP;

		FOR R IN (select Target from factory@site_link ORDER BY tdate DESC) LOOP
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




	
	procedure daily_prediction
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
		select Target into Target from factory@site_link where tdate=to_date(I_DATE,'DDMMYY');
		FOR R IN (select * from factory@site_link where tdate>prevdate and tdate<c_date) LOOP
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
		FOR R IN (select * from factory@site_link where tdate>prevdate and tdate<c_date) LOOP
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




	end daily_prediction;



	
	procedure delete_extra_data
			IS

		tdate DATE;
		cdate DATE;
		v_day int;
		I_DATE VARCHAR(6);
	BEGIN
		SELECT TO_CHAR(CURRENT_DATE, 'DDMMYY') INTO I_DATE FROM dual;
		cdate :=to_date(I_DATE,'DDMMYY');
		delete from factory@site_link where tdate>=cdate;
		commit;
	END delete_extra_data;





	
	procedure last_seven_day_production
			IS
			

		sdate DATE;
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
		DBMS_OUTPUT.PUT_LINE('                             ######');
		select current_date into c_date from dual;
		prevdate:= c_date-7;
		sdate:=prevdate+1;
		FOR R IN (select * from factory@site_link where tdate>prevdate and tdate<c_date) LOOP
		Assembled := R.Assembled;
		Passed := R.Passed;
		Target := R.Target;
		IF COUNT_FLAG=7 THEN
		EXIT;
		ELSE
		DBMS_OUTPUT.PUT_LINE('Date  	  ||' || 'Assembled	||' || 'Passed	||' || 'Target	||');
		DBMS_OUTPUT.PUT_LINE(sdate||'     '||Assembled || '         ' ||Passed ||'                '||Target);
		sdate:=sdate+1;
		END IF;
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('                          ######');


	end last_seven_day_production;


	
	procedure proc_m_data_create
			IS
				
		tdate DATE;
		cdate DATE;
		I_DATE VARCHAR(6);	
		Assembled INTEGER;
		Passed INTEGER;
		Target INTEGER;

	begin
		SELECT TO_CHAR(CURRENT_DATE, 'DDMMYY') INTO I_DATE FROM dual;
		tdate :=to_date(I_DATE,'DDMMYY');
		cdate:=LAST_DAY(TO_DATE(I_DATE, 'DDMMYY'));
		select Assembled,Passed into Assembled,Passed from factory@site_link where tdate=to_date(I_DATE,'DDMMYY');	
		tdate:=tdate+1;	
		LOOP
		IF tdate=cdate THEN
			Assembled := avgassemble(7,tdate);
			Passed := avgpassed(7,tdate);
			Target := avgTarget(7,tdate);
			insert into factory@site_link (tdate, Assembled,Passed,Target) values (tdate, Assembled, Passed,Target); 
			commit;
			EXIT;
		ELSE 

			Assembled := avgassemble(7,tdate);
			Passed := avgpassed(7,tdate);
			Target := avgTarget(7,tdate);
			insert into factory@site_link (tdate, Assembled,Passed,Target) values (tdate, Assembled, Passed,Target); 
			commit;
			tdate:=tdate+1;	
		END IF;	
		END LOOP;


		EXCEPTION 
		 
		   WHEN no_data_found THEN 
			LOOP
			IF tdate=cdate THEN
				Assembled := avgassemble(7,tdate);
				Passed := avgpassed(7,tdate);
				Target := avgTarget(7,tdate);
				insert into factory@site_link (tdate, Assembled,Passed,Target) values (tdate, Assembled, Passed,Target); 
				commit;
				EXIT;
			ELSE 

				Assembled := avgassemble(7,tdate);
				Passed := avgpassed(7,tdate);
				Target := avgTarget(7,tdate);
				insert into factory@site_link (tdate, Assembled,Passed,Target) values (tdate, Assembled, Passed,Target); 
				commit;
				tdate:=tdate+1;	
			END IF;	
			END LOOP;
	end proc_m_data_create;



	
	procedure m_porf(UNIT_PRICE in INTEGER,PRODUCTION_COST in INTEGER,sdate in DATE,fdate in DATE)
			IS
			

		TOTAL_PASSED INTEGER ;
		TOTAL_SALARY_F INTEGER;
		TOTAL_SALARY_H INTEGER;
		TOTAL_SALARY INTEGER;
		PROFIT INTEGER;
		LOSS INTEGER;
		

	begin

		select sum(SALARY) INTO TOTAL_SALARY_F from emp_f@site_link;
		select sum(SALARY) INTO TOTAL_SALARY_H from emp_h;
		select sum(PASSED) INTO TOTAL_PASSED from factory@site_link where tdate>=sdate and tdate<=fdate ;
		TOTAL_SALARY:= TOTAL_SALARY_F+TOTAL_SALARY_H;
		DBMS_OUTPUT.PUT_LINE('######');
		DBMS_OUTPUT.PUT_LINE('TOTAL SALARY OF EMPLOYES IN THIS MONTH '||TOTAL_SALARY);
		DBMS_OUTPUT.PUT_LINE('TOTAL UNIT CREATED IN THIS MONTH '||TOTAL_PASSED);
		TOTAL_SALARY:= TOTAL_SALARY_F+PRODUCTION_COST;
		TOTAL_PASSED:=UNIT_PRICE*TOTAL_PASSED;
		DBMS_OUTPUT.PUT_LINE('TOTAL PRICE OF ALL UNITS '||TOTAL_PASSED);
		IF TOTAL_PASSED>TOTAL_SALARY THEN
		PROFIT := TOTAL_PASSED - TOTAL_SALARY;
		DBMS_OUTPUT.PUT_LINE('(+) PROFIT IN THIS MONTH '|| PROFIT);
		ELSE
		LOSS :=  TOTAL_SALARY - TOTAL_PASSED;
		DBMS_OUTPUT.PUT_LINE('(-) LOSS IN THIS MONTH '|| LOSS);
		
		END IF;
		DBMS_OUTPUT.PUT_LINE('######');
	end m_porf;




	
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
		FOR R IN (select * from factory@site_link order by tdate DESC) LOOP
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
