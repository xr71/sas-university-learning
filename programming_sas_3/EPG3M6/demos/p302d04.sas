****************************************************************;
*  Validating Data with the PRXMATCH Function                  *;
****************************************************************;
 
*Constant; 
data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    Loc=prxmatch('/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/',Phone);
run;

proc print data=work.ValidPhoneNumbers noobs;
run;

*Column;
data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
    Loc=prxmatch(Exp,Phone);
run;

proc print data=work.ValidPhoneNumbers noobs;
run;

*Pattern ID Number;
data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
    Pid=prxparse(Exp);
    Loc=prxmatch(Pid,Phone);
run;

proc print data=work.ValidPhoneNumbers noobs;
run;

****************************************************************;
*  Demo                                                        *;
*  1) In the first DATA step, notice the incomplete assignment *;
*     statement.                                               *;
*       Loc=prxmatch('/ /',Phone);                             *;
*  2) Add a Perl regular expression to the first argument of   *;
*     the PRXMATCH function to find valid phone numbers.       *;
*       Loc=prxmatch('/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/',      *;
*                    Phone);                                   *;
*  3) Highlight and run the first DATA step and PROC PRINT     *;
*     step. Verify that the Loc value represents the starting  *;
*     location of the 10-digit phone number. Rows 2, 3, and 7  *;
*     should have a Loc value greater than 0.                  *;
*  4) Copy and paste the Loc assignment statement. Modify the  *;
*     statement to create a column named LocStartEnd and to    *;
*     find only values that start and end with the 10-digit    *;
*     number (no leading or trailing text).                    *;
*       LocStartEnd=                                           *;
*         prxmatch('/^([2-9]\d\d)-([2-9]\d\d)-(\d{4})$/',      *;
*                  strip(Phone));                              *;
*  5) Highlight and run the first DATA step and PROC PRINT     *;
*     step. Verify that only row 2 has a LocStartEnd value     *;
*     greater than 0.                                          *;
*  6) Copy and paste the Loc assignment statement. Modify the  *;
*     statement to create a column named LocParen. Alter the   *;
*     expression to find area codes in parentheses. In         *;
*     addition, instead of the first hyphen, there might or    *;
*     might not be a space. There is no longer a hyphen after  *;
*     the area code.                                           *;
*       LocParen=                                              *;
*         prxmatch('/\(([2-9]\d\d)\)\s*([2-9]\d\d)-(\d{4})/',  *;
*                  Phone);                                     *;
*  7) Highlight and run the first DATA step and PROC PRINT     *;
*     step. Verify that only rows 8 and 9 have a LocParen      *;
*     value greater than 0.                                    *;
*  8) Add a subsetting IF statement to subset the rows where a *;
*     pattern was matched. Highlight and run the first DATA    *;
*     step and PROC PRINT step. Verify that only five rows are *;
*     in the results.                                          *;
*       if Loc ne 0 or LocStartEnd ne 0 or LocParen ne 0;      *;
*  9) In the last DATA step, notice the CALL PRXDEBUG routine. *;
*     Run the DATA step and view the SAS log. Notice the       *;
*     Compiling line after each iteration.                     *;
*       call prxdebug(1);                                      *;
* 10) Add the O option to the end of the Perl regular          *;
*     expression. Run the DATA step and view the SAS log.      *;
*     Notice that the Compiling line is now only after the     *;
*     first iteration.                                         *;
*       Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';              *;
****************************************************************;

data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    Loc=prxmatch('/ /',Phone);
run;

title 'Pattern Matching Phone Numbers';
proc print data=work.ValidPhoneNumbers;
run;
title;

data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    putlog 'Iteration: ' _N_=;
    call prxdebug(1); /* Sends debugging output to the SAS log. */
    Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/';
    Loc=prxmatch(Exp,Phone);
run;

