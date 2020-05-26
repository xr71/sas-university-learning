**************************************************************;
*  LESSON 3, PRACTICE 5                                      *;
**************************************************************;

data work.MaxWind;
    /* add code to create and load two-dimensional array */

    set pg3.storm_stats;
    Qtr=qtr(StartDate);
    /* add code to use two-dimensional array */

run;

title 'Maximum Winds for Storms Between 1980 and 2016';
proc print data=work.MaxWind;
    var Season Qtr Name MaxWindMPH; 
run;
title;

