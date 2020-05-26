* categorical analysis;

* logistic and classification methods;

/* proc freq data=entertainment.movies; */
/* 	tables type rating type*rating; */
/* run; */

         
* we can use row percentages in these cross-tabulation
freq tables to check for associations;

proc freq data=stat1.safety;
	tables unsafe type region size;
run;


* tests for assoication;
