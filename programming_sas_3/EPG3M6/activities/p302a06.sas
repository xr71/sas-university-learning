***********************************************************;
*  Activity 2.06                                          *;
*  1) Run the PROC PRINT step and view the results.       *;
*  2) Modify the WHERE statement in the PROC PRINT step   *;
*     to find all the values of Narrative that contain    *;
*     EF3, EF-3, EF4, or EF-4.                            *;
*  3) Run the PROC PRINT step. View the results and the   *;
*     SAS log. How many rows were read based on the       *;
*     WHERE statement?                                    *;
***********************************************************;
      
title 'Category EF3 and EF4 Tornados';
proc print data=pg3.tornado_2017narrative;
    where prxmatch('/EF-?(3|4)/',Narrative)>0; /* Returns 21 rows */
run;
title;
