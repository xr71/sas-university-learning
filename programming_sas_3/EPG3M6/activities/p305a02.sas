***********************************************************;
*  Activity 5.02                                          *;
*  1) Run the program and notice the formatting of        *;
*     BeginDate.                                          *;
*  2) Add a PICTURE statement to create another date      *;
*     format.                                             *;
*     - Name the format MyMonth.                          *;
*     - Be sure to specify a default length.              *;
*     - All date values should have a format layout       *;
*       similar to November of 2017.                      *;
*       Hint: Use the %B and %Y directives.               *;
*     - Be sure to declare the data type.                 *;
*  3) Modify the FORMAT statement in the PROC FREQ step   *;
*     to use the new format. Run the program.             *;
*     Which month has the most tornados?                  *;
***********************************************************;
    
proc format;
    picture MyDate (default=14) 
            low-high = '%A-%Y' (datatype=date);
    /* add PICTURE statement here */
    picture MyMonth (default=16) 
            low-high = '%B of %Y' (datatype=date);
run;

title 'Frequency of 2017 US Tornadoes';
proc freq data=pg3.tornado_2017 order=freq;
    table BeginDate;
    format BeginDate MyMonth.;
run;
title;
 
