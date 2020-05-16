* simple linear regression;

proc reg data=stat1.ameshousing3;
	model saleprice = lot_area;
run;


 
proc reg data=stat1.bodyfat2; 
	model pctbodyfat2 = weight; 
run; 


* 2 way anova;

proc print data=stat1.ameshousing3 (obs=2); run;

proc sgplot data=stat1.ameshousing3;
	vline heating_qc / group=season_sold response=saleprice stat=mean;
run;


proc print data=stat1.bodyfat2 (obs=2); run;

%let bodyinterval = Density	Age	Weight	Height	Adioposity	FatFreeWt	Neck	Chest	Abdomen	Hip	Thigh	Knee	Ankle	Biceps	Forearm	Wrist;



* practice;
* Examine the data with a vertical line plot. Put BloodP on the Y axis, and DrugDose on the X axis, and then stratify by Disease.;
proc print data=stat1.drug (obs=2); run;

proc sgplot data=stat1.drug;
	vline drugdose / response=bloodp group=disease stat=mean markers;
run;

* What information can you obtain by looking at the data?;

/*
It seems that the drug dose affects a change in blood pressure. 
However, that effect is not consistent across diseases. Higher doses result 
in increased blood pressure for patients with disease B, decreased blood 
pressure for patients with disease A, and little change in blood pressure 
for patients with disease C.
*/

* Test the hypothesis that the means are equal. Be sure to include an interaction 
term if the graphical analysis that you performed indicates that would be advisable.;

proc glm data=stat1.drug;
	class disease;
	model bloodp = drugdose disease drugdose*disease;
run;

* we need to use lsmeans;
proc glm data=stat1.drug;
	class disease drugdose;
	model bloodp = drugdose disease drugdose*disease;
	lsmeans drugdose*disease;
run;

/*
The global F test indicates a significant difference among the 
different groups. Because the interaction is in the model, this 
is a test of all combinations of DrugDose*Disease against all other 
combinations. The R-square value implies that approximately 35% of 
the variation in BloodP can be explained by variations 
in the explanatory variables. The interaction term is statistically 
significant, as preditcted by the plot of the means.
*/

ods graphics on;
proc glm data=STAT1.drug plots(only)=intplot;
   class DrugDose Disease;
   model BloodP=DrugDose|Disease;
   lsmeans DrugDose*Disease / slice=Disease;
run;
quit;

