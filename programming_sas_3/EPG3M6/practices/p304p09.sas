**************************************************************;
*  LESSON 4, PRACTICE 9                                      *;
**************************************************************;

data work.category5; 
    if _N_=1 then do; 
       if 0 then set pg3.storm_final
                    (keep=Season Name BasinName MaxWindMPH);
       declare hash Storm(dataset:'pg3.storm_final', 
                          ordered:'ascending', multidata:'yes');
       Storm.definekey('MaxWindMPH');
       Storm.definedata('Season','Name','BasinName','MaxWindMPH');
       Storm.definedone();
       declare hiter Stm('Storm');
    end;
    Cat5Speed=157; 
    do until(rc=0); 
       /* add an assignment statement and a sum statement */ 
 

    end;
    do i=1 to 20;
       /* output and retrieve the weakest category 5 storms */


    end;
run;
   
title 'Twenty Weakest Category 5 Storms';
proc print data=work.category5;
run;
title;
