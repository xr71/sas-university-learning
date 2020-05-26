****************************************************************;
*  Counting and Finding Words with Character Functions         *;
****************************************************************;
 
****************************************************************;
*  Demo                                                        *;
*  1) Highlight and run the DATA step and the PROC PRINT step. *;
*     View the results and notice the values of Narrative.     *;
*  2) Uncomment the two assignment statements relating to the  *;
*     COUNT functions. Run the DATA step and the PROC PRINT    *;
*     step. View the results. Verify the values of NumEF and   *;
*     NumWord.                                                 *;
*       NumEF=count(Narrative,'EF');                           *;
*       NumWord=countw(Narrative,' ');                         *;
*  3) Uncomment the two assignment statements relating to the  *;
*     FIND functions. Run the DATA step and the PROC PRINT     *;
*     step. View the results. Notice that EFWordNum is equal   *;
*     to EFStartPos anytime the first occurrence of EF is      *;
*     followed by a hyphen and that EFWordNum is equal to 0    *;
*     anytime the first occurrence of EF is followed by a      *;
*     number.                                                  *;
*       EFStartPos=find(Narrative,'EF');                       *;
*       EFWordNum=findw(Narrative,'EF');                       *;
*  4) Modify the EFWordNum assignment statement to add a third *;
*     argument that includes a set of delimiters that          *;
*     separates words. Run the DATA step and the PROC PRINT    *;
*     step. View the results. Notice that EFWordNum is now     *;
*     equal to EFStartPos for all rows except row 240.         *;
*       EFWordNum=findw(Narrative,'EF','012345- .,');          *;
*  5) Modify the EFWordNum assignment statement to add a       *;
*     fourth argument that returns the number of the word      *;
*     instead of the starting position. Run the DATA step and  *;
*     the PROC PRINT step. View the results. Notice that       *;
*     EFWordNum is now the number of the word, so the number   *;
*     is smaller than EFStartPos.                              *;
*       EFWordNum=findw(Narrative,'EF','012345- .,','e');      *;
*  6) Uncomment the conditional statement, which, if true,     *;
*     scans the narrative for the word after the EF word. Run  *;
*     the DATA step and the PROC PRINT step. View the results. *;
*     Verify that AfterEF contains the word after the first    *;
*     occurrence of the EF word.                               *;
*       if EFWordNum>0 then                                    *;
*          AfterEF=scan(Narrative,EFWordNum+1,'012345- .,');   *;
*  7) Run the PROC FREQ step and the PROC MEANS step. View the *;
*     results.                                                 *;
*     - On average, EF is referenced 0.88 times within a       *;
*       narrative with a range of 0 to 6 times.                *;
*     - On average, 101.7 words are written in a narrative     *;
*       with a range of 3 to 676 words.                        *;
*     - Tornado is the word that tends to follow the EF value. *;
*  8) Self-study: Refer to program p302d03 for examples of     *;
*     using FIND and FINDW functions with a DO loop to find    *;
*     all occurrences of EF within a narrative.                *;
****************************************************************;

data work.narrative;
    set pg3.tornado_2017narrative;
    /* COUNT Functions */
    *NumEF=count(Narrative,'EF');
    *NumWord=countw(Narrative,' ');
    /* FIND Functions */
    *EFStartPos=find(Narrative,'EF');
    *EFWordNum=findw(Narrative,'EF');
    /* SCAN Function */
    *if EFWordNum>0 then 
       AfterEF=scan(Narrative,EFWordNum+1,'012345- .,');
run;

proc print data=work.narrative;
run;

proc means data=work.narrative maxdec=2;
    var NumEF NumWord ;
run;

proc freq data=work.narrative order=freq;
    tables AfterEF;
run;
 
