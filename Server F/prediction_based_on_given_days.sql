SET SERVEROUTPUT ON;

DECLARE
n_LOOP INTEGER := &HOW_MANY_DAYS;
tdate DATE;
Assembled INTEGER;
Passed INTEGER;
Target INTEGER;
BEGIN

	select current_date into tdate from dual;
	Assembled := avgassemble(n_LOOP,tdate);

	

	
	Passed := avgpassed(n_LOOP,tdate);

	
	
	Target := avgTarget(n_LOOP,tdate);
	DBMS_OUTPUT.PUT_LINE('######');
	DBMS_OUTPUT.PUT_LINE('PREDICATION FOR TODAY BASED ON LAST '||n_LOOP ||' DAY');
	DBMS_OUTPUT.PUT_LINE('PREDICATED ASSEMBLE '||Assembled ||' UNIT');
	DBMS_OUTPUT.PUT_LINE('PREDICATED PASS '||Passed ||' UNIT');
	DBMS_OUTPUT.PUT_LINE('PREDICATED TARGET '||Target ||' UNIT');
	DBMS_OUTPUT.PUT_LINE('TODAY '||tdate ||' ');
	DBMS_OUTPUT.PUT_LINE('######');
	

	

END;
/
