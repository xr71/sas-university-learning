****************************************************************;
*  DATA Step MERGE versus DATA Step Hash Object                *;
****************************************************************;
   
*DATA Step MERGE Solution;
data work.uscities;
    set pg3.population_uscities;
    StateName=stnamel(StateCode);
run;

proc sort data=work.uscities;
    by StateName;
run;

proc sort data=pg3.population_usstates
          out=work.usstates;
    by StateName;
run;

data work.StateCityPopulation;
    merge work.usstates work.uscities(in=C);
    by StateName;
    if C;
    PctPop=CityPop2017/StatePop2017;
    format StatePop2017 comma14. PctPop percent8.1;
run;

proc sort data=work.StateCityPopulation;
    by descending CityPop2017;
run;

*DATA Step Hash Object Solution;
*Character Literal for DATASET Argument;
data work.StateCityPopulation(drop=ReturnCode);
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
    ReturnCode=States.find(key:StateName);
    PctPop=CityPop2017/StatePop2017;
    format StatePop2017 comma14. PctPop percent8.1;
run;
 
*Character Column for DATASET Argument;
data work.StateCityPopulation(drop=ReturnCode);
    length StateName $ 20 Capital $ 14 StatePop2017 8;
    tablename='pg3.population_usstates';
    if _N_=1 then do;
       declare hash States(dataset: tablename);
       States.definekey('StateName');
       States.definedata('Capital','StatePop2017');
       States.definedone();
       call missing(StateName, Capital, StatePop2017);
    end;
    set pg3.population_uscities;
    StateName=stnamel(StateCode);
    ReturnCode=States.find(key:StateName);
    PctPop=CityPop2017/StatePop2017;
    format StatePop2017 comma14. PctPop percent8.1;
run;

*Character Expression for DATASET Argument;
data work.StateCityPopulation(drop=ReturnCode);
    length StateName $ 20 Capital $ 14 StatePop2017 8;
    location='usstates';
    if _N_=1 then do;
       declare hash States(dataset: cats('pg3.population_',location));
       States.definekey('StateName');
       States.definedata('Capital','StatePop2017');
       States.definedone();
       call missing(StateName, Capital, StatePop2017);
    end;
    set pg3.population_uscities;
    StateName=stnamel(StateCode);
    ReturnCode=States.find(key:StateName);
    PctPop=CityPop2017/StatePop2017;
    format StatePop2017 comma14. PctPop percent8.1;
run;
