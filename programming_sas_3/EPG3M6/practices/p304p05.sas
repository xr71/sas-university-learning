**************************************************************;
*  LESSON 4, PRACTICE 5                                      *;
**************************************************************;

data work.storm_cat345_facts;
    if _N_=1 then do;
       if 0 then set pg3.storm_range;
       declare hash Storm(dataset:'pg3.storm_range');
       Storm.definekey('StartYear','Name','Basin');
       Storm.definedata('Wind1','Wind2','Wind3','Wind4');
       Storm.definedone(); 
    end;
    set pg3.storm_summary_cat345;
    if Storm.find(key:year(StartDate),key:Name,key:Basin)=0;
    keep Name Basin Wind1-Wind4 Season MaxWindMPH StartDate; 
run;

proc sort data=work.storm_cat345_facts
          out=work.cat345_sort
             (keep=Season Name Wind1-Wind4 MaxWindMPH);
    by descending MaxWindMPH descending Season descending Name;
run;

title1 'Storm Statistics for Category 3, 4, and 5';
title2 'sorted by descending (MaxWindMPH, Season, and Name)';
proc print data=work.cat345_sort;  
run;
title;