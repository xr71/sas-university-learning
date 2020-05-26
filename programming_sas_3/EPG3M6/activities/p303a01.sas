***********************************************************;
*  Activity 3.01                                          *;
*  1) Replace the number signs (#) to reference the       *;
*     appropriate number of 2017 temperature columns.     *;
*  2) Modify the temperature conversion assignment        *;
*     statement by replacing the ??? with the name of the *;
*     column being incremented.                           *;
*  3) Run the program and confirm that you are now seeing *;
*     Celsius temperatures. What is the lowest average    *;
*     Celsius temperature for each City in 2017?          *;
***********************************************************;
  
 data work.DublinMadrid2017(drop=Month);
     set pg3.weather_dublinmadrid_monthly2017
        (keep=City Temp1-Temp12);
     array Temperature[#] Temp1-Temp12;
     do Month=1 to #;
        Temperature[???]=(Temperature[???]-32)*5/9;
     end;
     format Temp1-Temp12 6.1;
run;

title 'Average Monthly Celsius Temperatures for 2017';
proc print data=work.DublinMadrid2017;
run;
title;
