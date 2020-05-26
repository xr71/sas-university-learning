****************************************************************;
*  Declaring and Defining a Hash Object                        *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*  1) Notice the syntax to declare and define the States hash  *;
*     object with one key component and two data components.   *;
*  2) Run the program. View the error in the SAS log           *;
*     concerning the undeclared key symbol StateName. This     *;
*     error appears because the key component has not been     *;
*     defined as a column in the PDV.                          *;
*     Note: You can open the DATA Step Debugger in SAS         *;
*     Enterprise Guide to see that none of the hash object     *;
*     components have been defined in the PDV.                 *;
*  3) After the DATA statement, add a LENGTH statement to      *;
*     define StateName as character with a byte size of 20.    *;
*       length StateName $ 20;                                 *;
*  4) Run the program. View the error in the SAS log           *;
*     concerning the undeclared data symbol Capital. This      *;
*     error appears because the data component has not been    *;
*     defined as a column in the PDV.                          *;
*  5) Add to the LENGTH statement to define Capital as         *;
*     character with a byte size of 14 and StatePop2017 as     *;
*     numeric with a byte size of 8.                           *;
*       length StateName $ 20 Capital $ 14 StatePop2017 8;     *;
*  6) Run the program. View the uninitialized notes in the SAS *;
*     log. These notes appear because SAS does not see any     *;
*     syntax that is assigning values to the three columns in  *;
*     the PDV.                                                 *;
*       NOTE: Variable StateName is uninitialized.             *;
*       NOTE: Variable Capital is uninitialized.               *;
*       NOTE: Variable StatePop2017 is uninitialized.          *;
*  7) To eliminate the uninitialized notes, add a CALL MISSING *;
*     statement inside the DO block to assign a missing value  *;
*     to the three columns during the first iteration of the   *;
*     DATA step.                                               *;
*       call missing(StateName, Capital, StatePop2017);        *;
*  8) Run the program. Verify that 50 rows were read to load   *;
*     the hash object and that a new table has been created    *;
*     with 1 row of empty data.                                *;
*       NOTE: There were 50 observations read from the data    *;
*             set PG3.POPULATION_USSTATES.                     *;
*       NOTE: The data set WORK.STATECITYPOPULATION has 1      *;
*             observations and 3 variables.                    *;
*  9) As an alternative, delete the LENGTH and CALL MISSING    *;
*     statements. Add a conditional SET statement to the       *;
*     beginning of the DO block. This statement is never       *;
*     executed, but it makes a spot in the PDV for every       *;
*     column that is in the table.                             *;
*        if 0 then set pg3.population_usstates;                *;
* 10) Run the program. Verify that 50 rows were read to load   *;
*     the hash object and that a new table has been created    *;
*     with 1 row of empty data.                                *;
****************************************************************;
  
data work.StateCityPopulation;
    if _N_=1 then do;
       declare hash States(dataset: 'pg3.population_usstates');
       States.definekey('StateName');
       States.definedata('Capital','StatePop2017');
       States.definedone();
    end;
run;




