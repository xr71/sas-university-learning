proc sgplot data=stat1.normtemp;
	vbox bodytemp / category=gender connect=mean;
run;

* association within categorical variables - one way ANOVA;
* explore this association using boxplot;

* in other words, knowing this CAT var provides additional information in predicting the response;


proc sgplot data=stat1.ameshousing;
	vbox saleprice / category=central_air;
run;

 
proc sgscatter data=stat1.normtemp; 
	plot bodytemp * heartrate / reg; 
run;



/*
ANOVA - ONE WAY
*/
