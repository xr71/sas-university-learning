*Scenario 1;
data work.PctGrowth18Yrs;
    length Continent $ 13 Country $ 18;
    set pg3.population_top25countries;
    Country=scan(CountryCodeName,2,'-');
    PctGrowth18Yrs=(Pop2017-Pop2000)/Pop2000*100;
    drop CountryCodeName;
    format Pop2000 Pop2017 comma16. PctGrowth18Yrs 5.1;
run;

*Scenario 2;
proc sort data=pg3.population_top25countries
          out=work.continent_sorted;
    by Continent descending Pop2017;
run;

data work.PctGrowth18Yrs_Cont;
    set work.continent_sorted;
    by Continent;
    if first.Continent=1 then do; 
       Count=0; Pop2000Total=0; Pop2017Total=0;
    end;
    Count+1;
    Pop2000Total+Pop2000;
    Pop2017Total+Pop2017;
    if last.Continent=1 then do;
       PctGrowth18Yrs_Cont=
          (Pop2017Total-Pop2000Total)/Pop2000Total*100;
       output;
    end;
    format Pop2000Total Pop2017Total comma16. 
           PctGrowth18Yrs_Cont 5.1;
    keep Continent Count Pop2000Total 
         Pop2017Total PctGrowth18Yrs_Cont;
run;
