**************************************************************;
*  LESSON 4, PRACTICE 3                                      *;
**************************************************************;

data work.storm_cat345_facts work.nonmatches;
    if _N_=1 then do;
       if 0 then do;
          set pg3.storm_range;
       end;
       declare hash Storm(dataset:'pg3.storm_range');
       Storm.definekey('StartYear','Name','Basin');
       Storm.definedata('Wind1','Wind2','Wind3','Wind4');
       Storm.definedone(); 
       /* declare and define an additional hash object */




    end;
    set pg3.storm_summary_cat345;
    ReturnCode1=Storm.find(key:year(StartDate),key:Name,key:Basin); 
    drop StartYear;
run;

title 'Storm Statistics with Basin Names for Category 3, 4, and 5';
proc print data=work.storm_cat345_facts;  
run;
title;

title 'Non-Matches';
proc print data=work.nonmatches;  
run;
title;
