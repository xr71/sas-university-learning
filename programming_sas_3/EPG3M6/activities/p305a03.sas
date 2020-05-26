***********************************************************;
*  Activity 5.03                                          *;
*  What are the formatted values of PERCENT based on the  *;
*  PICTURE statement?                                     *;
***********************************************************;
   
proc freq data=pg3.tornado_2017 noprint;
    where PropertyDamage>0;
    tables State / out=work.tornado_2017_pct; 
run;

proc format;
    *picture mypct low-high='009.9%' (multiplier=10);
    *picture mypct (round) low-high='009.9%' (multiplier=10);
    picture mypct low-high='009.99%' (multiplier=100);
run;

title1 '2017 US Tornadoes';
title2 'with Property Damage by State';
proc print data=work.tornado_2017_pct noobs;
    *format Percent percent8.2;
    format Percent mypct.;
run;
title;
 
