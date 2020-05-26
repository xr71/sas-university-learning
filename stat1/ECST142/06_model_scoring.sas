* model scoring;

proc glmselect data=stat1.bodyfat2 seed=42;
	model pctbodyfat2 = weight wrist forearm
		ankle abdomen age biceps chest density height
		hip knee neck thigh;
	partition fraction(validate=0.3);
run;



%let interval=Gr_Liv_Area Basement_Area Garage_Area Deck_Porch_Area 
         Lot_Area Age_Sold Bedroom_AbvGr Total_Bathroom;
%let categorical=House_Style2 Overall_Qual2 Overall_Cond2 Fireplaces 
         Season_Sold Garage_Type_2 Foundation_2 Heating_QC 
         Masonry_Veneer Lot_Shape_2 Central_Air;
         
proc glmselect data=stat1.ameshousing3 seed=8675309
	plots=all;
	class &categorical / ref=first;
	model saleprice = &categorical &interval / 
		selection=stepwise select=aic choose=validate hierarchy=single;
	partition fraction(validate=0.333);
run;

	
* score statement in PROC PLM;
* using score statement in PROC GLMSELECT;
* use STORE statement in PROC GLMSELECT and the code 
	statement that results in a data step;

proc glmselect data=STAT1.ameshousing3
               seed=8675309
               noprint;
   class &categorical / param=ref ref=first;
   model SalePrice=&categorical &interval / 
               selection=stepwise
               (select=aic 
               choose=validate) hierarchy=single;
   partition fraction(validate=0.3333);
   score data=STAT1.ameshousing4 out=score1;
   store out=store1;
   title "Selecting the Best Model using Honest Assessment";
run;

proc plm restore=store1;
   score data=STAT1.ameshousing4 out=score2;
run;

proc compare base=score1 compare=score2 criterion=0.0001;
   var P_SalePrice;
   with Predicted;
run;

proc print data=work.score1 (obs=3); run;
proc print data=work.score2 (obs=3); run;

