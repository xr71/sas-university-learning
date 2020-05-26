**************************************************************;
*  LESSON 2, PRACTICE 3                                      *;
**************************************************************;
  
data work.Mammal_Names;
    set pg3.np_mammals(keep=Scientific_Name Common_Names);




run;

title 'National Park Mammals';
proc print data=work.Mammal_Names;
run;
title;