**************************************************************;
*  LESSON 2, PRACTICE 6                                      *;
**************************************************************;
  
data work.ParkCodes;
    set pg3.np_unstructured_codes;




run;

title 'Park Codes from Unstructured Column';
proc print data=work.ParkCodes;
run;
title;
