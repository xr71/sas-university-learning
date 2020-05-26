**************************************************************;
*  LESSON 4, PRACTICE 6                                      *;
**************************************************************;

data _null_; 
    if 0 then set pg3.storm_final(keep=Season MaxWindMPH);
    declare hash SeasWind(dataset:'pg3.storm_final
                         (where=(MaxWindMPH ne .))', 
                          ordered:'ascending');
    SeasWind.definekey('Season','MaxWindMPH');
    SeasWind.definedone();
    *output each unique combination of Season and MaxWindMPH;
    SeasWind.output(dataset:'work.SeasonWind');	
/*
    declare hash Seas1(dataset:'work.SeasonWind', 
                       ordered:'ascending'); 
    Seas1.definekey('Season');
    Seas1.definedata('Season','MaxWindMPH');
    Seas1.definedone();
    *output the lowest MaxWindMPH per Season;
    Seas1.output(dataset:'work.SeasonWindLow');
*/
/*
    declare hash Seas2(dataset:'work.SeasonWind', 
                       ordered:'ascending'); 
    Seas2.definekey('Season');
    Seas2.definedata('Season','MaxWindMPH');
    Seas2.definedone();
    *output the highest MaxWindMPH per Season;
    Seas2.output(dataset:'work.SeasonWindHigh');
*/	
    stop;
run;
