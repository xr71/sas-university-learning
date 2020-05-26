****************************************************************;
*  Processing One-Dimensional Arrays: Part 2                   *;
****************************************************************;
   
data work.DublinPrecipRotate;
    set pg3.weather_dublinmadrid_monthly5yr
       (keep=City Year PrecipQ1-PrecipQ4);
    where City='Dublin';
    array P[4] PrecipQ1-PrecipQ4;
    do Quarter=1 to 4;
       Precip=P[Quarter];  
       output;
    end;
    format Precip 6.2;
    drop PrecipQ1-PrecipQ4;
run;

title 'Average Quarterly Precipitation (IN) for Dublin';
proc sgplot data=work.DublinPrecipRotate;
    vbar Quarter / response=Precip stat=mean datalabel
                   datalabelattrs=(size=12pt);
    format Precip 6.2;
run;
title;

****************************************************************;
*  Demo                                                        *;
*  1) In the DATA step, notice the three ARRAY statements. The *;
*     array P references existing columns of quarterly         *;
*     precipitation read from the input table. The array PAvg  *;
*     creates and references new numeric columns with initial  *;
*     values representing quarterly averages more than five    *;
*     years. The array Status references new character columns *;
*     that are being created with a byte size of 5.            *;
*  2) In the DO loop, add three conditional statements to      *;
*     create the values for the status columns based on the    *;
*     comparison of the precipitation columns with the average *;
*     precipitation columns.                                   *;
*       if P[i] > PAvg[i] then Status[i]='Above';              *;
*       else if P[i] < PAvg[i] then Status[i]='Below';         *;
*       else if P[i] = PAvg[i] then Status[i]='Same';          *;
*  3) Run the DATA step and view the output table. Notice the  *;
*     redundant rows for the PAvg1 through PAvg4 columns.      *;
*  4) Add a DROP statement to eliminate the average            *;
*     precipitation columns.                                   *;
*       drop PAvgQ1-PAvgQ4;                                    *;
*  5) Run the DATA step. Verify that the output table contains *;
*     the four precipitation columns and the four status       *;
*     columns but not the four average precipitation columns.  *;
*  6) Alternatively, delete the DROP statement and replace the *;
*     syntax of PAvgQ1-PAvgQ4 with _TEMPORARY_ in the ARRAY    *;
*     statement for the PAvg array.                            *;
*       array PAvg[4] _temporary_ (7.65 , 6.26 , 7.56 , 9.12); *;
*  7) Run the DATA step and verify that the output table       *;
*     contains the same data as before the alternative         *;
*     changes.                                                 *;
*  8) Self-study: The section at the end of the demo program   *;
*     is an example of storing the initial values in a macro   *;
*     variable and then referencing the macro variable in the  *;
*     ARRAY statement.                                         *;
****************************************************************;

data work.DublinPrecipStatus(drop=i);
    set pg3.weather_dublinmadrid_monthly5yr
       (keep=City Year PrecipQ1-PrecipQ4);
    where City='Dublin';
    array P[4] PrecipQ1-PrecipQ4;
    array PAvg[4] PAvgQ1-PAvgQ4 (7.65 , 6.26 , 7.56 , 9.12);
    array Status[4] $ 5 StatusQ1-StatusQ4;
    do i=1 to 4;



    end;

run;
 
****************************************************************;
*  Self-study: The following example uses SQL to create a      *;
*              macro variable containing the four desired      *;
*              initial values and then references the macro    *;
*              variable in the ARRAY statement                 *;
****************************************************************;

proc sql noprint;
    select round(mean(Precip),.01)
	  into :averages separated by ', '
	from work.DublinPrecipRotate
	group by Quarter;
quit;

options symbolgen;
 
data work.DublinPrecipStatus(drop=i);
    set pg3.weather_dublinmadrid_monthly5yr
       (keep=City Year PrecipQ1-PrecipQ4);
    where City='Dublin';
    array P[4] PrecipQ1-PrecipQ4;
    array PAvg[4] _temporary_ (&averages);
    array Status[4] $ 5 StatusQ1-StatusQ4;
    do i=1 to 4;
       if P[i] > PAvg[i] then Status[i]='Above';
       else if P[i] < PAvg[i] then Status[i]='Below';
       else if P[i] = PAvg[i] then Status[i]='Same';
    end;
run;
