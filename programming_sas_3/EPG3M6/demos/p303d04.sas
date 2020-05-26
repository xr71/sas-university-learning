****************************************************************;
*    Processing Two-Dimensional Arrays: Part 1                 *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*     Note: The debugger portion of this demo must be          *;
*     performed in Enterprise Guide.                           *;
*  1) Notice the ARRAY statement that creates the              *;
*     two-dimensional array Avg. This array has two rows       *;
*     defined with year values of 2013 and 2014 and three      *;
*     columns defined with month values of 1, 2, and 3. The    *;
*     array creates six new columns, Avg1-Avg6. For simplicity *;
*     purposes, the SET statement contains a WHERE= data set   *;
*     option limiting the daily average temperatures to the    *;
*     15th day of January, February, or March for the years    *;
*     2013 and 2014.                                           *;
*  2) In Enterprise Guide, click the Toggle DATA Step Debugger *;
*     toolbar button to enable debugging in the program. Click *;
*     the Debugger icon next to the DATA statement. The DATA   *;
*     Step Debugger window appears. Notice that at the         *;
*     beginning of execution the six average columns are       *;
*     populated with the initial values from the ARRAY         *;
*     statement.                                               *;
*  3) Click the Step execution to the next line toolbar button *;
*     to execute through the statements. As the SET statement  *;
*     executes, Date and TempDailyAvg are populated. The Y and *;
*     M columns are populated from the first two assignment    *;
*     statements. TempMonthlyAvg is populated by the third     *;
*     assignment statement, which locates the desired monthly  *;
*     average temperature in the array using Y and M for the   *;
*     lookup. Continue clicking through the six iterations of  *;
*     the DATA step and notice that each iteration uses the    *;
*     appropriate value from the array.                        *;
*  4) Close the DATA Step Debugger window.                     *;
*  5) Run the DATA step. Notice that the output table contains *;
*     the six average columns.                                 *;
*  6) Add _temporary_ to the ARRAY statement prior to the      *;
*     initial values.                                          *;
*       array Avg[2013:2014,3] _temporary_                     *;
*                              (40.9, 40.7, 38.6,              *;
*                               42.5, 42.6, 45.4);             *;
*  7) Click the Debugger icon next to the DATA statement to    *;
*     open the DATA Step Debugger window. Notice that the six  *;
*     average columns do not appear in the debugger because    *;
*     the columns are defined as temporary. Close the DATA     *;
*     Step Debugger window.                                    *;
*  8) Run the DATA step. Verify that the output table contains *;
*     the desired output.                                      *;
*  9) As an alternative, eliminate the assignment statements   *;
*     for the Y and M columns. In the assignment statement for *;
*     the TempMonthlyAvg column, use expressions for the rows  *;
*     and columns within the reference to the Avg array.       *;
*       TempMonthlyAvg=Avg[year(Date),month(Date)];            *;
* 10) Run the DATA step. Verify that the output table contains *;
*     the desired output.                                      *;
****************************************************************;
 
data work.DublinDaily;
    array Avg[2013:2014,3] (40.9, 40.7, 38.6, 
                            42.5, 42.6, 45.4); 
    set pg3.weather_dublin_daily5yr
           (where=(day(Date)=15 and
                   month(Date) le 3 and 
                   year(Date) in (2013,2014))
            keep=Date TempDailyAvg);  
    Y=year(Date);
    M=month(Date); 
    TempMonthlyAvg=Avg[Y,M];
    Difference=TempDailyAvg-TempMonthlyAvg;
run;

