**************************************************************;
*  LESSON 5, PRACTICE 2                                      *;
**************************************************************;

proc format;
    picture shares 
            low-high='000,000,009 shares';                                    



run;

data work.stock_report;
    set pg3.stocks(drop=High Low);
    VolumeChar=catx(' ',put(Volume,comma18.),'shares');
    DailyChange=Close-Open;
    DailyChangeChar=catx(' ',DailyChange,'USD');

run;

title 'Monthly Stock Market Data for 2010 to 2017';
proc print data=work.stock_report;
run;
title;


