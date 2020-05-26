****************************************************************;
*  Specifying a Template for Datetime Values                   *;
****************************************************************;
  
proc format;
    value $genfmt 'F' = 'Female'
                  'M' = 'Male'
                other = 'Miscoded';
    value hrange low-<58  = 'Below Average'
                  58-60   = 'Average'
                 60<-high = 'Above Average';
run;

proc print data=pg3.class_birthdate noobs;
    var Name Gender Height;
    format Gender $genfmt. Height hrange.;
run;

proc format;
    picture MyDate (default=15) 
            low-high = '%a-%d-%3B-%Y' 
            (datatype=date);
    picture MyTime (default=14) 
            low-high = 'H:%0H M:%0M S:%0S' 
            (datatype=time);
    picture MyDateTime (default=24) 
            low-high = '%Y.%0m.%0d @ %I:%0M:%0S %p' 
            (datatype=datetime);
run;

data work.datetimetable;
    StartDate='02JAN2019'd;
    StartTime='21:13:5't;
    StartDateTime='02JAN2019:21:13:5'dt;
    format StartDate MyDate. StartTime MyTime. StartDateTime MyDateTime.; 
run;

proc print data=work.datetimetable;
run;

proc format;
    picture MyDate (default=15) 
             low-'31DEC1999'd = '%3B-%Y' (datatype=date)
            '01JAN2000'd-high = '%a-%d-%3B-%Y' (datatype=date);
run;

data work.datetimetable;
    StartDate='02JAN2019'd; output;
    StartDate='15MAY1995'd; output;
    format StartDate MyDate.; 
run;

proc print data=work.datetimetable;
run;

****************************************************************;
*  Demo                                                        *;
*  1) Highlight and run the TITLE statements and the PROC      *;
*     PRINT step. Notice the formatted value of ISO_time.      *;
*  2) Notice the syntax of the PROC FORMAT step. The date and  *;
*     time directives are specifying a one- or two-digit day   *;
*     of month, a three-letter proper case month name, a       *;
*     four-digit year, a colon, a one- or two-digit 24-clock   *;
*     hour, and the letter H (for example, 7Aug1980:18H).      *;
*  3) Modify the FORMAT statement in the PROC PRINT step to    *;
*     use the custom format created in the PROC FORMAT step.   *;
*       format ISO_time dateh.;                                *;
*  4) Highlight and run the demo program. Notice that the      *;
*     ISO_time values are not formatted properly because SAS   *;
*     did not recognize the date and time directives.          *;
*  5) Add the DATATYPE= option to the PICTURE statement after  *;
*     the directives.                                          *;
*       picture dateh                                          *;
*               low-high='%d%3B%Y:%HH'                         *;
*               (datatype=datetime);                           *;
*  6) Highlight and run the program. Notice that the ISO_time  *;
*     values are formatted but are being truncated. A length   *;
*     of 11 is being used by default because that is the       *;
*     length of the template.                                  *;
*  7) Add the DEFAULT= option to the PICTURE statement after   *;
*     the name of the format.                                  *;
*       picture dateh (default=13)                             *;
*               low-high='%d%3B%Y:%HH'                         *;
*               (datatype=datetime);                           *;
*  8) Highlight and run the demo program. Verify the formatted *;
*     values of ISO_time.                                      *;
****************************************************************;

proc format;
    picture dateh 
            low-high='%d%3B%Y:%HH';
run;

title 'Storms with Category 5 Winds';
proc print data=pg3.storm_detail noobs;
    var Name ISO_time Wind Pressure Region;
    where Wind>155; 
    format ISO_time datetime.;
run;
title;
 
