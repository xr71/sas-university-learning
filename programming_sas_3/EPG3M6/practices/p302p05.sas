**************************************************************;
*  LESSON 2, PRACTICE 5                                      *;
**************************************************************;
 
data work.BaseballPlayers; 
    set sashelp.baseball(keep=Name);  

run; 

title 'Names of Baseball Players'; 
proc print data=work.BaseballPlayers; 
run; 
title;
