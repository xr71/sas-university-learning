**************************************************************;
*  LESSON 5, PRACTICE 1                                      *;
**************************************************************;

proc format;


run;

proc sort data=pg3.storm_final out=work.storm_final;
    by descending StartDate;
run;

title 'Detail Storm Report by Descending Start Date';
proc print data=work.storm_final;
    var Name BasinName StartDate EndDate MaxWindMPH MinPressure;
    format StartDate EndDate worddate.;
run;
title;
