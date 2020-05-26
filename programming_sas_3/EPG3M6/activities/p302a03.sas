***********************************************************;
*  Activity 2.03                                          *;
*  1) Run the program and verify that Open3MnthAvg is     *;
*     equal to missing for the first two rows and to      *;
*     102.90 for the third row (02MAR2010).               *;
*  2) Delete the two assignment statements containing the *;
*     LAG functions.                                      *;
*  3) Modify the conditional statement to be the          *;
*     following:                                          *;
*     if _N_ ge 3 then                                    *;
*        Open3MnthAvg=mean(Open,lag1(Open),lag2(Open));   *;
*  4) Run the program and view the results.               *;
*  5) Is Open3MnthAvg equal to 102.90 for 02MAR2010?      *;
***********************************************************;
   
data work.stockmovingavg;
    set pg3.stocks_ABC(drop=Close);
    Open1MnthBack=lag1(Open);
    Open2MnthBack=lag2(Open);
    if _N_ ge 3 then 
       Open3MnthAvg=mean(Open,Open1MnthBack,Open2MnthBack);
    format Open3MnthAvg 8.2;
run;

title 'Three Month Moving Average on Opening Stock Price'; 
proc print data=work.stockmovingavg noobs;
run;
title;
