**************************************************************;
*  LESSON 4, PRACTICE 4                                      *;
**************************************************************;

data work.acreage;
    length ParkCode $ 4 ParkName $ 115 Type $ 28;
    if _N_=1 then do;
       declare hash ParkDesc(dataset:'pg3.np_codelookup');
       ParkDesc.definekey('ParkCode');
       ParkDesc.definedata('ParkName','Type');
       ParkDesc.definedone();
       call missing(ParkCode,ParkName,Type);
       /* declare and define a hash object */




    end;
    set pg3.np_acres2;
    ParkCode=upcase(ParkCode);
    RC=ParkDesc.find(key:ParkCode); 
    /* change the subsetting IF statement to be IF/THEN statement */
    if RC=0;
    /* add an IF/THEN statement */

    drop RC;
run; 

title 'Gross Acres for National Parks Sorted by ParkCode';
proc print data=work.acreage; 
run; 
title;
