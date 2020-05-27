**************************************************************;
*  LESSON 2, PRACTICE 5                                      *;
**************************************************************;
 
 /* p302p05_s.sas */

data work.BaseballPlayers; 
    set sashelp.baseball(keep=Name);  
    FirstLastName=prxchange('s/(\w+\D*\w*)(, )(\w+\s*\w*\b)/$3 $1/',-1,Name); 
run; 

title 'Names of Baseball Players'; 
proc print data=work.BaseballPlayers; 
run; 
title;
