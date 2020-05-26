***********************************************************;
*  Activity 4.03                                          *;
*  1) Run the program and view the duplicate key errors   *;
*     in the SAS log.                                     *;
*  2) Add the MULTIDATA: 'YES' argument to the DECLARE    *;
*     statement for the CapitalPopSort hash object.       *;
*     Arguments are separated with a comma.               *;
*  3) Run the program. View the work.CapitalPopSort       *;
*     table. Do you see duplicate PctPop values?          *;
***********************************************************;
   
data work.StateCityPopulation;
    if _N_=1 then do;
       if 0 then set pg3.population_usstates;
       declare hash States(dataset: 'pg3.population_usstates');
       States.definekey('StateName');
       States.definedata('Capital','StatePop2017');
       States.definedone();
       declare hash CapitalPopSort(ordered: 'descending');
       CapitalPopSort.definekey('PctPop');
       CapitalPopSort.definedata('PctPop',
                                 'CityName','CityPop2017',
                                 'StateName','StatePop2017');
       CapitalPopSort.definedone();
    end;
    set pg3.population_uscities end=lastrow;
    StateName=stnamel(StateCode);
    RC=States.find(key:StateName);
    if RC ne 0 then call missing(Capital, StatePop2017);
    PctPop=round(CityPop2017/StatePop2017*100,.1);
    output work.StateCityPopulation;
    if Capital=CityName then CapitalPopSort.add();
    if lastrow=1 then 
       CapitalPopSort.output(dataset: 'work.CapitalPopSort');
    format StatePop2017 comma14.;
run;
