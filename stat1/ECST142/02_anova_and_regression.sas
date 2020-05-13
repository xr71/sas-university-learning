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

proc glm data=stat1.ameshousing3 plots=diagnostics;
	class heating_qc;
	model saleprice = heating_qc;
	means heating_qc / hovtest=levene;
run;

* practice;
proc glm data=stat1.garlic plots=diagnostics;
	class fertilizer;
	model bulbwt = fertilizer;
	means fertilizer / hovtest=levene;
run;

* practice for multiple comparison procs;
proc glm data=stat1.garlic plots(only)=(diagnostic diffplot controlplot);
	class fertilizer;
	model bulbwt = fertilizer;
	means fertilizer;
	lsmeans fertilizer / pdiff=all adjust=tukey;
	lsmeans fertilizer / pdiff=control('4') adjust=dunnett;
run;

* unadjusted;
ods graphics;

ods select lsmeans diff diffplot controlplot;
proc glm data=STAT1.Garlic 
         plots(only)=(diffplot(center) controlplot);
   class Fertilizer;
   model BulbWt=Fertilizer;
   No_Adjust: lsmeans Fertilizer / pdiff=all adjust=t;
   title "Post-Hoc Analysis of ANOVA - Fertilizer as Predictor";
run;
quit;

