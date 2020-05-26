***********************************************************;
*  Activity 4.02                                          *;
*  1) Add two statements to the DATA step for the Monthly *;
*     hash object:                                        *;
*     - Add a DEFINEKEY method referencing the keys of    *;
*       City and Month.                                   *;
*         object-name.DEFINEKEY('key-1','key-2');         *;
*     - Add a DEFINEDATA method referencing the data of   *;
*       TempMonAvg and PrecipMonSum.                      *;
*         object-name.DEFINEDATA('data-1','data-2');      *;
*  2) Run the DATA step and confirm no errors in your SAS *;
*     log. How many rows were read from the input table   *;
*     into the hash object?                               *;
***********************************************************;
   
data work.Top5TempPrecip;
    length City $ 11 Month TempMonAvg PrecipMonSum 8;
    if _N_=1 then do;
       declare hash Monthly(dataset: 'pg3.weather_ustop5_monthly2017');
       /* add DEFINEKEY method for City and Month */

       /* add DEFINEDATA method for TempMonAvg and PrecipMonSum */

       Monthly.definedone();
       call missing (City, Month, TempMonAvg, PrecipMonSum);
    end;
run;


