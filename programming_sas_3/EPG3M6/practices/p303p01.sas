**************************************************************;
*  LESSON 3, PRACTICE 1                                      *;
**************************************************************;
   
data work.MonthlyOcc;
    set pg3.eu_occ(drop=Geo);
    OccTotal=sum(Hotel,ShortStay,Camp);

    format Hotel ShortStay Camp OccTotal comma16.;
run;

title 'Percentage of Occupancy by Type';
proc print data=work.MonthlyOcc;
run;
title;
