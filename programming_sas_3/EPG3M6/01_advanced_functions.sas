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
data stocklag;
	set pg3.stocks_ABC;
	close1mnthback = lag1(close);
	close2mnthback = lag2(close);
	close3mnthavg = mean(close, close1mnthback, close2mnthback);
run;


proc sgplot data=stocklag;
	scatter x=Date y=close;
	series x=Date y=close3mnthavg;
run;



* the wrong way of doing lag;
data work.stockmovingavg;
    set pg3.stocks_ABC(drop=Close);
    Open1MnthBack=lag1(Open);
    Open2MnthBack=lag2(Open);
    if _N_ ge 3 then 
       Open3MnthAvg=mean(Open,lag1(Open),lag2(Open));
    format Open3MnthAvg 8.2;
run;

title 'Three Month Moving Average on Opening Stock Price'; 
proc print data=work.stockmovingavg noobs;
run;
title;
* lag creates the que starting only from row 3;
* instead, create the lag values outside of the conditional;





