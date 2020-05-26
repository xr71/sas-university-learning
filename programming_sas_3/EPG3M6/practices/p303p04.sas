**************************************************************;
*  LESSON 3, PRACTICE 4                                      *;
**************************************************************;
 
data work.MaxWind;
    set pg3.storm_stats;
    where Season between 1980 and 1981;
    Qtr=qtr(StartDate);

run;

title 'Maximum Winds for Storms Between 1980 and 1981';
proc print data=work.MaxWind;
    var Season Qtr Name MaxWindMPH; 
run;
title;
