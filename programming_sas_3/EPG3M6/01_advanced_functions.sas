data testing1;
	a = "hello";
	c = find(a, "elo");
	output;
	
	
	a = "world";
	c = find(a, "or");
	output;
	
	
	a = "sas";
	c = find(a, "sas");
	output;
run;


data testing2;
	a = "hello";
	b = "elo";
	c = find(a, b, "it");
	output;
	
	
	a = "world";
	b = "or";
	c = find(a, b, "it");
	output;
	
	
	a = "sas";
	b = "sas";
	c = find(a, b, "it");
	output;
run;




* lag function;