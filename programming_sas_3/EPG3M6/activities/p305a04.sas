***********************************************************;
*  Activity 5.04                                          *;
*  1) Create another custom function in the PROC FCMP     *;
*     step.                                               *;
*     - Add a FUNCTION statement to create a function     *;
*       named INtoCM that has a numeric argument of Pin.  *;
*     - Add the following assignment statement:           *;
*       Pcm=Pin*2.54;                                     *;
*     - Add a RETURN statement to return the value of     *;
*       Pcm.                                              *;
*     - Add an ENDSUB statement.                          *;
*  2) Run the program and verify that the PrecipCM values *;
*     are 2.54 times bigger than the Precip values. Does  *;
*     the PROC SQL step use the custom functions          *;
*     successfully?                                       *;
***********************************************************;
   
proc fcmp outlib=pg3.funcs.weather;
    function FtoC(TempF);
       TempC=round((TempF-32)*5/9,.01);
       return(TempC);
    endsub;
    /* add FUNCTION, assignment, RETURN, and ENDSUB statements here */

run;

options cmplib=pg3.funcs;

proc sql;
    select Date, Tavg, Tunit, FtoC(Tavg) as TavgC, 
           Precip, Punit, INtoCM(Precip) as PrecipCM
    from pg3.weather_ny_daily2017;
quit;
 
