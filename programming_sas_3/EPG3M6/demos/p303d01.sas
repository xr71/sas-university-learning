****************************************************************;
*    Processing One-Dimensional Arrays: Part 1                 *;
****************************************************************;
 
data HighSumamry1;
    set pg3.health_stats;
    HighCount=0;
    if  Weight='High' then HighCount+1;
    if  BlPres='High' then HighCount+1;
    if   Pulse='High' then HighCount+1;
    if    Chol='High' then HighCount+1;
    if Glucose='High' then HighCount+1;
run;

data HighSumamry2(drop=i);
    set pg3.health_stats;
    HighCount=0;
    array health[5] Weight BlPres Pulse Chol Glucose;
    *array health[5] Weight--Glucose;
    do i = 1 to 5;
       if health[i]='High' then HighCount+1;
    end;
run;

data work.DublinMadrid2017(drop=Month);
    set pg3.weather_dublinmadrid_Monthly2017
       (keep=City Temp1-Temp12);
    array Temperature[12] Temp1-Temp12;
    do Month=1 to 12;
       Temperature[Month]=(Temperature[Month]-32)*5/9;
    end;
    format Temp1-Temp12 6.1;
run;

data work.DublinMadrid2018(drop=Month);
    set pg3.weather_dublinmadrid_Monthly2018
       (keep=City Temp:);
    array Temperature[*] Temp:;
    do Month=1 to dim(Temperature);
       Temperature[Month]=(Temperature[Month]-32)*5/9;
    end;
    format Temp: 6.1;
run;

****************************************************************;
*  Demo                                                        *;
*  1) In the first DATA step, notice the two ARRAY statements. *;
*     The array Farenht references existing columns            *;
*     of Fahrenheit temperatures read from the input table.    *;
*     The array Celsius references new numeric columns that    *;
*     are being created.                                       *;
*  2) Add the following DO loop to the first DATA step after   *;
*     the ARRAY statements. The assignment statement           *;
*     calculates the Celsius temperatures.                     *;
*       do Month=1 to 3;                                       *;
*          Celsius[Month]=(Farenht[Month]-32)*5/9;             *;
*       end;                                                   *;
*  3) Highlight and run the DATA step. Verify that your output *;
*     table tempQ1 contains the three existing Fahrenheit      *;
*     temperatures and the three new Celsius temperatures for  *;
*     months 1 through 3.                                      *;
*  4) Modify the first DATA step to create the table tempQ3    *;
*     that contains the Celsius temperatures for months 7      *;
*     through 9.                                               *;
*       data work.tempQ3(drop=Month);                          *;
*           set pg3.weather_dublinmadrid_Monthly2017           *;
*              (keep=City Temp7-Temp9);                        *;
*           array Farenht[7:9] Temp7-Temp9;                    *;
*           array Celsius[7:9] TempC7-TempC9;                  *;
*           do Month=7 to 9;                                   *;
*              Celsius[Month]=(Farenht[Month]-32)*5/9;         *;
*           end;                                               *;
*           format TempC7-TempC9 6.1;                          *;
*       run;                                                   *;
*  5) Highlight and run the DATA step. Verify that your output *;
*     table tempQ3 contains the three existing Fahrenheit      *;
*     temperatures and the three new Celsius temperatures for  *;
*     months 7 through 9.                                      *;
*  6) Open the pg3.weather_dublinmadrid_monthly2017 table.     *;
*     Notice that the table contains four quarterly            *;
*     precipitation columns in inches (PrecipQ1-PrecipQ4) in   *;
*     addition to the Fahrenheit temperature columns.          *;
*  7) In the second DATA step, notice the two array            *;
*     statements. The array P references existing columns of   *;
*     quarterly precipitation read from the input table. The   *;
*     array Pct references new numeric columns that are being  *;
*     created.                                                 *;
*  8) After the first ARRAY statement, add an assignment       *;
*     statement to calculate the total yearly precipitation by *;
*     summing the four quarterly precipitation columns.        *;
*       PrecipTotal=sum(of PrecipQ1-PrecipQ4);                 *;
*     An alternative for specifying the columns in the SUM     *;
*     function is to reference all elements of the P array by  *;
*     using an asterisk in an array reference.                 *;
*       PrecipTotal=sum(of P[*]);                              *;
*  9) In the DO loop, add an assignment statement to calculate *;
*     the quarterly percent of precipitation based on the      *;
*     quarterly precipitation divided by the total yearly      *;
*     precipitation.                                           *;
*       Pct[i]=P[i]/PrecipTotal;                               *;
* 10) Highlight and run the DATA step. Verify that your output *;
*     table precip contains the four existing quarterly        *;
*     precipitation columns and the four new percentages of    *;
*     quarterly precipitation along with the total yearly      *;
*     precipitation.                                           *;
****************************************************************;

*First DATA Step;
data work.tempQ1(drop=Month);
    set pg3.weather_dublinmadrid_monthly2017
       (keep=City Temp1-Temp3);
    array Farenht[3] Temp1-Temp3;
    array Celsius[3] TempC1-TempC3; 



    format TempC1-TempC3 6.1;
run;

*Second DATA Step;
data work.precip(drop=i);
    set pg3.weather_dublinmadrid_monthly2017
       (keep=City PrecipQ1-PrecipQ4);
    array P[4] PrecipQ1-PrecipQ4;

    array Pct[4] PrecipPctQ1-PrecipPctQ4;
    do i=1 to 4;
      
    end;
    format PrecipPctQ1-PrecipPctQ4 percent8.1;
run;
