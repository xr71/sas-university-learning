**************************************************************;
*  LESSON 3, PRACTICE 2                                      *;
**************************************************************;

data work.TestScores; 
    set pg3.test_answers;
    Score=0; 

run;

title 'Employee Test Results';
proc print data=work.TestScores;
run;
title;
