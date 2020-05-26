****************************************************************;
*  Creating Functions Containing One Argument                  *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*  1) Highlight and run the PROC FCMP step. View the output    *;
*     table storing the new function.                          *;
*  2) Highlight and run the DATA step. View the error in the   *;
*     SAS log that is related to SAS not finding the FtoC      *;
*     function.                                                *;
*  3) Highlight and run the OPTIONS statement and the DATA     *;
*     step. View the new column TavgC in the NewYork table.    *;
*  4) Open pg3.weather_sydney_daily2017. Notice that the Tavg  *;
*     values are in the unit of Celsius.                       *;
*  5) Add syntax to the PROC FCMP step to create the CtoF      *;
*     function.                                                *;
*       function CtoF(TempC);                                  *;
*          TempF=round(TempC*9/5+32,.01);                      *;
*          return(TempF);                                      *;
*       endsub;                                                *;
*  6) Highlight and run the PROC FCMP step. Confirm that there *;
*     are no errors. View the output table storing the new     *;
*     function.                                                *;
*  7) Copy and paste the DATA step for the New York data.      *;
*     Modify the new DATA step to use the Sydney data with the *;
*     CtoF function.                                           *;
*       data work.Sydney;                                      *;
*           set pg3.weather_sydney_daily2017;                  *;
*           TavgF=CtoF(TAvg);                                  *;
*       run;                                                   *;
*  8) Highlight and run the new DATA step. View the new column *;
*     TavgF in the Sydney table.                               *;
****************************************************************; 

proc fcmp outlib=pg3.funcs.weather;
    function FtoC(TempF);
       TempC=round((TempF-32)*5/9,.01);
       return(TempC);
    endsub;
run;

options cmplib=pg3.funcs;

data work.NewYork;
    set pg3.weather_ny_daily2017;
    TavgC=FtoC(Tavg);
run;
