﻿****************************************************************;
*  Performing a Table Lookup with the FIND Method              *;
****************************************************************;
 
data work.Top5TempPrecip;
    length City $ 11 Month TempMonAvg PrecipMonSum 8;
    if _N_=1 then do;
       declare hash Monthly(dataset: 'pg3.weather_ustop5_monthly2017');
       Monthly.definekey('City','Month');
       Monthly.definedata('TempMonAvg','PrecipMonSum');
       Monthly.definedone();
	   call missing (City, Month, TempMonAvg, PrecipMonSum);
    end;
    set pg3.weather_ustop5_daily2017;
    Monthly.find(key:City,key:month(Date));
    TempDiff=TempDlyAvg-TempMonAvg;
    PrecipDiff=PrecipDlySum-PrecipMonSum;
    drop Month;
run;
 
****************************************************************;
*  Demo                                                        *;
*  1) Notice that rows are being read from the                 *;
*     pg3.population_uscities table and that StateCode is      *;
*     being used to create StateName.                          *;
*  2) Highlight and run the DATA step. View the output table   *;
*     and notice that the values of Capital and StatePop2017   *;
*     are missing. There is no syntax in the DATA step for the *;
*     StateName value to be searched in the hash object.       *;
*  3) Add an RC assignment statement after the StateName       *;
*     assignment statement to find the values of StateName in  *;
*     the hash object.                                         *;
*       RC=States.find(key:StateName);                         *;
*  4) Uncomment the PctPop assignment statement and the FORMAT *;
*     statement.                                               *;
*  5) Run the DATA step. Observe that the value of RC is 0 for *;
*     all rows except row 20. The StateName value District of  *;
*     Columbia does not have a match in the hash object.       *;
*     Notice the values of Capital and StatePop2017 are        *;
*     missing for row 20. The values were reinitialized to     *;
*     missing at the beginning of the iteration, and no values *;
*     were retrieved from the hash object.                     *;
*  6) As an alternative, delete the LENGTH and CALL MISSING    *;
*     statements. Add a conditional SET statement to the       *;
*     beginning of the DO block.                               *;
*       if 0 then set pg3.population_usstates;                 *;
*  7) Run the DATA step and notice the difference for row 20.  *;
*     The Capital and StatePop2017 are retained due to the     *;
*     nature of the SET statement. Therefore, you are seeing   *;
*     the previous values for these two columns.               *;
*  8) Add the following statement after the RC assignment      *;
*     statement to set the values of Capital and StatePop2017  *;
*     to missing when a match is not found. Run the program    *;
*     and confirm the results.                                 *;
*       if RC ne 0 then call missing(Capital, StatePop2017);   *;
*  9) Modify the DATA step to create an additional table that  *;
*     contains the population data for only the capital        *;
*     cities.                                                  *;
*       data work.StateCityPopulation work.CapitalPopulation;  *;
*           ...                                                *;
*           output work.StateCityPopulation;                   *;
*           if Capital=CityName then                           *;
*              output work.CapitalPopulation;                  *;
* 10) Run the DATA step. Verify that work.StateCityPopulation  *;
*     contains 19,500 rows and work.CapitalPopulation contains *;
*     50 rows. What would need to be added to the program if   *;
*     we wanted work.CapitalPopulation in sorted order by      *;
*     descending PctPop values?                                *;
****************************************************************;

data work.StateCityPopulation;
    length StateName $ 20 Capital $ 14 StatePop2017 8;
    if _N_=1 then do;
       declare hash States(dataset: 'pg3.population_usstates');
       States.definekey('StateName');
       States.definedata('Capital','StatePop2017');
       States.definedone();
       call missing(StateName, Capital, StatePop2017);
    end;
    set pg3.population_uscities;
    StateName=stnamel(StateCode);

    *PctPop=CityPop2017/StatePop2017;
    *format StatePop2017 comma14. PctPop percent8.1;
run;

