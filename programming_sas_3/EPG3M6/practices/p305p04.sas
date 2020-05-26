**************************************************************;
*  LESSON 5, PRACTICE 4                                      *;
**************************************************************;

/* add a PROC FCMP step */


/* add an OPTIONS statement */


data work.scores;
    set pg3.class_tests;
    /* add an assignment statement */

run;

title 'Student Scores';
proc print data=work.scores;
run;
title;
