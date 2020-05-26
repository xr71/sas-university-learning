**************************************************************;
*  LESSON 4, PRACTICE 1                                      *;
**************************************************************;

data work.acreage;
    length ParkCode $ 4 ParkName $ 115 Type $ 28;
    if _N_=1 then do;
       declare hash ParkDesc(dataset:'pg3.np_codelookup');
       ParkDesc.definekey('ParkCode');
       ParkDesc.definedata('ParkName','Type');
       ParkDesc.definedone();
       call missing(ParkCode,ParkName,Type);
    end;
    set pg3.np_acres2;
    ParkCode=upcase(ParkCode);
    /* add an assignment statement */ 

    /* add a subsetting IF statment */

    /* add a DROP statement */

run; 

title 'Gross Acres for National Parks';
proc print data=work.acreage; 
run; 
title; 
