**************************************************************;
*  LESSON 4, PRACTICE 2                                      *;
**************************************************************;

data work.storm_cat345_facts;
    if _N_=1 then do;
       if 0 then set pg3.storm_range;
       /* add a DECLARE statement */

       /* use the DEFINEKEY, DEFINEDATA, and DEFINEDONE methods */



    end;
    set pg3.storm_summary_cat345;
    /* add an assignment statement and later
       modify to a subsetting IF statement */

    /* add a DROP statement */ 

run;

title 'Storm Statistics for Category 3, 4, and 5';
proc print data=work.storm_cat345_facts;  
run;
title;
