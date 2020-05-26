***********************************************************;
*  Activity 1.03                                          *;
*  1) View the DATA step syntax. Run the DATA step.       *;
*     View the output table.                              *;
*     - How many rows are in the output table?            *;
*     - What is the value of Year?                        *;
*  2) Uncomment the OUTPUT statement. Run the DATA step.  *;
*     View the output table.                              *;
*     - How many rows are in the output table?            *;
*     - What is the range of values for Year?             *;
*     View the SAS log.                                   *;
*     - How many times did SAS iterate through the DATA   *;
*       step based on the PUTLOG statement?               *;
*  3) Run the PROC SGPLOT step. In what year will the     *;
*     predicted population of India exceed China?         *;
***********************************************************;
    
data work.PredictedPopulation;
    set pg3.population_top25countries;
    putlog 'Top of Step - Iteration #' _N_;
    PopPredicted=Pop2017;
    do Year=2018 to 2022;
       PopPredicted=PopPredicted+(PopPredicted*PctGrowthAvgYr/100);
       output;
    end;
    keep CountryCodeName Pop2000 Pop2017 PctGrowthAvgYr PopPredicted Year;
    format Pop2000 Pop2017 PopPredicted comma16.;
run;

title1 'Predicted Populations for Years 2018 to 2022';
title2 'for 2017 Country Populations Greater than 1 Billion';
proc sgplot data=work.PredictedPopulation;
    where Pop2017>1000000000;
    series x=Year y=PopPredicted / group=CountryCodeName markers;
run;
title;


proc sgplot data=work.PredictedPopulation;
    *where Pop2017>1000000000;
    series x=Year y=PopPredicted / group=CountryCodeName markers;
run;