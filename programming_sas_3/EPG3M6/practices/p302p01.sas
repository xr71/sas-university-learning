**************************************************************;
*  LESSON 2, PRACTICE 1                                      *;
**************************************************************;
   
data work.ParkTraffic2016;
    set pg3.np_2016traffic;
    by ParkCode;
	
	prevmthTC = lag1(trafficCount);
	if first.ParkCode=1 then prevmthTC=.;
	
	onemthchange = trafficCount - PrevMthTC;

run;

title '2016 National Park Traffic Counts';
proc print data=work.ParkTraffic2016;
run;
