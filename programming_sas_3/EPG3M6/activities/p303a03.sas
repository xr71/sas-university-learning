***********************************************************;
*  Activity 3.03                                          *;
*  1) Run the DATA step, which does not include ARRAY     *;
*     syntax, and verify that the new table contains 20   *;
*     rows of rotated data.                               *;
*  2) Modify the DATA step to use ARRAY syntax to rotate  *;
*     the data. Delete 12 assignment statements.          *;
*     Add 5 statements.                                   *;
*       array P[4] PrecipQ1-PrecipQ4;                     *;
*       do Quarter=1 to 4;                                *;
*          Precip=P[Quarter]*2.54;                        *;
*          output;                                        *;
*       end;                                              *;
*  3) Run the DATA step, which now includes ARRAY syntax, *;
*     and verify that the new table contains 20 rows of   *;
*     rotated data.                                       *;
*  4) Run the PROC SGPLOT step to create the desired bar  *;
*     chart.                                              *;
*  5) What is the highest average quarterly precipitation *;
*     in centimeters for Dublin?                          *;
***********************************************************;
     
data work.DublinPrecipRotate;
    set pg3.weather_dublinmadrid_monthly5yr
       (keep=City Year PrecipQ1-PrecipQ4);
    where City='Dublin';
    Quarter=1; Precip=PrecipQ1*2.54; output;
    Quarter=2; Precip=PrecipQ2*2.54; output;
    Quarter=3; Precip=PrecipQ3*2.54; output;
    Quarter=4; Precip=PrecipQ4*2.54; output;
    format Precip 6.2;
    drop PrecipQ1-PrecipQ4;
run;

title 'Average Quarterly Precipitation (CM) for Dublin';
proc sgplot data=work.DublinPrecipRotate;
    vbar Quarter / response=Precip stat=mean datalabel
                   datalabelattrs=(size=12pt);
    format Precip 6.2;
run;
title;
 
