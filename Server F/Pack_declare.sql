create or replace package  myPackage as


	 function avgassemble(n_LOOP in INTEGER,c_date in DATE)
	  return INTEGER;

	 function avgpassed(n_LOOP in INTEGER,c_date in DATE)
	  return INTEGER;
	  
	 function avgTarget(n_LOOP in INTEGER,c_date in DATE)
	  return INTEGER;


	 procedure daily_prediction;
	 
	 procedure delete_extra_data;
	 
	 procedure last_seven_day_production;
	 
	 procedure proc_m_data_create;
	 
	

	 procedure m_porf(UNIT_PRICE in INTEGER,PRODUCTION_COST in INTEGER,sdate in DATE,fdate in DATE);

	 procedure proc_porfit;
	 
	 

end myPackage;
/