**************************************************************;
*  LESSON 3, PRACTICE 3                                      *;
**************************************************************;
 
data work.WindDifference;
    set pg3.storm_range;
	Diff12=Wind1-Wind2;
	Diff23=Wind2-Wind3;
	Diff34=Wind3-Wind4;
run;

title 'Storm Wind Differences (first 10 rows)';
proc print data=work.WindDifference(obs=10);
    var Name Basin StartYear Wind1-Wind4 Diff12 Diff23 Diff34;
run;
title;

title 'Summary of Storm Wind Differences';
proc means data=work.WindDifference maxdec=1;
    var Diff12 Diff23 Diff34;
run;
title;