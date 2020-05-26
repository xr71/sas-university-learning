****************************************************************;
*  Reading Data in Forward and Reverse Direction               *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*  1) Notice the syntax for declaring and defining the hash    *;
*     object Capitals.                                         *;
*  2) Add a DECLARE statement after the Capitals hash object   *;
*     has been defined to create a hash iterator object        *;
*     named C.                                                 *;
*       declare hiter C('Capitals');                           *;
*  3) Notice the remaining syntax of the DATA step. The first  *;
*     DO loop iterates five times. The first time reads in the *;
*     first item of the hash iterator object, and the          *;
*     remaining iterations read the next item of the hash      *;
*     iterator object. The last DO loop also iterates five     *;
*     times. The first time reads in the last item of the hash *;
*     iterator object, and the remaining iterations read the   *;
*     previous item of the hash iterator object.               *;
*  4) Run the program. Verify that the LowCapitalPop table     *;
*     contains low city populations and the HighCapitalPop     *;
*     contains high city populations.                          *;
****************************************************************;

data work.LowCapitalPop(drop=High) 
     work.HighCapitalPop(drop=Low);
    if _N_=1 then do;
       if 0 then set pg3.population_uscapitals;
       declare hash Capitals(dataset: 'pg3.population_uscapitals',
                             ordered: 'ascending',
                             multidata: 'yes');
       Capitals.definekey('CityPop2017');
       Capitals.definedata('PctPop','CityName','CityPop2017',
                           'StateName','StatePop2017');
       Capitals.definedone();
  
    end;
    do Low=1 to 5;
       if Low=1 then C.first();
       else C.next();
       output work.LowCapitalPop;
    end;
    do High=1 to 5;
       if High=1 then C.last();
       else C.prev();
       output work.HighCapitalPop;
    end;
run;
 
