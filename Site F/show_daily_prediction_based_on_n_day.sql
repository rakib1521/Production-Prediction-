/*
Showing prediction based on given day

*/

SET SERVEROUTPUT ON;

DECLARE
n_LOOP INTEGER := &HOW_MANY_DAYS;
tdate factory.tdate %TYPE;
Assembled factory.Assembled %TYPE;
Passed factory.Passed %TYPE;
Target factory.Target %TYPE;
BEGIN

	select current_date into tdate from dual;
	Assembled := avgassemble(n_LOOP);

	

	
	Passed := avgpassed(n_LOOP);

	
	
	Target := avgTarget(n_LOOP);
	
	DBMS_OUTPUT.PUT_LINE('######');
	DBMS_OUTPUT.PUT_LINE('PREDICATION ON LAST '||n_LOOP ||' DAY');
	DBMS_OUTPUT.PUT_LINE('PREDICATED ASSEMBLE '||Assembled ||' UNIT');
	DBMS_OUTPUT.PUT_LINE('PREDICATED PASSED '||Passed ||' UNIT');
	DBMS_OUTPUT.PUT_LINE('PREDICATED TARGET '||Target ||' UNIT');
	DBMS_OUTPUT.PUT_LINE('######');
	

END;
/
