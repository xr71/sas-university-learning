**************************************************************;
*  LESSON 4, PRACTICE 8                                      *;
**************************************************************;

data work.LowWind work.HighWind; 
    if _N_=1 then do;  
       if 0 then set pg3.storm_final
                    (keep=Season Name BasinName MaxWindMPH);
       /* declare a hash object */ 

       Storm.definekey('MaxWindMPH');
       Storm.definedata('Season','Name','BasinName','MaxWindMPH');
       Storm.definedone();
       /* declare a hash iterator */

    end;
    do i=1 to 5;
       /* retrieve storms with the lowest maximum winds */



    end;
    do i=1 to 5;
       /* retrieve storms with the highest maximum winds */



    end;
    drop i;
run;

title 'Storms with Lowest Maximum Winds';
proc print data=work.LowWind;
run;
title;

title 'Storms with Highest Maximum Winds';
proc print data=work.HighWind;
run;
title;

