****************************************************************;
*  Creating a Table with the ADD and OUTPUT Methods            *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*  1) Run the program. Verify that work.StateCityPopulation    *;
*     contains 19,500 rows and work.CapitalPopulation contains *;
*     50 rows.                                                 *;
*  2) Delete work.CapitalPopulation from the DATA statement.   *;
*  3) Remove the /* and */ from around the statements that are *;
*     creating the hash object CapitalPopSort.                 *;
*       declare hash CapitalPopSort(ordered: 'descending');    *;
*       CapitalPopSort.definekey('PctPop');                    *;
*       CapitalPopSort.definedata('PctPop',                    *;
*                                 'CityName','CityPop2017',    *;
*                                 'StateName','StatePop2017'); *;
*       CapitalPopSort.definedone();                           *;
*  4) Add the END= option to the SET statement for the cities  *;
*     table.                                                   *;
*       set pg3.population_uscities end=lastrow;               *;
*  5) Modify the conditional statement to add data to the      *;
*     CapitalPopSort hash object instead of writing the output *;
*     to a table.                                              *;
*       if Capital=CityName then CapitalPopSort.add();         *;
*  6) Add the following statement to output the CapitalPopSort *;
*     hash object to a table.                                  *;
*       if lastrow=1 then                                      *;
*       CapitalPopSort.output(dataset: 'work.CapitalPopSort'); *;
*  7) Run the program. Verify that work.StateCityPopulation    *;
*     contains 19,500 rows and work.CapitalPopSort contains *;
*     50 rows sorted by descending PctPop. Are there any       *;
*     duplicate values of PctPop in work.CapitalPopSort?       *;
*  8) It appears that there are duplicate values of PctPop in  *;
*     work.CapitalPopSort. For example, rows 23 and 24 show a  *;
*     PctPop value of 4.3% and rows 25 and 26 show a PctPop    *;
*     value of 4.1%.                                           *;
*  9) Comment out the format for PctPop in the FORMAT          *;
*     statement. Run the program. Verify that there are no     *;
*     duplicate values for PctPop in work.CapitalPopSort.      *;
*       format StatePop2017 comma14. /* PctPop percent8.1 */;  *;
* 10) Modify the calculation of PctPop to round the value,     *;
*     which will now produce duplicate values. Run the         *;
*     program. Notice the error messages in the SAS log,       *;
*     ERROR: Duplicate key. Nine error messages exist due to   *;
*     the duplicate values for 4.3, 4.1, 3.4, 2.6, 1.2, 0.9    *;
*     (2), 0.7, and 0.6.                                       *;
*       PctPop=round(CityPop2017/StatePop2017*100,.1);         *;
****************************************************************;

data work.StateCityPopulation work.CapitalPopulation;
    if _N_=1 then do;
       if 0 then set pg3.population_usstates;
       declare hash States(dataset: 'pg3.population_usstates');
       States.definekey('StateName');
       States.definedata('Capital','StatePop2017');
       States.definedone();
 	   /*
       declare hash CapitalPopSort(ordered: 'descending');
       CapitalPopSort.definekey('PctPop');
       CapitalPopSort.definedata('PctPop',
                                 'CityName','CityPop2017',
                                 'StateName','StatePop2017');
       CapitalPopSort.definedone();
	   */
    end;
    set pg3.population_uscities;
    StateName=stnamel(StateCode);
    RC=States.find(key:StateName);
    if RC ne 0 then call missing(Capital, StatePop2017);
    PctPop=CityPop2017/StatePop2017;
    output work.StateCityPopulation;
    if Capital=CityName then output work.CapitalPopulation;

    format StatePop2017 comma14. PctPop percent8.1;
run;
