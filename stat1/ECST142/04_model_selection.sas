* model selection - we can create a lot of possible models;

* all regression model - creates a large permutation of all possible models;
* this is time consuming;
* stepwise may be better since it is a lot less computationally expensive
as input columns increase;


* stepwise selection;
* forward and backward;
* start with all variables, and remove least p-value significant each time;

%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom ;
         
proc glmselect data=stat1.ameshousing3 plots=all;
   FORWARD: model SalePrice=&interval / selection=forward details=steps select=SL slentry=0.05;
   title "Forward Model Selection for SalePrice - SL 0.05";
run;


proc glmselect data=stat1.ameshousing3 plots=all;
   BACKWARD: model SalePrice=&interval / selection=backward details=steps select=SL slstay=0.05;
   title "Backward Model Selection for SalePrice - SL 0.05";
run;
title;


* body fact regression;
%let bodyfatinterval = Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;

proc glmselect data=stat1.bodyfat2 plots=all;
	STEPWISE: model pctbodyfat2 = &bodyfatinterval / selection=stepwise select=sl;
run;

proc glmselect data=stat1.bodyfat2 plots=all;
	model pctbodyfat2 = &bodyfatinterval / selection=forward select=sl;
run;

proc glmselect data=stat1.bodyfat2 plots=all;
	model pctbodyfat2 = &bodyfatinterval / selection=stepwise select=sl slentry=0.05 slexit=0.05;
run;

proc glmselect data=stat1.bodyfat2 plots=all;
	model pctbodyfat2 = &bodyfatinterval / selection=forward select=sl slentry=0.05;
run;



* more model selection - using information criterion;

%let bodyfatinterval = Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;

proc glmselect data=stat1.bodyfat2 plots=all;
	STEPWISESBC: model pctbodyfat2 = &bodyfatinterval / 
		selection=stepwise select=SBC;
run;

proc glmselect data=stat1.bodyfat2 plots=all;
	stepwiseaic: model pctbodyfat2 = &bodyfatinterval / 
		selection=stepwise select=AIC;
run;

	