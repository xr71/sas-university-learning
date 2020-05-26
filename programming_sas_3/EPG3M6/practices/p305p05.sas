 **************************************************************;
*  LESSON 5, PRACTICE 5                                      *;
**************************************************************;

/* add a PROC FCMP step */


/* add an OPTIONS statement */


data work.FlipNames;
    set sashelp.baseball(keep=Name Team);
    /* add an assignment statement */

    drop Name;
run;

title 'Baseball Players and Teams';
proc print data=work.FlipNames;
    var Player Team;
run;
title;
