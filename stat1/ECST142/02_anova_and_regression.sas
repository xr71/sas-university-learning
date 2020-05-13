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



* pearson correlation;

proc corr data=stat1.ameshousing3;
	var lot_area gr_liv_area basement_area 
		deck_porch_area bedroom_abvgr total_bathroom;
	with saleprice;
	id PID;
run;

proc print data=stat1.ameshousing3 (obs=3); run;


proc corr data=stat1.ameshousing3
	plots=(matrix scatter);
	var gr_liv_area basement_area 
		deck_porch_area ;
	with saleprice;
	id PID;
run;


proc corr data=stat1.ameshousing3 nosimple best=5
	plots=matrix;
	var lot_area gr_liv_area basement_area 
		deck_porch_area bedroom_abvgr total_bathroom
		saleprice;
run;

proc corr data=stat1.bodyfat2
	plots=(scatter matrix);
	var age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist;
	with pctbodyfat2;
run;

%let interval=Age Weight Height Neck Chest Abdomen Hip 
              Thigh Knee Ankle Biceps Forearm Wrist;

ods graphics / reset=all imagemap;
proc corr data=STAT1.BodyFat2
          plots(only)=scatter(nvar=all ellipse=none);
   var &interval;
   with PctBodyFat2;
   id Case;
   title "Correlations and Scatter Plots";
run;

%let interval=Biceps Forearm Wrist;

ods graphics / reset=all imagemap;
ods select scatterplot;
proc corr data=STAT1.BodyFat2
          plots(only)=scatter(nvar=all ellipse=none);
   var &interval;
   with PctBodyFat2;
   id Case;
   title "Correlations and Scatter Plots";
run;




%let interval=Age Weight Height Neck Chest Abdomen Hip 
              Thigh Knee Ankle Biceps Forearm Wrist pctbodyfat2;

proc corr data=stat1.bodyfat2
	nosimple
	best=5
	out=pearson;
	var &interval;
run;

proc corr data=stat1.bodyfat2 nosimple
     plots(only)=scatter(nvar=all);
     var Age Weight Height;   
  run;
  


* simple linear regression;

proc reg data=stat1.ameshousing3;
	model saleprice = lot_area;
run;


 
proc reg data=stat1.bodyfat2; 
	model pctbodyfat2 = weight; 
run; 
