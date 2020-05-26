**************************************************************;
*  LESSON 2, PRACTICE 4                                      *;
**************************************************************;
  
data work.NationalPreserves;
    set pg3.np_acres;



run;

title 'National Preserves (NPRE)';
proc print data=work.NationalPreserves;
run;
title;
