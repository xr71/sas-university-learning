****************************************************************;
*  Extracting Data Based on the CALL PRXSUBSTR Routine         *;
****************************************************************;
*  Syntax                                                      *;
*  CALL PRXSUBSTR(pattern-identifier-number, source,           *;
*                 position <,length>);                         *;
*  CALL PRXNEXT(pattern-identifier-number,start,stop,          *;
*               source,position,length);                       *;
****************************************************************;
 
*First DATA snd PROC PRINT steps;
data work.MultiStateDamage;
    set pg3.storm_damage;
    Exp='/[A-Z][A-Z](, [A-Z][A-Z])+(,? and [A-Z][A-Z])?/o';
    Pid=prxparse(Exp);
    call prxsubstr(Pid,Summary,MyStart,MyLength);

run;

title 'Storms Causing Damages in Multiple States';
proc print data=work.MultiStateDamage;
    var Event Date Summary MyStart MyLength;
    format Date date9.;
run;
title;

*Second DATA snd PROC PRINT steps;
data work.MultiStateDamage;
    set pg3.storm_damage;
    Exp='/[A-Z][A-Z](, [A-Z][A-Z])+(,? and [A-Z][A-Z])?/o';
    Pid=prxparse(Exp);
    Start=1;
    call prxnext(Pid,Start,length(Summary),
                 Summary,MyStart,MyLength);
    do while (MyStart>0);
       MultiState=substr(Summary,MyStart,MyLength);
       output;
       call prxnext(Pid,Start,length(Summary),
                    Summary,MyStart,MyLength);
    end;
run;

title 'Storms Causing Damages in Multiple States';
proc print data=work.MultiStateDamage;
    var Event Date Summary Start MyStart MyLength MultiState;
    format Date date9.;
run;
title;

*CALL PRXNEXT routine returns the position and length of a 
 substring  that matches a pattern, and iterates over multiple 
 matches within one string.;

*For the start argument, if the match is successful, CALL PRXNEXT 
 returns a value of position+MAX(1,length).;
