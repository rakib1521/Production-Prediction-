SET SERVEROUTPUT ON;

DECLARE
tdate DATE :=to_date('&Enter_Date','DDMMYY');
Assembled INTEGER;
Passed INTEGER;
Target INTEGER;
cdate DATE;
c_loop INTEGER;
BEGIN
select count(tdate) into Assembled from factory@site_link;


FOR R in (SELECT tdate into cdate from factory@site_link order by tdate ) LOOP
cdate:=R.tdate;

END LOOP;

c_loop:=tdate-cdate;


FOR n_i IN 1..c_loop LOOP
	
	cdate:=cdate+1;
	Assembled := avgassemble(7,cdate);
	Assembled := Assembled +5;
	

	
	Passed := avgpassed(7,cdate);
	Passed :=Passed +3;
	

	
	
	Target := avgTarget(7,cdate);
	Target :=Target+2;
	

	insert into factory@site_link (tdate, Assembled,Passed,Target) values (cdate, Assembled, Passed,Target); 
	
END LOOP;
DBMS_OUTPUT.PUT_LINE('INSERTED');
commit;
END;
/
