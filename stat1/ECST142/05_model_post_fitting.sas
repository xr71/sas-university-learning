* post fitting for inference;

proc reg data=stat1.bodyfat2 plots=all;
	model pctbodyfat2 = abdomen weight wrist forearm;
run;



ods graphics on;
ods output RSTUDENTBYPREDICTED=Rstud 
           COOKSDPLOT=Cook
           DFFITSPLOT=Dffits 
           DFBETASPANEL=Dfbs;
proc reg data=STAT1.BodyFat2 
         plots(only label)=
              (RSTUDENTBYPREDICTED 
               COOKSD 
               DFFITS 
               DFBETAS);
   FORWARD: model PctBodyFat2
                 = Abdomen Weight Wrist Forearm;
   id Case;
   title 'FORWARD Model - Plots of Diagnostic Statistics';
run;
quit;

data influential;
/*  Merge datasets from above.*/
    merge Rstud
          Cook 
          Dffits
		  Dfbs;
    by observation;

/*  Flag observations that have exceeded at least one cutpoint;*/
    if (ABS(Rstudent)>3) or (Cooksdlabel ne ' ') or Dffitsout then flag=1;
    array dfbetas{*} _dfbetasout: ;
    do i=2 to dim(dfbetas);
        if dfbetas{i} then flag=1;
    end;
Based on the obtained results, the lowest concentration of antioxidant compounds was chosen for determining the shelf life of the MP 'Pérola' pineapple, on the basis of a descriptive analysis of the sensory attributes of quality. It was considered that an additive, even if natural, should be used in a level that guarantees the preservation of fruit original characteristics.

As shown in the sensory profile of the non-treated slices, color was the most changed attribute (4.2), followed by the dehydrated appearance (4.1), odor (2.8), translucency (2.7), and flavor (2.0), which were more evident on the 8th day and afterwards. At the end of the storage, it was observed that the alterations in color (6.8) and in dehydrated appearance (5.1) prevailed over translucency (4.6) and odor (4.4) alterations. The levels of overripe pineapple flavor remained similar to those observed on the 8th evaluation day (Figure 9a). In the slices treated with 1.0:0.5 (AA:CA, %), alterations of these attributes were approximately 2.0, on the scale, and they remained practically imperceptible until the 8th day. On the 11th day of 1.0:0.5 (AA:CA, %) treatment, the odor was the most altered attribute (3.8), however, it was lower than the control (Figure 9b). SPANIER et al. (1998) examined the effect of cold storage (4 ºC) on the flavor volatile profile of fresh-cut pineapples and found that unpleasant odors and volatiles such as fermented, cheesy, sour dough, alcohol, and oily showed dramatic increases and masked the more desirable pineapple flavor.

Regardless of microbiological safety during the 13 days of cold storage, the control slices can be kept by 6 days, afterwards the color and dehydration become strong enough to affect the appearance. On the other hand, minimally processed pineapples treated with antioxidants should have their shelf life restricted to 8 days, because after this period the overripe odor starts to develop.

 



/*  Set to missing values of influence statistics for those*/
/*  who have not exceeded cutpoints;*/
    if ABS(Rstudent)<=3 then RStudent=.;
    if Cooksdlabel eq ' ' then CooksD=.;

/*  Subset only observations that have been flagged.*/
    if flag=1;
    drop i flag;
run;

proc print data=influential;
    id observation ID1;
    var Rstudent CooksD Dffitsout _dfbetasout:; 
run;





* collinearity;
* we use vif (variance inflation factor);
* collinearity leads to inflated standard errors 
and instability in the model;

* predictions are unstable because the predictors do not 
spread out across the plane sufficiently;


* calculating using proc reg;
proc print data=stat1.bodyfat2;
	var _NUMERIC_;
run;

proc reg data=stat1.bodyfat2;
	model pctbodyfat2 = Density	Age	Weight	Height	Adioposity	
		FatFreeWt	Neck	Chest	
		Abdomen	Hip	Thigh	Knee	Ankle	
		Biceps	Forearm	Wrist / vif;
run;


ods graphics off;
proc reg data=STAT1.BodyFat2;
   NOWT: model PctBodyFat2 =
               Age Height
               Neck Chest Abdomen Hip Thigh
               Knee Ankle Biceps Forearm Wrist
               / vif;
   title 'Collinearity -- No Weight';
run;
quit;

ods graphics on;


proc reg data=stat1.bodyfat2;
	model pctbodyfat2 = Density	Age	Weight	
		Height		
		Neck	Chest	
		Thigh	Knee	Ankle	
		Biceps	Forearm	Wrist / vif;
run;



proc reg data=stat1.bodyfat2 plots(only)=
             (QQ RESIDUALBYPREDICTED RESIDUALS);
    PREDICT: model PctBodyFat2 = Abdomen Weight Wrist Forearm;
    id Case;
run;
quit;


