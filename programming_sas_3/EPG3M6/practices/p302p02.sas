**************************************************************;
*  LESSON 2, PRACTICE 2                                      *;
**************************************************************;
  
data work.SouthRim;
    set pg3.np_grandcanyon;




run;

title 'Grand Canyon Comments Regarding South Rim';
proc print data=work.SouthRim;
run;
title;
