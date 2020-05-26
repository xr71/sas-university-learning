**************************************************************;
*  LESSON 5, PRACTICE 6                                      *;
**************************************************************;
  
/* add a PROC FCMP step */


/* add an OPTIONS statement */


data work.DateChange;
    set pg3.eu_occ;
    call missing(NewDate);
    /* add a CALL statement */

    format NewDate date9.;
run;

title 'End of Month Occupancies';
proc print data=work.DateChange;
run;
title;