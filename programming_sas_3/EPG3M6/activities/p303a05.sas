***********************************************************;
*  Activity 3.05                                          *;
*  1) Add an ARRAY statement to create a two-dimensional  *;
*     array.                                              *;
*     - Name the array PMT.                               *;
*     - The row dimension should reference the values     *;
*       2015, 2016, and 2017.                             *;
*     - The column dimension should reference the values  *;
*       1 to 2.                                           *;
*     - The array elements should be temporary.           *;
*     - Use the following as the six initial values:      *;
*       2.29, 1.04, 4.15, 2.34, 0.90, and 2.44.           *;
*  2) Run the program and view the results.               *;
*  3) How many dates have daily precipitation greater     *;
*     than 0.3 inches and greater than 20% of the monthly *;
*     precipitation?                                      *;
***********************************************************;
 
data work.DublinPrecipPct(drop=Y M);
    /* add an ARRAY statement */



    set pg3.weather_dublin_daily5yr(keep=Date Precip);
    where month(Date) le 2 and year(Date) ge 2015 
          and Precip > 0.3;
    Y=year(Date);
    M=month(Date);
    PrecipMonthlyTotal=PMT[Y,M];
    PrecipMonthlyPct=Precip/PrecipMonthlyTotal;
    format PrecipMonthlyPct percent8.1;
run;

title1 'Daily Precipitation Greater Than 0.3 Inches';
title2 'and Greater Than 20% of Monthly Precipitation';
proc print data=work.DublinPrecipPct noobs;
    where PrecipMonthlyPct>0.2;
run;
title;
 
