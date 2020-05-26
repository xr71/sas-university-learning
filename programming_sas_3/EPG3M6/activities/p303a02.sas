***********************************************************;
*  Activity 3.02                                          *;
*  1) Modify the ARRAY statement to use an asterisk in    *;
*     place of the number of elements and to reference    *;
*     all 2018 temperature columns that start with Temp.  *;
*  2) In the DO statement, replace the value of 12 with   *;
*     the DIM function referencing the Temperature array. *;
*  3) Run the program. Based on the results, how many     *;
*     temperature columns are in the array for the 2018   *;
*     data?                                               *;
***********************************************************;
 
 data work.DublinMadrid2018(drop=Month);
     set pg3.weather_dublinmadrid_monthly2018
        (keep=City Temp:);
     array Temperature[12] Temp1-Temp12;
     do Month=1 to 12;
        Temperature[Month]=(Temperature[Month]-32)*5/9;
     end;
     format Temp: 6.1;
run;

title 'Average Monthly Celsius Temperatures for 2018';
proc print data=work.DublinMadrid2018;
run;
title;
