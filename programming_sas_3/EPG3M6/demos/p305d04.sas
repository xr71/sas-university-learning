****************************************************************;
*  Creating Functions Containing Multiple Arguments            *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*  1) Notice the syntax for the PROC FCMP step. The Unit       *;
*     argument specifies whether the temperature is currently  *;
*     a Fahrenheit or Celsius value. If the current            *;
*     temperature is Fahrenheit, it is converted to Celsius.   *;
*     Conversely, if the current temperature is Celsius, it is *;
*     converted to Fahrenheit.                                 *;
*  2) Highlight and run the PROC FCMP step, the OPTIONS        *;
*     statement, and the DATA step. View the new column        *;
*     TavgConverted in the SydneyNewYork table. The            *;
*     temperature is in Fahrenheit for the Sydney rows and     *;
*     Celsius for the New York rows.                           *;
*  3) Add a third argument to the CnvTemp function that        *;
*     specifies the desired final unit.                        *;
*       function CnvTemp(Temp, Unit $, FinalUnit $);           *;
*  4) Delete the two conditional statements for the CnvTemp    *;
*     function and uncomment the four conditional statements.  *;
*  5) In the DATA step, delete the TavgConverted assignment    *;
*     statement and uncomment the TavgF and TavgC assignment   *;
*     statements.                                              *;
*       TavgF=CnvTemp(TAvg,Tunit,'F');                         *;
*       TavgC=CnvTemp(TAvg,Tunit,'C');                         *;
*  6) Run the demo program that includes the SGPLOT procedure. *;
*     View the new columns TavgF and TavgC in the              *;
*     SydneyNewYork table. Also view the graph of the TavgF    *;
*     column.                                                  *;
*  7) In the PROC FCMP step, copy and paste the syntax for     *;
*     creating the CnvTemp function within the step. Modify    *;
*     the syntax to create a function that returns a character *;
*     value that concatenates the letter F or C after the      *;
*     temperature value.                                       *;
*       function CharTemp(Temp, Unit $, FinalUnit $) $ 20;     *;
*        ...                                                   *;
*       return(catx(' ',put(NewTemp,8.2),FinalUnit));          *;
*  8) In the DATA step, add the following two assignment       *;
*     statements:                                              *;
*       TavgFchar=CharTemp(TAvg,Tunit,'F');                    *;
*       TavgCchar=CharTemp(TAvg,Tunit,'C');                    *;
*  9) Highlight and run the PROC FCMP step, the OPTIONS        *;
*     statement, and the DATA step. View the new columns       *;
*     TavgFchar and TavgCchar in the SydneyNewYork table.      *;
****************************************************************;
 
proc fcmp outlib=pg3.funcs.temps;
    function CnvTemp(Temp, Unit $);
       if upcase(Unit)='F' 
          then NewTemp=round((Temp-32)*5/9,.01);
       else if upcase(Unit)='C' 
          then NewTemp=round(Temp*9/5+32,.01);
       /*
       if upcase(Unit)='F' and upcase(FinalUnit)='C'  
          then NewTemp=round((Temp-32)*5/9,.01);
       else if upcase(Unit)='F' and upcase(FinalUnit)='F' 
          then NewTemp=Temp;
       else if upcase(Unit)='C' and upcase(FinalUnit)='F' 
          then NewTemp=round(Temp*9/5+32,.01);
       else if upcase(Unit)='C' and upcase(FinalUnit)='C' 
          then NewTemp=Temp;
       */
       return(NewTemp);
    endsub;
run;

options cmplib=pg3.funcs;

data work.SydneyNewYork;
    set pg3.weather_sydney_ny_monthly2017;
    TavgConverted=CnvTemp(TAvg,Tunit);
    *TavgF=CnvTemp(TAvg,Tunit,'F');
    *TavgC=CnvTemp(TAvg,Tunit,'C');
run;

proc sgplot data=work.SydneyNewYork;
    series x=Date y=TavgF / group=city;
run;
